import 'dart:io';

import 'package:clashmi/app/modules/board_provider_manager.dart';
import 'package:clashmi/app/modules/remote_config_manager.dart';
import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/app/utils/app_utils.dart';
import 'package:clashmi/app/utils/platform_utils.dart';
import 'package:clashmi/app/utils/url_launcher_utils.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/inapp_webview_screen.dart'
    show InAppWebViewScreen;
import 'package:clashmi/screens/login_step_account_screen.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/webview_isp_helper.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginStepProviderScreen extends StatefulWidget {
  static RouteSettings routSettings() {
    return const RouteSettings(name: "LoginStepProviderScreen");
  }

  const LoginStepProviderScreen({super.key});
  @override
  State<LoginStepProviderScreen> createState() =>
      _LoginStepProviderScreenState();
}

class _LoginStepProviderScreenState extends State<LoginStepProviderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _serviceNameController = TextEditingController();

  bool _fetching = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _serviceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tcontext = Translations.of(context);
    Size windowSize = MediaQuery.of(context).size;

    return PopScope(
      canPop: !_fetching,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.zero,
          child: AppBar(title: Text(AppUtils.getName()), centerTitle: true),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _fetching
                          ? const SizedBox(width: 50)
                          : InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const SizedBox(
                                width: 50,
                                height: 30,
                                child: Icon(
                                  Icons.arrow_back_ios_outlined,
                                  size: 26,
                                ),
                              ),
                            ),
                      SizedBox(
                        width: windowSize.width - 50 * 2,
                        child: Text(
                          tcontext.loginScreen.login,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: ThemeConfig.kFontWeightTitle,
                            fontSize: ThemeConfig.kFontSizeTitle,
                          ),
                        ),
                      ),
                      SizedBox(width: 50, height: 30),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(child: createPanel()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createPanel({String title = ""}) {
    final tcontext = Translations.of(context);
    const primaryPurple = Color(0xFF7B5FF5);
    return Center(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: tcontext.loginScreen
                              .providerLoginSupportRequired(p: ''),
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        TextSpan(
                          text: RemoteConfigManager.getConfig().connect,
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              UrlLauncherUtils.loadUrl(
                                RemoteConfigManager.getConfig().connect,
                              );
                            },
                        ),
                        TextSpan(
                          text:
                              "\n\n${tcontext.loginScreen.providerDisclaimer}",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),
                  TextFormField(
                    controller: _serviceNameController,
                    decoration: InputDecoration(
                      labelText: tcontext.loginScreen.providerName,
                      hintText: tcontext.loginScreen.providerNameRequired,
                      prefixIcon: const Icon(
                        Icons.business,
                        color: ThemeDefine.kColorBlue,
                      ),
                    ),
                    onChanged: (value) async {
                      setState(() {});
                    },
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        final tcontext = Translations.of(context);
                        return tcontext.loginScreen.providerNameRequired;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _fetching ? null : _go,
                      style: ElevatedButton.styleFrom(padding: EdgeInsets.zero),
                      child: Ink(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [ThemeDefine.kColorBlue, primaryPurple],
                          ),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Container(
                          alignment: Alignment.center,
                          child: _fetching
                              ? SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: const RepaintBoundary(
                                    child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : Text(
                                  tcontext.meta.next,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 36),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _go() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final serviceName = _serviceNameController.text.trim();
    _fetching = true;
    setState(() {});
    Uri? uri;
    if (serviceName.startsWith("https://")) {
      uri = Uri.tryParse(serviceName);
    }
    final result = uri != null && uri.host.isNotEmpty
        ? await BoardProviderManager.getProviderByUri(uri)
        : await BoardProviderManager.getProvider(serviceName);
    if (!mounted) {
      return;
    }
    _fetching = false;
    setState(() {});
    if (result.error != null) {
      DialogUtils.showAlertDialog(
        context,
        result.error!.message,
        showCopy: true,
        showFAQ: true,
        withVersion: true,
      );
      return;
    }
    final provider = result.data!;
    if (!provider.panelLogin) {
      final tcontext = Translations.of(context);
      DialogUtils.showAlertDialog(
        context,
        "${tcontext.loginScreen.unActivedProvider}: $serviceName",
        showCopy: true,
        showFAQ: true,
        withVersion: true,
      );
      return;
    }
    if (!provider.web) {
      if (!BoardProviderType.support(provider.type.name)) {
        final tcontext = Translations.of(context);
        DialogUtils.showAlertDialog(
          context,
          "${tcontext.loginScreen.unsupportedProviderType}: $serviceName",
          showCopy: true,
          showFAQ: true,
          withVersion: true,
        );
        return;
      }
    }
    BoardProviderManager.notifyProviderIntegration(
      provider.id,
      provider.domain,
      provider.type.name,
    );
    Navigator.of(context).pop();
    if (provider.web) {
      await _loginByWeb(provider);
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(
          settings: LoginStepAccountScreen.routSettings(),
          builder: (context) => LoginStepAccountScreen(provider: provider),
        ),
      );
    }
  }

  Future<void> _loginByWeb(BoardProviderConfig provider) async {
    if (Platform.isLinux) {
      //final tcontext = Translations.of(context);
      DialogUtils.showAlertDialog(
        context,
        "Linux platforms do not currently support web-based login.",
        showCopy: true,
        showFAQ: true,
        withVersion: true,
      );
      return;
    }
    String url = await UrlLauncherUtils.reorganizationUrlWithAnchor(
      provider.loginUrl,
    );
    if (!context.mounted) {
      return;
    }
    await InAppWebViewScreen.makeSureEnvironmentCreated();
    if (!context.mounted) {
      return;
    }
    bool debug = PlatformUtils.isPC() && SettingManager.getConfig().devMode;
    await InAppWebViewScreen.setWebViewEnvironmentDebug(debug);
    if (!mounted) {
      return;
    }
    String bindJs = provider.bindJs.isEmpty
        ? "https://harry.karing.app/assets/bind.js?v="
        : provider.bindJs;
    if (bindJs.isNotEmpty) {
      if (bindJs.endsWith("?v=") || bindJs.endsWith("&v=")) {
        bindJs = "$bindJs${DateTime.now().millisecondsSinceEpoch.toString()}";
      }
    }
    final tcontext = Translations.of(context);
    await Navigator.push(
      context,
      MaterialPageRoute(
        settings: InAppWebViewScreen.routSettings("isp_login"),
        builder: (context) => InAppWebViewScreen(
          title: "${tcontext.loginScreen.login} - ${provider.name}",
          url: url,
          enableDebug: debug,
          showGoBackGoForward: false,
          setJSWindowObject: true,
          injectJs: bindJs,
          jsObjectName: "karing",
          javaScriptHandlers: WebviewISPHelper.getJavaScriptHandlers(),
          javaScriptHandlerArgument: provider,
        ),
      ),
    );
  }
}
