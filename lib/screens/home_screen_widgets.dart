import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clashmi/app/clash/clash_config.dart';
import 'package:clashmi/app/clash/clash_http_api.dart';
import 'package:clashmi/app/local_services/vpn_service.dart';
import 'package:clashmi/app/modules/auto_update_manager.dart';
import 'package:clashmi/app/modules/biz.dart';
import 'package:clashmi/app/modules/clash_setting_manager.dart';
import 'package:clashmi/app/modules/profile_manager.dart';
import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/app/modules/zashboard.dart';
import 'package:clashmi/app/runtime/return_result.dart';
import 'package:clashmi/app/utils/app_lifecycle_state_notify.dart';
import 'package:clashmi/app/utils/app_scheme_actions.dart';
import 'package:clashmi/app/utils/file_utils.dart';
import 'package:clashmi/app/utils/log.dart';
import 'package:clashmi/app/utils/move_to_background_utils.dart';
import 'package:clashmi/app/utils/network_utils.dart';
import 'package:clashmi/app/utils/path_utils.dart';
import 'package:clashmi/app/utils/platform_utils.dart';
import 'package:clashmi/app/utils/vpn_action_handler.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/about_screen.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/file_view_screen.dart';
import 'package:clashmi/screens/group_helper.dart';
import 'package:clashmi/screens/net_check_screen.dart';
import 'package:clashmi/screens/profiles_board_screen.dart';
import 'package:clashmi/screens/proxy_board_screen.dart';
import 'package:clashmi/screens/richtext_viewer.screen.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/webview_helper.dart';
import 'package:clashmi/screens/widgets/segmented_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:libclash_vpn_service/state.dart';
import 'package:libclash_vpn_service/vpn_service.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:tuple/tuple.dart';

class ProxyHttpOverrides extends HttpOverrides {
  ProxyHttpOverrides(this.proxyPort);

  final int proxyPort;

  @override
  HttpClient createHttpClient(SecurityContext? context) {
    final client = super.createHttpClient(context);
    client.findProxy = (Uri uri) => "PROXY 127.0.0.1:$proxyPort";
    return client;
  }
}

class HomeScreenWidgetPart1 extends StatefulWidget {
  const HomeScreenWidgetPart1({super.key});

  @override
  State<HomeScreenWidgetPart1> createState() => _HomeScreenWidgetPart1();
}

class _HomeScreenWidgetPart1 extends State<HomeScreenWidgetPart1> {
  static final String _kNoSpeed = "↑ 0 B/s   ↓ 0 B/s";
  static final String _kNoTrafficTotal = "↑ 0 B   ↓ 0 B";
  //static final String _kNoMemory = "0 B   0 B";
  final FocusNode _focusNodeConnect = FocusNode();
  FlutterVpnServiceState _state = FlutterVpnServiceState.disconnected;
  Timer? _timerStateChecker;
  Timer? _timerConnectToCore;
  QuickActions? _quickActions;
  bool _quickActionWorking = false;

  //final ValueNotifier<String> _memory = ValueNotifier<String>(_kNoMemory);
  final ValueNotifier<String> _trafficSpeed = ValueNotifier<String>(_kNoSpeed);
  final ValueNotifier<String> _trafficTotal = ValueNotifier<String>(
    _kNoTrafficTotal,
  );
  final ValueNotifier<String> _proxyNow = ValueNotifier<String>("");
  bool _proxyNowUpdating = false;

