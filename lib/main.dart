// ignore_for_file: empty_catches, unused_catch_stack

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:clashmi/app/local_services/vpn_service.dart';
import 'package:clashmi/app/modules/auto_update_manager.dart';
import 'package:clashmi/app/modules/biz.dart';
import 'package:clashmi/app/modules/board_provider_manager.dart';
import 'package:clashmi/app/modules/board_session_persistent_manager.dart';
import 'package:clashmi/app/modules/remote_config_manager.dart';
import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/app/utils/app_args.dart';
import 'package:clashmi/app/utils/app_lifecycle_state_notify.dart';
import 'package:clashmi/app/utils/app_utils.dart';
import 'package:clashmi/app/utils/device_utils.dart';
import 'package:clashmi/app/utils/log.dart';
import 'package:clashmi/app/utils/move_to_background_utils.dart';
import 'package:clashmi/app/utils/path_utils.dart';
import 'package:clashmi/app/utils/platform_utils.dart';
import 'package:clashmi/app/utils/system_scheme_utils.dart';
import 'package:clashmi/app/utils/windows_version_helper.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/home_screen.dart';
import 'package:clashmi/screens/launch_failed_screen.dart';
import 'package:clashmi/screens/theme_data_dark.dart';
import 'package:clashmi/screens/themes.dart';
import 'package:clashmi/screens/widgets/routes.dart';
import 'package:clashmi/tray.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_single_instance/flutter_single_instance.dart';
import 'package:libclash_vpn_service/vpn_service.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

List<String> processArgs = [];
StartFailedReason? startFailedReason;
String? startFailedReasonDesc;
bool linuxRotate180Fix = false;

void main(List<String> args) async {
  processArgs = args;
  linuxRotate180Fix =
      Platform.isLinux && Platform.environment["CLASHMI_ROTATE_180"] == "1";
  WidgetsFlutterBinding.ensureInitialized();
  await LocaleSettings.useDeviceLocale();
  await VPNService.initABI();
  await RemoteConfigManager.init();
  await SettingManager.init();
  Log.setLevel(SettingManager.getConfig().logLevel);
  await BoardSessionPersistentManager.init();
  await BoardProviderManager.init();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    await _ensureSingleInstanceOrExit();
  }

  await run(args);
}

Future<void> run(List<String> args) async {
  try {
    do {
      String profileDir = await PathUtils.profileDir();
      if (profileDir.isEmpty) {
        startFailedReason = StartFailedReason.invalidProfile;
        break;
      }
      await Log.init();
      String buildVersion = AppUtils.getBuildinVersion();
      String exePath = Platform.resolvedExecutable;
      Log.w(
        'launch $buildVersion $exePath, $args, ${Directory.current.absolute.path}, $profileDir',
      );
      String cache = await PathUtils.cacheDir();
      if (cache.isEmpty) {
        startFailedReason = StartFailedReason.invalidProfile;
        break;
      }
      String version = await AppUtils.getPackgetVersion();
      if (buildVersion != version) {
        startFailedReason = StartFailedReason.invalidVersion;
        break;
      }
      if (PlatformUtils.isPC()) {
        if (path.basename(exePath).toLowerCase() !=
            PathUtils.getExeName().toLowerCase()) {
          startFailedReason = StartFailedReason.invalidProcess;
          break;
        }
      }
      const inProduction = bool.fromEnvironment("dart.vm.product");
      if (inProduction) {
        if (Platform.isMacOS) {
          if (!path.isWithin("/Applications", exePath)) {
            startFailedReason = StartFailedReason.invalidInstallPath;
            break;
          }
        }
      }
      if (Platform.isWindows) {
        var tmp = await getTemporaryDirectory();
        if (exePath.contains("UNC/") ||
            exePath.contains("UNC\\") ||
            path.isWithin(tmp.absolute.path, exePath)) {
          startFailedReason = StartFailedReason.invalidInstallPath;
          break;
        }

        if (VersionHelper.instance.majorVersion != 0 &&
            VersionHelper.instance.majorVersion < 10) {
          startFailedReason = StartFailedReason.systemVersionLow;
          startFailedReasonDesc =
              "Current: ${VersionHelper.instance.majorVersion}\nMinimum required: >= 10.0";
          break;
        }
      } else if (Platform.isAndroid) {
        String version = await FlutterVpnService.getSystemVersion();
        int? v = int.tryParse(version);
        if (v != null && v < 26) {
          startFailedReason = StartFailedReason.systemVersionLow;
          String osVersion = "";
          if (v == 25) {
            osVersion = "7.1";
          } else if (v == 24) {
            osVersion = "7.0";
          } else if (v == 23) {
            osVersion = "6.0";
          } else {
            osVersion = "< 6.0";
          }
          startFailedReasonDesc =
              "Current: $osVersion\nMinimum required: >= 8.0";
          break;
        }
      }
    } while (false);

    if (PlatformUtils.isPC()) {
      await windowManager.ensureInitialized();
      const inProduction = bool.fromEnvironment("dart.vm.product");
      if (inProduction) {
        //await windowManager.setResizable(false);
        //await windowManager.setMaximizable(false);
        if (Platform.isLinux) {
          await windowManager.setMinimumSize(Size(400, 740));
        } else {
          await windowManager.setMinimumSize(Size(400, 700));
        }
      }

      await windowManager.center();
    }

    await AutoUpdateManager.init();

    bool disableOrientation = await DeviceUtils.disableOrientation();
    if (!disableOrientation) {
      if (SettingManager.getConfig().ui.autoOrientation) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.portraitDown,
          DeviceOrientation.landscapeRight,
        ]);
      } else {
        SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      }
    }
  } catch (err, stacktrace) {
    startFailedReason = StartFailedReason.exception;
    startFailedReasonDesc = err.toString();
    String cmdline = args.toString();
    Log.w("main.run exception: ${err.toString()}, $cmdline");
  }
  try {
    await FastCachedImageConfig.init(subDir: AppUtils.getName());
    SettingConfigItemUIScreen.fastCachedImageConfigInited = true;
  } catch (err, stacktrace) {
    SettingConfigItemUIScreen.fastCachedImageConfigInited = false;
    Log.w("FastCachedImageConfig.init() exception: ${err.toString()}");
  }
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }
  runApp(TranslationProvider(child: const MyApp()));
}

