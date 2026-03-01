// ignore_for_file: unused_catch_stack, empty_catches

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clashmi/app/local_services/vpn_service.dart';
import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/app/runtime/return_result.dart';
import 'package:clashmi/app/utils/app_lifecycle_state_notify.dart';
import 'package:clashmi/app/utils/convert_utils.dart';
import 'package:clashmi/app/utils/date_time_utils.dart';
import 'package:clashmi/app/utils/download_utils.dart';
import 'package:clashmi/app/utils/file_utils.dart';
import 'package:clashmi/app/utils/http_utils.dart';
import 'package:clashmi/app/utils/log.dart';
import 'package:clashmi/app/utils/path_utils.dart';
import 'package:clashmi/app/utils/profile_decrypt_utils.dart';
import 'package:intl/intl.dart';

import 'package:libclash_vpn_service/state.dart';
import 'package:path/path.dart' as path;
import 'package:tuple/tuple.dart';

const int kRemarkMaxLength = 32;

class ProfileSettingProxyGroup {
  List<String> proxies = [];
  Map<String, dynamic> toJson() => {'proxies': proxies};
  void fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    proxies = List<String>.from(map['proxies'] ?? []);
  }

  ProfileSettingProxyGroup clone() {
    ProfileSettingProxyGroup ps = ProfileSettingProxyGroup();
    ps.proxies = proxies.toList();
    return ps;
  }
}

class ProfileSetting {
  ProfileSetting({
    this.id = "",
    this.remark = "",
    this.updateInterval,
    this.updateIntervalByProfile,
    this.update,
    this.url = "",
    this.xhwid = false,
    this.decryptPassword = "",
    this.userAgent = "",
    this.patch = "",
  });
  String id = "";
  String remark = "";
  String patch = "";
  Duration? updateInterval;
  Duration? updateIntervalByProfile;
  DateTime? update;
  String url;
  String userAgent;
  bool xhwid = false;
  String decryptPassword = "";
  num upload = 0;
  num download = 0;
  num total = 0;
  String expire = "";

  bool overwriteProxyGroups = false;
  bool overwriteRules = false;
  Map<String, ProfileSettingProxyGroup> proxyGroups = {};
  Map<String, String> rules = {};
  Map<String, String> rulesForProxyGroups = {};

