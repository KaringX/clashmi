import 'dart:convert';
import 'dart:io';
import 'package:clashmi/app/utils/did.dart';
import 'package:device_info_plus/device_info_plus.dart';

class HwidUtils {
  static Future<String> getHwid() async {
    final did = await Did.getDid();
    return base64Encode(utf8.encode(did.hashCode.toString()));
  }

  static Future<Map<String, String>> getHwidHeaders() async {
    Map<String, String> headers = {};
    final plugin = DeviceInfoPlugin();
    final hwid = await getHwid();
    headers["x-hwid"] = hwid.toLowerCase();
    if (Platform.isIOS) {
      final info = await plugin.iosInfo;
      headers['x-device-os'] = "iOS";
      headers['x-ver-os'] = info.systemVersion;
      headers['x-device-model'] = info.modelName;
    } else if (Platform.isMacOS) {
      final info = await plugin.macOsInfo;
      headers['x-device-os'] = "macOS";
      headers['x-ver-os'] = "${info.majorVersion}.${info.minorVersion}";
      headers['x-device-model'] = info.model;
    } else if (Platform.isWindows) {
      final info = await plugin.windowsInfo;
      headers['x-device-os'] = "Windows";
      headers['x-ver-os'] = "${info.majorVersion}.${info.minorVersion}";
      headers['x-device-model'] = info.productName;
    } else if (Platform.isLinux) {
      final info = await plugin.linuxInfo;
      headers['x-device-os'] = "Linux";
      headers['x-ver-os'] = info.versionId ?? "";
      headers['x-device-model'] = info.name;
    } else if (Platform.isAndroid) {
      final info = await plugin.androidInfo;
      headers['x-device-os'] = "Android";
      headers['x-ver-os'] = info.version.release;
      headers['x-device-model'] = '${info.manufacturer} ${info.model}';
    }

    return headers;
  }
}
