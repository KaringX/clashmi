import 'package:board_service/sspanel_uim/sspanel_uim_client.dart'
    as sspanel_client;
import 'package:board_service/v2board/v2board_client.dart' as v2board_client;
import 'package:board_service/xboard/xboard_client.dart' as xboard_client;
import 'package:clashmi/app/modules/board_provider_manager.dart';
import 'package:clashmi/app/modules/board_session_persistent_manager.dart';
import 'package:clashmi/app/utils/app_utils.dart';
import 'package:clashmi/app/utils/url_launcher_utils.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/sspanel/sspanel_login.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/v2board/v2board_login.dart';
import 'package:clashmi/screens/xboard/xboard_login.dart';
import 'package:flutter/material.dart';

class LoginStepAccountScreen extends StatefulWidget {
  static RouteSettings routeSettings() {
    return const RouteSettings(name: "LoginStepAccountScreen");
  }

  final BoardProviderConfig provider;

  const LoginStepAccountScreen({super.key, required this.provider});
  @override
  State<LoginStepAccountScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginStepAccountScreen> {
  final _formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isPasswordVisible = false;
  bool _logining = false;

  @override
  void initState() {
    final session = BoardSessionPersistentManager.instance().current();
    if (session != null) {
      _usernameController.text = session.account;
    }

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
    _usernameController.dispose();
    _passwordController.dispose();
    V2boardLogin.onEventLogin.remove(hashCode);
    XboardLogin.onEventLogin.remove(hashCode);
    SSPanelLogin.onEventLogin.remove(hashCode);
    super.dispose();
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
                          "${tcontext.loginScreen.login} - ${widget.provider.name}",
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
    var accountStr = tcontext.loginScreen.account;
    var accountRequiredStr = tcontext.loginScreen.accountRequired;
    const primaryPurple = Color(0xFF7B5FF5);

    if (widget.provider.type == BoardProviderType.v2board ||
        widget.provider.type == BoardProviderType.xboard ||
        widget.provider.type == BoardProviderType.sspanel) {
      accountStr = tcontext.loginScreen.email;
      accountRequiredStr = tcontext.loginScreen.emailRequired;
    }

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
                  const SizedBox(height: 26),
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
                    validator: (String? value) {
                      if (widget.provider.type == BoardProviderType.v2board) {
                        return _validateV2boardUsername(value);
                      } else if (widget.provider.type ==
                          BoardProviderType.xboard) {
                        return _validateXboardUsername(value);
                      } else if (widget.provider.type ==
                          BoardProviderType.sspanel) {
                        return _validateSSPanelUsername(value);
                      }
                      return null;
                    },
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
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        final tcontext = Translations.of(context);
                        return tcontext.loginScreen.passwordRequired;
                      }

                      if (widget.provider.type == BoardProviderType.v2board) {
                        return _validateV2boardPassword(value);
                      } else if (widget.provider.type ==
                          BoardProviderType.xboard) {
                        return _validateXboardPassword(value);
                      } else if (widget.provider.type ==
                          BoardProviderType.sspanel) {
                        return _validateSSPanelPassword(value);
                      }

                      return null;
                    },
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
                        onPressed: widget.provider.forgotPasswordUrl.isNotEmpty
                            ? () {
                                _forgotpwd();
                              }
                            : null,
                        child: Text(
                          widget.provider.forgotPasswordUrl.isNotEmpty
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
                            widget.provider.registerUrl != null &&
                                widget.provider.type !=
                                    BoardProviderType.sspanel
                            ? () async {
                                _register();
                              }
                            : null,
                        child: Text(
                          widget.provider.registerUrl != null &&
                                  widget.provider.type !=
                                      BoardProviderType.sspanel
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

  void _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    _logining = true;
    setState(() {});
    BoardSessionLoginError? sessionLoginError;
    try {
      if (widget.provider.type == BoardProviderType.v2board) {
        sessionLoginError = await V2boardLogin.login(
          widget.provider,
          _usernameController.text.trim(),
          _passwordController.text.trim(),
        );
      } else if (widget.provider.type == BoardProviderType.xboard) {
        sessionLoginError = await XboardLogin.login(
          widget.provider,
          _usernameController.text.trim(),
          _passwordController.text.trim(),
        );
      } else if (widget.provider.type == BoardProviderType.sspanel) {
        sessionLoginError = await SSPanelLogin.login(
          widget.provider,
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
      widget.provider.id,
      widget.provider.domain,
      widget.provider.type.name,
    );
  }

  void _forgotpwd() async {
    if (widget.provider.forgotPasswordUrl.isEmpty) {
      return;
    }
    UrlLauncherUtils.loadUrl(widget.provider.forgotPasswordUrl);
  }

  void _register() async {
    if (widget.provider.registerUrl == null) {
      return;
    }
    if (widget.provider.registerUrl!.isNotEmpty) {
      UrlLauncherUtils.loadUrl(widget.provider.registerUrl!);
      return;
    }
  }
}