  Map<String, dynamic> toJson() => {
    'id': id,
    'remark': remark,
    'patch': patch,
    'update_interval': updateInterval?.inSeconds,
    'update_interval_by_profile': updateIntervalByProfile?.inSeconds,
    'update': update.toString(),
    'url': url,
    'user_agent': userAgent,
    'xhwid': xhwid,
    'decrypt_password': decryptPassword,
    'upload': upload,
    'download': download,
    'total': total,
    'expire': expire,
    'overwrite_rules': overwriteRules,
    'overwrite_proxy_groups': overwriteProxyGroups,
    'proxy_groups': proxyGroups,
    'rules': rules,
    'rules_for_proxy_groups': rulesForProxyGroups,
  };
  void fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }

    id = map['id'] ?? '';
    remark = map['remark'] ?? '';
    patch = map['patch'] ?? '';

    var updateIntervalTime = map['update_interval'];
    if (updateIntervalTime is int) {
      if (updateIntervalTime < 60) {
        updateIntervalTime = 24 * 60;
      }
      updateInterval = Duration(seconds: updateIntervalTime);
    }
    var updateIntervalByProfileTime = map['update_interval_by_profile'];
    if (updateIntervalByProfileTime is int) {
      if (updateIntervalByProfileTime < 3600) {
        updateIntervalByProfileTime = 3600;
      }
      updateIntervalByProfile = Duration(seconds: updateIntervalByProfileTime);
    }
    final updateTime = map['update'];
    if (updateTime is String) {
      update = DateTime.tryParse(updateTime);
    }
    url = map['url'] ?? '';
    userAgent = map['user_agent'] ?? '';
    xhwid = map['xhwid'] ?? false;
    decryptPassword = map['decrypt_password'] ?? '';
    upload = map['upload'] ?? 0;
    download = map['download'] ?? 0;
    total = map['total'] ?? 0;
    expire = map['expire'] ?? "";
    decryptPassword = map['decrypt_password'] ?? "";
    overwriteProxyGroups = map['overwrite_proxy_groups'] ?? false;
    overwriteRules = map['overwrite_rules'] ?? false;
    final pgs = map["proxy_groups"];
    if (pgs is Map) {
      pgs.forEach((key, value) {
        ProfileSettingProxyGroup pg = ProfileSettingProxyGroup();
        pg.fromJson(value);
        proxyGroups[key] = pg;
      });
    }
    rules = ConvertUtils.convertMap(map["rules"]) ?? {};
    rules.removeWhere((key, value) {
      return key.isEmpty || value.isEmpty;
    });
    rulesForProxyGroups =
        ConvertUtils.convertMap(map["rules_for_proxy_groups"]) ?? {};
    rulesForProxyGroups.removeWhere((key, value) {
      return key.isEmpty || value.isEmpty;
    });
  }

  String getType() {
    if (url.isNotEmpty) {
      return "URL";
    }
    return "Local";
  }

  bool isRemote() {
    return url.isNotEmpty;
  }

  String getShowName() {
    return remark.isEmpty ? id : remark;
  }

  void updateSubscriptionTraffic(HttpHeaders? header) {
    if (header == null) {
      return;
    }
    //subscription-userinfo: upload=9579993656; download=92563554739; total=2684354560000; expire=1695781320
    List<String>? subscription = header["subscription-userinfo"];
    if (subscription == null || subscription.isEmpty) {
      return;
    }
    List<String> items = subscription[0].split(';');
    if (items.isEmpty) {
      return;
    }

    for (var item in items) {
      List<String> subitems = item.split('=');
      if (subitems.length != 2) {
        continue;
      }
      String key = subitems[0].trim();
      num? value = num.tryParse(subitems[1].trim());
      if (value == null) {
        continue;
      }

      switch (key) {
        case "upload":
          upload = value;
          break;
        case "download":
          download = value;
          break;
        case "total":
          total = value;
          break;
        case "expire":
          expire =
              DateTimeUtils.millisecondSecondsToDate((value * 1000).toInt()) ??
              "";
          break;
      }
    }
  }

  Tuple2<bool, String> getExpireTime(String languageTag) {
    bool expiring = false;
    String expireTime = expire;
    if (expireTime.isNotEmpty) {
      DateTime? date = DateTime.tryParse(expireTime);
      if (date != null) {
        try {
          var dif = date.difference(DateTime.now());
          if (dif.inDays <= 14) {
            expiring = true;
          }
          if (languageTag.isNotEmpty) {
            expireTime = DateFormat.yMd(languageTag).format(date);
          }
        } catch (e) {}
      }
    }

    return Tuple2(expiring, expireTime);
  }

  ProfileSetting clone() {
    ProfileSetting ps = ProfileSetting();
    ps.id = id;
    ps.remark = remark;
    ps.patch = patch;
    ps.updateInterval = updateInterval;
    ps.updateIntervalByProfile = updateIntervalByProfile;
    ps.update = update;
    ps.url = url;
    ps.userAgent = userAgent;
    ps.xhwid = xhwid;
    ps.decryptPassword = decryptPassword;
    ps.upload = upload;
    ps.download = download;
    ps.total = total;
    ps.expire = expire;
    ps.overwriteProxyGroups = overwriteProxyGroups;
    ps.overwriteRules = overwriteRules;
    proxyGroups.forEach((key, value) {
      ps.proxyGroups[key] = value.clone();
    });
    rules.forEach((key, value) {
      ps.rules[key] = value;
    });
    rulesForProxyGroups.forEach((key, value) {
      ps.rulesForProxyGroups[key] = value;
    });
    return ps;
  }
}

class ProfileConfig {
  String _currentId = "";
  List<ProfileSetting> profiles = [];

  Map<String, dynamic> toJson() => {
    'current_id': _currentId,
    'profiles': profiles,
  };

