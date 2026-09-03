import 'dart:io';

import 'package:clashmi/app/clash/clash_http_api.dart';
import 'package:clashmi/app/modules/diversion_template_manager.dart';
import 'package:clashmi/app/modules/profile_manager.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/proxygroup_select_screen.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:flutter/material.dart';

class ProxyGroupsScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return RouteSettings(name: "ProxyGroupsScreen");
  }

  final ProfileSetting profile;
  final List<ClashProxiesNode> nodes;
  const ProxyGroupsScreen({
    super.key,
    required this.profile,
    required this.nodes,
  });

  @override
  State<ProxyGroupsScreen> createState() => _ProxyGroupsScreenState();
}

class _ProxyGroupsScreenState extends LasyRenderingState<ProxyGroupsScreen> {
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
    Size windowSize = MediaQuery.of(context).size;
    final tcontext = Translations.of(context);
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.zero, child: AppBar()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const SizedBox(
                        width: 50,
                        height: 30,
                        child: Icon(Icons.arrow_back_ios_outlined, size: 26),
                      ),
                    ),
                    SizedBox(
                      width: windowSize.width - 50 * 2,
                      child: Text(
                        tcontext.meta.proxyGroups,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: ThemeConfig.kFontWeightTitle,
                          fontSize: ThemeConfig.kFontSizeTitle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 50, height: 30),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: _loadListView(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadListView() {
    Size windowSize = MediaQuery.of(context).size;
    final proxyGroups = DiversionTemplateManager.getProxyGroupTemplates();

    List<Widget> widgets = [];
    for (int i = 0; i < proxyGroups.length; ++i) {
      widgets.add(
        SizedBox(
          key: Key(i.toString()),
          child: createWidget(i, proxyGroups[i], windowSize),
        ),
      );
    }

    return Scrollbar(
      child: ReorderableListView(
        children: widgets,
        onReorderItem: (int oldIndex, int newIndex) {},
      ),
    );
  }

  Widget createWidget(int index, ProxyGroupTemplate current, Size windowSize) {
    const double rightWidth = 30.0;
    double centerWidth = windowSize.width - rightWidth - 20 - 20 * 2;

    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Material(
        borderRadius: ThemeDefine.kBorderRadius,
        child: InkWell(
          onTap: () {
            onTapEdit(current.name);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: ThemeConfig.kListItemHeight2 - 2,
            child: Row(
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: centerWidth,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    current.name,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: ThemeConfig.kFontSizeGroupItem,
                                      fontFamily: Platform.isWindows
                                          ? 'Emoji'
                                          : null,
                                    ),
                                  ),
                                  Text(
                                    ProxyGroupTemplate.toClashProtocolTypeString(
                                      current.type,
                                    ),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void onTapEdit(String name) async {
    List<ClashProxiesNode> nodes = [];
    final proxyGroups = DiversionTemplateManager.getProxyGroupTemplates();
    for (var pg in proxyGroups) {
      if (pg.name != name) {
        ClashProxiesNode cn = ClashProxiesNode();
        cn.name = pg.name;
        cn.type = ProxyGroupTemplate.toClashProtocolTypeString(pg.type);
        nodes.add(cn);
      }
    }
    nodes.addAll(widget.nodes);
    widget.profile.proxyGroups[name] ??= ProfileSettingProxyGroup();
    final pg = await Navigator.push(
      context,
      MaterialPageRoute(
        settings: ProxyGroupScreenScreen.routeSettings(),
        builder: (context) => ProxyGroupScreenScreen(
          name: name,
          proxies: widget.profile.proxyGroups[name]!.proxies,
          nodes: nodes,
        ),
      ),
    );
    if (pg != null) {
      widget.profile.proxyGroups[name]?.proxies = pg;
    }
  }
}