Future<void> _ensureSingleInstanceOrExit() async {
  FlutterSingleInstance.debugMode = false;
  // Use a stable lock file key. On Linux, process names can vary by launch
  // path (e.g. xdg-open/AppImage), which breaks single-instance detection.
  FlutterSingleInstance.processName = AppUtils.getId();
  FlutterSingleInstance.onFocus = (metadata) async {
    await windowManager.show();
    var args = metadata["args"] as List<dynamic>?;
    if (args != null && args.isNotEmpty) {
      String schemeArg = args.firstWhere((element) {
        final arg = element.toString().trim();
        return arg.startsWith(SystemSchemeUtils.getClashSchemeWith()) ||
            arg.startsWith(SystemSchemeUtils.getClashMiSchemeWith());
      }, orElse: () => '');
      if (schemeArg.isNotEmpty) {
        Biz.onEventSingletonInstance?.call(schemeArg);
      }
    }
  };

  final singleInstance = FlutterSingleInstance();
  final isFirst = await singleInstance.isFirstInstance(
    maxRetries: Platform.isLinux ? 5 : 1,
    retryInterval: const Duration(milliseconds: 250),
  );

  if (!isFirst) {
    try {
      await singleInstance.focus({"args": processArgs});
    } catch (err) {
      Log.w("single instance focus exception: ${err.toString()}");
    }

    // Never continue launching a second process.
    exit(0);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp>
    with WidgetsBindingObserver, WindowListener {
  bool _launchAtStartup = false;
  bool _windowVisibleForMac = false;
  Tray? _tray;
  String _trafficOld = "";
  String _speedOld = "";
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    if (PlatformUtils.isPC()) {
      windowManager.addListener(this);
      windowManager.setPreventClose(true);
      _tray = Tray();
      _tray!.init(
        onOpen: () async {
          if (await windowManager.isMinimized()) {
            await windowManager.restore();
          } else {
            await windowManager.show();
            onWindowRestore();
          }
        },
        onExit: () async {
          await _quit();
        },
      );
    }
    if (Platform.isMacOS) {
      Biz.onEventTrafficChanged.add((String traffic, String speed) {
        if (!SettingManager.getConfig().showTrayTraffic) {
          traffic = "";
          speed = "";
        }
        if (_trafficOld != traffic || _speedOld != speed) {
          _trafficOld = traffic;
          _speedOld = speed;
          if (traffic.isEmpty && speed.isEmpty) {
            _tray?.setIconTitleForConnected("");
          } else if (traffic.isNotEmpty && speed.isNotEmpty) {
            _tray?.setIconTitleForConnected("$traffic $speed");
          } else if (traffic.isNotEmpty) {
            _tray?.setIconTitleForConnected(traffic);
          } else if (speed.isNotEmpty) {
            _tray?.setIconTitleForConnected(speed);
          } else {
            _tray?.setIconTitleForConnected("");
          }
        }
      });
    }

    AppLifecycleStateNofity.init();
    LocaleSettings.getLocaleStream().listen((event) {});
    String launchStartupArg = processArgs.firstWhere(
      (element) => element == AppArgs.launchStartup,
      orElse: () => '',
    );
    _launchAtStartup = launchStartupArg.isNotEmpty;

    AppLifecycleStateNofity.stateLaunch(_launchAtStartup);
    _init();
  }

  @override
  void dispose() {
    AppLifecycleStateNofity.uninit();
    WidgetsBinding.instance.removeObserver(this);
    if (PlatformUtils.isPC()) {
      windowManager.removeListener(this);
      _tray?.dispose();
      _tray = null;
    }

    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.resumed:
        AppLifecycleStateNofity.stateResumed("resumed");
        break;
      case AppLifecycleState.inactive:
        AppLifecycleStateNofity.stateInactive("inactive");
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.paused:
        AppLifecycleStateNofity.statePaused("paused");
        break;
      case AppLifecycleState.hidden:
        AppLifecycleStateNofity.stateInactive("hidden");
        break;
    }
  }

  @override
  Future<AppExitResponse> didRequestAppExit() async {
    await _quit();
    return AppExitResponse.cancel;
  }

  @override
  void didHaveMemoryPressure() {
    Log.w("memoryPressure");
  }

  @override
  Widget build(BuildContext context) {
    String schemeArg = processArgs.firstWhere((element) {
      final arg = element.trim();
      return arg.startsWith(SystemSchemeUtils.getClashSchemeWith()) ||
          arg.startsWith(SystemSchemeUtils.getClashMiSchemeWith());
    }, orElse: () => '');

    List<NavigatorObserver> observers = [];

    observers.add(AppRouteObserver.instance);

    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: Themes())],
      child: Consumer<Themes>(
        builder: (context, appTheme, _) {
          Provider.of<Themes>(
            context,
          ).setTheme(SettingManager.getConfig().ui.theme, false);
          Widget app = Shortcuts(
            shortcuts: const {
              SingleActivator(LogicalKeyboardKey.select): ActivateIntent(),
            },
            child: MaterialApp(
              //showSemanticsDebugger: false,
              debugShowCheckedModeBanner: false,
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              navigatorObservers: observers,
              home: PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, result) {
                  if (Platform.isAndroid || Platform.isIOS) {
                    MoveToBackgroundUtils.moveToBackground();
                  }
                },
                child: startFailedReason != null
                    ? LaunchFailedScreen(
                        startFailedReason: startFailedReason!,
                        startFailedReasonDesc: startFailedReasonDesc,
                      )
                    : HomeScreen(launchUrl: schemeArg.trim()),
              ),
              builder: SettingManager.getConfig().ui.disableFontScaler
                  ? (context, widget) {
                      return MediaQuery(
                        data: MediaQuery.of(
                          context,
                        ).copyWith(textScaler: TextScaler.noScaling),
                        child: widget!,
                      );
                    }
                  : null,
              themeMode: appTheme.themeMode(),
              theme: appTheme.themeData(context),
              darkTheme: ThemeDataDark.theme(context),
            ),
          );

          if (linuxRotate180Fix) {
            // Workaround for some Linux devices where Flutter content is upside down.
            app = RotatedBox(quarterTurns: 2, child: app);
          }

          return app;
        },
      ),
    );
  }

  @override
  void onWindowClose() async {
    Log.d("onWindowClose");
    await windowManager.hide();
    _windowVisibleForMac = false;
    AppLifecycleStateNofity.statePaused("close");
  }

  @override
  void onWindowMinimize() {
    _windowVisibleForMac = false;
    Log.d("onWindowMinimize");
    AppLifecycleStateNofity.statePaused("minimize");
  }

  @override
  void onWindowRestore() {
    _windowVisibleForMac = true;
    Log.d("onWindowRestore");
    AppLifecycleStateNofity.stateResumed("restore");
  }

  @override
  void onWindowFocus() {
    if (Platform.isMacOS) {
      if (!_windowVisibleForMac) {
        Log.d("onWindowFocus");
        _windowVisibleForMac = true;
        AppLifecycleStateNofity.stateResumed("restore");
      }
    }
  }

  @override
  void onWindowDeviceShutdown() {
    Log.d("main.dart onWindowDeviceShutdown");
    _quit();
  }

  @override
  void onWindowUserSessionDisconnect() {
    Log.d("main.dart onWindowUserSessionDisconnect");
  }

  void firstShowWindow(bool forceShow) {
    if (!PlatformUtils.isPC()) {
      return;
    }
    windowManager.waitUntilReadyToShow(null, () async {
      final settings = SettingManager.getConfig();
      if (Platform.isMacOS && settings.hideDockIcon) {
        FlutterVpnService.hideDockIcon(true);
      }
      if (forceShow || (Platform.isWindows && !settings.ui.hideAfterLaunch)) {
        await windowManager.show();
        onWindowRestore();
      }
    });
  }

  Future<void> _init() async {
    Biz.onEventExit = (() {
      _quit();
    });

    Biz.onEventVPNStateChanged = ((bool connected) {
      if (PlatformUtils.isPC()) {
        _tray?.setIconDisconneted(!connected);
        if (Platform.isMacOS && !connected) {
          _trafficOld = "";
          _speedOld = "";
          _tray?.setIconTitleForConnected("");
        }
      }
    });
    if (startFailedReason == null) {
      Biz.onEventInitHomeFinish.add(() {
        firstShowWindow(false);
      });

      await Biz.init(_launchAtStartup);
    } else {
      firstShowWindow(true);
    }
  }

  Future<void> _uninit() async {
    if (PlatformUtils.isPC()) {
      await windowManager.hide();
    }
    if (startFailedReason == null) {
      await Biz.uninit();
    }
  }

  Future<void> _quit() async {
    await _uninit();
    Future.delayed(const Duration(seconds: 0), () async {
      await Log.uninit();
      await ServicesBinding.instance.exitApplication(AppExitType.required);
    });
  }
}