  void fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    _currentId = map['current_id'] ?? '';
    final p = map['profiles'];
    if (p is List) {
      for (var value in p) {
        ProfileSetting ps = ProfileSetting();
        try {
          ps.fromJson(value);
          profiles.add(ps);
        } catch (err) {
          Log.w("ProfileConfig.fromJson exception ${err.toString()} ");
        }
      }
    }
  }
}

class ProfileManager {
  static const String yamlExtension = "yaml";
  static const String urlComment = "#url:";
  static final ProfileConfig _config = ProfileConfig();

  static final List<void Function(String)> onEventCurrentChanged = [];
  static final List<void Function(String)> onEventAdd = [];
  static final List<void Function(String)> onEventRemove = [];
  static final List<void Function(String, bool)> onEventUpdate = [];
  static final Set<String> updating = {};
  static bool _saving = false;

  static Future<void> init() async {
    await load();
    VPNService.onEventStateChanged.add((
      FlutterVpnServiceState state,
      Map<String, String> params,
    ) async {
      if (state == FlutterVpnServiceState.connected) {
        Future.delayed(const Duration(seconds: 3), () async {
          updateByTicker();
        });
      }
    });
    AppLifecycleStateNofity.onStateResumed(null, () {
      Future.delayed(const Duration(seconds: 3), () async {
        updateByTicker();
      });
    });
    Future.delayed(const Duration(seconds: 30), () async {
      updateByTicker();
    });
  }

  static Future<void> uninit() async {}
  static Future<void> reload() async {
    final dir = await PathUtils.profilesDir();
    List<String> ids = [];
    List<String> idsToDelete = [];
    for (var profile in _config.profiles) {
      ids.add(profile.id);
    }
    _config._currentId = "";
    _config.profiles = [];
    await load();
    for (var id in ids) {
      int index = _config.profiles.indexWhere((value) {
        return value.id == id;
      });
      if (index < 0) {
        idsToDelete.add(id);
      }
    }
    for (var id in idsToDelete) {
      final filePath = path.join(dir, id);
      await FileUtils.deletePath(filePath);
    }
    for (var event in onEventCurrentChanged) {
      event(_config._currentId);
    }
  }

  static Future<void> save() async {
    if (_saving) {
      return;
    }
    _saving = true;
    String filePath = await PathUtils.profilesConfigFilePath();
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    String content = encoder.convert(_config);
    try {
      await File(filePath).writeAsString(content, flush: true);
    } catch (err, stacktrace) {
      Log.w("ProfileManager.save exception  $filePath ${err.toString()}");
    }
    _saving = false;
  }

  static Future<void> load() async {
    String dir = await PathUtils.profilesDir();
    String filePath = await PathUtils.profilesConfigFilePath();
    var file = File(filePath);
    bool exists = await file.exists();
    if (exists) {
      try {
        String content = await file.readAsString();
        if (content.isNotEmpty) {
          var config = jsonDecode(content);
          _config.fromJson(config);
        }
      } catch (err, stacktrace) {
        Log.w("ProfileManager.load exception ${err.toString()} ");
      }
    } else {
      await save();
    }

    Map<String, String?> existProfiles = {};
    var files = FileUtils.recursionFile(
      dir,
      extensionFilter: {".yaml", ".yml"},
    );
    for (var file in files) {
      String? line = await FileUtils.readLastLineStartWith(file, urlComment);
      existProfiles[path.basename(file)] = line
          ?.substring(urlComment.length)
          .trim();
    }
    for (int i = 0; i < _config.profiles.length; ++i) {
      if (!existProfiles.containsKey(_config.profiles[i].id) &&
          !_config.profiles[i].isRemote()) {
        _config.profiles.removeAt(i);
        --i;
      }
    }
    existProfiles.forEach((key, existValue) {
      int index = _config.profiles.indexWhere((value) {
        return value.id == key;
      });
      if (index < 0) {
        _config.profiles.add(ProfileSetting(id: key, url: existValue ?? ""));
      }
    });

    if (_config._currentId.isNotEmpty) {
      int index = _config.profiles.indexWhere((value) {
        return value.id == _config._currentId;
      });

      if (index < 0) {
        _config._currentId = "";
      }
    }
    if (_config._currentId.isEmpty && _config.profiles.isNotEmpty) {
      _config._currentId = _config.profiles.first.id;
    }
  }

