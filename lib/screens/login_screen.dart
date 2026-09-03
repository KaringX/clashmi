import 'package:board_service/sspanel_uim/sspanel_uim_client.dart'
    as sspanel_client;
import 'package:board_service/v2board/v2board_client.dart' as v2board_client;
import 'package:board_service/xboard/xboard_client.dart' as xboard_client;

import 'package:clashmi/app/modules/remote_config_manager.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:clashmi/app/modules/board_provider_manager.dart';
import 'package:clashmi/app/modules/board_session_persistent_manager.dart';
import 'package:clashmi/app/utils/app_utils.dart';
import 'package:clashmi/app/utils/url_launcher_utils.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/sspanel/sspanel_login.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/v2board/v2board_login.dart';
import 'package:clashmi/screens/xboard/xboard_login.dart';

class LoginScreen extends StatefulWidget {
  static RouteSettings routeSettings() {
    return const RouteSettings(name: "LoginScreen");
  }

  static bool isAlive = false;

  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _serviceNameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final FocusNode _serviceNameFocus = FocusNode();
  bool _isPasswordVisible = false;
  bool _logining = false;
  BoardProviderConfig? _provider;

  @override
  void initState() {
    LoginScreen.isAlive = true;
    final session = BoardSessionPersistentManager.instance().current();
    if (session != null) {
      _serviceNameController.text = session.provider.name;
      _usernameController.text = session.account;
      _provider = session.provider;
    }
    _serviceNameFocus.addListener(() async {
      if (_serviceNameFocus.hasFocus) {
        return;
      }
      final value = _serviceNameController.text.trim();
      if (value.isNotEmpty) {
        Uri? uri;
        if (value.contains(".")) {
          if (!value.startsWith("https://")) {
            uri = Uri.tryParse("https://$value");
          } else {
            uri = Uri.tryParse(value);
          }
          if (uri != null) {
            _serviceNameController.text =
                "${uri.scheme}://${Uri.decodeComponent(uri.host)}";
          }
        }
      }

      _validateServiceNameAsync();
    });
    V2boardLogin.onEventLogin[hashCode] = (() {
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
    });
    XboardLogin.onEventLogin[hashCode] = (() {
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
    });
    SSPanelLogin.onEventLogin[hashCode] = (() {
      if (!mounted) {
        return;
      }
      Navigator.of(context).pop();
    });

    super.initState();
  }

  @override
  void dispose() {
    _serviceNameFocus.dispose();
    _serviceNameController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    V2boardLogin.onEventLogin.remove(hashCode);
    XboardLogin.onEventLogin.remove(hashCode);
    SSPanelLogin.onEventLogin.remove(hashCode);
    super.dispose();
    LoginScreen.isAlive = false;
  }

