import 'package:clashmi/app/modules/diversion_template_manager.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/proxygroup_templates_add_or_edit_screen.dart';

import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:flutter/material.dart';

class ProxyGroupsTemplatesScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return RouteSettings(name: "ProxyGroupsTemplatesScreen");
  }

  const ProxyGroupsTemplatesScreen({super.key});

  @override
  State<ProxyGroupsTemplatesScreen> createState() => _ProxyGroupsScreenState();
}

class _ProxyGroupsScreenState
    extends LasyRenderingState<ProxyGroupsTemplatesScreen> {
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
                    InkWell(
                      onTap: () async {
                        onTapAdd();
                      },
                      child: const SizedBox(
                        width: 50,
                        height: 30,
                        child: Icon(Icons.add_outlined, size: 26),
                      ),
                    ),
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
        onReorderItem: (int oldIndex, int newIndex) {
          DiversionTemplateManager.reorderProxyGroupTemplates(
            oldIndex,
            newIndex,
          );
          DiversionTemplateManager.save();
          setState(() {});
        },
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
                            SizedBox(
                              width: rightWidth,
                              child: InkWell(
                                onTap: () async {
                                  onTapDelete(current.name);
                                },
                                child: const Icon(
                                  Icons.remove_circle_outlined,
                                  size: 26,
                                  color: Colors.red,
                                ),
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

  void onTapAdd() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        settings: ProxyGroupTemplatesAddOrEditScreen.routeSettings(),
        builder: (context) => ProxyGroupTemplatesAddOrEditScreen(),
      ),
    );
    setState(() {});
  }

  void onTapDelete(String name) async {
    DiversionTemplateManager.removeProxyGroupTemplateByName(name);
    DiversionTemplateManager.save();
    setState(() {});
  }

  void onTapEdit(String name) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        settings: ProxyGroupTemplatesAddOrEditScreen.routeSettings(),
        builder: (context) => ProxyGroupTemplatesAddOrEditScreen(name: name),
      ),
    );
    setState(() {});
  }
}
