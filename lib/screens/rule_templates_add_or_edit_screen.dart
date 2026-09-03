import 'package:clashmi/app/modules/diversion_template_manager.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/group_item_creator.dart';
import 'package:clashmi/screens/group_item_options.dart';
import 'package:clashmi/screens/rule_templates_rule_add_or_edit_screen.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:flutter/material.dart';

class RuleTemplatesAddOrEditScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return RouteSettings(name: "RuleTemplateAddOrEditScreen");
  }

  final String name;
  const RuleTemplatesAddOrEditScreen({super.key, this.name = ""});

  @override
  State<RuleTemplatesAddOrEditScreen> createState() =>
      _RuleTemplatesAddOrEditScreenState();
}

class _RuleTemplatesAddOrEditScreenState
    extends LasyRenderingState<RuleTemplatesAddOrEditScreen> {
  late RuleTemplate _data;
  @override
  void initState() {
    if (widget.name.isNotEmpty) {
      final exist = DiversionTemplateManager.getRuleTemplateByName(widget.name);
      if (exist != null) {
        _data = exist.clone();
      } else {
        _data = RuleTemplate(rules: []);
      }
    } else {
      _data = RuleTemplate(rules: []);
    }
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
                      width: windowSize.width - 50 * 3,
                      child: Text(
                        tcontext.meta.rule,
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
                    InkWell(
                      onTap: () {
                        onTapSave();
                      },
                      child: const SizedBox(
                        width: 50,
                        height: 30,
                        child: Icon(Icons.done, size: 26),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                child: SingleChildScrollView(
                  child: FutureBuilder(
                    future: getGroupOptions(),
                    builder:
                        (
                          BuildContext context,
                          AsyncSnapshot<List<GroupItem>> snapshot,
                        ) {
                          List<GroupItem> data = snapshot.hasData
                              ? snapshot.data!
                              : [];
                          return Column(
                            children: GroupItemCreator.createGroups(
                              context,
                              data,
                            ),
                          );
                        },
                  ),
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

  void onTapAdd() async {
    String? newRule = await Navigator.push(
      context,
      MaterialPageRoute(
        settings: RuleTemplatesRuleAddOrEditScreen.routeSettings(),
        builder: (context) => RuleTemplatesRuleAddOrEditScreen(),
      ),
    );
    if (newRule != null &&
        newRule.isNotEmpty &&
        !_data.rules.contains(newRule)) {
      _data.rules.add(newRule);
    }
    setState(() {});
  }

  void onTapSave() async {
    final tcontext = Translations.of(context);
    if (_data.name.isEmpty) {
      DialogUtils.showAlertDialog(
        context,
        "${tcontext.meta.name} can not be empty",
      );
      return;
    }

    final names = DiversionTemplateManager.getRuleTemplatesNames();
    if (widget.name.isEmpty) {
      if (names.contains(_data.name)) {
        DialogUtils.showAlertDialog(
          context,
          "${tcontext.meta.name}:${_data.name} already exists",
        );
        return;
      }
    } else {
      if ((widget.name != _data.name) && names.contains(_data.name)) {
        DialogUtils.showAlertDialog(
          context,
          "${tcontext.meta.name}:${_data.name} already exists",
        );
        return;
      }
    }
    if (_data.rules.isEmpty) {
      DialogUtils.showAlertDialog(
        context,
        "${tcontext.meta.rule} can not be empty",
      );
      return;
    }
    if (widget.name.isNotEmpty) {
      DiversionTemplateManager.updateRuleTemplate(widget.name, _data);
    } else {
      DiversionTemplateManager.addRuleTemplate(_data);
    }

    DiversionTemplateManager.save();
    Navigator.pop(context);
  }

  Widget _loadListView() {
    Size windowSize = MediaQuery.of(context).size;

    List<Widget> widgets = [];
    for (int i = 0; i < _data.rules.length; ++i) {
      widgets.add(
        SizedBox(
          key: Key(i.toString()),
          child: createWidget(i, _data.rules[i], windowSize),
        ),
      );
    }

    return Scrollbar(
      child: ReorderableListView(
        children: widgets,
        onReorderItem: (int oldIndex, int newIndex) {
          _data.reorder(oldIndex, newIndex);

          setState(() {});
        },
      ),
    );
  }

  Widget createWidget(int index, String current, Size windowSize) {
    const double rightWidth = 30.0;
    double centerWidth = windowSize.width - rightWidth - 20 - 20 * 2;

    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Material(
        borderRadius: ThemeDefine.kBorderRadius,
        child: InkWell(
          onTap: () {
            onTapEdit(index);
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
                                current,
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
                                  onTapDelete(index);
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

  void onTapDelete(int index) async {
    _data.rules.removeAt(index);
    setState(() {});
  }

  void onTapEdit(int index) async {
    String? newRule = await Navigator.push(
      context,
      MaterialPageRoute(
        settings: RuleTemplatesRuleAddOrEditScreen.routeSettings(),
        builder: (context) =>
            RuleTemplatesRuleAddOrEditScreen(rule: _data.rules[index]),
      ),
    );
    if (newRule != null && newRule.isNotEmpty) {
      if (newRule != _data.rules[index]) {
        _data.rules[index] = "";
        _data.rules.remove(newRule);
        _data.rules[index] = newRule;
      }
    }
    setState(() {});
  }

  Future<List<GroupItem>> getGroupOptions() async {
    final tcontext = Translations.of(context);

    List<GroupItemOptions> options = [
      GroupItemOptions(
        textFormFieldOptions: GroupItemTextFieldOptions(
          name: tcontext.meta.name,
          text: _data.name,
          textWidthPercent: 0.7,
          hint: "[${tcontext.meta.required}]",
          onChanged: (String value) {
            _data.name = value.trim();
          },
        ),
      ),
    ];

    return [GroupItem(options: options)];
  }
}