  @override
  void initState() {
    super.initState();
    VPNService.onEventStateChanged.add(_onStateChanged);
    AppLifecycleStateNofity.onStateResumed(hashCode, _onStateResumed);
    AppLifecycleStateNofity.onStatePaused(hashCode, _onStatePaused);
    ProfileManager.onEventCurrentChanged.add(_onCurrentChanged);
    ProfileManager.onEventUpdate.add(_onUpdate);
    if (!AppLifecycleStateNofity.isPaused()) {
      _onStateResumed();
    }
    Biz.onEventInitAllFinish.add(() async {
      if (Platform.isAndroid) {
        if (SettingManager.getConfig().excludeFromRecent) {
          FlutterVpnService.setExcludeFromRecents(true);
        }
      }
      await _onInitAllFinish();
    });
    ClashSettingManager.onEventModeChanged.add(() async {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNodeConnect.dispose();
    super.dispose();
  }

  void initQuickAction() async {
    if (!Platform.isIOS && !Platform.isAndroid) {
      return;
    }
    String connect = AppSchemeActions.connectAction();
    String disconnect = AppSchemeActions.disconnectAction();
    try {
      _quickActions ??= QuickActions();
      await _quickActions!.initialize((String shortcutType) async {
        if (_quickActionWorking) {
          return;
        }
        _quickActionWorking = true;
        var state = await VPNService.getState();
        if (shortcutType == connect) {
          if (state != FlutterVpnServiceState.invalid &&
              state != FlutterVpnServiceState.disconnected) {
            MoveToBackgroundUtils.moveToBackground(
              duration: const Duration(milliseconds: 300),
            );
            _quickActionWorking = false;
            return;
          }

          bool ok = await start("quickAction");
          if (ok) {
            MoveToBackgroundUtils.moveToBackground(
              duration: const Duration(milliseconds: 300),
            );
          }
        } else if (shortcutType == disconnect) {
          if (state == FlutterVpnServiceState.connected) {
            await stop();
          }
          MoveToBackgroundUtils.moveToBackground(
            duration: const Duration(milliseconds: 300),
          );
        }
        _quickActionWorking = false;
      });

      await _quickActions!.setShortcutItems(<ShortcutItem>[
        ShortcutItem(type: connect, localizedTitle: 'ON', icon: 'ic_launcher'),
        ShortcutItem(
          type: disconnect,
          localizedTitle: 'OFF',
          icon: 'ic_launcher',
        ),
      ]);
    } catch (err, stacktrace) {
      Log.w("initQuickAction exception ${err.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    final tcontext = Translations.of(context);
    bool connected = _state == FlutterVpnServiceState.connected;
    final currentProfile = ProfileManager.getCurrent();
    final currentProfileName = currentProfile?.getShowName() ?? "";
    final settings = SettingManager.getConfig();
    String tranffic = "";
    Tuple2<bool, String>? tranfficExpire;
    if (currentProfile != null && currentProfile.isRemote()) {
      if (currentProfile.upload != 0 ||
          currentProfile.download != 0 ||
          currentProfile.total != 0) {
        String upload = ClashHttpApi.convertTrafficToStringDouble(
          currentProfile.upload,
        );
        String download = ClashHttpApi.convertTrafficToStringDouble(
          currentProfile.download,
        );
        String total = ClashHttpApi.convertTrafficToStringDouble(
          currentProfile.total,
        );
        tranffic = "↑ $upload ↓ $download/$total";
      }
      if (currentProfile.expire.isNotEmpty) {
        tranfficExpire = currentProfile.getExpireTime(settings.languageTag);
      }
    }
    var widgets = [
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: connected ? Colors.green : Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 10),
                  Text(
                    connected
                        ? tcontext.meta.connected
                        : tcontext.meta.disconnected,
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
              Stack(
                children: [
                  SizedBox(
                    width: 60,
                    child: FittedBox(
                      fit: BoxFit.fill,
                      child: Switch.adaptive(
                        value: _state == FlutterVpnServiceState.connected,
                        focusNode: _focusNodeConnect,
                        onChanged: (bool value) async {
                          if (value) {
                            await start("switch");
                          } else {
                            await stop();
                          }
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    left: 8,
                    top: 12,
                    child: SizedBox(
                      width: 25,
                      height: 25,
                      child:
                          _state == FlutterVpnServiceState.connecting ||
                              _state == FlutterVpnServiceState.disconnecting ||
                              _state == FlutterVpnServiceState.reasserting
                          ? const RepaintBoundary(
                              child: CircularProgressIndicator(
                                color: ThemeDefine.kColorGreenBright,
                              ),
                            )
                          : null,
                    ),
                  ),
                ],
              ),
            ],
          ),
          /*connected
              ? Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  ValueListenableBuilder<String>(
                    builder: _buildWithTrafficSpeedValue,
                    valueListenable: _memory,
                  ),
                ])
              : const SizedBox.shrink(),*/
          connected
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ValueListenableBuilder<String>(
                      builder: _buildWithTrafficSpeedValue,
                      valueListenable: _trafficTotal,
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          connected
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ValueListenableBuilder<String>(
                      builder: _buildWithTrafficSpeedValue,
                      valueListenable: _trafficSpeed,
                    ),
                  ],
                )
              : const SizedBox.shrink(),
          SizedBox(height: connected ? 10 : 0),
        ],
      ),
      Container(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        height: 70,
        child: SegmentedElevatedButton(
          segments: [
            SegemntedElevatedButtonItem(
              value: ClashConfigsMode.rule.index,
              text: tcontext.meta.rule,
            ),
            SegemntedElevatedButtonItem(
              value: ClashConfigsMode.global.index,
              text: tcontext.meta.global,
            ),
            SegemntedElevatedButtonItem(
              value: ClashConfigsMode.direct.index,
              text: tcontext.meta.direct,
            ),
          ],
          selected: ClashSettingManager.getConfigsMode().index,
          padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
          onPressed: (int value) async {
            ClashConfigsMode type = ClashConfigsMode.values[value];
            var error = await ClashSettingManager.setConfigsMode(type);
            if (!context.mounted) {
              return;
            }
            if (error != null) {
              DialogUtils.showAlertDialog(
                context,
                error.message,
                withVersion: true,
              );
              return;
            }
            _updateProxyNow();
          },
        ),
      ),
      ListTile(
        title: Text(tcontext.meta.myProfiles),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            currentProfile != null
                ? Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      currentProfileName,
                      style: TextStyle(color: ThemeDefine.kColorBlue),
                    ),
                  )
                : SizedBox.shrink(),
            tranffic.isNotEmpty
                ? Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      tranffic,
                      style: TextStyle(color: ThemeDefine.kColorBlue),
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
                            : ThemeDefine.kColorBlue,
                        fontSize: 12,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
        trailing: SizedBox(
          width: 70,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 45,
                height: 45,
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        settings: ProfilesBoardScreen.routSettings(),
                        builder: (context) =>
                            ProfilesBoardScreen(navigateToAdd: true),
                      ),
                    );
                    setState(() {});
                  },
                  child: Icon(Icons.add, size: 30),
                ),
              ),
              SizedBox(width: 5),
              Icon(Icons.keyboard_arrow_right, size: 20),
            ],
          ),
        ),
        minVerticalPadding: 20,
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              settings: ProfilesBoardScreen.routSettings(),
              builder: (context) => ProfilesBoardScreen(),
            ),
          );
          setState(() {});
        },
      ),
    ];

    if (connected) {
      widgets.add(
        ListTile(
          title: Text(tcontext.meta.proxy),
          subtitle: ValueListenableBuilder<String>(
            builder: _buildWithValue,
            valueListenable: _proxyNow,
          ),
          trailing: Icon(Icons.keyboard_arrow_right, size: 20),
          minVerticalPadding: 20,
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                settings: ProxyBoardScreen.routSettings(),
                builder: (context) => ProxyBoardScreen(),
              ),
            );
            _updateProxyNow();
          },
        ),
      );
      widgets.add(
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: InkWell(
                  onTap: () {
                    _onTapBoard();
                  },
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Icon(Icons.dashboard_outlined),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 40,
                        child: Text(
                          tcontext.meta.board,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _onTapRunTimeProfile();
                  },
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Icon(Icons.file_present),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 40,
                        child: Text(
                          tcontext.meta.runtimeProfile,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 5),
              Expanded(
                child: InkWell(
                  onTap: () {
                    _onTapNetCheck();
                  },
                  child: Column(
                    children: [
                      const SizedBox(height: 5),
                      Icon(Icons.network_check_outlined),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 40,
                        child: Text(
                          tcontext.meta.networkCheck,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return widgets[index];
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 1, thickness: 0.3);
          },
          itemCount: widgets.length,
        ),
      ),
    );
  }

  Widget _buildWithTrafficSpeedValue(
    BuildContext context,
    String value,
    Widget? child,
  ) {
    return SizedBox(
      child: Text(
        value,
        textAlign: TextAlign.left,
        style: const TextStyle(fontSize: ThemeConfig.kFontSizeListSubItem),
      ),
    );
  }

  Widget _buildWithValue(BuildContext context, String value, Widget? child) {
    return SizedBox(
      child: Text(
        value,
        textAlign: TextAlign.start,
        style: TextStyle(color: ThemeDefine.kColorBlue),
      ),
    );
  }

  Future<String> _getLocalAddress() async {
    String ipLocal = "127.0.0.1";
    String ipInterface = ipLocal;

    List<NetInterfacesInfo> interfaces = await NetworkUtils.getInterfaces(
      addressType: InternetAddressType.IPv4,
    );
    if (interfaces.isNotEmpty) {
      ipInterface = interfaces.first.address;
    }
    for (var interf in interfaces) {
      if (interf.name.startsWith("en") || interf.name.startsWith("wlan")) {
        ipInterface = interf.address;
        break;
      }
    }

    return ipInterface;
  }

  Future<void> _onInitAllFinish() async {
    VpnActionHandler.vpnConnect = _vpnConnect;
    VpnActionHandler.vpnDisconnect = _vpnDisconnect;
    VpnActionHandler.vpnReconnect = _vpnReconnect;
    initQuickAction();
    if (PlatformUtils.isPC()) {
      if (SettingManager.getConfig().autoConnectAfterLaunch) {
        await start("launch");
      }
    }
  }

  Future<void> stop() async {
    await VPNService.stop();
  }

  Future<bool> start(String from) async {
    final currentProfile = ProfileManager.getCurrent();
    if (currentProfile == null) {
      await Navigator.push(
        context,
        MaterialPageRoute(
          settings: ProfilesBoardScreen.routSettings(),
          builder: (context) => ProfilesBoardScreen(),
        ),
      );
      setState(() {});
      return false;
    }
    if (Platform.isLinux) {
      String? installer = await AutoUpdateManager.checkReplace();
      if (installer != null) {
        return true;
      }
      final servicePath = PathUtils.serviceExePath();
      if (!await FlutterVpnService.isServiceAuthorized(servicePath)) {
        if (!mounted) {
          return false;
        }
        String? password = await DialogUtils.showPasswordInputDialog(context);
        if (password == null || password.isEmpty) {
          setState(() {});
          return true;
        }
        final result = await FlutterVpnService.authorizeService(
          servicePath,
          password,
        );
        if (result != null) {
          if (!mounted) {
            return false;
          }
          DialogUtils.showAlertDialog(
            context,
            result.message,
            withVersion: true,
          );
          setState(() {});
          return false;
        }
      }
    }
    var state = await VPNService.getState();
    if (state == FlutterVpnServiceState.connecting ||
        state == FlutterVpnServiceState.disconnecting ||
        state == FlutterVpnServiceState.reasserting) {
      setState(() {});
      return false;
    }

    var err = await VPNService.start(const Duration(seconds: 60));
    if (!mounted) {
      return false;
    }
    setState(() {});
    if (err != null) {
      if (err.message == "willCompleteAfterRebootInstall") {
        err.message = t.meta.willCompleteAfterRebootInstall;
      } else if (err.message == "requestNeedsUserApproval") {
        err.message = t.meta.requestNeedsUserApproval;
      } else if (err.message.contains("FullDiskAccessPermissionRequired")) {
        err.message = t.meta.FullDiskAccessPermissionRequired;
      } else if (err.message.contains(
        "configure tun interface: Access is denied",
      )) {
        err.message += "\n${t.meta.tunModeRunAsAdmin}";
      }

      DialogUtils.showAlertDialog(context, err.message, withVersion: true);
      return false;
    }

    return true;
  }

  Future<void> _vpnConnect(String from, bool background) async {
    Future.delayed(const Duration(seconds: 0), () async {
      bool ok = await start(from);
      if (ok) {
        if (background) {
          MoveToBackgroundUtils.moveToBackground(
            duration: const Duration(milliseconds: 300),
          );
        }
      }
    });
  }

  Future<void> _vpnDisconnect(String from, bool background) async {
    Future.delayed(const Duration(seconds: 0), () async {
      await stop();
      if (background) {
        MoveToBackgroundUtils.moveToBackground(
          duration: const Duration(milliseconds: 300),
        );
      }
    });
  }

  Future<void> _vpnReconnect(String from, bool background) async {
    Future.delayed(const Duration(seconds: 0), () async {
      await stop();
      bool ok = await start(from);
      if (ok) {
        if (background) {
          MoveToBackgroundUtils.moveToBackground(
            duration: const Duration(milliseconds: 300),
          );
        }
      }
    });
  }

  Future<void> _onStateChanged(
    FlutterVpnServiceState state,
    Map<String, String> params,
  ) async {
    if (_state == state) {
      return;
    }
    _state = state;
    if (state == FlutterVpnServiceState.disconnected) {
      _disconnectToCore();
      Biz.vpnStateChanged(false);
    } else if (state == FlutterVpnServiceState.connecting) {
    } else if (state == FlutterVpnServiceState.connected) {
      if (ClashSettingManager.getConfig().MixedPort != null &&
          HttpOverrides.current == null) {}
      if (!AppLifecycleStateNofity.isPaused()) {
        _connectToCore();
      }
      Biz.vpnStateChanged(true);
    } else if (state == FlutterVpnServiceState.reasserting) {
      _disconnectToCore();
    } else if (state == FlutterVpnServiceState.disconnecting) {
      _stopStateCheckTimer();
      Zashboard.stop();
    } else {
      _disconnectToCore();
      Biz.vpnStateChanged(false);
    }
    if (!mounted) {
      return;
    }
    setState(() {});
  }

  Future<void> _onStateResumed() async {
    _checkState();
    _startStateCheckTimer();
    _connectToCore();

    _updateProxyNow();
  }

  Future<void> _onStatePaused() async {
    _stopStateCheckTimer();
    _disconnectToCore(resetUI: false);
  }

  Future<void> _onCurrentChanged(String id) async {
    if (id.isEmpty) {
      await VPNService.stop();
      return;
    }

    final err = await VPNService.restart(const Duration(seconds: 60));
    if (err != null) {
      if (!mounted) {
        return;
      }
      DialogUtils.showAlertDialog(context, err.message, withVersion: true);
    }
  }

  Future<void> _onUpdate(String id, bool finish) async {
    setState(() {});
  }

  Future<void> _checkState() async {
    var state = await VPNService.getState();
    await _onStateChanged(state, {});
  }

  void _startStateCheckTimer() {
    const Duration duration = Duration(seconds: 1);
    _timerStateChecker ??= Timer.periodic(duration, (timer) async {
      if (!Platform.isMacOS) {
        if (AppLifecycleStateNofity.isPaused()) {
          return;
        }
      }
      await _checkState();
    });
  }

  void _stopStateCheckTimer() {
    if (!Platform.isMacOS) {
      _timerStateChecker?.cancel();
      _timerStateChecker = null;
    }
  }

  Future<void> _connectToCore() async {
    bool started = await VPNService.getStarted();
    if (!started) {
      return;
    }
    if (AppLifecycleStateNofity.isPaused()) {
      return;
    }
    const Duration duration = Duration(seconds: 1);
    _timerConnectToCore ??= Timer.periodic(duration, (timer) async {
      if (AppLifecycleStateNofity.isPaused()) {
        return;
      }
      String connections = await FlutterVpnService.clashiApiConnections(false);
      String tranffic = await FlutterVpnService.clashiApiTraffic();
      if (AppLifecycleStateNofity.isPaused()) {
        return;
      }
      try {
        var obj = jsonDecode(connections);
        ClashConnections body = ClashConnections();
        body.fromJson(obj, false);
        //_memory.value =
        //    ClashHttpApi.convertTrafficToStringDouble(body.memory);
        _trafficTotal.value =
            "↑ ${ClashHttpApi.convertTrafficToStringDouble(body.uploadTotal)}  ↓ ${ClashHttpApi.convertTrafficToStringDouble(body.downloadTotal)} ";
      } catch (err) {}
      try {
        var obj = jsonDecode(tranffic);
        ClashTraffic traffic = ClashTraffic();
        traffic.fromJson(obj);
        _trafficSpeed.value =
            "↑ ${ClashHttpApi.convertTrafficToStringDouble(traffic.upload)}/s  ↓ ${ClashHttpApi.convertTrafficToStringDouble(traffic.download)}/s";
      } catch (err) {}

      if (_proxyNow.value.isEmpty) {
        Future.delayed(Duration(seconds: 1), () async {
          _updateProxyNow();
        });
      }
    });
  }

  Future<void> _disconnectToCore({bool resetUI = true}) async {
    _timerConnectToCore?.cancel();
    _timerConnectToCore = null;
    if (resetUI) {
      _trafficTotal.value = _kNoTrafficTotal;
      _trafficSpeed.value = _kNoSpeed;
      // _memory.value = _kNoMemory;
      _proxyNow.value = "";
    }
  }

  Future<void> _updateProxyNow() async {
    if (_state == FlutterVpnServiceState.connected) {
      if (AppLifecycleStateNofity.isPaused()) {
        return;
      }
      if (_proxyNowUpdating) {
        return;
      }
      _proxyNowUpdating = true;

      final result = await ClashHttpApi.getNowProxy(
        ClashSettingManager.getConfig().Mode ?? ClashConfigsMode.rule.name,
      );
      if (result.error != null || result.data!.isEmpty) {
        _proxyNow.value = "";
      } else {
        if (result.data!.length >= 2) {
          if (result.data!.first.delay != null) {
            _proxyNow.value =
                "${result.data![1].name} -> ${result.data!.first.name} (${result.data!.first.delay} ms)";
          } else {
            _proxyNow.value =
                "${result.data![1].name} -> ${result.data!.first.name}";
          }
        } else {
          if (result.data!.first.delay != null) {
            _proxyNow.value =
                "${result.data!.first.name} (${result.data!.first.delay} ms)";
          } else {
            _proxyNow.value = result.data!.first.name;
          }
        }
      }
      _proxyNowUpdating = false;
    } else {
      _proxyNow.value = "";
    }
  }

  Future<void> _onTapBoard() async {
    final tcontext = Translations.of(context);
    var setting = SettingManager.getConfig();
    if (setting.boardOnline && setting.boardUrl.isNotEmpty) {
      final uri = Uri.tryParse(setting.boardUrl);
      if (uri == null) {
        final msg = "${tcontext.meta.urlInvalid}:${setting.boardUrl}";
        DialogUtils.showAlertDialog(context, msg, withVersion: true);
        return;
      }
      final shortUrl = Uri(
        scheme: uri.scheme,
        userInfo: uri.userInfo,
        host: uri.host,
        port: uri.port,
      );
      String host = Platform.isIOS ? await _getLocalAddress() : "127.0.0.1";
      String secret = await ClashHttpApi.getSecret();
      final url =
          '${shortUrl.toString()}/?hostname=$host&port=${ClashSettingManager.getControlPort()}&secret=$secret&http=true';

      if (!mounted) {
        return;
      }
      await WebviewHelper.loadUrl(
        context,
        url,
        "onlineboard",
        title: tcontext.meta.board,
        inappWebViewOpenExternal: false,
      );
      return;
    }
    ReturnResult result = await Zashboard.start();
    if (result.error != null) {
      if (!mounted) {
        return;
      }
      DialogUtils.showAlertDialog(
        context,
        result.error!.message,
        withVersion: true,
      );
      return;
    }
    String url = result.data!;
    if (!mounted) {
      return;
    }
    await WebviewHelper.loadUrl(
      context,
      url,
      "board",
      title: tcontext.meta.board,
      inappWebViewOpenExternal: false,
    );
    if (PlatformUtils.isMobile()) {
      await Zashboard.stop();
    }
    _updateProxyNow();
  }

  Future<void> _onTapRunTimeProfile() async {
    final tcontext = Translations.of(context);
    late String content;
    try {
      final path = await PathUtils.serviceCoreRuntimeProfileFilePath();
      content = await File(path).readAsString();
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
    await Navigator.push(
      context,
      MaterialPageRoute(
        settings: FileViewScreen.routSettings(),
        builder: (context) => FileViewScreen(
          title: tcontext.meta.runtimeProfile,
          content: content,
        ),
      ),
    );
  }

  Future<void> _onTapNetCheck() async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        settings: NetCheckScreen.routSettings(),
        builder: (context) => const NetCheckScreen(),
      ),
    );
  }
}

