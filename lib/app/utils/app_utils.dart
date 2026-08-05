import 'dart:io';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:clashmi/generated/build_time.dart' as build_time;

abstract final class AppUtils {
  static Future<String> getPackgetVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return "${packageInfo.version}.${packageInfo.buildNumber}";
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
    return "1.0.28.1404";
  }

  static DateTime getBuildinVersionDate() {
    return build_time.buildDateTime;
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
    return "1.19.29";
  }
}