  static ProfileSetting? getCurrent() {
    if (_config._currentId.isEmpty) {
      return null;
    }
    int index = _config.profiles.indexWhere((value) {
      return value.id == _config._currentId;
    });
    if (index < 0) {
      return null;
    }
    return _config.profiles[index];
  }

  static Future<ReturnResultError?> prepare(ProfileSetting profile) async {
    String dir = await PathUtils.profilesDir();
    final filePath = path.join(dir, profile.id);
    try {
      if (!await File(filePath).exists()) {
        if (profile.isRemote()) {
          return await update(profile.id);
        }
        return ReturnResultError("file not exist: $filePath");
      }
      return await validFileContentFormat(filePath);
    } catch (err) {
      return ReturnResultError(err.toString());
    }
  }

  static void setCurrent(String id) {
    if (_config._currentId == id) {
      return;
    }
    int index = _config.profiles.indexWhere((value) {
      return value.id == id;
    });
    if (index < 0) {
      return;
    }
    _config._currentId = id;
    for (var event in onEventCurrentChanged) {
      event(id);
    }
  }

  static void removePatch(String patch) {
    for (var profile in _config.profiles) {
      if (profile.patch == patch) {
        profile.patch = "";
      }
    }
  }

  static List<ProfileSetting> getProfiles() {
    return _config.profiles;
  }

  static Future<ReturnResultError?> addLocal(
    String filePath, {
    String remark = "",
  }) async {
    final id = "${filePath.hashCode}.yaml";
    final savePath = path.join(await PathUtils.profilesDir(), id);
    final file = File(filePath);
    if (!await file.exists()) {
      return ReturnResultError("file not exist: $filePath");
    }
    try {
      await file.copy(savePath);
      int index = _config.profiles.indexWhere((value) {
        return value.id == id;
      });
      if (index < 0) {
        _config.profiles.add(
          ProfileSetting(id: id, remark: remark, update: DateTime.now()),
        );
      } else {
        _config.profiles[index] = ProfileSetting(
          id: id,
          remark: remark,
          update: DateTime.now(),
        );
      }

      for (var event in onEventAdd) {
        event(id);
      }

      if (_config._currentId.isEmpty) {
        setCurrent(id);
      }

      await save();
      return null;
    } catch (err) {
      return ReturnResultError("addLocalProfile exception: ${err.toString()}");
    }
  }

  static Future<ReturnResultError?> validFileContentFormat(
    String filepath,
  ) async {
    var file = File(filepath);
    if (!await file.exists()) {
      return ReturnResultError("$file not exists:\n\n$filepath");
    }
    String content = await file.readAsString();
    content = content.trimLeft();
    if (content.startsWith("<!DOCTYPE html>") || content.startsWith("<html")) {
      return ReturnResultError("Invalid format: html");
    }
    if (!content.contains("proxies") && !content.contains("proxy-providers")) {
      return ReturnResultError(
        "Invalid Clash Yaml file: proxies and proxy-providers not found",
      );
    }
    return null;
  }

