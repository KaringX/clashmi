// ignore_for_file: unused_catch_stack, non_constant_identifier_names

import 'dart:io';
import 'dart:ffi';

import 'package:clashmi/app/runtime/return_result.dart';
import 'package:win32_registry/win32_registry.dart';
import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

final _shlwapi = DynamicLibrary.open('shlwapi.dll');

int SHLoadIndirectString(
  Pointer<Utf16> pszSource,
  Pointer<Utf16> pszOutBuf,
  int cchOutBuf,
  Pointer<Pointer> ppv,
) => _SHLoadIndirectString(pszSource, pszOutBuf, cchOutBuf, ppv);

final _SHLoadIndirectString = _shlwapi
    .lookupFunction<
      Int32 Function(
        Pointer<Utf16> pszSource,
        Pointer<Utf16> pszOutBuf,
        Uint32 cchOutBuf,
        Pointer<Pointer> ppv,
      ),
      int Function(
        Pointer<Utf16> pszSource,
        Pointer<Utf16> pszOutBuf,
        int cchOutBuf,
        Pointer<Pointer> ppv,
      )
    >('SHLoadIndirectString');

class UWPMapping {
  String name = "";
  String sid = "";
  String msName = "";
  String packageFullName = "";
  UWPMapping(this.name, this.sid, this.msName, this.packageFullName);
}

abstract final class UWPUtils {
  static Future<Map<String, String>> getAppxPackage() async {
    //Get-AppxPackage -AllUsers
    Map<String, String> kvs = {};
    try {
      final result = await Process.run('powershell.exe', ['Get-AppxPackage']);
      if (result.exitCode == 0) {
        String res = result.stdout as String;
        List<String> parts = res.split("\r\n\r\n");
        for (final part in parts) {
          final line = part.split("\r\n");
          String name = "";
          String packageFullName = "";
          for (final item in line) {
            final keyvalue = item.split(":");
            if (keyvalue.length == 2) {
              if (keyvalue[0].trim() == "Name") {
                name = keyvalue[1].trim();
              } else if (keyvalue[0].trim() == "PackageFullName") {
                packageFullName = keyvalue[1].trim();
              }
              if (name.isNotEmpty && packageFullName.isNotEmpty) {
                kvs[packageFullName] = name;
                break;
              }
            }
          }
        }
      }
    } catch (err) {}
    return kvs;
  }

  static Future<List<UWPMapping>> getMappings() async {
    List<UWPMapping> data = [];
    try {
      //bool needAppxPackage = false;
      RegistryKey key = Registry.openPath(
        RegistryHive.currentUser,
        path:
            'Software\\Classes\\Local Settings\\Software\\Microsoft\\Windows\\CurrentVersion\\AppContainer\\Mappings',
      );
      //Software\\Classes\\Local Settings\\Software\\Microsoft\\Windows\\CurrentVersion\\AppModel\\Repository\\Packages
      //HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\SharedAccess\Parameters\FirewallPolicy\RestrictedServices\AppIso\FirewallRules
      try {
        for (var sid in key.subkeyNames.toList()) {
          RegistryValue? value = key.getValue("DisplayName", path: sid);
          if (value == null || value.type != RegistryValueType.string) {
            continue;
          }
          String displayName = value.data as String;
          String msName = "";
          String packageFullName = "";
          if (displayName.startsWith('@{')) {
            final pszSource = displayName.toNativeUtf16();
            final pszOutBuf = wsalloc(MAX_PATH);

            int result = SHLoadIndirectString(
              pszSource,
              pszOutBuf,
              MAX_PATH,
              Pointer.fromAddress(0),
            );
            if (result == S_OK) {
              displayName = pszOutBuf.toDartString();
            }
            free(pszOutBuf);
            free(pszSource);
          } else if (displayName.startsWith("ms-resource:")) {
            msName = displayName;
            //needAppxPackage = true;
            RegistryValue? moniker = key.getValue("Moniker", path: sid);
            if (moniker != null && moniker.type == RegistryValueType.string) {
              packageFullName = moniker.data as String;
              int index = packageFullName.indexOf("_");
              if (index > 0) {
                displayName = packageFullName.substring(0, index);
              }
            }
          }

          data.add(UWPMapping(displayName, sid, msName, packageFullName));
        }
      } catch (err) {}
      key.close();
      /*if (needAppxPackage) {
        final packages = await getAppxPackage();
        for (int i = 0; i < data.length; ++i) {
          if (data[i].msName.isNotEmpty) {
            String? name = packages[data[i].packageFullName];
            if (name != null && name.isNotEmpty) {
              data[i].name = name;
            }
          }
        }
      }*/
    } catch (err) {}

    return data;
  }

  static Future<ReturnResult<Set<String>>> getNetIsolation() async {
    late ProcessResult result;
    try {
      result = await Process.run("CheckNetIsolation", ["loopbackexempt", "-s"]);
    } catch (err) {
      return ReturnResult(error: ReturnResultError(err.toString()));
    }
    Set<String> netIsolation = {};
    if (result.stdout is String) {
      String res = result.stdout as String;
      List<String> sids = res.split("\n");
      for (var value in sids) {
        if (value.contains("SID:")) {
          value = value.replaceAll("SID:", "").trim();
          netIsolation.add(value);
        }
      }
    }
    return ReturnResult(data: netIsolation);
  }

  static Future<ReturnResultError?> ClearNetIsolation() async {
    try {
      await Process.run("CheckNetIsolation", ["loopbackexempt", "-c"]);
    } catch (err, stacktrace) {
      return ReturnResultError(err.toString(), stacktrace: stacktrace);
    }

    return null;
  }

  static Future<ReturnResultError?> SetNetIsolation(
    Set<String> sids,
    bool enable,
  ) async {
    try {
      for (var sid in sids) {
        await Process.run("CheckNetIsolation", [
          "loopbackexempt",
          enable ? "-a" : "-d",
          "-p=$sid",
        ]);
      }
    } catch (err, stacktrace) {
      return ReturnResultError(err.toString(), stacktrace: stacktrace);
    }

    return null;
  }
}
