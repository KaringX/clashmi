// ignore_for_file: unused_catch_stack, empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:clashmi/app/modules/clash_setting_manager.dart';
import 'package:clashmi/app/modules/profile_manager.dart';
import 'package:clashmi/app/modules/profile_patch_manager.dart';
import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/app/runtime/return_result.dart';
import 'package:clashmi/app/utils/app_args.dart';
import 'package:clashmi/app/utils/app_utils.dart';
import 'package:clashmi/app/utils/did.dart';
import 'package:clashmi/app/utils/error_reporter_utils.dart';
import 'package:clashmi/app/utils/file_utils.dart';
import 'package:clashmi/app/utils/install_referrer_utils.dart';
import 'package:clashmi/app/utils/log.dart';
import 'package:clashmi/app/utils/network_utils.dart';
import 'package:clashmi/app/utils/path_utils.dart';
import 'package:clashmi/app/utils/platform_utils.dart';
import 'package:launch_at_startup/launch_at_startup.dart';
import 'package:libclash_vpn_service/proxy_manager.dart';
import 'package:libclash_vpn_service/state.dart';
import 'package:libclash_vpn_service/vpn_service.dart';
import 'package:libclash_vpn_service/vpn_service_platform_interface.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path/path.dart' as path;

class VPNServiceSetServerOptions {
  String disabledServerError = "";
  String invalidServerError = "";
  String expiredServerError = "";
  Set<String> allOutboundsTags = {};
}

class VPNService {
  static const localhost = "127.0.0.1";
  static bool _runAsAdmin = false;
  static final bool _systemExtension = true;
  static List<String> _abis = [];
  static final List<
    void Function(FlutterVpnServiceState state, Map<String, String> params)
  >
  onEventStateChanged = [];

  static Future<void> initABI() async {
    if (Platform.isAndroid) {
      String abisAll = await FlutterVpnService.getABIs();
      _abis = abisAll.replaceAll("[", "").replaceAll("]", "").split(",");
    }
  }