  static Future<ReturnResult<String>> addRemote(
    String url, {
    String remark = "",
    String patch = "",
    String userAgent = "",
    bool xhwid = false,
    String decryptPassword = "",
    Duration? updateInterval,
  }) async {
    final uri = Uri.tryParse(url);
    if (uri == null) {
      return ReturnResult(error: ReturnResultError("invalid url"));
    }
    final id = "${url.hashCode}.yaml";
    final savePath = path.join(await PathUtils.profilesDir(), id);
    if (userAgent.isEmpty) {
      userAgent = SettingManager.getConfig().userAgent();
    }

    final result = await DownloadUtils.downloadWithPort(
      uri,
      savePath,
      userAgent,
      xhwid,
      null,
      timeout: const Duration(seconds: 30),
    );
    if (result.error != null) {
      return ReturnResult(error: result.error);
    }

    Duration? updateIntervalByProfile;
    if (result.data != null) {
      final err = await decryptProfile(result.data, savePath, decryptPassword);
      if (err != null) {
        await FileUtils.deletePath(savePath);
        return ReturnResult(error: err);
      }
      //final announce = result.data!.value("announce");
      //final supportUrl = result.data!.value("support-url");
      //final xhwidLimit = result.data!.value("x-hwid-limit");
      final profileUpdateInterval = result.data!.value(
        "profile-update-interval",
      );
      if (profileUpdateInterval != null) {
        var pui = int.tryParse(profileUpdateInterval);
        if (pui != null) {
          if (pui < 1) {
            pui = 1;
          }
          updateIntervalByProfile = Duration(hours: pui);
        }
      }
    }
    final err = await validFileContentFormat(savePath);
    if (err != null) {
      await FileUtils.deletePath(savePath);
      return ReturnResult(error: err);
    }

    await FileUtils.append(savePath, "\n$urlComment$url\n");
    if (remark.isEmpty) {
      final result = await HttpUtils.httpGetTitle(url, userAgent);
      if (result.data == null || result.data!.length > 32) {
        remark = uri.host;
      } else {
        remark = result.data!;
      }
    }
    int index = _config.profiles.indexWhere((value) {
      return value.id == id;
    });
    final profile = ProfileSetting(
      id: id,
      remark: remark,
      updateInterval: updateInterval ?? const Duration(days: 1),
      updateIntervalByProfile: updateIntervalByProfile,
      update: DateTime.now(),
      url: url,
      userAgent: userAgent,
      xhwid: xhwid,
      decryptPassword: decryptPassword,
      patch: patch,
    );

    profile.updateSubscriptionTraffic(result.data);
    if (index < 0) {
      _config.profiles.add(profile);
    } else {
      _config.profiles[index] = profile;
    }

    for (var event in onEventAdd) {
      event(id);
    }

    if (_config._currentId.isEmpty) {
      setCurrent(id);
    }

    await save();
    return ReturnResult(data: id);
  }

  static Future<void> updateAll() async {
    for (var profile in _config.profiles) {
      update(profile.id);
    }
  }

  static Future<ReturnResultError?> update(String id) async {
    if (updating.contains(id)) {
      return null;
    }
    int index = _config.profiles.indexWhere((value) {
      return value.id == id;
    });
    if (index < 0) {
      return null;
    }
    ProfileSetting profile = _config.profiles[index];
    if (!profile.isRemote()) {
      return null;
    }
    final uri = Uri.tryParse(profile.url);
    if (uri == null) {
      return null;
    }
    updating.add(id);
    Future.delayed(const Duration(milliseconds: 10), () async {
      for (var event in onEventUpdate) {
        event(id, false);
      }
    });

    String userAgent = profile.userAgent;
    if (userAgent.isEmpty) {
      userAgent = SettingManager.getConfig().userAgent();
    }
    final savePath = path.join(await PathUtils.profilesDir(), id);
    final savePathTmp = "$savePath.tmp";
    final result = await DownloadUtils.downloadWithPort(
      uri,
      savePathTmp,
      userAgent,
      profile.xhwid,
      null,
      timeout: const Duration(seconds: 30),
    );
    profile.update = DateTime.now();
    if (result.error == null) {
      final err1 = await decryptProfile(
        result.data,
        savePathTmp,
        profile.decryptPassword,
      );
      if (err1 != null) {
        await FileUtils.deletePath(savePath);
        return err1;
      }
      final err = await validFileContentFormat(savePathTmp);
      if (err != null) {
        updating.remove(id);
        await FileUtils.deletePath(savePathTmp);

        Future.delayed(const Duration(milliseconds: 10), () async {
          for (var event in onEventUpdate) {
            event(id, true);
          }
        });
        return err;
      }

      String renameError = "";
      for (var i = 0; i < 3; ++i) {
        try {
          var file = File(savePathTmp);
          await file.rename(savePath);
          renameError = "";
          break;
        } catch (err) {
          renameError = err.toString();
          await Future.delayed(const Duration(seconds: 1));
        }
      }
      if (renameError.isNotEmpty) {
        updating.remove(id);
        await FileUtils.deletePath(savePathTmp);

        Future.delayed(const Duration(milliseconds: 10), () async {
          for (var event in onEventUpdate) {
            event(id, true);
          }
        });
        return ReturnResultError(
          "Rename file from [$savePathTmp] to [$savePath] failed: $renameError",
        );
      }

      await FileUtils.append(savePath, "\n$urlComment${profile.url}\n");
      if (profile.remark.isEmpty) {
        final result = await HttpUtils.httpGetTitle(profile.url, userAgent);
        if (result.data == null || result.data!.length > 32) {
          profile.remark = uri.host;
        } else {
          profile.remark = result.data!;
        }
      }
      profile.updateSubscriptionTraffic(result.data);
      if (result.data != null) {
        final profileUpdateInterval = result.data!.value(
          "profile-update-interval",
        );
        if (profileUpdateInterval != null) {
          var pui = int.tryParse(profileUpdateInterval);
          if (pui != null) {
            if (pui < 1) {
              pui = 1;
            }
            profile.updateIntervalByProfile = Duration(hours: pui);
          }
        }
      }
    }
    await save();
    updating.remove(id);
    Future.delayed(const Duration(milliseconds: 10), () async {
      for (var event in onEventUpdate) {
        event(id, true);
      }
    });
    return result.error;
  }

