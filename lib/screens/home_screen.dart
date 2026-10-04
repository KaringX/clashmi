// ignore_for_file: prefer_interpolation_to_compose_strings, use_build_context_synchronously, empty_catches, unused_catch_stack

import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:clashmi/app/local_services/vpn_service.dart';
import 'package:clashmi/app/modules/auto_update_manager.dart';
import 'package:clashmi/app/modules/biz.dart';
import 'package:clashmi/app/modules/remote_config_manager.dart';
import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/app/utils/app_lifecycle_state_notify.dart';
import 'package:clashmi/app/utils/app_utils.dart';
import 'package:clashmi/app/utils/error_reporter_utils.dart';
import 'package:clashmi/app/utils/local_storage.dart';
import 'package:clashmi/app/utils/log.dart';
import 'package:clashmi/app/utils/system_scheme_utils.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/home_screen_widgets.dart';
import 'package:clashmi/screens/language_settings_screen.dart';
import 'package:clashmi/screens/local_image_provider.dart';
import 'package:clashmi/screens/scheme_handler.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/themes.dart';
import 'package:clashmi/screens/user_agreement_screen.dart';
import 'package:clashmi/screens/webview_helper.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hotkey_manager/hotkey_manager.dart';
import 'package:libclash_vpn_service/state.dart';
import 'package:protocol_handler/protocol_handler.dart';
import 'package:provider/provider.dart';
import 'package:window_manager/window_manager.dart';

class HomeScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return const RouteSettings(name: "/");
  }

  final String launchUrl;
  const HomeScreen({super.key, required this.launchUrl});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends LasyRenderingState<HomeScreen>
    with WidgetsBindingObserver, ProtocolListener, AfterLayoutMixin {
  static const String userAgreementAgreedIdKey = 'userAgreementAgreedKey';

  bool _onInitAllFinished = false;
  String _initUrl = "";
  String? _invalidBackgroundImageUrl;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
    protocolHandler.addListener(this);
    Biz.onEventSingletonInstance = (String url) {
      Log.w("onEventSingletonInstance: $url");
      if (!mounted) {
        return;
      }
      SchemeHandler.handle(context, url);
    };
    _initUrl = widget.launchUrl;
    _init();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    Biz.initHomeFinish();
    ErrorReporterUtils.register(() {
      if (!mounted) {
        return;
      }
      final tcontext = Translations.of(context);
      DialogUtils.showAlertDialog(
        context,
        tcontext.meta.deviceNoSpace,
        showCopy: true,
        showFAQ: true,
        withVersion: true,
      );
    });

    Future.delayed(const Duration(seconds: 0), () async {
      showAgreement();
    });

    Future.delayed(const Duration(seconds: 0), () async {
      if (Platform.isMacOS) {
        await hotKeyManager.unregisterAll();
        HotKey hotKey = HotKey(
          key: PhysicalKeyboardKey.keyW,
          modifiers: [HotKeyModifier.meta],
          scope: HotKeyScope.inapp,
        );
        await hotKeyManager.register(
          hotKey,
          keyDownHandler: (hotKey) {
            windowManager.hide();
          },
        );
      }
    });
  }

  Future<bool> futureBool(bool value) async {
    return value;
  }

  void showAgreement() async {
    String? agreement;
    try {
      if (Platform.isIOS || Platform.isMacOS) {
        agreement = await LocalStorage.read(userAgreementAgreedIdKey);
      } else {
        agreement = "true";
      }
    } catch (e) {}

    if (agreement != null) {
      /*String? installer = await AutoUpdateManager.checkReplace();
      if (installer != null) {
        await Navigator.push(
            context,
            MaterialPageRoute(
                settings: VersionUpdateScreen.routeSettings(),
                fullscreenDialog: true,
                builder: (context) => const VersionUpdateScreen(
                      force: true,
                    )));
      }*/
      return;
    }
    if (Platform.isIOS || Platform.isMacOS) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          settings: UserAgreementScreen.routeSettings(),
          fullscreenDialog: true,
          builder: (context) => const UserAgreementScreen(),
        ),
      );
      LocalStorage.write(userAgreementAgreedIdKey, "true");
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        settings: LanguageSettingsScreen.routeSettings(),
        fullscreenDialog: true,
        builder: (context) => LanguageSettingsScreen(
          canPop: false,
          canGoBack: false,
          nextText: () {
            var tcontext = Translations.of(context);
            return tcontext.meta.done;
          },
        ),
      ),
    );
  }

  void _init() async {
    Biz.onEventInitAllFinish.add(() async {
      await _onInitAllFinish();
    });
  }

  Future<void> _onInitAllFinish() async {
    AutoUpdateManager.onEventCheck.add(() {
      setState(() {});
    });
    DialogUtils.faqCallback = (BuildContext context, String text) async {
      final tcontext = Translations.of(context);
      var remoteConfig = RemoteConfigManager.getConfig();
      await WebviewHelper.loadUrl(
        context,
        remoteConfig.faq,
        "faqCallback",
        title: tcontext.meta.faq,
      );
    };
    VPNService.onEventStateChanged.add(_onStateChanged);

    if (Platform.isWindows || Platform.isLinux) {
      final clashRegisterErr = await SystemSchemeUtils.register(
        SystemSchemeUtils.getClashScheme(),
      );
      if (clashRegisterErr != null) {
        Log.w("register clash scheme failed: $clashRegisterErr");
      }

      final clashMiRegisterErr = await SystemSchemeUtils.register(
        SystemSchemeUtils.getClashMiScheme(),
      );
      if (clashMiRegisterErr != null) {
        Log.w("register clashmi scheme failed: $clashMiRegisterErr");
      }
    }

    _onInitAllFinished = true;

    setState(() {});

    if (_initUrl.isNotEmpty) {
      await SchemeHandler.handle(context, _initUrl);
      _initUrl = "";
    }

    setState(() {});
  }

  Future<void> _onStateChanged(
    FlutterVpnServiceState state,
    Map<String, String> params,
  ) async {
    if (state == FlutterVpnServiceState.disconnected) {
      Biz.vpnStateChanged(false);
    } else if (state == FlutterVpnServiceState.connecting) {
    } else if (state == FlutterVpnServiceState.connected) {
      if (!AppLifecycleStateNofity.isPaused()) {}

      Biz.vpnStateChanged(true);
    } else if (state == FlutterVpnServiceState.reasserting) {
    } else if (state == FlutterVpnServiceState.disconnecting) {
    } else {}

    setState(() {});
  }

  @override
  void onProtocolUrlReceived(String url) {
    Log.i("onProtocolUrlReceived: $url");
    if (!mounted) {
      return;
    }
    if (!_onInitAllFinished) {
      _initUrl = url;
      return;
    }
    SchemeHandler.handle(context, url);
  }

  @override
  void dispose() {
    protocolHandler.removeListener(this);
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var themes = Provider.of<Themes>(context, listen: false);
    final theme = Theme.of(context);
    Color? color = theme.colorScheme.surface;
    final decoration = getBackgroundDecoration();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: AppBar(
          systemOverlayStyle: SystemUiOverlayStyle(
            systemNavigationBarIconBrightness: decoration == null
                ? themes.getStatusBarIconBrightness(context)
                : Brightness
                      .light, //must be light if has decoration, or transparent does not work if light theme on android
            systemNavigationBarColor: decoration == null
                ? color
                : Colors.transparent,
            systemNavigationBarDividerColor: Colors.transparent,
            statusBarColor: decoration == null ? color : Colors.transparent,
            statusBarBrightness: themes.getStatusBarBrightness(context),
            statusBarIconBrightness: themes.getStatusBarIconBrightness(context),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: decoration,
        child: SafeArea(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          AppUtils.getName(),
                          style: const TextStyle(
                            fontWeight: ThemeConfig.kFontWeightTitle,
                            fontSize: ThemeConfig.kFontSizeTitle,
                          ),
                        ),
                        SizedBox(height: 10),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        HomeScreenWidgetPart1(),
                        SizedBox(height: 15),
                        HomeScreenWidgetPart2(
                          onUpdate: () {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration? getBackgroundDecoration() {
    var settingConfig = SettingManager.getConfig();
    if (settingConfig.uiScreen.backgroundImageType ==
        SettingConfigItemUIScreen.backgroundTypeDisable) {
      return null;
    }
    if (settingConfig.uiScreen.backgroundImageType ==
            SettingConfigItemUIScreen.backgroundTypeLocal &&
        settingConfig.uiScreen.backgroundImageLocal.isNotEmpty) {
      return BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: LocalImageProvider(
            settingConfig.uiScreen.backgroundImageLocal,
          ),
        ),
      );
    }
    if (settingConfig.uiScreen.backgroundImageType ==
            SettingConfigItemUIScreen.backgroundTypeRemote &&
        settingConfig.uiScreen.backgroundImageUrl.isNotEmpty &&
        SettingConfigItemUIScreen.fastCachedImageConfigInited) {
      final backgroundImageUrl = settingConfig.uiScreen.backgroundImageUrl;
      if (_invalidBackgroundImageUrl == backgroundImageUrl) {
        return null;
      }

      return BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: FastCachedImageProvider(backgroundImageUrl),
          onError: (Object error, StackTrace? stackTrace) {
            Log.w(
              "fast_cached_network_image background image: $backgroundImageUrl error:${error.toString()}",
            );
            unawaited(
              FastCachedImageConfig.deleteCachedImage(
                imageUrl: backgroundImageUrl,
                showLog: false,
              ),
            );
            if (_invalidBackgroundImageUrl == backgroundImageUrl || !mounted) {
              return;
            }
            setState(() {
              _invalidBackgroundImageUrl = backgroundImageUrl;
            });
          },
        ),
      );
    }
    return null;
  }
}
