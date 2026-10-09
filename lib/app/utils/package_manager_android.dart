import 'dart:io';

import 'package:android_package_manager/android_package_manager.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class PackageInfoImpl extends PackageInfo {
  PackageInfoImpl(String packageName)
    : super(
        packageName: packageName,
        installLocation: AndroidInstallLocation.unspecified,
      );
}

class ApplicationInfoImpl extends ApplicationInfo {
  ApplicationInfoImpl(String packageName)
    : super(
        compatibleWidthLimitDp: 0,
        dataDir: null,
        descriptionRes: 0,
        enabled: true,
        flags: 0,
        largestWidthLimitDp: 0,
        processName: packageName,
        publicSourceDir: null,
        requiresSmallestWidthDp: 0,
        sourceDir: null,
        theme: 0,
        uiOptions: 0,
        uid: 0,
        targetSdkVersion: 0,
        packageItemInfo: {'packageName': packageName},
      );
}

class PackageInfoFromApplicationInfo extends PackageInfo {
  PackageInfoFromApplicationInfo(ApplicationInfo applicationInfo)
    : super(
        applicationInfo: applicationInfo,
        packageName: applicationInfo.packageName,
        installLocation: AndroidInstallLocation.unspecified,
      );
}

class PackageInfoEx {
  late PackageInfo info;
  String name = "";
  Image? icon;
}

class PackageManagerAndroid {
  static const int kAndroidFlagSystem = 1;
  static const kRemoved = "[removed]";
  static AndroidPackageManager? _pkgMgr;
  static final Map<String, String> _appNameCache = {};

  static Future<List<PackageInfoEx>> getInstalledPackages({
    bool Function(PackageInfo)? onValid,
  }) async {
    if (!Platform.isAndroid) {
      return [];
    }

    _pkgMgr ??= AndroidPackageManager();
    try {
      List<PackageInfo>? packageInfos;
      try {
        packageInfos = await _pkgMgr!.getInstalledPackages(
          flags: PackageInfoFlags({PMFlag.getMetaData}),
        );
      } on PlatformException {
        packageInfos = await _getInstalledPackagesFallback();
      } catch (_) {
        packageInfos = await _getInstalledPackagesFallback();
      }

      return await _buildPackageInfoList(packageInfos, onValid: onValid);
    } catch (err, stacktrace) {}
    return [];
  }

  static Future<List<PackageInfo>?> _getInstalledPackagesFallback() async {
    final applications = await _pkgMgr!.getInstalledApplications(
      flags: ApplicationInfoFlags({PMFlag.getMetaData}),
    );
    if (applications == null) {
      return null;
    }

    return applications
        .where((app) => app.packageName != null)
        .map(
          (app) => PackageInfoFromApplicationInfo(
            app.packageName == null ? ApplicationInfoImpl("") : app,
          ),
        )
        .toList();
  }

  static Future<List<PackageInfoEx>> _buildPackageInfoList(
    List<PackageInfo>? packageInfos, {
    bool Function(PackageInfo)? onValid,
  }) async {
    if (packageInfos == null || packageInfos.length <= 1) {
      return [];
    }

    List<PackageInfoEx> packages = [];
    for (var app in packageInfos) {
      if (app.packageName == null) {
        continue;
      }
      if (onValid != null && !onValid(app)) {
        continue;
      }
      PackageInfoEx info = PackageInfoEx();
      info.info = app;
      info.name =
          _appNameCache[app.packageName!] ?? await getAppName(app.packageName!);
      _appNameCache[app.packageName!] = info.name;
      if (info.name.contains("{") &&
          info.name.contains(":") &&
          info.name.contains("\"")) {
        continue;
      }

      packages.add(info);
    }

    return packages;
  }

  static Future<Image?> getInstalledPackageIcon(
    List<PackageInfoEx> packages,
    String packageName, {
    int size = 96,
  }) async {
    for (var app in packages) {
      if (app.info.packageName == packageName) {
        if (app.icon != null) {
          return app.icon;
        }
        if (app.name == PackageManagerAndroid.kRemoved) {
          return null;
        }
        Image? image = await getAppIcon(app.info.packageName, size: size);
        app.icon = image;
        return app.icon;
      }
    }
    return null;
  }

  static int sortByName(PackageInfoEx a, PackageInfoEx b) {
    return a.name.compareTo(b.name);
  }

  static Future<String> getAppName(String? packageName) async {
    if (_pkgMgr == null || packageName == null) {
      return "";
    }
    try {
      return await _pkgMgr!.getApplicationLabel(packageName: packageName) ?? "";
    } catch (err, stacktrace) {
      return packageName;
    }
  }

  static Future<Image?> getAppIcon(String? packageName, {int size = 96}) async {
    if (_pkgMgr == null || packageName == null) {
      return null;
    }
    try {
      var data = await _pkgMgr!.getApplicationIcon(
        packageName: packageName,
        format: BitmapCompressFormat.png,
      );
      if (data == null) {
        return null;
      }
      return Image.memory(data, cacheHeight: size, cacheWidth: size);
    } catch (err, stacktrace) {
      return null;
    }
  }
}
