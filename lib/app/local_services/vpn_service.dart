// ignore_for_file: unused_catch_stack, empty_catches

import 'dart:convert';
import 'dart:io';

import 'package:clashmi/app/clash/clash_http_api.dart';
import 'package:clashmi/app/modules/clash_setting_manager.dart';
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

  static final List<
          void Function(
              FlutterVpnServiceState state, Map<String, String> params)>
      onEventStateChanged = [];

  static init() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (Platform.isWindows) {
      _runAsAdmin = await FlutterVpnService.isRunAsAdmin();
      FlutterVpnService.firewallAddApp(
          Platform.resolvedExecutable, PathUtils.getExeName());
      FlutterVpnService.firewallAddApp(
          PathUtils.serviceExePath(), PathUtils.serviceExeName());
    }

    launchAtStartup.setup(
        appName: packageInfo.appName,
        appPath: Platform.resolvedExecutable, //windows下开机启动的路径里不能有/,否则无法正常启动
        args: [AppArgs.launchStartup]);

    FlutterVpnService.onStateChanged(
        (FlutterVpnServiceState state, Map<String, String> params) async {
      for (var callback in onEventStateChanged) {
        callback(state, params);
      }
    });

    if (Platform.isWindows) {
      //启动后就把之前残留的进程杀掉,后续验证端口需要用
      await stop();
    }
  }

  static Future<void> uninit() async {}

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

  static Future<bool> _prepareConfig(String profileName) async {
    final controlPort = ClashSettingManager.getControlPort();
    final mixedPort = ClashSettingManager.getMixedPort();
    var excludePorts = [
      controlPort,
    ];
    if (mixedPort != null) {
      excludePorts.add(mixedPort);
    }

    String name = AppUtils.getName();
    String vpnName = name;
    String configFilePath = await PathUtils.serviceConfigFilePath();
    String installReferrer = await InstallReferrerUtils.getString();

    VpnServiceConfig config = VpnServiceConfig();
    config.control_port = controlPort;
    config.base_dir = await PathUtils.profileDir();
    config.work_dir = PathUtils.appAssetsDir();
    config.cache_dir = await PathUtils.cacheDir();
    config.core_path = path.join(await PathUtils.profilesDir(), profileName);
    config.patch_core_path = SettingManager.getConfig().coreSettingOverwrite
        ? await PathUtils.serviceCoreSettingFilePath()
        : await PathUtils.serviceCoreSettingNoOverwriteFilePath();
    config.log_path = await PathUtils.serviceLogFilePath();
    config.err_path = await PathUtils.serviceStdErrorFilePath();
    config.id = await Did.getDid();
    config.version = AppUtils.getBuildinVersion();
    config.name = name;
    config.secret = await ClashHttpApi.getSecret();
    config.install_refer = installReferrer;

    FlutterVpnService.prepareConfig(
      config: config,
      tunnelServicePath: PathUtils.serviceExePath(),
      configFilePath: configFilePath,
      systemExtension: false,
      bundleIdentifier: getBundleId(),
      uiServerAddress: name,
      uiLocalizedDescription: vpnName,
      excludePorts: excludePorts,
    );

    await ClashSettingManager.saveSetting();
    await ClashSettingManager.saveSettingNoOverwrite();

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

  static Future<ReturnResultError?> restart(
      String profileName, Duration timeout) async {
    var started = await getStarted();
    if (!started) {
      return null;
    }
    bool reinstall = await _prepareConfig(profileName);
    if (reinstall) {
      await uninstall();
    }

    var setting = SettingManager.getConfig();

    if (Platform.isWindows) {
      if (setting.proxy.host == SettingConfigItemProxy.hostNetwork) {
        final controlPort = ClashSettingManager.getControlPort();
        final mixedPort = ClashSettingManager.getMixedPort();
        var ports = [
          controlPort,
        ];
        if (mixedPort != null) {
          ports.add(mixedPort);
        }

        FlutterVpnService.firewallAddPorts(ports, PathUtils.serviceExeName());
      }
    }
    if (Platform.isIOS || Platform.isMacOS) {
      await FlutterVpnService.setAlwaysOn(false);
    }

    VpnServiceWaitResult result = await FlutterVpnService.restart(timeout);
    if (result.type == VpnServiceWaitType.timeout) {
      await stop();
      return ReturnResultError("service restart timeout");
    }
    if (result.type != VpnServiceWaitType.done) {
      Log.w(
          "VPNService.restart err ${result.type}:${result.err!.message.toString()}");

      await stop();
      return convertErr(result.err);
    }
    String errorPath = await PathUtils.serviceStdErrorFilePath();
    String? content = await FileUtils.readAndDelete(errorPath);
    if (content != null && content.isNotEmpty) {
      await stop();
      return ReturnResultError(content);
    }
    if (Platform.isIOS || Platform.isMacOS) {
      if (setting.alwayOn) {
        await FlutterVpnService.setAlwaysOn(setting.alwayOn);
      }
    }

    return null;
  }

  static Future<ReturnResultError?> start(
      String profileName, Duration timeout) async {
    bool reinstall = await _prepareConfig(profileName);
    if (reinstall) {
      await uninstall();
    }
    var setting = SettingManager.getConfig();
    if (Platform.isWindows) {
      if (setting.proxy.host == SettingConfigItemProxy.hostNetwork) {
        final controlPort = ClashSettingManager.getControlPort();
        final mixedPort = ClashSettingManager.getMixedPort();
        var ports = [
          controlPort,
        ];
        if (mixedPort != null) {
          ports.add(mixedPort);
        }
        FlutterVpnService.firewallAddPorts(ports, PathUtils.serviceExeName());
      }
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
    if (Platform.isIOS || Platform.isMacOS) {
      if (setting.alwayOn) {
        await FlutterVpnService.setAlwaysOn(setting.alwayOn);
      }
    }

    var proxy = SettingManager.getConfig().proxy;
    if (proxy.autoSetSystemProxy) {
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
          await FlutterVpnService.setSystemProxy(options);
        } else {
          if (await FlutterVpnService.getSystemProxyEnable(options)) {
            await FlutterVpnService.cleanSystemProxy();
          }
        }
      } catch (err) {
        Log.w("VPNService setSystemProxy exception:${err.toString()}");
      }
    }
  }

  static Future<bool> getSystemProxy() async {
    if (getSupportSystemProxy()) {
      final options = await getSystemProxyOptions();
      if (options.port == 0) {
        return false;
      }
      bool enable = await FlutterVpnService.getSystemProxyEnable(options);
      return enable;
    }
    return false;
  }

  static bool isRunAsAdmin() {
    return _runAsAdmin;
  }

  static Future<bool> getTunMode() async {
    /* if (!SettingManager.getConfig().tun.enable) {
      return false;
    }*/
    if (Platform.isWindows) {
      return isRunAsAdmin();
    }
    return true;
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

  static Future<List<int?>> getPortsBySetting() async {
    bool start = await getStarted();
    if (start) {
      final mixedPort = ClashSettingManager.getMixedPort();
      return [mixedPort, null];
    }
    return [null];
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

  static Future<ReturnResultError?> reload(
      String profileName, Duration timeout) async {
    //reload经常因为连接中的请求造成阻塞,重新载入配置文件可能延迟高,新配置生效不及时
    return restart(profileName, timeout);
    /*  var started = await getStarted();
    if (!started) {
      return ReturnResultError("service is not running");
    }
    VpnServiceResultError? err = await FlutterVpnService.reload();
    if (err != null) {
      return convertErr(err);
    }
    return null;*/
  }

  static String getBundleId() {
    if (Platform.isIOS || Platform.isMacOS) {
      return AppUtils.getBundleId();
    }
    return "";
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
                getLaunchAtStartupTaskName(), Platform.resolvedExecutable,
                processArgs: AppArgs.launchStartup, runElevated: admin);
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
              getLaunchAtStartupTaskName())) {
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

  static Future<ProxyOption> getSystemProxyOptions() async {
    final mixedPort = ClashSettingManager.getMixedPort();
    if (mixedPort == null) {
      return ProxyOption(localhost, 0);
    }

    if (Platform.isMacOS) {
      List<NetInterfacesInfo> interfaces = await NetworkUtils.getInterfaces(
          addressType: InternetAddressType.IPv4);

      for (var face in interfaces) {
        if (face.name.startsWith("en")) {
          return ProxyOption(face.address, mixedPort);
        }
      }
    }
    return ProxyOption(localhost, mixedPort);
  }
}
