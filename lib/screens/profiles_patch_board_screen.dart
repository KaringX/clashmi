import 'dart:async';

import 'package:after_layout/after_layout.dart';
import 'package:clashmi/app/modules/profile_patch_manager.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/add_profile_by_scan_qrcode_screen.dart';
import 'package:clashmi/screens/add_profile_patch_by_import_from_file_screen.dart';
import 'package:clashmi/screens/add_profile_patch_by_url_screen.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/profiles_patch_board_screen_widgets.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:clashmi/screens/widgets/sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProfilesPatchBoardScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return const RouteSettings(name: "/");
  }

  const ProfilesPatchBoardScreen({super.key});

  @override
  State<ProfilesPatchBoardScreen> createState() =>
      _ProfilesPatchBoardScreenState();
}

class _ProfilesPatchBoardScreenState
    extends LasyRenderingState<ProfilesPatchBoardScreen>
    with WidgetsBindingObserver, AfterLayoutMixin {
  @override
  void initState() {
    super.initState();
    ProfilePatchManager.onEventAdd.add(_onAdd);
    ProfilePatchManager.onEventRemove.add(_onRemove);
    ProfilePatchManager.onEventUpdate.add(_onUpdate);
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {}

  @override
  void dispose() {
    ProfilePatchManager.onEventAdd.remove(_onAdd);
    ProfilePatchManager.onEventRemove.remove(_onRemove);
    ProfilePatchManager.onEventUpdate.remove(_onUpdate);
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
                    width: windowSize.width - 50 * 3,
                    child: Text(
                      tcontext.meta.overwrite,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: ThemeConfig.kFontWeightTitle,
                        fontSize: ThemeConfig.kFontSizeTitle,
                      ),
                    ),
                  ),
                  ProfilePatchManager.updating.isNotEmpty
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
                            onTapUpdateAll();
                          },
                          child: Tooltip(
                            message: tcontext.meta.update,
                            child: const SizedBox(
                              width: 50,
                              height: 30,
                              child: Icon(
                                Icons.cloud_download_outlined,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                  InkWell(
                    onTap: () async {
                      onTapAdd();
                    },
                    child: Tooltip(
                      message: tcontext.meta.add,
                      child: const SizedBox(
                        width: 50,
                        height: 30,
                        child: Icon(Icons.add, size: 30),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: FutureBuilder(
                    future: getProfiles(),
                    builder:
                        (
                          BuildContext context,
                          AsyncSnapshot<List<ProfilePatchSetting>> snapshot,
                        ) {
                          List<ProfilePatchSetting> data = snapshot.hasData
                              ? snapshot.data!
                              : [];
                          return ProfilesPatchBoardScreenWidget(settings: data);
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

  Future<List<ProfilePatchSetting>> getProfiles() async {
    return ProfilePatchManager.getProfiles();
  }

  void onTapUpdateAll() async {
    await ProfilePatchManager.updateAll();
  }

  void onTapAdd() async {
    final tcontext = Translations.of(context);
    var widgets = [
      ListTile(
        title: Text(tcontext.meta.profileAddUrlOrContent),
        onTap: () async {
          Navigator.of(context).pop();
          await Navigator.push(
            context,
            MaterialPageRoute(
              settings: AddProfilePatchByUrlScreen.routeSettings(),
              builder: (context) => AddProfilePatchByUrlScreen(),
            ),
          );
        },
      ),
      ListTile(
        title: Text(tcontext.meta.importFromClipboard),
        onTap: () async {
          Navigator.of(context).pop();
          ClipboardData? data;
          try {
            data = await Clipboard.getData("text/plain");
          } catch (err) {
            if (!mounted) {
              return;
            }
            DialogUtils.showAlertDialog(
              context,
              err.toString(),
              showCopy: true,
              showFAQ: true,
              withVersion: true,
            );
            return;
          }
          if (!mounted) {
            return;
          }
          if (data == null || data.text == null || data.text!.isEmpty) {
            return;
          }
          await Navigator.push(
            context,
            MaterialPageRoute(
              settings: AddProfilePatchByUrlScreen.routeSettings(),
              builder: (context) =>
                  AddProfilePatchByUrlScreen(url: data!.text!),
            ),
          );
        },
      ),
      ListTile(
        title: Text(tcontext.meta.qrcodeScan),
        onTap: () async {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              settings: AddProfileByScanQrcodeScanScreen.routeSettings(),
              builder: (context) => const AddProfileByScanQrcodeScanScreen(),
            ),
          ).then((value) {
            if ((value != null) && (value.qrcode != null)) {
              if (!mounted) {
                return;
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  settings: AddProfilePatchByUrlScreen.routeSettings(),
                  builder: (context) =>
                      AddProfilePatchByUrlScreen(url: value.qrcode!),
                ),
              );
            }
          });
        },
      ),
      ListTile(
        title: Text(tcontext.meta.profileImport),
        onTap: () async {
          Navigator.of(context).pop();
          Navigator.push(
            context,
            MaterialPageRoute(
              settings: AddProfilePatchByImportFromFileScreen.routeSettings(),
              builder: (context) =>
                  const AddProfilePatchByImportFromFileScreen(),
            ),
          );
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

  Future<void> _onAdd(String id) async {
    setState(() {});
  }

  Future<void> _onRemove(String id) async {
    setState(() {});
  }

  Future<void> _onUpdate(String id, bool finish) async {
    setState(() {});
  }
}
