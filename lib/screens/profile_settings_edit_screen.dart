import 'dart:io';

import 'package:clashmi/app/clash/clash_config.dart';
import 'package:clashmi/app/clash/clash_http_api.dart';
import 'package:clashmi/app/local_services/vpn_service.dart';
import 'package:clashmi/app/modules/board_provider_manager.dart';
import 'package:clashmi/app/modules/diversion_template_manager.dart';
import 'package:clashmi/app/modules/profile_manager.dart';
import 'package:clashmi/app/modules/profile_patch_manager.dart';
import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/group_item_creator.dart';
import 'package:clashmi/screens/group_item_options.dart';
import 'package:clashmi/screens/group_screen.dart';

import 'package:clashmi/screens/proxygroup_screen.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:clashmi/screens/widgets/sheet.dart';
import 'package:clashmi/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class ProfilesSettingsEditScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routSettings() {
    return const RouteSettings(name: "ProfilesSettingsEditScreen");
  }

  final ProfileSetting profile;
  const ProfilesSettingsEditScreen({super.key, required this.profile});

  @override
  State<ProfilesSettingsEditScreen> createState() =>
      _ProfilesSettingsEditScreenState();
}

class _ProfilesSettingsEditScreenState
    extends LasyRenderingState<ProfilesSettingsEditScreen> {
  final _textControllerRemark = TextEditingController();
  final _textControllerUrl = TextEditingController();
  late ProfileSetting _profile;
  BoardProviderConfig? _provider;
  List<ClashProxiesNode> _nodes = [];

  @override
  void initState() {
    _profile = widget.profile.clone();
    _profile.userAgent = _profile.userAgent.isEmpty
        ? SettingManager.getConfig().userAgent()
        : _profile.userAgent;

    _provider = BoardProviderManager.getProviderById(_profile.boardProviderId);

    _textControllerRemark.value = _textControllerRemark.value.copyWith(
      text: _profile.remark,
    );
    _textControllerUrl.value = _textControllerUrl.value.copyWith(
      text: _profile.url,
    );

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final tcontext = Translations.of(context);
    Size windowSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.zero, child: AppBar()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            children: [
              Row(
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
                      tcontext.meta.profileEdit,
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
                      child: Icon(Icons.done_outlined, size: 26),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                          child: Column(
                            children: [
                              TextFieldEx(
                                enabled: _provider == null,
                                controller: _textControllerRemark,
                                textInputAction: _profile.isRemote()
                                    ? TextInputAction.next
                                    : TextInputAction.done,
                                decoration: InputDecoration(
                                  labelText: tcontext.meta.remark,
                                  hintText: tcontext.meta.remark,
                                ),
                              ),
                              _profile.isRemote()
                                  ? const SizedBox(height: 20)
                                  : const SizedBox.shrink(),
                              _profile.isRemote()
                                  ? TextFieldEx(
                                      maxLines: 5,
                                      enabled: _provider == null,
                                      controller: _textControllerUrl,
                                      decoration: InputDecoration(
                                        labelText: tcontext.meta.url,
                                        hintText: tcontext.meta.url,
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                              const SizedBox(height: 20),
                              FutureBuilder(
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onTapSave() {
    String remarkText = _textControllerRemark.text.trim();
    String urlText = _textControllerUrl.text.trim();
    if (_profile.updateInterval != null) {
      if (_profile.updateInterval!.inMinutes < 5) {
        _profile.updateInterval = const Duration(minutes: 5);
      }
    }

    final err = checkUrl(_profile.url, urlText);
    if (err != null) {
      DialogUtils.showAlertDialog(context, err);
      return;
    }
    _profile.remark = remarkText;
    _profile.url = urlText;

    ProfileManager.updateProfile(_profile.id, _profile);
    ProfileManager.save();
    Navigator.pop(context);
  }

  String? checkUrl(String oldUrl, String url) {
    final tcontext = Translations.of(context);
    if (oldUrl == url) {
      return null;
    }
    Uri? uri = Uri.tryParse(url);
    if (uri == null || (uri.scheme != 'http' && uri.scheme != 'https')) {
      return tcontext.meta.urlInvalid;
    }

    return null;
  }

  Future<List<GroupItem>> getGroupOptions() async {
    final tcontext = Translations.of(context);
    final currentPatch = ProfilePatchManager.getCurrent();
    String currentSelectedAppend = "";
    if (currentPatch.id == kProfilePatchBuildinOverwrite) {
      currentSelectedAppend = "(${tcontext.profilePatchMode.overwrite})";
    } else if (currentPatch.id == kProfilePatchBuildinNoOverwrite) {
      currentSelectedAppend = "(${tcontext.profilePatchMode.noOverwrite})";
    } else {
      currentSelectedAppend = "(${currentPatch.remark})";
    }
    List<Tuple2<String?, String>> overwrite = [
      Tuple2(
        "",
        "${tcontext.profilePatchMode.currentSelected}$currentSelectedAppend",
      ),
      Tuple2(
        kProfilePatchBuildinOverwrite,
        tcontext.profilePatchMode.overwrite,
      ),
      Tuple2(
        kProfilePatchBuildinNoOverwrite,
        tcontext.profilePatchMode.noOverwrite,
      ),
    ];
    final items = ProfilePatchManager.getProfilePatchs();
    for (var item in items) {
      overwrite.add(Tuple2(item.id, item.remark));
    }
    List<GroupItem> groupOptions = [];
    List<GroupItemOptions> options = [
      GroupItemOptions(
        textFormFieldOptions: GroupItemTextFieldOptions(
          name: tcontext.meta.userAgent,
          text: _profile.userAgent,
          textWidthPercent: 0.6,
          enabled:
              _provider == null ||
              (_provider != null && _provider!.userAgent.isEmpty),
          onChanged: (String value) {
            _profile.userAgent = value;
          },
        ),
      ),
      GroupItemOptions(
        switchOptions: GroupItemSwitchOptions(
          name: "X-HWID",
          switchValue: _profile.xhwid,
          onSwitch: _provider != null
              ? null
              : (bool value) async {
                  _profile.xhwid = value;
                  setState(() {});
                },
        ),
      ),
      GroupItemOptions(
        textFormFieldOptions: GroupItemTextFieldOptions(
          name: tcontext.meta.decryptPassword,
          text: _profile.decryptPassword,
          textWidthPercent: 0.6,
          onChanged: (String value) {
            _profile.decryptPassword = value;
          },
        ),
      ),
      GroupItemOptions(
        stringPickerOptions: GroupItemStringPickerOptions(
          name: tcontext.meta.coreOverwrite,
          selected: _profile.patch,
          tupleStrings: overwrite,
          onPicker: (String? selected) async {
            _profile.patch = selected ?? "";
            setState(() {});
          },
        ),
      ),
      if (_profile.isRemote()) ...[
        GroupItemOptions(
          switchOptions: GroupItemSwitchOptions(
            name:
                "${tcontext.meta.updateInterval}:${tcontext.meta.updateIntervalPreferByProfile}",
            tips: _profile.updateIntervalByProfile != null
                ? "${_profile.updateIntervalByProfile!.inHours.toString()}h"
                : null,
            switchValue: _profile.updateIntervalPreferByProfile,
            onSwitch: (bool value) async {
              _profile.updateIntervalPreferByProfile = value;
              setState(() {});
            },
          ),
        ),
        GroupItemOptions(
          timerIntervalPickerOptions: GroupItemTimerIntervalPickerOptions(
            name: tcontext.meta.updateInterval,
            tips: tcontext.meta.updateInterval5mTips,
            duration: _profile.updateInterval,
            showSeconds: false,
            onPicker: (bool canceled, Duration? duration) async {
              if (canceled) {
                return;
              }
              if (duration != null) {
                if (duration.inDays > 365) {
                  duration = const Duration(days: 365);
                }
                if (duration.inMinutes < 5) {
                  duration = const Duration(minutes: 5);
                }
              }

              _profile.updateInterval = duration;
              setState(() {});
            },
          ),
        ),
      ],
    ];

    List<GroupItemOptions> options1 = [
      GroupItemOptions(
        pushOptions: GroupItemPushOptions(
          name: tcontext.meta.proxyGroups,
          tips: "proxy-groups",
          onPush: () async {
            showClashSettingsProxyGroups();
          },
        ),
      ),
      GroupItemOptions(
        pushOptions: GroupItemPushOptions(
          name: tcontext.meta.rule,
          tips: "rules",
          onPush: () async {
            showClashSettingsRules();
          },
        ),
      ),
    ];

    List<GroupItemOptions> options2 = [
      GroupItemOptions(
        switchOptions: GroupItemSwitchOptions(
          name: tcontext.meta.profileRulesAppendApplePush,
          tips: tcontext.meta.profileRulesAppendProxyTips,
          switchValue: _profile.appendApplePushRules,
          onSwitch: (bool value) async {
            _profile.appendApplePushRules = value;
            setState(() {});
          },
        ),
      ),
    ];

    groupOptions.add(GroupItem(options: options));
    groupOptions.add(GroupItem(options: options1));
    if (Platform.isIOS) {
      groupOptions.add(GroupItem(options: options2));
    }

    return groupOptions;
  }

  Future<void> showClashSettingsProxyGroups() async {
    final current = ProfileManager.getCurrent();
    final connected = await VPNService.getStarted();
    if (!mounted) {
      return;
    }
    if (!connected || current == null || current.id != _profile.id) {
      final tcontext = Translations.of(context);
      DialogUtils.showAlertDialog(context, tcontext.meta.profileNeedActive);
      return;
    }
    if (_nodes.isEmpty) {
      _nodes = await getProxies();
    }
    var newNodes = _nodes.toList();
    newNodes.removeWhere((ClashProxiesNode node) {
      return ClashProtocolType.GroupToList().contains(node.type);
    });
    if (!mounted) {
      return;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
        settings: ProxyGroupsScreen.routSettings(),
        builder: (context) =>
            ProxyGroupsScreen(profile: _profile, nodes: newNodes),
      ),
    );
  }

  Future<void> showClashSettingsRules() async {
    final tcontext = Translations.of(context);
    Future<List<GroupItem>> getOptions(
      BuildContext context,
      SetStateCallback? setstate,
    ) async {
      List<GroupItemOptions> options = [
        GroupItemOptions(
          switchOptions: GroupItemSwitchOptions(
            name: "${tcontext.meta.overwrite} [${tcontext.meta.rule}]",
            switchValue: _profile.overwriteRules,
            onSwitch: (bool value) async {
              _profile.overwriteRules = value;
              setState(() {});
            },
          ),
        ),
        GroupItemOptions(
          switchOptions: GroupItemSwitchOptions(
            name: "${tcontext.meta.overwrite} [${tcontext.meta.proxyGroups}]",
            switchValue: _profile.overwriteProxyGroups,
            onSwitch: !_profile.overwriteRules
                ? null
                : (bool value) async {
                    _profile.overwriteProxyGroups = value;
                    setState(() {});
                  },
          ),
        ),
      ];
      List<GroupItemOptions> options1 = [];
      final names = DiversionTemplateManager.getRuleTemplatesNames();
      for (var name in names) {
        final target = _profile.overwriteProxyGroups
            ? _profile.rulesForProxyGroups[name]
            : _profile.rules[name];
        options1.add(
          GroupItemOptions(
            pushOptions: GroupItemPushOptions(
              name: name,
              text: target,
              onPush: !_profile.overwriteRules
                  ? null
                  : () async {
                      onTapRule(name, setstate);
                    },
            ),
          ),
        );
      }

      return [GroupItem(options: options), GroupItem(options: options1)];
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        settings: GroupScreen.routSettings("rules"),
        builder: (context) =>
            GroupScreen(title: tcontext.meta.rule, getOptions: getOptions),
      ),
    );
  }

  Future<List<ClashProxiesNode>> getProxies() async {
    var result = await ClashHttpApi.getProxies();
    if (result.error == null) {
      return result.data!;
    }

    return [];
  }

  Future<void> onTapRule(String ruleName, SetStateCallback? setstate) async {
    final current = ProfileManager.getCurrent();
    final connected = await VPNService.getStarted();
    if (!mounted) {
      return;
    }
    if (!connected || current == null || current.id != _profile.id) {
      final tcontext = Translations.of(context);
      DialogUtils.showAlertDialog(context, tcontext.meta.profileNeedActive);
      return;
    }
    if (_nodes.isEmpty) {
      _nodes = await getProxies();
    }
    var newNodes = _nodes.toList();
    if (_profile.overwriteProxyGroups) {
      newNodes.removeWhere((ClashProxiesNode node) {
        return ClashProtocolType.GroupToList().contains(node.type);
      });
      List<ClashProxiesNode> pgNodes = [];
      final pgs = DiversionTemplateManager.getProxyGroupTemplates();
      for (var pg in pgs) {
        ClashProxiesNode cn = ClashProxiesNode();
        cn.name = pg.name;
        cn.type = ProxyGroupTemplate.toClashProtocolTypeString(pg.type);
        pgNodes.add(cn);
      }
      newNodes.insertAll(0, pgNodes);
    }

    var widgets = [];
    for (int i = 0; i < newNodes.length; ++i) {
      final node = newNodes[i];
      String subtitle = "";
      Color? color;
      if (node.delay != null && node.delay! > 0) {
        subtitle = "(${node.delay} ms)";
        if (node.delay! < 800) {
          color = ThemeDefine.kColorGreenBright;
        } else if (node.delay! < 1500) {
          color = Colors.black;
        } else {
          color = Colors.red;
        }
      }
      widgets.add(
        ListTile(
          title: Text(
            "${i + 1} ${node.name}",
            style: TextStyle(fontFamily: Platform.isWindows ? 'Emoji' : null),
          ),
          subtitle: subtitle.isEmpty
              ? Text(node.type)
              : Row(
                  children: [
                    Text(node.type),
                    SizedBox(width: 5),
                    Text(subtitle, style: TextStyle(color: color)),
                  ],
                ),
          selected:
              (_profile.overwriteProxyGroups &&
                  node.name == _profile.rulesForProxyGroups[ruleName]) ||
              (!_profile.overwriteProxyGroups &&
                  node.name == _profile.rules[ruleName]),
          selectedColor: ThemeDefine.kColorBlue,
          onTap: () async {
            if (_profile.overwriteProxyGroups) {
              _profile.rulesForProxyGroups[ruleName] = node.name;
            } else {
              _profile.rules[ruleName] = node.name;
            }

            Navigator.of(context).pop();
            setstate?.call();
          },
        ),
      );
    }
    if (!mounted) {
      return;
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
