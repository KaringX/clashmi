import 'dart:io';

class SystemUtils {
  static Future<String> getRouteTable() async {
    try {
      ProcessResult result;
      if (Platform.isWindows) {
        result = await Process.run('route', [
          'print',
        ]).timeout(const Duration(seconds: 10));
      } else if (Platform.isMacOS) {
        result = await Process.run('netstat', [
          '-rn',
        ]).timeout(const Duration(seconds: 10));
      } else if (Platform.isAndroid) {
        return await _getRouteTableAndroid();
      } else if (Platform.isLinux) {
        result = await Process.run('ip', [
          'route',
        ]).timeout(const Duration(seconds: 10));
      } else {
        // iOS: process spawning is not supported in the sandbox
        return '';
      }
      final out = result.stdout.toString().trim();
      final err = result.stderr.toString().trim();
      if (out.isNotEmpty) return out;
      if (err.isNotEmpty) return err;
      return '';
    } catch (err) {
      return err.toString();
    }
  }

  static Future<String> _getRouteTableAndroid() async {
    final errors = <String>[];

    try {
      final viaIp = await _getRouteTableByIpCommand();
      if (viaIp.isNotEmpty) {
        return viaIp;
      }
    } catch (err) {
      errors.add('ip route: $err');
    }

    for (final path in const ['/proc/net/route', '/proc/self/net/route']) {
      try {
        final viaProc = await _getRouteTableByProcFile(path);
        if (viaProc.isNotEmpty) {
          return viaProc;
        }
      } catch (err) {
        errors.add('$path: $err');
      }
    }

    try {
      final viaInterface = await _getRouteTableByInterfaces();
      if (viaInterface.isNotEmpty) {
        return viaInterface;
      }
    } catch (err) {
      errors.add('NetworkInterface: $err');
    }

    if (errors.isEmpty) {
      return 'Route table is unavailable on this Android device.';
    }

    return 'Route table is unavailable on this Android device.\n${errors.join('\n')}';
  }

  static Future<String> _getRouteTableByIpCommand() async {
    final result = await Process.run('ip', [
      'route',
    ]).timeout(const Duration(seconds: 10));

    final out = result.stdout.toString().trim();
    final err = result.stderr.toString().trim();
    if (out.isNotEmpty) {
      return out;
    }
    if (err.isNotEmpty) {
      throw err;
    }
    return '';
  }

  static Future<String> _getRouteTableByProcFile(String filePath) async {
    final lines = await File(filePath).readAsLines();
    if (lines.length <= 1) {
      return '';
    }

    final rows = <String>[];
    rows.add('Iface           Destination     Gateway         Flags   Mask');
    for (final line in lines.skip(1)) {
      final parts = line.trim().split(RegExp(r'\s+'));
      if (parts.length < 8) {
        continue;
      }

      final iface = parts[0].padRight(16);
      final dest = _hexToIp(parts[1]).padRight(16);
      final gw = _hexToIp(parts[2]).padRight(16);
      final flags = parts[3].padRight(8);
      final mask = _hexToIp(parts[7]);
      rows.add('$iface$dest$gw$flags$mask');
    }

    return rows.join('\n');
  }

  static Future<String> _getRouteTableByInterfaces() async {
    final interfaces = await NetworkInterface.list(
      includeLoopback: true,
      includeLinkLocal: true,
    );
    if (interfaces.isEmpty) {
      return '';
    }

    final rows = <String>[];
    rows.add('Route table unavailable, showing interfaces instead:');
    rows.add('Iface           Address');
    for (final iface in interfaces) {
      if (iface.addresses.isEmpty) {
        rows.add('${iface.name.padRight(16)}<no address>');
        continue;
      }
      for (final address in iface.addresses) {
        rows.add('${iface.name.padRight(16)}${address.address}');
      }
    }
    return rows.join('\n');
  }

  static String _hexToIp(String hex) {
    final v = int.tryParse(hex, radix: 16) ?? 0;
    return '${v & 0xff}.${(v >> 8) & 0xff}.${(v >> 16) & 0xff}.${(v >> 24) & 0xff}';
  }
}
