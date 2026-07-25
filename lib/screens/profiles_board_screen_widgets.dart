import 'dart:io';

import 'package:clashmi/app/clash/clash_http_api.dart';
import 'package:clashmi/app/modules/board_provider_manager.dart';
import 'package:clashmi/app/modules/board_session_persistent_manager.dart';
import 'package:clashmi/app/modules/profile_manager.dart';
import 'package:clashmi/app/modules/profile_patch_manager.dart';
import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/app/runtime/return_result.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/file_view_screen.dart';
import 'package:clashmi/screens/group_helper.dart';
import 'package:clashmi/screens/profile_settings_edit_screen.dart';
import 'package:clashmi/screens/qrcode_screen.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/widgets/sheet.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tuple/tuple.dart';

class ProfilesBoardItem extends StatelessWidget {
  const ProfilesBoardItem({
    super.key,
    required this.setting,
    required this.selected,
    required this.showDivider,
    required this.onTap,
    required this.onTapMore,
  });

  final ProfileSetting setting;
  final bool selected;
  final bool showDivider;
  final Function() onTap;
  final Function() onTapMore;

  @override
  Widget build(BuildContext context) {
    final tcontext = Translations.of(context);
    final settings = SettingManager.getConfig();
    final patch = ProfilePatchManager.getProfilePatch(setting.patch);
    final provider = BoardProviderManager.getProviderById(
      setting.boardProviderId,
    );

    String patchRemark = "";
    if (setting.patch.isEmpty || patch.id.isEmpty) {
      final currentPatch = ProfilePatchManager.getCurrent();
      patchRemark =
          "${tcontext.profilePatchMode.currentSelected} [${currentPatch.getShowName(context)}]";
    } else {
      patchRemark = patch.getShowName(context);
    }

    String tranffic = "";
    Tuple2<bool, String>? tranfficExpire;
    String updateInterval = "";

    if (setting.isRemote()) {
      if (setting.upload != 0 || setting.download != 0 || setting.total != 0) {
        String upload = ClashHttpApi.convertTrafficToStringDouble(
          setting.upload,
        );
        String download = ClashHttpApi.convertTrafficToStringDouble(
          setting.download,
        );
        String total = ClashHttpApi.convertTrafficToStringDouble(setting.total);
        tranffic = "↑ $upload ↓ $download/$total";
      }
      if (setting.expire.isNotEmpty) {
        tranfficExpire = setting.getExpireTime(settings.languageTag);
      }
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if (provider != null) ...[
                        provider.appIconUrl.isNotEmpty && provider.logoBranding
                            ? FastCachedImage(
                                url: provider.appIconUrl,
                                width: 16,
                                height: 16,
                                cacheWidth: 64,
                                cacheHeight: 64,
                                loadingBuilder: (context, loadingProgress) {
                                  return SizedBox.shrink();
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.business,
                                    size: 16,
                                    color: selected
                                        ? ThemeDefine.kColorBlue
                                        : null,
                                  );
                                },
                              )
                            : Icon(
                                Icons.business,
                                size: 16,
                                color: selected ? ThemeDefine.kColorBlue : null,
                              ),
                        const SizedBox(width: 5),
                      ],
                      Text(
                        setting.getShowName(),
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: selected ? ThemeDefine.kColorBlue : null,
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    setting.id,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: selected ? ThemeDefine.kColorBlue : null,
                    ),
                  ),
                ),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    patchRemark,
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
                tranffic.isNotEmpty
                    ? Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          tranffic,
                          style: TextStyle(
                            color: selected ? ThemeDefine.kColorBlue : null,
                            fontSize: 12,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                tranfficExpire != null
                    ? Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: Text(
                          tranfficExpire.item2,
                          style: TextStyle(
                            color: tranfficExpire.item1
                                ? Colors.red
                                : (selected ? ThemeDefine.kColorBlue : null),
                            fontSize: 12,
                          ),
                        ),
                      )
                    : SizedBox.shrink(),
                SizedBox(height: 10),
                showDivider
                    ? const Divider(height: 1, thickness: 0.3)
                    : SizedBox.shrink(),
              ],
            ),
          ),
          SizedBox(
            width: 50,
            child: Text(
              updateInterval,
              textAlign: TextAlign.right,
              style: TextStyle(color: selected ? ThemeDefine.kColorBlue : null),
            ),
          ),
          SizedBox(
            width: 40,
            height: 40,
            child: ProfileManager.updating.contains(setting.id)
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
                      onTapMore();
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

class ProfilesBoardScreenWidget extends StatefulWidget {
  const ProfilesBoardScreenWidget({super.key, required this.settings});
  final List<ProfileSetting> settings;

  @override
  State<ProfilesBoardScreenWidget> createState() =>
      _ProfilesBoardScreenWidget();
}

class _ProfilesBoardScreenWidget extends State<ProfilesBoardScreenWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    ProfileManager.save();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final current = ProfileManager.getCurrent();

    List<Widget> widgets = [];
    for (int i = 0; i < widget.settings.length; ++i) {
      var setting = widget.settings[i];
      final isCurrent = current?.id == setting.id;

      widgets.add(
        SizedBox(
          key: Key(setting.id),
          child: ProfilesBoardItem(
            setting: setting,
            selected: isCurrent,
            showDivider: i != widget.settings.length - 1,
            onTap: () {
              ProfileManager.setCurrent(setting.id);
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
              ProfileManager.reorder(oldIndex, newIndex);

              setState(() {});
            },
          ),
        ),
      ),
    );
  }

  void showMore(ProfileSetting setting) {
    final tcontext = Translations.of(context);
    final provider = BoardProviderManager.getProviderById(
      setting.boardProviderId,
    );

    var widgets = [
      if (provider != null && GroupHelper.canShowVpnProvider(provider)) ...[
        ListTile(
          title: Text(provider.name),
          onTap: () async {
            Navigator.of(context).pop();
            final session = BoardSessionPersistentManager.instance()
                .getBySubscribeUrl(setting.url);
            GroupHelper.showVpnProvider(context, provider, session);
          },
        ),
      ],
      if (provider?.hideNodeDetails != true) ...[
        ListTile(
          title: Text(
            setting.isRemote() ? tcontext.meta.view : tcontext.meta.edit,
          ),
          onTap: () async {
            Navigator.of(context).pop();
            final path = await ProfileManager.getProfilePath(setting.id);
            final content = await File(path).readAsString();
            if (!mounted) {
              return;
            }
            await Navigator.push(
              context,
              MaterialPageRoute(
                settings: FileViewScreen.routSettings(),
                builder: (context) => FileViewScreen(
                  title: setting.getShowName(),
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
      ],
      if (setting.isRemote()) ...[
        ListTile(
          title: Text(tcontext.meta.update),
          onTap: () async {
            Navigator.of(context).pop();
            ReturnResultError? err = await ProfileManager.update(setting.id);
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
        if (provider?.hideNodeDetails != true) ...[
          ListTile(
            title: Text(tcontext.meta.copyUrl),
            onTap: () async {
              Navigator.of(context).pop();
              try {
                Clipboard.setData(ClipboardData(text: setting.url));
              } catch (e) {}
            },
          ),
          ListTile(
            title: Text(tcontext.meta.qrcode),
            onTap: () async {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  settings: QrcodeScreen.routSettings(),
                  builder: (context) => QrcodeScreen(content: setting.url),
                ),
              );
            },
          ),
        ],
      ],

      ListTile(
        title: Text(tcontext.meta.profileEdit),
        onTap: () async {
          Navigator.of(context).pop();
          await Navigator.push(
            context,
            MaterialPageRoute(
              settings: ProfilesSettingsEditScreen.routSettings(),
              builder: (context) =>
                  ProfilesSettingsEditScreen(profile: setting),
            ),
          );
          setState(() {});
        },
      ),
      ListTile(
        title: Text(tcontext.meta.remove),
        onTap: () async {
          Navigator.of(context).pop();
          bool? del = await DialogUtils.showConfirmDialog(
            context,
            tcontext.meta.removeConfirm,
          );
          if (del == true) {
            ProfileManager.remove(setting.id);
          }
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
