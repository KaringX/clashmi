import 'package:clashmi/app/modules/profile_patch_manager.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/group_item_creator.dart';
import 'package:clashmi/screens/group_item_options.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:clashmi/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

class ProfilesPatchSettingsEditScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return const RouteSettings(name: "ProfilesPatchSettingsEditScreen");
  }

  final String profileid;
  const ProfilesPatchSettingsEditScreen({super.key, required this.profileid});

  @override
  State<ProfilesPatchSettingsEditScreen> createState() =>
      _ProfilesPatchSettingsEditScreenState();
}

class _ProfilesPatchSettingsEditScreenState
    extends LasyRenderingState<ProfilesPatchSettingsEditScreen> {
  final _textControllerRemark = TextEditingController();
  final _textControllerUrl = TextEditingController();
  Duration? _updateInterval = const Duration(hours: 24);
  ProfilePatchFileType _type = ProfilePatchFileType.yaml;
  String _appendPatchBuildin = "";

  @override
  void initState() {
    var profile = ProfilePatchManager.getProfilePatch(widget.profileid);
    _textControllerRemark.value = _textControllerRemark.value.copyWith(
      text: profile.remark,
    );
    _textControllerUrl.value = _textControllerUrl.value.copyWith(
      text: profile.url,
    );
    _updateInterval = profile.updateInterval;
    _type = profile.type;
    _appendPatchBuildin = profile.appendPatchBuildin;
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
    var profile = ProfilePatchManager.getProfilePatch(widget.profileid);

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
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(18, 10, 18, 10),
                        child: Column(
                          children: [
                            TextFieldEx(
                              controller: _textControllerRemark,
                              textInputAction: profile.isRemote()
                                  ? TextInputAction.next
                                  : TextInputAction.done,
                              decoration: InputDecoration(
                                labelText: tcontext.meta.remark,
                                hintText: tcontext.meta.remark,
                              ),
                            ),
                            profile.isRemote()
                                ? const SizedBox(height: 20)
                                : const SizedBox.shrink(),
                            profile.isRemote()
                                ? TextFieldEx(
                                    maxLines: 4,
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
            ],
          ),
        ),
      ),
    );
  }

  void onTapSave() {
    var profile = ProfilePatchManager.getProfilePatch(widget.profileid);

    String remarkText = _textControllerRemark.text.trim();
    String urlText = _textControllerUrl.text.trim();

    if (_updateInterval != null) {
      if (_updateInterval!.inMinutes < 5) {
        _updateInterval = const Duration(minutes: 5);
      }
    }

    final err = checkUrl(profile.url, urlText);
    if (err != null) {
      DialogUtils.showAlertDialog(context, err);
      return;
    }
    profile.remark = remarkText;
    profile.url = urlText;
    profile.updateInterval = _updateInterval;
    profile.type = _type;
    profile.appendPatchBuildin = _appendPatchBuildin;
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
    var profile = ProfilePatchManager.getProfilePatch(widget.profileid);

    final tcontext = Translations.of(context);

    List<GroupItem> groupOptions = [];
    List<GroupItemOptions> options = [
      if (profile.isRemote()) ...[
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
      ],
    ];
    String currentSelectedAppend = "";
    if (_appendPatchBuildin == kProfilePatchBuildinOverwrite) {
      currentSelectedAppend = tcontext.profilePatchMode.overwrite;
    } else {
      currentSelectedAppend = tcontext.profilePatchMode.noOverwrite;
    }
    List<Tuple2<String?, String>> overwrite = [
      Tuple2(
        kProfilePatchBuildinOverwrite,
        tcontext.profilePatchMode.overwrite,
      ),
      Tuple2(
        kProfilePatchBuildinNoOverwrite,
        tcontext.profilePatchMode.noOverwrite,
      ),
    ];
    List<GroupItemOptions> options1 = [
      GroupItemOptions(
        stringPickerOptions: GroupItemStringPickerOptions(
          name: tcontext.meta.type,
          selected: _type.name,
          strings: ProfilePatchFileType.getTypes(),
          onPicker: (String? selected) async {
            _type = ProfilePatchFileType.values.firstWhere(
              (e) => e.name == selected,
              orElse: () => ProfilePatchFileType.yaml,
            );
            setState(() {});
          },
        ),
      ),
      GroupItemOptions(
        stringPickerOptions: GroupItemStringPickerOptions(
          name: tcontext.meta.overwriteAppend,
          selected: currentSelectedAppend,
          tupleStrings: overwrite,
          onPicker: (String? selected) async {
            _appendPatchBuildin = selected ?? "";
            setState(() {});
          },
        ),
      ),
    ];

    groupOptions.add(GroupItem(options: options));
    groupOptions.add(GroupItem(options: options1));

    return groupOptions;
  }
}
