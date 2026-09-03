// ignore_for_file: unused_catch_stack

import 'dart:io';
import 'dart:ui';

import 'package:app_installer/app_installer.dart';
import 'package:clashmi/app/local_services/vpn_service.dart';
import 'package:clashmi/app/modules/auto_update_manager.dart';
import 'package:clashmi/app/utils/install_referrer_utils.dart';
import 'package:clashmi/app/utils/log.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class VersionUpdateScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return const RouteSettings(name: "VersionUpdateScreen");
  }

  const VersionUpdateScreen({super.key});

  @override
  State<VersionUpdateScreen> createState() => _VersionUpdateScreenState();
}

class _VersionUpdateScreenState
    extends LasyRenderingState<VersionUpdateScreen> {
  bool _installing = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tcontext = Translations.of(context);
    var checkVersion = AutoUpdateManager.getVersionCheck();

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.zero, child: AppBar()),
      body: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      tcontext.VersionUpdateScreen.versionReady(
                        p: checkVersion.version,
                      ),
                      style: const TextStyle(
                        fontSize: ThemeConfig.kFontSizeListItem,
                        fontWeight: ThemeConfig.kFontWeightListItem,
                        color: ThemeDefine.kColorBlue,
                      ),
                    ),
                    const SizedBox(height: 30),
                    SizedBox(
                      height: 45.0,
                      child: ElevatedButton(
                        onPressed: _installing
                            ? null
                            : () async {
                                await checkReplace();
                              },
                        child: _installing
                            ? SizedBox(
                                width: 26,
                                height: 26,
                                child: RepaintBoundary(
                                  child: CircularProgressIndicator(
                                    color: ThemeDefine.kColorGreenBright,
                                  ),
                                ),
                              )
                            : Text(tcontext.VersionUpdateScreen.update),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> checkReplace() async {
    String? installer = await AutoUpdateManager.checkReplace();
    if (!mounted) {
      return;
    }
    if (installer == null) {
      Navigator.pop(context);
      return;
    }
    if (_installing) {
      return;
    }
    _installing = true;
    setState(() {});
    try {
      await VPNService.stop();
      if (Platform.isWindows) {
        await launchUrl(Uri(path: installer, scheme: 'file'));
        await ServicesBinding.instance.exitApplication(AppExitType.required);
      } else if (Platform.isMacOS) {
        await launchUrl(Uri(path: installer, scheme: 'file'));
        await ServicesBinding.instance.exitApplication(AppExitType.required);
      } else if (Platform.isAndroid) {
        await AppInstaller.installApk(installer);
      } else if (Platform.isLinux) {
        if (!mounted) {
          return;
        }

        String? password = await DialogUtils.showPasswordInputDialog(context);
        if (password == null || password.isEmpty) {
          _installing = false;
          setState(() {});
          return;
        }
        final shell = Platform.environment['SHELL'] ?? 'bash';
        final arguments = ["-c"];
        final channelName = InstallReferrerUtils.getBuildChannelName();
        if (channelName.toLowerCase().contains("deb")) {
          arguments.add('echo "$password" | sudo -S dpkg -i "$installer"');
        } else if (channelName.toLowerCase().contains("rpm")) {
          arguments.add('echo "$password" | sudo -S rpm -i "$installer"');
        } else if (channelName.toLowerCase().contains("appimage")) {
          _installing = false;
          setState(() {});
          return;
        } else {
          arguments.add('echo "$password" | sudo -S dpkg -i "$installer"');
        }
        final result = await Process.run(shell, arguments);
        if (result.exitCode != 0) {
          if (!mounted) {
            _installing = false;
            setState(() {});
            return;
          }
          DialogUtils.showAlertDialog(
            context,
            "install $installer failed, exitCode: ${result.exitCode}",
            showCopy: true,
            showFAQ: true,
            withVersion: true,
          );
          _installing = false;
          setState(() {});
          return;
        }
        await ServicesBinding.instance.exitApplication(AppExitType.required);
      }
    } catch (err, stacktrace) {
      Log.w("VersionUpdateScreen.checkReplace exception ${err.toString()}");
      _installing = false;
      if (!mounted) {
        return;
      }
      DialogUtils.showAlertDialog(
        context,
        err.toString(),
        showCopy: true,
        showFAQ: true,
        withVersion: true,
      );
      setState(() {});
    }
    _installing = false;
    if (!mounted) {
      setState(() {});
    }
  }
}