  @override
  Widget build(BuildContext context) {
    final tcontext = Translations.of(context);
    Size windowSize = MediaQuery.of(context).size;

    return PopScope(
      canPop: !_logining,
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
                      _logining
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
                Expanded(child: createLoginPanel()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget createLoginPanel({String title = ""}) {
    final tcontext = Translations.of(context);
    var accountStr = tcontext.loginScreen.account;
    var accountRequiredStr = tcontext.loginScreen.accountRequired;
    const primaryPurple = Color(0xFF7B5FF5);
    if (_provider != null) {
      if (_provider!.type == BoardProviderType.v2board ||
          _provider!.type == BoardProviderType.xboard ||
          _provider!.type == BoardProviderType.sspanel) {
        accountStr = tcontext.loginScreen.email;
        accountRequiredStr = tcontext.loginScreen.emailRequired;
      }
    }
    bool isProviderSupported =
        _provider != null && BoardProviderType.support(_provider!.type.name);
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
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isProviderSupported &&
                              _provider!.clientServiceUrl.isNotEmpty
                          ? InkWell(
                              onTap: () {
                                UrlLauncherUtils.loadUrl(
                                  _provider!.clientServiceUrl,
                                );
                              },
                              child: Icon(
                                Icons.contact_support_outlined,
                                size: 30,
                                color: ThemeDefine.kColorBlue,
                              ),
                            )
                          : const SizedBox.shrink(),
                    ],
                  ),

                  const SizedBox(height: 18),
                  TextFormField(
                    controller: _serviceNameController,
                    focusNode: _serviceNameFocus,
                    decoration: InputDecoration(
                      labelText: tcontext.loginScreen.providerName,
                      hintText: tcontext.loginScreen.providerNameRequired,
                      prefixIcon: const Icon(
                        Icons.business,
                        color: ThemeDefine.kColorBlue,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isProviderSupported ? Icons.done : null,
                          color: ThemeDefine.kColorGreenBright,
                        ),
                        onPressed: null,
                      ),
                    ),
                    onChanged: (value) async {
                      _provider = null;
                      setState(() {});
                    },
                    validator: _validateServiceName,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _usernameController,
                    decoration: InputDecoration(
                      labelText: accountStr,
                      hintText: accountRequiredStr,
                      prefixIcon: const Icon(
                        Icons.person,
                        color: ThemeDefine.kColorBlue,
                      ),
                    ),
                    validator: _validateUsername,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      labelText: tcontext.loginScreen.password,
                      hintText: tcontext.loginScreen.passwordRequired,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: ThemeDefine.kColorBlue,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 48,
                    child: ElevatedButton(
                      onPressed: _logining ? null : _login,
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
                          child: _logining
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
                                  tcontext.loginScreen.login,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed:
                            isProviderSupported &&
                                _provider!.forgotPasswordUrl.isNotEmpty
                            ? () {
                                _forgotpwd();
                              }
                            : null,
                        child: Text(
                          isProviderSupported &&
                                  _provider!.forgotPasswordUrl.isNotEmpty
                              ? tcontext.loginScreen.forgotPassword
                              : '',
                          style: TextStyle(
                            color: ThemeDefine.kColorBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed:
                            isProviderSupported &&
                                _provider!.registerUrl != null &&
                                _provider!.type != BoardProviderType.sspanel
                            ? () async {
                                _register();
                              }
                            : null,
                        child: Text(
                          isProviderSupported &&
                                  _provider!.registerUrl != null &&
                                  _provider!.type != BoardProviderType.sspanel
                              ? tcontext.loginScreen.register
                              : '',
                          style: TextStyle(
                            color: ThemeDefine.kColorBlue,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _validateServiceNameAsync() async {
    final value = _serviceNameController.text.trim();
    if (value.isEmpty) {
      return;
    }
    Uri? uri;
    if (value.startsWith("https://")) {
      uri = Uri.tryParse(value);
    }

    final result = uri != null && uri.host.isNotEmpty
        ? await BoardProviderManager.getProviderByUri(uri)
        : await BoardProviderManager.getProvider(value);
    if (result.error != null) {
      return;
    }
    if (!BoardProviderType.support(result.data!.type.name)) {
      return;
    }
    if (value != _serviceNameController.text.trim()) {
      return;
    }
    _provider = result.data;
    Future.delayed(const Duration(milliseconds: 100)).then((value) {
      if (!mounted) {
        return;
      }

      setState(() {});
    });
  }

  String? _validateServiceName(String? value) {
    if (value == null || value.isEmpty) {
      final tcontext = Translations.of(context);
      return tcontext.loginScreen.providerNameRequired;
    }
    return null;
  }

  String? _validateUsername(String? value) {
    if (_provider == null) {
      return null;
    }
    if (_provider!.type == BoardProviderType.v2board) {
      return _validateV2boardUsername(value);
    } else if (_provider!.type == BoardProviderType.xboard) {
      return _validateXboardUsername(value);
    } else if (_provider!.type == BoardProviderType.sspanel) {
      return _validateSSPanelUsername(value);
    }
    return null;
  }

  String? _validateV2boardUsername(String? value) {
    if (!v2board_client.V2BoardClient.validateEmail(value?.trim())) {
      final tcontext = Translations.of(context);
      return tcontext.loginScreen.validEmailRequired;
    }
    return null;
  }

  String? _validateXboardUsername(String? value) {
    if (!xboard_client.XboardClient.validateEmail(value?.trim())) {
      final tcontext = Translations.of(context);
      return tcontext.loginScreen.validEmailRequired;
    }
    return null;
  }

  String? _validateSSPanelUsername(String? value) {
    if (!sspanel_client.SSPanelUimClient.validateEmail(value?.trim())) {
      final tcontext = Translations.of(context);
      return tcontext.loginScreen.validEmailRequired;
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.trim().isEmpty) {
      final tcontext = Translations.of(context);
      return tcontext.loginScreen.passwordRequired;
    }
    if (_provider == null) {
      return null;
    }
    if (_provider!.type == BoardProviderType.v2board) {
      return _validateV2boardPassword(value);
    } else if (_provider!.type == BoardProviderType.xboard) {
      return _validateXboardPassword(value);
    } else if (_provider!.type == BoardProviderType.sspanel) {
      return _validateSSPanelPassword(value);
    }

    return null;
  }

  String? _validateV2boardPassword(String value) {
    int minLength = v2board_client.V2BoardClient.getPasswordMinLen();
    if (value.trim().length < minLength) {
      final tcontext = Translations.of(context);
      return tcontext.loginScreen.passwordMinLength(minLength: minLength);
    }
    return null;
  }

  String? _validateXboardPassword(String value) {
    int minLength = xboard_client.XboardClient.getPasswordMinLen();
    if (value.trim().length < minLength) {
      final tcontext = Translations.of(context);
      return tcontext.loginScreen.passwordMinLength(minLength: minLength);
    }
    return null;
  }

  String? _validateSSPanelPassword(String value) {
    int minLength = sspanel_client.SSPanelUimClient.getPasswordMinLen();
    if (value.trim().length < minLength) {
      final tcontext = Translations.of(context);
      return tcontext.loginScreen.passwordMinLength(minLength: minLength);
    }
    return null;
  }

  void _login({bool handle403 = true}) async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final serviceName = _serviceNameController.text.trim();
    _logining = true;
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
    if (result.error != null) {
      _provider = null;
      _logining = false;
      setState(() {});
      DialogUtils.showAlertDialog(
        context,
        result.error!.message,
        showCopy: true,
        showFAQ: true,
        withVersion: true,
      );
      return;
    }

    if (!BoardProviderType.support(result.data!.type.name)) {
      _provider = null;
      _logining = false;
      setState(() {});
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

    if (!result.data!.panelLogin) {
      _provider = null;
      _logining = false;
      setState(() {});
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
    _provider = result.data!;
    BoardProviderConfig provider = _provider!;
    BoardSessionLoginError? sessionLoginError;
    try {
      if (provider.type == BoardProviderType.v2board) {
        sessionLoginError = await V2boardLogin.login(
          provider,
          _usernameController.text.trim(),
          _passwordController.text.trim(),
        );
      } else if (provider.type == BoardProviderType.xboard) {
        sessionLoginError = await XboardLogin.login(
          provider,
          _usernameController.text.trim(),
          _passwordController.text.trim(),
        );
      } else if (provider.type == BoardProviderType.sspanel) {
        sessionLoginError = await SSPanelLogin.login(
          provider,
          _usernameController.text.trim(),
          _passwordController.text.trim(),
        );
      }
    } catch (e) {
      if (!mounted) {
        return;
      }
      DialogUtils.showAlertDialog(
        context,
        e.toString(),
        showCopy: true,
        showFAQ: true,
        withVersion: true,
      );
    }

    if (!mounted) {
      return;
    }

    _logining = false;
    setState(() {});
    if (sessionLoginError != null) {
      /*if (sessionLoginError.httpStatusCode == 403 && handle403) {
        if (await BotHelper().handle403(context, provider, sessionLoginError, (
          bool handle403,
        ) {
          _login(handle403: handle403);
        })) {
          return;
        }
      }
      if (!mounted) {
        return;
      }*/
      DialogUtils.showAlertDialog(
        context,
        sessionLoginError.message ?? "unknown error",
        showCopy: true,
        showFAQ: true,
        withVersion: true,
      );
      return;
    }

    BoardProviderManager.notifyProviderIntegration(
      provider.id,
      provider.domain,
      provider.type.name,
    );
  }

  void _forgotpwd() async {
    if (_provider == null || _provider!.forgotPasswordUrl.isEmpty) {
      return;
    }
    UrlLauncherUtils.loadUrl(_provider!.forgotPasswordUrl);
  }

  void _register() async {
    if (_provider == null || _provider!.registerUrl == null) {
      return;
    }
    if (_provider!.registerUrl!.isNotEmpty) {
      UrlLauncherUtils.loadUrl(_provider!.registerUrl!);
      return;
    }
  }
}
