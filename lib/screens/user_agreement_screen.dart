// ignore_for_file: unused_catch_stack

import 'package:clashmi/app/utils/assets_utils.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:flutter/material.dart';

class UserAgreementScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return const RouteSettings(name: "UserAgreementScreen");
  }

  const UserAgreementScreen({super.key});

  @override
  State<UserAgreementScreen> createState() => _UserAgreementScreenState();
}

class _UserAgreementScreenState
    extends LasyRenderingState<UserAgreementScreen> {
  String _res = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tcontext = Translations.of(context);
    Size windowSize = MediaQuery.of(context).size;

    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: PreferredSize(preferredSize: Size.zero, child: AppBar()),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 20, 18, 0),
            child: Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        tcontext.UserAgreementScreen.privacyFirst,
                        style: const TextStyle(
                          fontSize: ThemeConfig.kFontSizeListItem,
                          fontWeight: ThemeConfig.kFontWeightListItem,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Container(
                        alignment: Alignment.topCenter,
                        height: windowSize.height * 0.68,
                        child: FutureBuilder(
                          future: getData(),
                          builder:
                              (
                                BuildContext context,
                                AsyncSnapshot<String> snapshot,
                              ) {
                                String data = snapshot.hasData
                                    ? snapshot.data!
                                    : "";
                                return Text.rich(TextSpan(text: data));
                              },
                        ),
                      ),
                      SizedBox(
                        height: 45.0,
                        child: ElevatedButton(
                          autofocus: true,
                          child: Text(
                            tcontext.UserAgreementScreen.agreeAndContinue,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<String> getData() async {
    if (_res.isNotEmpty) {
      return _res;
    }
    final languageCode = WidgetsBinding
        .instance
        .platformDispatcher
        .locale
        .languageCode
        .toLowerCase();
    bool isChinese = languageCode.contains('zh');

    _res = await AssetsUtils.loadUserAgreement(isChinese);
    return _res;
  }
}