  static Future<void> init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isWindows) {
      _runAsAdmin = await FlutterVpnService.isRunAsAdmin();
      FlutterVpnService.firewallAddApp(
        Platform.resolvedExecutable,
        PathUtils.getExeName(),
      );
      FlutterVpnService.firewallAddApp(
        PathUtils.serviceExePath(),
        PathUtils.serviceExeName(),
      );
    }

    launchAtStartup.setup(
      appName: packageInfo.appName,
      appPath: Platform.resolvedExecutable,
      args: [AppArgs.launchStartup],
    );

    FlutterVpnService.onStateChanged((
      FlutterVpnServiceState state,
      Map<String, String> params,
    ) async {
      if (getSupportSystemProxy()) {
        if (state == FlutterVpnServiceState.disconnected) {
          bool enable = await getSystemProxyEnable();
          if (enable) {
            await FlutterVpnService.cleanSystemProxy();
          }
        }
      }

      for (var callback in onEventStateChanged) {
        callback(state, params);
      }
    });

    final profile = ProfileManager.getCurrent();
    if (profile != null) {
      final prepareResult = await ProfileManager.prepare(profile);
      if (prepareResult == null) {
        await _prepareConfig(profile);
      }
    }

    if (Platform.isWindows) {
      await stop();
    }
  }

  static Future<void> uninit() async {
    if (PlatformUtils.isPC()) {
      await stop();
    }
  }

  static List<String> getABIs() {
    return _abis;
  }

  static ReturnResultError? convertErr(VpnServiceResultError? err) {
    if (err == null) {
      return null;
    }
    return ReturnResultError(err.message);
  }

  static String durationToString(Duration? duration) {
    if (duration == null) {
      return "";
    }
    var microseconds = duration.inMicroseconds;
    var sign = "";
    var negative = microseconds < 0;

    var hours = microseconds ~/ Duration.microsecondsPerHour;
    microseconds = microseconds.remainder(Duration.microsecondsPerHour);

    // Correcting for being negative after first division, instead of before,
    // to avoid negating min-int, -(2^31-1), of a native int64.
    if (negative) {
      hours = 0 - hours; // Not using `-hours` to avoid creating -0.0 on web.
      microseconds = 0 - microseconds;
      sign = "-";
    }

    var minutes = microseconds ~/ Duration.microsecondsPerMinute;
    microseconds = microseconds.remainder(Duration.microsecondsPerMinute);

    var minutesPadding = minutes < 10 ? "0" : "";

    var seconds = microseconds ~/ Duration.microsecondsPerSecond;
    microseconds = microseconds.remainder(Duration.microsecondsPerSecond);

    var secondsPadding = seconds < 10 ? "0" : "";

    return "$sign$hours:"
        "$minutesPadding$minutes:"
        "$secondsPadding$seconds";
  }

  static Future<bool> _prepareConfig(ProfileSetting profile) async {
    final corePath = path.join(await PathUtils.profilesDir(), profile.id);
    final patch = ProfilePatchManager.getProfilePatch(profile.patch);
    final setting = ClashSettingManager.getConfig();
    final appSetting = SettingManager.getConfig();
    final controlPort = ClashSettingManager.getControlPort();

    bool overwriteFinal =
        patch.id.isEmpty ||
        patch.id == kProfilePatchBuildinOverwrite ||
        patch.appendPatchBuildin == kProfilePatchBuildinOverwrite;
    List<String>? appendRules = Platform.isIOS && profile.appendApplePushRules
        ? ProfilePatchManager.appendRulesApplePush()
        : null;
    await ClashSettingManager.saveCorePatchFinal(
      profile.id,
      overwriteFinal,
      profile.overwriteRules
          ? (profile.overwriteProxyGroups
                ? profile.rulesForProxyGroups
                : profile.rules)
          : null,
      profile.overwriteProxyGroups ? profile.proxyGroups : null,
      appendRules,
    );

    var excludePorts = [controlPort];
    excludePorts.add(ClashSettingManager.getMixedPort());

    String name = AppUtils.getName();
    String vpnName = name;
    String configFilePath = await PathUtils.serviceConfigFilePath();
    String installReferrer = await InstallReferrerUtils.getString();

    VpnServiceConfig config = VpnServiceConfig();
    config.control_port = controlPort;
    config.base_dir = await PathUtils.profileDir();
    config.work_dir = PathUtils.appAssetsDir();
    config.cache_dir = await PathUtils.cacheDir();
    if (patch.type == ProfilePatchFileType.yaml) {
      config.core_path = corePath;
      config.core_path_patch = await ProfilePatchManager.getProfilePatchPath(
        profile.patch,
      );
    } else {
      config.core_path = await ProfilePatchManager.getProfilePatchScriptPath(
        corePath,
        profile.patch,
      );
    }

    config.core_path_patch_final = await PathUtils.serviceCorePatchFinalPath();
    config.log_path = await PathUtils.serviceLogFilePath();
    config.err_path = await PathUtils.serviceStdErrorFilePath();
    config.id = await Did.getDid();
    config.version = AppUtils.getBuildinVersion();
    config.name = name;
    config.secret = ClashSettingManager.getConfig().Secret!;
    config.install_refer = installReferrer;
    config.prepare =
        (overwriteFinal &&
            setting.Tun?.OverWrite == true &&
            setting.Tun?.Enable == true) ||
        !overwriteFinal;
    config.wake_lock = appSetting.wakeLock;
    config.auto_connect_at_boot = appSetting.autoConnectAtBoot;
    config.include_all_networks =
        setting.Extension?.Tun.includeAllNetworks ?? false;
    config.exclude_local_networks =
        setting.Extension?.Tun.excludeLocalNetworks ?? false;
    config.exclude_cellular_services =
        setting.Extension?.Tun.excludeCellularServices ?? false;
    config.exclude_apns = setting.Extension?.Tun.excludeApns ?? false;
    config.exclude_device_communication =
        setting.Extension?.Tun.excludeDeviceCommunication ?? false;
    config.enforce_routes = setting.Extension?.Tun.enforceRoutes ?? false;
    config.auto_route_use_sub_ranges_by_default =
        setting.Extension?.Tun.autoRouteUseSubRangesByDefault ?? false;
    var bundleIdentifier = AppUtils.getBundleId(_systemExtension);
    var uiServerAddress = name;
    var uiLocalizedDescription = vpnName;
    if (Platform.isMacOS) {
      if (_systemExtension) {
        uiServerAddress = "$uiServerAddress (system)";
        uiLocalizedDescription = "$uiLocalizedDescription (system)";
      }
    }
    FlutterVpnService.prepareConfig(
      config: config,
      tunnelServicePath: PathUtils.serviceExePath(),
      configFilePath: configFilePath,
      systemExtension: _systemExtension,
      bundleIdentifier: bundleIdentifier,
      controlKind: AppUtils.getControlKind(),
      uiServerAddress: uiServerAddress,
      uiLocalizedDescription: uiLocalizedDescription,
      excludePorts: excludePorts,
    );
    File confFile = File(configFilePath);
    bool reinstall = false;
    if (Platform.isIOS || Platform.isMacOS) {
      bool exists = await confFile.exists();
      if (exists) {
        try {
          String content = await confFile.readAsString();
          if (content.isNotEmpty) {
            var configJson = jsonDecode(content);
            VpnServiceConfig configOld = VpnServiceConfig();
            configOld.fromJson(configJson);
            if (config.install_refer != configOld.install_refer) {
              reinstall = true;
            }
          }
        } catch (err, stacktrace) {
          Log.w("VPNService.prepareConfig exception ${err.toString()}");
        }
      }
    }

    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    String content = encoder.convert(config);
    try {
      await confFile.writeAsString(content, flush: true);
    } catch (err) {
      ErrorReporterUtils.tryReportNoSpace(err.toString());
    }

    if (Platform.isMacOS) {
      ProxyManager().setExcludeDevices({vpnName});
    }

    return reinstall;
  }

  static Future<ReturnResultError?> install() async {
    VpnServiceResultError? err = await FlutterVpnService.installService();
    if (err != null) {
      Log.w("VPNService.install err ${err.message.toString()}");
    }
    return convertErr(err);
  }

  static Future<ReturnResultError?> uninstall() async {
    VpnServiceResultError? err = await FlutterVpnService.uninstallService();
    if (err != null) {
      Log.w("VPNService.uninstall err ${err.message.toString()}");
    }
    return convertErr(err);
  }

  static Future<ReturnResultError?> restart(Duration timeout) async {
    final profile = ProfileManager.getCurrent();
    if (profile == null) {
      return ReturnResultError("current profile is empty");
    }
    final prepareResult = await ProfileManager.prepare(profile);
    if (prepareResult != null) {
      return prepareResult;
    }
    var started = await getStarted();
    if (!started) {
      return null;
    }
    try {
      bool reinstall = await _prepareConfig(profile);
      if (reinstall) {
        await uninstall();
      }
    } catch (err, stacktrace) {
      return ReturnResultError(err.toString());
    }
    var setting = SettingManager.getConfig();
    if (Platform.isWindows) {
      final controlPort = ClashSettingManager.getControlPort();
      final mixedPort = ClashSettingManager.getMixedPort();
      var ports = [controlPort, mixedPort];

      FlutterVpnService.firewallAddPorts(ports, PathUtils.serviceExeName());
    }
    if (Platform.isIOS || Platform.isMacOS) {
      await FlutterVpnService.setAlwaysOn(false);
    }
    final enable = await getSystemProxyEnable();
    VpnServiceWaitResult result = await FlutterVpnService.restart(timeout);
    if (result.type == VpnServiceWaitType.timeout) {
      await stop();
      return ReturnResultError("service restart timeout");
    }
    if (result.type != VpnServiceWaitType.done) {
      Log.w(
        "VPNService.restart err ${result.type}:${result.err!.message.toString()}",
      );

      await stop();
      return convertErr(result.err);
    }
    String errorPath = await PathUtils.serviceStdErrorFilePath();
    String? content = await FileUtils.readAndDelete(errorPath);
    if (content != null && content.isNotEmpty) {
      await stop();
      return ReturnResultError(content);
    }
    if (Platform.isIOS || (Platform.isMacOS && setting.alwayOn)) {
      await FlutterVpnService.setAlwaysOn(true);
    }

    if (enable) {
      await setSystemProxy(true);
    }
    return null;
  }

  static Future<ReturnResultError?> start(Duration timeout) async {
    final profile = ProfileManager.getCurrent();
    if (profile == null) {
      return ReturnResultError("current profile is empty");
    }
    final prepareResult = await ProfileManager.prepare(profile);
    if (prepareResult != null) {
      return prepareResult;
    }
    try {
      bool reinstall = await _prepareConfig(profile);
      if (reinstall) {
        await uninstall();
      }
    } catch (err, stacktrace) {
      return ReturnResultError(err.toString());
    }
    var setting = SettingManager.getConfig();
    if (Platform.isWindows) {
      final controlPort = ClashSettingManager.getControlPort();
      final mixedPort = ClashSettingManager.getMixedPort();
      var ports = [controlPort, mixedPort];

      FlutterVpnService.firewallAddPorts(ports, PathUtils.serviceExeName());
    }
    VpnServiceWaitResult result = await FlutterVpnService.start(timeout);
    if (result.type == VpnServiceWaitType.timeout) {
      await stop();
      return ReturnResultError("service start timeout");
    }

    if (result.err != null) {
      Log.w("VPNService.start err ${result.err!.message.toString()}");
      await stop();
      return convertErr(result.err);
    }
    String errorPath = await PathUtils.serviceStdErrorFilePath();
    String? content = await FileUtils.readAndDelete(errorPath);
    if (content != null && content.isNotEmpty) {
      await stop();
      return ReturnResultError(content);
    }
    if (Platform.isIOS || (Platform.isMacOS && setting.alwayOn)) {
      await FlutterVpnService.setAlwaysOn(true);
    }

    if (SettingManager.getConfig().autoSetSystemProxy) {
      await setSystemProxy(true);
    }

    return null;
  }

  static Future<void> stop() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await FlutterVpnService.setAlwaysOn(false);
    }
    await setSystemProxy(false);
    await FlutterVpnService.stop();

    if (Platform.isWindows) {
      await uninstall();
    }
  }

  static bool getSupportSystemProxy() {
    return PlatformUtils.isPC();
  }

  static Future<void> setSystemProxy(bool enable) async {
    if (getSupportSystemProxy()) {
      try {
        final options = await getSystemProxyOptions();
        if (options.port == 0) {
          return;
        }
        if (enable) {
          await FlutterVpnService.setSystemProxy(await getSystemProxyOptions());
        } else {
          if (await getSystemProxyEnable()) {
            await FlutterVpnService.cleanSystemProxy();
          }
        }
      } catch (err) {
        Log.w("VPNService setSystemProxy exception:${err.toString()}");
      }
    }
  }

  static Future<bool> getSystemProxyEnable() async {
    if (!getSupportSystemProxy()) {
      return false;
    }
    final hostOptionsLocal = getSystemProxyOptionsLocalhost();
    bool enable = await FlutterVpnService.getSystemProxyEnable(
      hostOptionsLocal,
    );
    if (!enable) {
      final hostOptionsLan = await getSystemProxyOptionsLan();
      if (hostOptionsLan != null) {
        enable |= await FlutterVpnService.getSystemProxyEnable(hostOptionsLan);
      }
    }

    return enable;
  }

  static bool isRunAsAdmin() {
    return _runAsAdmin;
  }

  static Future<FlutterVpnServiceState> getState() async {
    return await FlutterVpnService.currentState;
  }

  static Future<bool> getStarted() async {
    FlutterVpnServiceState newState = await FlutterVpnService.currentState;
    if (newState == FlutterVpnServiceState.connected) {
      return true;
    }

    return false;
  }

  static Future<List<int?>> getPortsByPrefer(bool preferForward) async {
    var started = await getStarted();
    if (started) {
      final mixedPort = ClashSettingManager.getMixedPort();
      if (preferForward) {
        return [mixedPort, null];
      }
      return [null, mixedPort];
    }
    return [null];
  }

  static Future<int?> getPort() async {
    final mixedPort = ClashSettingManager.getMixedPort();
    var started = await getStarted();
    return started ? mixedPort : null;
  }

  static Future<ReturnResultError?> reload(Duration timeout) async {
    return restart(timeout);
  }

  static String getLaunchAtStartupTaskName() {
    return "${AppUtils.getName()} Autorun";
  }

  static Future<ReturnResultError?> setLaunchAtStartup(bool enable) async {
    if (PlatformUtils.isPC()) {
      try {
        if (enable) {
          if (Platform.isWindows) {
            bool admin = isRunAsAdmin();
            await FlutterVpnService.autoStartCreate(
              getLaunchAtStartupTaskName(),
              Platform.resolvedExecutable,
              processArgs: AppArgs.launchStartup,
              runElevated: admin,
            );
            return null;
          }
        } else {
          await FlutterVpnService.autoStartDelete(getLaunchAtStartupTaskName());
          await launchAtStartup.disable();
        }
      } catch (err, stacktrace) {
        return ReturnResultError(err.toString());
      }
    }
    return null;
  }

  static Future<bool> getLaunchAtStartup() async {
    if (PlatformUtils.isPC()) {
      try {
        if (Platform.isWindows) {
          if (await FlutterVpnService.autoStartIsActive(
            getLaunchAtStartupTaskName(),
          )) {
            return true;
          }
        }
        return await launchAtStartup.isEnabled();
      } catch (err, stacktrace) {
        return false;
      }
    }
    return false;
  }

  static ProxyOption getSystemProxyOptionsLocalhost() {
    return ProxyOption(
      localhost,
      ClashSettingManager.getMixedPort(),
      SettingManager.getConfig().systemProxyBypassDomain,
    );
  }

  static Future<ProxyOption?> getSystemProxyOptionsLan() async {
    if (!PlatformUtils.isPC()) {
      return null;
    }

    var host = localhost;
    List<NetInterfacesInfo> interfaces = await NetworkUtils.getInterfaces();
    if (interfaces.length == 1) {
      host = interfaces[0].address;
    } else {
      for (var face in interfaces) {
        if (Platform.isMacOS && face.name.startsWith("en")) {
          host = face.address;
          break;
        }
      }
    }

    return ProxyOption(
      host,
      ClashSettingManager.getMixedPort(),
      SettingManager.getConfig().systemProxyBypassDomain,
    );
  }

  static Future<ProxyOption> getSystemProxyOptions() async {
    final bypassDomain = SettingManager.getConfig().systemProxyBypassDomain;
    final mixedPort = ClashSettingManager.getMixedPort();
    if (Platform.isMacOS) {
      List<NetInterfacesInfo> interfaces = await NetworkUtils.getInterfaces(
        addressType: InternetAddressType.IPv4,
      );

      for (var face in interfaces) {
        if (face.name.startsWith("en")) {
          return ProxyOption(face.address, mixedPort, bypassDomain);
        }
      }
    }
    return ProxyOption(localhost, mixedPort, bypassDomain);
  }
}
