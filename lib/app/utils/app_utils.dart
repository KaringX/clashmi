import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';

abstract final class AppUtils {
  static Future<String> getPackgetVersion() async {
    try {
      PackageInfo packageInfo = await PackageInfo.fromPlatform();
      return "${packageInfo.version}.${packageInfo.buildNumber}";
    } catch (e) {
      return getBuildinVersion();
    }
  }

  static String getName() {
    return "Clash Mi";
  }

  static String getReleaseVersion() {
    List<String> v = getBuildinVersion().split(".");
    return "${v[0]}.${v[1]}.${v[2]}+${v[3]}";
  }

  static String getNextBuildinVersion() {
    List<String> v = getBuildinVersion().split(".");
    return "${v[0]}.${v[1]}.${v[2]}.${int.parse(v[3]) + 1}";
  }

  static String getBuildinVersion() {
    return "1.0.20.606";
  }

  static String getId() {
    return "com.nebula.clashmi";
  }

  static String getGroupId() {
    return "group.com.nebula.clashmi";
  }

  static String getBundleId(bool systemExtension) {
    if (Platform.isIOS || Platform.isMacOS) {
      if (Platform.isMacOS && systemExtension) {
        return "com.nebula.clashmi.clashmiServiceSE";
      }
      return "com.nebula.clashmi.clashmiService";
    }
    return "";
  }

  static String getControlKind() {
    return "com.nebula.clashmi.clashmiWidget.ControlCenterToggle";
  }

  static String getICloudContainerId() {
    return "iCloud.com.nebula.clashmi";
  }

  static String getCoreVersion() {
    return "1.19.22";
  }
}
