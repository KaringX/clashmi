// ignore_for_file: empty_catches, unused_catch_stack

import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:clashmi/app/modules/biz.dart';
import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/app/utils/app_args.dart';
import 'package:clashmi/app/utils/app_lifecycle_state_notify.dart';
import 'package:clashmi/app/utils/log.dart';
import 'package:clashmi/app/utils/move_to_background_utils.dart';
import 'package:clashmi/app/utils/platform_utils.dart';
import 'package:clashmi/app/utils/system_scheme_utils.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/home_screen.dart';
import 'package:clashmi/screens/launch_failed_screen.dart';
import 'package:clashmi/screens/scheme_handler.dart';
import 'package:clashmi/screens/theme_data_dark.dart';
import 'package:clashmi/screens/themes.dart';
import 'package:clashmi/screens/widgets/routes.dart';
import 'package:clashmi/tray.dart';
import 'package:clashmi/windows_bounds.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:libclash_vpn_service/vpn_service.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

class MyApp extends StatefulWidget {
  final List<String> args;
  final StartFailedReason? startFailedReason;
  final String? startFailedReasonDesc;
  const MyApp({
    super.key,
    required this.args,
    required this.startFailedReason,
    required this.startFailedReasonDesc,
  });
  @override
  State<MyApp> createState() => MyAppState();
}

class MyAppState extends State<MyApp>
    with WidgetsBindingObserver, WindowListener {
  bool _launchAtStartup = false;
  bool _windowVisibleForMac = false;
  bool linuxRotate180Fix = false;
  Tray? _tray;
  String _trafficOld = "";
  String _speedOld = "";
  @override
  void initState() {
    super.initState();
    linuxRotate180Fix =
        Platform.isLinux && Platform.environment["CLASHMI_ROTATE_180"] == "1";
    WidgetsBinding.instance.addObserver(this);
    if (PlatformUtils.isPC()) {
      windowManager.addListener(this);
      windowManager.setPreventClose(true);
      _tray = Tray();
      _tray!.init(
        openExitOnly: widget.startFailedReason != null,
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
            _tray?.setTitle("");
          } else if (traffic.isNotEmpty && speed.isNotEmpty) {
            _tray?.setTitle("$traffic $speed");
          } else if (traffic.isNotEmpty) {
            _tray?.setTitle(traffic);
          } else if (speed.isNotEmpty) {
            _tray?.setTitle(speed);
          } else {
            _tray?.setTitle("");
          }
        }
      });
    }
    AppLifecycleStateNofity.init();
    //LocaleSettings.getLocaleStream().listen((event) {});
    String launchStartupArg = widget.args.firstWhere(
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
    String schemeArg = widget.args.firstWhere((element) {
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
              SingleActivator(LogicalKeyboardKey.select):
                  ActivateIntent(), // for android tv OK/Select button
            },
            child: MaterialApp(
              //showSemanticsDebugger: false,
              debugShowCheckedModeBanner: false,
              locale: TranslationProvider.of(context).flutterLocale,
              supportedLocales: AppLocaleUtils.supportedLocales,
              localizationsDelegates: GlobalMaterialLocalizations.delegates,
              navigatorObservers: observers,
              // Deep links delivered by the engine arrive as route names; without
              // this fallback Flutter crashes in _onUnknownRoute. The placeholder
              // dispatches clashmi:// URLs to SchemeHandler and is then removed.
              onUnknownRoute: (settings) => PageRouteBuilder<void>(
                settings: settings,
                opaque: false,
                transitionDuration: Duration.zero,
                reverseTransitionDuration: Duration.zero,
                pageBuilder: (context, _, _) {
                  final name = settings.name ?? '';
                  final route = ModalRoute.of(context);
                  Log.w('Unknown route: $name\n');
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    final navigator = Navigator.maybeOf(context);
                    if ((name.startsWith(
                              SystemSchemeUtils.getClashSchemeWith(),
                            ) ||
                            name.startsWith(
                              SystemSchemeUtils.getClashMiSchemeWith(),
                            )) &&
                        context.mounted) {
                      await SchemeHandler.handle(context, name);
                    }
                    if (navigator != null && route != null && route.isActive) {
                      navigator.removeRoute(route);
                    }
                  });
                  return const SizedBox.shrink();
                },
              ),
              home: PopScope(
                canPop: false,
                onPopInvokedWithResult: (didPop, result) {
                  if (Platform.isAndroid || Platform.isIOS) {
                    MoveToBackgroundUtils.moveToBackground();
                  }
                },
                child: widget.startFailedReason != null
                    ? LaunchFailedScreen(
                        startFailedReason: widget.startFailedReason!,
                        startFailedReasonDesc: widget.startFailedReasonDesc,
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
    await WindowBounds.saveWindowBounds();
    await windowManager.hide();
    _windowVisibleForMac = false;
    AppLifecycleStateNofity.statePaused("close");
  }

  @override
  void onWindowResize() => WindowBounds.updateWindowBounds();

  @override
  void onWindowResized() => WindowBounds.updateWindowBounds();

  @override
  void onWindowMove() => WindowBounds.updateWindowBounds();

  @override
  void onWindowMoved() => WindowBounds.updateWindowBounds();

  @override
  void onWindowMaximize() => WindowBounds.updateWindowBounds();

  @override
  void onWindowUnmaximize() => WindowBounds.updateWindowBounds();

  @override
  void onWindowMinimize() async {
    _windowVisibleForMac = false;
    Log.d("onWindowMinimize");
    AppLifecycleStateNofity.statePaused("minimize");
    await WindowBounds.saveWindowBounds();
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
      if (forceShow || !settings.ui.hideAfterLaunch) {
        await windowManager.show();
        onWindowRestore();
      } else {
        await windowManager.hide();
      }
    });
  }

  Future<void> _init() async {
    Biz.onEventExit = (() {
      _quit();
    });

    Biz.onEventVPNStateChanged = ((bool connected) {
      if (PlatformUtils.isPC()) {
        _tray?.setConnected(connected);
        if (Platform.isMacOS && !connected) {
          _trafficOld = "";
          _speedOld = "";
          _tray?.setTitle("");
        }
      }
    });
    if (widget.startFailedReason == null) {
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
      await WindowBounds.saveWindowBounds();
      await windowManager.hide();
    }
    if (widget.startFailedReason == null) {
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
