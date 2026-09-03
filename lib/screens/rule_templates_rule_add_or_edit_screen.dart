import 'package:clashmi/app/modules/diversion_template_manager.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/group_item_creator.dart';
import 'package:clashmi/screens/group_item_options.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:clashmi/screens/widgets/sheet.dart';
import 'package:flutter/material.dart';

class RuleTemplatesRuleAddOrEditScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return RouteSettings(name: "RuleTemplateAddOrEditScreen");
  }

  final String rule;
  const RuleTemplatesRuleAddOrEditScreen({super.key, this.rule = ""});

  @override
  State<RuleTemplatesRuleAddOrEditScreen> createState() =>
      _RuleTemplatesRuleAddOrEditScreenState();
}

class _RuleTemplatesRuleAddOrEditScreenState
    extends LasyRenderingState<RuleTemplatesRuleAddOrEditScreen> {
  String _type = RuleTemplate.getTypes().first;
  String _value = "";
  bool _noResolve = false;
  @override
  void initState() {
    List<String> parts = RuleTemplate.parseRule(widget.rule);
    if (parts.isNotEmpty) {
      _type = parts[0];
      if (parts.length > 1) {
        _value = parts[1];
      }
      _noResolve = parts.contains("NO-RESOLVE");
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
            ],
          ),
        ),
      ),
    );
  }

  void onTapSave() async {
    final tcontext = Translations.of(context);
    String rule = "";
    if (RuleTemplate.needValue(_type)) {
      if (_value.isEmpty) {
        DialogUtils.showAlertDialog(
          context,
          _type == "RULE-SET"
              ? "${tcontext.meta.ruleProviders} can not be empty"
              : "$_type can not be empty",
        );
        return;
      }
      if (_noResolve) {
        rule = [_type, _value, "NO-RESOLVE"].join(",");
      } else {
        rule = [_type, _value].join(",");
      }
    } else if (_type == "MATCH") {
      _value = "";
      rule = _type;
    }

    Navigator.pop(context, rule);
  }

  Future<List<GroupItem>> getGroupOptions() async {
    final tcontext = Translations.of(context);

    List<GroupItem> groupOptions = [];
    List<GroupItemOptions> options = [
      GroupItemOptions(
        stringPickerOptions: GroupItemStringPickerOptions(
          name: "Type",
          selected: _type,
          strings: RuleTemplate.getTypes(),
          onPicker: (String? selected) async {
            _type = selected ?? RuleTemplate.getTypes().first;
            _value = "";
            setState(() {});
          },
        ),
      ),
    ];

    groupOptions.add(GroupItem(options: options));
    final supportResolve = RuleTemplate.supportNoResolve(_type);
    List<GroupItemOptions> options1 = [];

    if (_type == "RULE-SET") {
      options1.add(
        GroupItemOptions(
          pushOptions: GroupItemPushOptions(
            name: tcontext.meta.ruleProviders,
            text: _value,
            onPush: () async {
              onTapRuleset();
            },
          ),
        ),
      );
    } else if (_type != "MATCH") {
      String hint = "";
      if (_type == "GEOSITE" || _type == "GEOIP") {
        hint = "CN[${tcontext.meta.required}]";
      } else if (_type == "IP-ASN") {
        hint = "14[${tcontext.meta.required}]";
      } else {
        hint = tcontext.meta.required;
      }
      options1.add(
        GroupItemOptions(
          textFormFieldOptions: GroupItemTextFieldOptions(
            name: _type,
            text: _value,
            hint: hint,
            textWidthPercent: 0.6,
            textInputAction: TextInputAction.next,
            onChanged: (String value) {
              _value = value;
            },
          ),
        ),
      );
    }

    if (options1.isNotEmpty) {
      if (supportResolve) {
        options1.add(
          GroupItemOptions(
            switchOptions: GroupItemSwitchOptions(
              name: "NO-RESOLVE",
              switchValue: _noResolve,
              onSwitch: (bool value) async {
                _noResolve = value;
                setState(() {});
              },
            ),
          ),
        );
      }
      groupOptions.add(GroupItem(options: options1));
    }

    return groupOptions;
  }

  void onTapRuleset() {
    final ruleProviders = DiversionTemplateManager.getRuleProvidersNames();
    var widgets = [];
    for (var provider in ruleProviders) {
      widgets.add(
        ListTile(
          title: Text(
            provider,
            style: TextStyle(
              color: provider == _value ? ThemeDefine.kColorBlue : null,
            ),
          ),
          onTap: () async {
            Navigator.pop(context);
            _value = provider;
            setState(() {});
          },
        ),
      );
    }
    showSheet(
      context: context,
      body: SizedBox(
        height: 400,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Scrollbar(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return widgets[index];
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(height: 1, thickness: 0.3);
              },
              itemCount: widgets.length,
            ),
          ),
        ),
      ),
    );
  }
}
