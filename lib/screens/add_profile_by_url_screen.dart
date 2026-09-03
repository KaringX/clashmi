// ignore_for_file: use_build_context_synchronously, empty_catches

import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:clashmi/app/modules/board_provider_manager.dart';
import 'package:clashmi/app/modules/profile_manager.dart';
import 'package:clashmi/app/modules/profile_patch_manager.dart';
import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/app/utils/http_utils.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/group_item_creator.dart';
import 'package:clashmi/screens/group_item_options.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:clashmi/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class AddProfileByUrlScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return const RouteSettings(name: "AddProfileByUrlScreen");
  }

  static int pushed = 0;
  final String url;
  final String remark;
  final bool? overwrite;
  final bool? xhwid;
  const AddProfileByUrlScreen({
    super.key,
    this.url = "",
    this.remark = "",
    this.overwrite,
    this.xhwid,
  });

  @override
  State<AddProfileByUrlScreen> createState() => _AddProfileByUrlScreenState();
}

class _AddProfileByUrlScreenState
    extends LasyRenderingState<AddProfileByUrlScreen>
    with AfterLayoutMixin {
  final _textControllerLink = TextEditingController();
  final _textControllerRemark = TextEditingController();
  Duration? _updateInterval = const Duration(hours: 24);
  bool _updateIntervalPreferByProfile = true;
  String _userAgent = "";
  bool _xhwid = false;
  String _boardProviderId = "";
  String _decryptPassword = "";
  String _patch = "";
  bool _loading = false;
  @override
  void initState() {
    ++AddProfileByUrlScreen.pushed;
    _textControllerLink.text = widget.url.trim();
    _textControllerRemark.text = widget.remark.trim();
    var setting = SettingManager.getConfig();
    _userAgent = setting.userAgent();
    if (widget.overwrite == true) {
      _patch = kProfilePatchBuildinOverwrite;
    } else if (widget.overwrite == false) {
      _patch = kProfilePatchBuildinNoOverwrite;
    }
    _boardProviderId = BoardProviderManager.unknownProviderId;
    _xhwid = widget.xhwid == true;
    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {}

  @override
  void dispose() {
    --AddProfileByUrlScreen.pushed;
    _textControllerLink.dispose();
    _textControllerRemark.dispose();
    super.dispose();
  }

  Future<void> onAdd(BuildContext context) async {
    final tcontext = Translations.of(context);
    String url = _textControllerLink.text.trim();
    String remark = _textControllerRemark.text.trim();
    _loading = true;
    setState(() {});

    final result = await ProfileManager.addRemote(
      url,
      remark: remark,
      patch: _patch,
      userAgent: _userAgent,
      xhwid: _xhwid,
      decryptPassword: _decryptPassword,
      updateInterval: _updateInterval,
      updateIntervalPreferByProfile: _updateIntervalPreferByProfile,
      boardProviderId: _boardProviderId,
    );

    if (!mounted) {
      return;
    }
    _loading = false;
    setState(() {});
    if (result.error == null) {
      await DialogUtils.showAlertDialog(context, tcontext.meta.addSuccess);
      if (!mounted) {
        return;
      }
      Navigator.pop(context, true);
      return;
    }
    if (!mounted) {
      return;
    }

    DialogUtils.showAlertDialog(
      context,
      result.error!.message,
      showCopy: true,
      showFAQ: true,
      withVersion: true,
    );
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
                      tcontext.meta.profileAddUrlOrContent,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: ThemeConfig.kFontWeightTitle,
                        fontSize: ThemeConfig.kFontSizeTitle,
                      ),
                    ),
                  ),
                  _loading
                      ? const Row(
                          children: [
                            SizedBox(width: 12),
                            SizedBox(
                              width: 26,
                              height: 26,
                              child: RepaintBoundary(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                            SizedBox(width: 12),
                          ],
                        )
                      : InkWell(
                          onTap: () async {
                            await onAdd(context);
                          },
                          child: Tooltip(
                            message: tcontext.meta.save,
                            child: const SizedBox(
                              width: 50,
                              height: 30,
                              child: Icon(Icons.done, size: 26),
                            ),
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
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                18,
                                10,
                                18,
                                10,
                              ),
                              child: TextFieldEx(
                                textInputAction: TextInputAction.next,
                                maxLines: 5,
                                controller: _textControllerLink,
                                decoration: InputDecoration(
                                  labelText: tcontext.meta.profileUrlOrContent(
                                    p: "Clash",
                                  ),
                                  hintText: tcontext.meta
                                      .profileUrlOrContentHit(p: "Clash"),
                                ),
                                onChanged: (text) {},
                                onEditingComplete: () async {
                                  String url = _textControllerLink.text.trim();
                                  if (url.isNotEmpty ||
                                      null != Uri.tryParse(url)) {
                                    final userAgent = SettingManager.getConfig()
                                        .userAgent();
                                    final result = await HttpUtils.httpGetTitle(
                                      url,
                                      userAgent,
                                    );
                                    if (result.error == null) {
                                      if (_textControllerRemark.text
                                          .trim()
                                          .isEmpty) {
                                        _textControllerRemark.text =
                                            result.data!;
                                        setState(() {});
                                      }
                                    }
                                  }
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                18,
                                10,
                                18,
                                10,
                              ),
                              child: TextFieldEx(
                                textInputAction: TextInputAction.done,
                                controller: _textControllerRemark,
                                decoration: InputDecoration(
                                  labelText: tcontext.meta.remark,
                                  hintText: tcontext.meta.required,
                                  prefixIcon: const Icon(
                                    Icons.edit_note_outlined,
                                  ),
                                ),
                                onSubmitted: (String? text) {
                                  FocusScope.of(context).nextFocus();
                                },
                              ),
                            ),
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
            ],
          ),
        ),
      ),
    );
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
      overwrite.add(Tuple2(item.id, item.id));
    }
    List<GroupItem> groupOptions = [];
    List<GroupItemOptions> options = [
      GroupItemOptions(
        textFormFieldOptions: GroupItemTextFieldOptions(
          name: tcontext.meta.userAgent,
          text: _userAgent,
          textWidthPercent: 0.6,
          onChanged: (String value) {
            _userAgent = value;
          },
        ),
      ),
      GroupItemOptions(
        switchOptions: GroupItemSwitchOptions(
          name: "X-HWID",
          switchValue: _xhwid,
          onSwitch: (bool value) async {
            _xhwid = value;
            setState(() {});
          },
        ),
      ),
      GroupItemOptions(
        switchOptions: GroupItemSwitchOptions(
          name: tcontext.meta.profileDownloadBackupChannel,
          tips: tcontext.meta.profileDownloadBackupChannelTips,
          switchValue:
              _boardProviderId == BoardProviderManager.unknownProviderId,
          onSwitch: (bool value) async {
            _boardProviderId = value
                ? BoardProviderManager.unknownProviderId
                : "";
            setState(() {});
          },
        ),
      ),
      GroupItemOptions(
        textFormFieldOptions: GroupItemTextFieldOptions(
          name: tcontext.meta.decryptPassword,
          text: _decryptPassword,
          textWidthPercent: 0.6,
          onChanged: (String value) {
            _decryptPassword = value;
          },
        ),
      ),
      GroupItemOptions(
        stringPickerOptions: GroupItemStringPickerOptions(
          name: tcontext.meta.coreOverwrite,
          selected: _patch,
          tupleStrings: overwrite,
          onPicker: (String? selected) async {
            _patch = selected ?? "";
            setState(() {});
          },
        ),
      ),
      GroupItemOptions(
        switchOptions: GroupItemSwitchOptions(
          name:
              "${tcontext.meta.updateInterval}:${tcontext.meta.updateIntervalPreferByProfile}",
          switchValue: _updateIntervalPreferByProfile,
          onSwitch: (bool value) async {
            _updateIntervalPreferByProfile = value;
            setState(() {});
          },
        ),
      ),
      GroupItemOptions(
        timerIntervalPickerOptions: GroupItemTimerIntervalPickerOptions(
          name: tcontext.meta.updateInterval,
          tips: tcontext.meta.updateInterval5mTips,
          duration: _updateInterval,
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

            _updateInterval = duration;
            setState(() {});
          },
        ),
      ),
    ];
    groupOptions.add(GroupItem(options: options));
    return groupOptions;
  }
}
