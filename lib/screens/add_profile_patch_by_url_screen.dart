// ignore_for_file: use_build_context_synchronously, empty_catches

import 'dart:async';

import 'package:after_layout/after_layout.dart';
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

class AddProfilePatchByUrlScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return const RouteSettings(name: "AddProfilePatchByUrlScreen");
  }

  static int pushed = 0;
  final String url;
  final String remark;
  final bool overwrite;
  const AddProfilePatchByUrlScreen({
    super.key,
    this.url = "",
    this.remark = "",
    this.overwrite = true,
  });

  @override
  State<AddProfilePatchByUrlScreen> createState() =>
      _AddProfilePatchByUrlScreenState();
}

class _AddProfilePatchByUrlScreenState
    extends LasyRenderingState<AddProfilePatchByUrlScreen>
    with AfterLayoutMixin {
  final _textControllerLink = TextEditingController();
  final _textControllerRemark = TextEditingController();
  ProfilePatchFileType _type = ProfilePatchFileType.yaml;
  bool _loading = false;

  @override
  void initState() {
    ++AddProfilePatchByUrlScreen.pushed;
    _textControllerLink.text = widget.url.trim();
    _textControllerRemark.text = widget.remark.trim();
    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {}

  @override
  void dispose() {
    --AddProfilePatchByUrlScreen.pushed;
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

    final result = await ProfilePatchManager.addRemote(
      url,
      remark: remark,
      type: _type,
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
                              child: SingleChildScrollView(
                                child: TextFieldEx(
                                  textInputAction: TextInputAction.next,
                                  maxLines: 5,
                                  controller: _textControllerLink,
                                  decoration: InputDecoration(
                                    labelText:
                                        tcontext.meta.profileUrlOrContent,
                                    hintText:
                                        tcontext.meta.profileUrlOrContentHit,
                                  ),
                                  onChanged: (text) {},
                                  onEditingComplete: () async {
                                    String url = _textControllerLink.text
                                        .trim();
                                    if (url.isNotEmpty ||
                                        null != Uri.tryParse(url)) {
                                      final userAgent =
                                          SettingManager.getConfig()
                                              .userAgent();
                                      final result =
                                          await HttpUtils.httpGetTitle(
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
                            const SizedBox(height: 10),
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
                            const SizedBox(height: 200),
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
    List<GroupItem> groupOptions = [];
    List<GroupItemOptions> options = [
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
    ];

    groupOptions.add(GroupItem(options: options));

    return groupOptions;
  }
}
