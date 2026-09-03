import 'dart:io';

import 'package:clashmi/app/modules/profile_patch_manager.dart';
import 'package:clashmi/app/runtime/return_result.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/file_view_screen.dart';
import 'package:clashmi/screens/profile_patch_settings_edit_screen.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/widgets/sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilesPatchBoardItem extends StatelessWidget {
  const ProfilesPatchBoardItem({
    super.key,
    required this.setting,
    required this.selected,
    required this.showDivider,
    required this.onTap,
    this.onTapMore,
  });

  final ProfilePatchSetting setting;
  final bool selected;
  final bool showDivider;
  final Function() onTap;
  final Function()? onTapMore;

  @override
  Widget build(BuildContext context) {
    String updateInterval = "";

    if (setting.isRemote()) {
      if (setting.update != null) {
        final interval = DateTime.now().difference(setting.update!);
        if (interval.inDays > 0) {
          updateInterval = "> ${interval.inDays} d";
        } else if (interval.inHours > 0) {
          updateInterval = "> ${interval.inHours} h";
        } else {
          updateInterval = "< 1 h";
        }
      }
    }
    return InkWell(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 10),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    setting.getShowName(context),
                    style: TextStyle(
                      color: selected ? ThemeDefine.kColorBlue : null,
                      fontSize: 12,
                    ),
                  ),
                ),
                setting.isBuildIn()
                    ? const SizedBox.shrink()
                    : Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          setting.id,
                          style: TextStyle(
                            color: selected ? ThemeDefine.kColorBlue : null,
                            fontSize: 12,
                          ),
                        ),
                      ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    setting.getType(),
                    style: TextStyle(
                      color: selected ? ThemeDefine.kColorBlue : null,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                showDivider
                    ? const Divider(height: 1, thickness: 0.3)
                    : SizedBox.shrink(),
              ],
            ),
          ),
          onTapMore == null
              ? const SizedBox.shrink()
              : SizedBox(
                  width: 50,
                  child: Text(
                    updateInterval,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: selected ? ThemeDefine.kColorBlue : null,
                    ),
                  ),
                ),
          onTapMore == null
              ? const SizedBox.shrink()
              : SizedBox(
                  width: 40,
                  height: 40,
                  child: ProfilePatchManager.updating.contains(setting.id)
                      ? const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 20,
                              height: 20,
                              child: RepaintBoundary(
                                child: CircularProgressIndicator(),
                              ),
                            ),
                          ],
                        )
                      : InkWell(
                          child: Icon(Icons.more_vert_outlined, size: 20),
                          onTap: () {
                            onTapMore!();
                          },
                        ),
                ),
        ],
      ),
      onTap: () {
        onTap();
      },
    );
  }
}

class ProfilesPatchBoardScreenWidget extends StatefulWidget {
  const ProfilesPatchBoardScreenWidget({super.key, required this.settings});
  final List<ProfilePatchSetting> settings;

  @override
  State<ProfilesPatchBoardScreenWidget> createState() =>
      _ProfilesPatchBoardScreenWidget();
}

class _ProfilesPatchBoardScreenWidget
    extends State<ProfilesPatchBoardScreenWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ProfilePatchManager.save();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = ProfilePatchManager.getCurrent();

    ProfilePatchSetting buildinOverwrite = ProfilePatchSetting(
      id: kProfilePatchBuildinOverwrite,
    );
    ProfilePatchSetting buildinNoOverwrite = ProfilePatchSetting(
      id: kProfilePatchBuildinNoOverwrite,
    );
    List<Widget> widgets = [];
    widgets.add(
      SizedBox(
        key: Key(buildinOverwrite.id),
        child: ProfilesPatchBoardItem(
          setting: buildinOverwrite,
          selected: current.id == buildinOverwrite.id,
          showDivider: true,
          onTap: () {
            ProfilePatchManager.setCurrent(buildinOverwrite.id);
            Navigator.of(context).pop();
          },
          onTapMore: null,
        ),
      ),
    );
    widgets.add(
      SizedBox(
        key: Key(buildinNoOverwrite.id),
        child: ProfilesPatchBoardItem(
          setting: buildinNoOverwrite,
          selected: current.id == buildinNoOverwrite.id,
          showDivider: true,
          onTap: () {
            ProfilePatchManager.setCurrent(buildinNoOverwrite.id);
            Navigator.of(context).pop();
          },
          onTapMore: null,
        ),
      ),
    );

    for (int i = 0; i < widget.settings.length; ++i) {
      var setting = widget.settings[i];
      final isCurrent = current.id == setting.id;

      widgets.add(
        SizedBox(
          key: Key(setting.id),
          child: ProfilesPatchBoardItem(
            setting: setting,
            selected: isCurrent,
            showDivider: i != widget.settings.length - 1,
            onTap: () {
              ProfilePatchManager.setCurrent(setting.id);
              Navigator.of(context).pop();
            },
            onTapMore: () {
              showMore(setting);
            },
          ),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Scrollbar(
          child: ReorderableListView(
            children: widgets,
            onReorderItem: (int oldIndex, int newIndex) {
              ProfilePatchManager.reorder(oldIndex, newIndex);

              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  void showMore(ProfilePatchSetting setting) {
    final tcontext = Translations.of(context);

    var widgets = [
      ListTile(
        title: Text(
          setting.isRemote() ? tcontext.meta.view : tcontext.meta.edit,
        ),
        onTap: () async {
          Navigator.of(context).pop();
          final path = await ProfilePatchManager.getProfilePatchPath(
            setting.id,
          );
          final content = await File(path).readAsString();
          if (!mounted) {
            return;
          }
          await Navigator.push(
            context,
            MaterialPageRoute(
              settings: FileViewScreen.routeSettings(),
              builder: (context) => FileViewScreen(
                title: setting.getShowName(context),
                content: content,
                onSave: setting.isRemote()
                    ? null
                    : (BuildContext context, String content) async {
                        await File(path).writeAsString(content);
                      },
              ),
            ),
          );
        },
      ),
      if (setting.isRemote()) ...[
        ListTile(
          title: Text(tcontext.meta.update),
          onTap: () async {
            Navigator.of(context).pop();
            ReturnResultError? err = await ProfilePatchManager.update(
              setting.id,
            );
            if (err != null) {
              if (!mounted) {
                return;
              }
              DialogUtils.showAlertDialog(
                context,
                err.message,
                showCopy: true,
                showFAQ: true,
                withVersion: true,
              );
            }
          },
        ),
      ],
      if (setting.isRemote()) ...[
        ListTile(
          title: Text(tcontext.meta.copyUrl),
          onTap: () async {
            Navigator.of(context).pop();
            try {
              Clipboard.setData(ClipboardData(text: setting.url));
            } catch (e) {}
          },
        ),
      ],
      ListTile(
        title: Text(tcontext.meta.profileEdit),
        onTap: () async {
          Navigator.of(context).pop();
          await Navigator.push(
            context,
            MaterialPageRoute(
              settings: ProfilesPatchSettingsEditScreen.routeSettings(),
              builder: (context) =>
                  ProfilesPatchSettingsEditScreen(profileid: setting.id),
            ),
          );
          setState(() {});
        },
      ),
      ListTile(
        title: Text(tcontext.meta.remove),
        onTap: () async {
          Navigator.of(context).pop();
          ProfilePatchManager.remove(setting.id);
        },
      ),
    ];

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