class HomeScreenWidgetPart2 extends StatelessWidget {
  const HomeScreenWidgetPart2({super.key});

  @override
  Widget build(BuildContext context) {
    AutoUpdateCheckVersion versionCheck = AutoUpdateManager.getVersionCheck();
    final tcontext = Translations.of(context);
    var widgets = [
      ListTile(
        title: Text(tcontext.meta.settingApp),
        leading: Icon(Icons.settings, size: 20),
        trailing: Icon(Icons.keyboard_arrow_right, size: 20),
        minVerticalPadding: 22,
        onTap: () async {
          await GroupHelper.showAppSettings(context);
        },
      ),
      ListTile(
        title: Text(tcontext.meta.settingCore),
        leading: Icon(Icons.settings, size: 20),
        trailing: Icon(Icons.keyboard_arrow_right, size: 20),
        minVerticalPadding: 22,
        onTap: () async {
          await GroupHelper.showClashSettings(context);
        },
      ),
      ListTile(
        title: Text(tcontext.meta.coreLog),
        leading: Icon(Icons.set_meal, size: 20),
        trailing: Icon(Icons.keyboard_arrow_right, size: 20),
        minVerticalPadding: 22,
        onTap: () async {
          String content = "";
          final filePath = await PathUtils.serviceLogFilePath();
          final item = await FileUtils.readAsStringReverse(
            filePath,
            20 * 1024,
            false,
          );
          if (item != null) {
            content = item.item1;
          }
          if (!context.mounted) {
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(
              settings: RichtextViewScreen.routSettings(),
              builder: (context) => RichtextViewScreen(
                title: tcontext.meta.coreLog,
                file: "",
                content: content,
                showAction: true,
              ),
            ),
          );
        },
      ),
      ListTile(
        title: Text(tcontext.meta.backupAndSync),
        leading: Icon(Icons.cloud_sync_outlined, size: 20),
        trailing: Icon(Icons.keyboard_arrow_right, size: 20),
        minVerticalPadding: 22,
        onTap: () async {
          GroupHelper.showBackupAndSync(context);
        },
      ),
    ];
    if (versionCheck.newVersion) {
      widgets.add(
        ListTile(
          title: Text(tcontext.meta.hasNewVersion(p: versionCheck.version)),
          leading: Icon(Icons.fiber_new_outlined, size: 20, color: Colors.red),
          trailing: Icon(Icons.keyboard_arrow_right, size: 20),
          minVerticalPadding: 22,
          onTap: () async {
            GroupHelper.newVersionUpdate(context);
          },
        ),
      );
    }

    widgets.addAll([
      ListTile(
        title: Text(tcontext.meta.help),
        leading: Icon(Icons.help, size: 20),
        trailing: Icon(Icons.keyboard_arrow_right, size: 20),
        minVerticalPadding: 22,
        onTap: () async {
          await GroupHelper.showHelp(context);
        },
      ),
      ListTile(
        title: Text(tcontext.meta.about),
        leading: Icon(Icons.info, size: 20),
        trailing: Icon(Icons.keyboard_arrow_right, size: 20),
        minVerticalPadding: 22,
        onTap: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(
              settings: AboutScreen.routSettings(),
              builder: (context) => AboutScreen(),
            ),
          );
        },
      ),
    ]);

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (_, index) {
            return widgets[index];
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider(height: 1, thickness: 0.3);
          },
          itemCount: widgets.length,
        ),
      ),
    );
  }
}
