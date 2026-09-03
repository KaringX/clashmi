import 'package:clashmi/app/modules/diversion_template_manager.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/rule_templates_add_or_edit_screen.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:flutter/material.dart';

class RuleTemplatesScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return RouteSettings(name: "RuleTemplatesScreen");
  }

  const RuleTemplatesScreen({super.key});

  @override
  State<RuleTemplatesScreen> createState() => _RuleTemplatesScreenState();
}

class _RuleTemplatesScreenState
    extends LasyRenderingState<RuleTemplatesScreen> {
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
                        tcontext.meta.ruleTemplates,
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
    final ruleTemplates = DiversionTemplateManager.getRuleTemplates();

    List<Widget> widgets = [];
    for (int i = 0; i < ruleTemplates.length; ++i) {
      widgets.add(
        SizedBox(
          key: Key(i.toString()),
          child: createWidget(i, ruleTemplates[i], windowSize),
        ),
      );
    }

    return Scrollbar(
      child: ReorderableListView(
        children: widgets,
        onReorderItem: (int oldIndex, int newIndex) {
          DiversionTemplateManager.reorderRuleTemplates(oldIndex, newIndex);
          DiversionTemplateManager.save();
          setState(() {});
        },
      ),
    );
  }

  Widget createWidget(int index, RuleTemplate current, Size windowSize) {
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
                              child: Text(
                                current.name,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: ThemeConfig.kFontSizeGroupItem,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: rightWidth,
                              height: ThemeConfig.kListItemHeight2 - 2,
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
        settings: RuleTemplatesAddOrEditScreen.routeSettings(),
        builder: (context) => RuleTemplatesAddOrEditScreen(),
      ),
    );
    setState(() {});
  }

  void onTapDelete(String name) async {
    DiversionTemplateManager.removeRuleTemplateByName(name);
    DiversionTemplateManager.save();
    setState(() {});
  }

  void onTapEdit(String name) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        settings: RuleTemplatesAddOrEditScreen.routeSettings(),
        builder: (context) => RuleTemplatesAddOrEditScreen(name: name),
      ),
    );
    setState(() {});
  }
}