  static Future<void> updateByTicker() async {
    DateTime now = DateTime.now();
    for (var profile in _config.profiles) {
      if (!profile.isRemote()) {
        continue;
      }
      final interval =
          profile.updateIntervalByProfile ?? profile.updateInterval;
      if (interval == null) {
        continue;
      }
      if (profile.update == null ||
          now.difference(profile.update!).inSeconds >= interval.inSeconds) {
        update(profile.id);
      }
    }
  }

  static Future<void> remove(String id) async {
    _config.profiles.removeWhere((p) => p.id == id);
    for (var event in onEventRemove) {
      event(id);
    }
    if (_config._currentId == id) {
      _config._currentId = _config.profiles.isEmpty
          ? ""
          : _config.profiles.first.id;

      for (var event in onEventCurrentChanged) {
        event(_config._currentId);
      }
    }

    final filePath = path.join(await PathUtils.profilesDir(), id);
    await FileUtils.deletePath(filePath);
    await save();
  }

  static Future<void> removeAllProfile() async {
    var dir = await PathUtils.profilesDir();
    for (var profile in _config.profiles) {
      final filePath = path.join(dir, profile.id);
      await FileUtils.deletePath(filePath);
    }
    _config.profiles.clear();
    _config._currentId = "";
    for (var event in onEventCurrentChanged) {
      event(_config._currentId);
    }
    await save();
  }

  static ProfileSetting? getProfile(String id) {
    for (var profile in _config.profiles) {
      if (id == profile.id) {
        return profile;
      }
    }
    return null;
  }

  static Future<String> getProfilePath(String id) async {
    final filePath = path.join(await PathUtils.profilesDir(), id);
    return filePath;
  }

  static void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    if (oldIndex >= _config.profiles.length ||
        newIndex >= _config.profiles.length) {
      return;
    }
    var item = _config.profiles.removeAt(oldIndex);
    _config.profiles.insert(newIndex, item);
  }

  static void updateProfile(String id, ProfileSetting profile) {
    for (int i = 0; i < _config.profiles.length; ++i) {
      if (_config.profiles[i].id == id) {
        _config.profiles[i] = profile;
        break;
      }
    }
  }

  static Future<ReturnResultError?> decryptProfile(
    HttpHeaders? headers,
    String filePath,
    String password,
  ) async {
    if (headers == null) {
      return null;
    }
    final subscriptionEncryption = headers['subscription-encryption'];
    if (subscriptionEncryption == null ||
        subscriptionEncryption.isEmpty ||
        subscriptionEncryption.first.trim() != "true") {
      return null;
    }
    if (password.isEmpty) {
      return ReturnResultError("profile is encrypted but no password provided");
    }
    final file = File(filePath);
    if (!await file.exists()) {
      return null;
    }
    final content = await file.readAsString();
    final decodedContent = ProfileDecryptUtils.decryptProfileContent(
      password,
      content,
    );
    if (decodedContent == null) {
      return ReturnResultError("decrypt profile failed");
    }

    await file.writeAsString(decodedContent);
    return null;
  }
}
