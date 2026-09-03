import 'package:clashmi/app/modules/diversion_template_manager.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/group_item_creator.dart';
import 'package:clashmi/screens/group_item_options.dart';

import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:flutter/material.dart';

class ProxyGroupTemplatesAddOrEditScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return RouteSettings(name: "ProxyGroupTemplateAddOrEditScreen");
  }

  final String name;
  const ProxyGroupTemplatesAddOrEditScreen({super.key, this.name = ""});

  @override
  State<ProxyGroupTemplatesAddOrEditScreen> createState() =>
      _ProxyGroupTemplatesAddOrEditScreenState();
}

class _ProxyGroupTemplatesAddOrEditScreenState
    extends LasyRenderingState<ProxyGroupTemplatesAddOrEditScreen> {
  late ProxyGroupTemplate _data;
  @override
  void initState() {
    if (widget.name.isNotEmpty) {
      final exist = DiversionTemplateManager.getProxyGroupTemplateByName(
        widget.name,
      );
      if (exist != null) {
        _data = exist.clone();
      } else {
        _data = ProxyGroupTemplate(type: ProxyGroupTemplate.getTypes().first);
      }
    } else {
      _data = ProxyGroupTemplate(type: ProxyGroupTemplate.getTypes().first);
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

    final names = DiversionTemplateManager.getProxyGroupTemplatesNames();
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

    if (widget.name.isNotEmpty) {
      DiversionTemplateManager.updateProxyGroupTemplate(widget.name, _data);
    } else {
      DiversionTemplateManager.addProxyGroupTemplate(_data);
    }

    DiversionTemplateManager.save();
    Navigator.pop(context);
  }

  Future<List<GroupItem>> getGroupOptions() async {
    final tcontext = Translations.of(context);

    List<GroupItemOptions> options = [
      GroupItemOptions(
        textFormFieldOptions: GroupItemTextFieldOptions(
          name: tcontext.meta.name,
          text: _data.name,
          tips: "name",
          textWidthPercent: 0.7,
          hint: "[${tcontext.meta.required}]",
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
          strings: ProxyGroupTemplate.getTypes(),
          onPicker: (String? selected) async {
            _data.type = selected ?? ProxyGroupTemplate.getTypes().first;
            setState(() {});
          },
        ),
      ),
      GroupItemOptions(
        textFormFieldOptions: GroupItemTextFieldOptions(
          name: "Icon",
          text: _data.icon,
          tips: "icon",
          textWidthPercent: 0.7,
          hint: "http://a.com/a.png",
          onChanged: (String value) {
            final uri = Uri.tryParse(value.trim());
            if (uri != null) {
              _data.icon = value.trim();
            }
          },
        ),
      ),
    ];

    return [GroupItem(options: options)];
  }
}
