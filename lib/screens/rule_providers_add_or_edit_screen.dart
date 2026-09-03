import 'package:clashmi/app/modules/diversion_template_manager.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/group_item_creator.dart';
import 'package:clashmi/screens/group_item_options.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:flutter/material.dart';

class RuleProvidersAddOrEditScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return RouteSettings(name: "RuleProvidersAddOrEditScreen");
  }

  final String name;
  const RuleProvidersAddOrEditScreen({super.key, this.name = ""});

  @override
  State<RuleProvidersAddOrEditScreen> createState() =>
      _RuleProvidersAddOrEditScreenState();
}

class _RuleProvidersAddOrEditScreenState
    extends LasyRenderingState<RuleProvidersAddOrEditScreen> {
  late RuleProvider _data;
  @override
  void initState() {
    final httpDefault = RuleProviderHttp(
      format: RuleProviderHttp.getFormats().first,
      behavior: RuleProviderHttp.getBehaviors().first,
    );
    if (widget.name.isNotEmpty) {
      final exist = DiversionTemplateManager.getRuleProviderByName(widget.name);
      if (exist != null) {
        _data = exist.clone();
      } else {
        _data = RuleProvider(name: "", type: "http", http: httpDefault);
      }
    } else {
      _data = RuleProvider(name: "", type: "http", http: httpDefault);
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
                      width: windowSize.width - 50 * 2,
                      child: Text(
                        tcontext.meta.ruleProviders,
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
    if (_data.name.isEmpty) {
      DialogUtils.showAlertDialog(
        context,
        "${tcontext.meta.name} can not be empty",
      );
      return;
    }

    final names = DiversionTemplateManager.getRuleProvidersNames();
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
    if (_data.http != null) {
      if (_data.http!.url.isEmpty) {
        DialogUtils.showAlertDialog(context, "url can not be empty");
        return;
      }
      final url = Uri.tryParse(_data.http!.url);
      if (url == null) {
        DialogUtils.showAlertDialog(
          context,
          "url:${_data.http!.url} is invalid",
        );
        return;
      }
    }

    if (widget.name.isNotEmpty) {
      DiversionTemplateManager.updateRuleProvider(widget.name, _data);
    } else {
      DiversionTemplateManager.addRuleProvider(_data);
    }

    DiversionTemplateManager.save();
    if (!mounted) {
      return;
    }
    Navigator.pop(context);
  }

  Future<List<GroupItem>> getGroupOptions() async {
    final tcontext = Translations.of(context);

    List<GroupItem> groupOptions = [];
    List<GroupItemOptions> options = [
      GroupItemOptions(
        textFormFieldOptions: GroupItemTextFieldOptions(
          name: tcontext.meta.name,
          text: _data.name,
          textWidthPercent: 0.7,
          hint: tcontext.meta.required,
          onChanged: (String value) {
            _data.name = value.trim();
          },
        ),
      ),
      GroupItemOptions(
        stringPickerOptions: GroupItemStringPickerOptions(
          name: "Type",
          tips: "type",
          selected: _data.type,
          strings: RuleProvider.getTypes(),
          onPicker: (String? selected) async {
            _data.type = selected ?? RuleProvider.getTypes().first;
            setState(() {});
          },
        ),
      ),

      if (_data.http != null) ...[
        GroupItemOptions(
          textFormFieldOptions: GroupItemTextFieldOptions(
            name: "url",
            tips: "url",
            text: _data.http!.url,
            hint: "https://e.com/rule.mrs[${tcontext.meta.required}]",
            textWidthPercent: 0.7,
            onChanged: (String value) {
              _data.http!.url = value.trim();
            },
          ),
        ),
        GroupItemOptions(
          stringPickerOptions: GroupItemStringPickerOptions(
            name: "Format",
            tips: "format",
            selected: _data.http!.format,
            strings: RuleProviderHttp.getFormats(),
            onPicker: (String? selected) async {
              _data.http!.format =
                  selected ?? RuleProviderHttp.getFormats().first;
              setState(() {});
            },
          ),
        ),
        GroupItemOptions(
          stringPickerOptions: GroupItemStringPickerOptions(
            name: "Behavior",
            tips: "behavior",
            selected: _data.http!.behavior,
            strings: RuleProviderHttp.getBehaviors(),
            onPicker: (String? selected) async {
              _data.http!.behavior =
                  selected ?? RuleProviderHttp.getBehaviors().first;
              setState(() {});
            },
          ),
        ),
        GroupItemOptions(
          timerIntervalPickerOptions: GroupItemTimerIntervalPickerOptions(
            name: tcontext.meta.updateInterval,
            tips: "interval",
            duration: _data.http!.interval,
            showDays: true,
            showHours: true,
            showMinutes: true,
            showSeconds: false,
            showDisable: true,
            onPicker: (bool canceled, Duration? duration) async {
              if (canceled) {
                return;
              }
              _data.http!.interval = duration;
              setState(() {});
            },
          ),
        ),
      ],
    ];

    groupOptions.add(GroupItem(options: options));

    return groupOptions;
  }
}
