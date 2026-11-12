import 'dart:io';

import 'package:clashmi/app/clash/clash_config.dart';
import 'package:clashmi/app/modules/clash_setting_manager.dart';
import 'package:clashmi/app/utils/app_utils.dart';
import 'package:clashmi/app/utils/log.dart';
import 'package:clashmi/app/utils/platform_utils.dart';
import 'package:clashmi/app/utils/vpn_action_handler.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:tray_manager/tray_manager.dart';

class TrayMenuMode {
  static List<MenuItem> getModeItem() {
    var menuItemRule = MenuItem.createWithLabelAndType(
      t.meta.rule,
      MenuItemType.checkbox,
    )!;
    var menuItemGlobal = MenuItem.createWithLabelAndType(
      t.meta.global,
      MenuItemType.checkbox,
    )!;
    var menuItemDirect = MenuItem.createWithLabelAndType(
      t.meta.direct,
      MenuItemType.checkbox,
    )!;

    menuItemRule.addListener((event) async {
      if (event is MenuItemClickedEvent) {
        menuItemRule.state = MenuItemState.checked;
        menuItemGlobal.state = MenuItemState.unchecked;
        menuItemDirect.state = MenuItemState.unchecked;
        await ClashSettingManager.setConfigsMode(ClashConfigsMode.rule);
      }
    });
    menuItemGlobal.addListener((event) async {
      if (event is MenuItemClickedEvent) {
        menuItemGlobal.state = MenuItemState.checked;
        menuItemRule.state = MenuItemState.unchecked;
        menuItemDirect.state = MenuItemState.unchecked;
        await ClashSettingManager.setConfigsMode(ClashConfigsMode.global);
      }
    });
    menuItemDirect.addListener((event) async {
      if (event is MenuItemClickedEvent) {
        menuItemDirect.state = MenuItemState.checked;
        menuItemGlobal.state = MenuItemState.unchecked;
        menuItemRule.state = MenuItemState.unchecked;
        await ClashSettingManager.setConfigsMode(ClashConfigsMode.direct);
      }
    });

    void updateMenu() {
      final mode = ClashSettingManager.getConfigsMode();
      menuItemRule.state = mode == ClashConfigsMode.rule
          ? MenuItemState.checked
          : MenuItemState.unchecked;
      menuItemGlobal.state = mode == ClashConfigsMode.global
          ? MenuItemState.checked
          : MenuItemState.unchecked;
      menuItemDirect.state = mode == ClashConfigsMode.direct
          ? MenuItemState.checked
          : MenuItemState.unchecked;
    }

    updateMenu();
    ClashSettingManager.onEventModeChanged.add(() async {
      updateMenu();
    });
    return [menuItemRule, menuItemGlobal, menuItemDirect];
  }
}

class TrayMenuConnected {
  Future<void> Function()? onDisconnect;
  Future<void> Function()? onOpen;
  Future<void> Function()? onExit;
  Menu? _menu;

  void init({
    bool openExitOnly = false,
    Future<void> Function()? onOpen,
    Future<void> Function()? onExit,
    Future<void> Function()? onDisconnect,
  }) {
    this.onOpen = onOpen;
    this.onExit = onExit;
    this.onDisconnect = onDisconnect;
    _menu = Menu.create();
    if (_menu == null) {
      Log.w("Tray Menu creation failed");
      return;
    }

    final menuItemDisconnect = MenuItem.createWithLabelAndType(
      t.meta.disconnect,
      MenuItemType.normal,
    )!;

    final menuItemOpen = MenuItem.createWithLabelAndType(
      t.main.tray.menuOpen,
      MenuItemType.normal,
    )!;
    final menuItemExit = MenuItem.createWithLabelAndType(
      t.main.tray.menuExit,
      MenuItemType.normal,
    )!;

    menuItemDisconnect.addListener((event) async {
      if (event is MenuItemClickedEvent) {
        await onDisconnect?.call();
      }
    });

    menuItemOpen.addListener((event) async {
      if (event is MenuItemClickedEvent) {
        await onOpen?.call();
      }
    });
    menuItemExit.addListener((event) async {
      if (event is MenuItemClickedEvent) {
        await onExit?.call();
      }
    });

    if (!openExitOnly) {
      _menu!.addItem(menuItemDisconnect);
      _menu!.addSeparator();
      final items = TrayMenuMode.getModeItem();
      for (var item in items) {
        _menu!.addItem(item);
      }
      _menu!.addSeparator();
    }

    _menu!.addItem(menuItemOpen);
    _menu!.addItem(menuItemExit);
  }

  void uninit() {
    _menu?.dispose();
  }

  Menu? getMenu() {
    return _menu;
  }
}

class TrayMenuDisconnected {
  Future<void> Function()? onConnect;
  Future<void> Function()? onOpen;
  Future<void> Function()? onExit;
  Menu? _menu;

  void init({
    bool openExitOnly = false,
    Future<void> Function()? onOpen,
    Future<void> Function()? onExit,
    Future<void> Function()? onConnect,
  }) {
    this.onOpen = onOpen;
    this.onExit = onExit;
    this.onConnect = onConnect;

    _menu = Menu.create();
    if (_menu == null) {
      Log.w("Tray Menu creation failed");
      return;
    }

    final menuItemConnect = MenuItem.createWithLabelAndType(
      t.meta.connect,
      MenuItemType.normal,
    )!;

    final menuItemOpen = MenuItem.createWithLabelAndType(
      t.main.tray.menuOpen,
      MenuItemType.normal,
    )!;
    final menuItemExit = MenuItem.createWithLabelAndType(
      t.main.tray.menuExit,
      MenuItemType.normal,
    )!;

    menuItemConnect.addListener((event) async {
      if (event is MenuItemClickedEvent) {
        await onConnect?.call();
      }
    });

    menuItemOpen.addListener((event) async {
      if (event is MenuItemClickedEvent) {
        await onOpen?.call();
      }
    });
    menuItemExit.addListener((event) async {
      if (event is MenuItemClickedEvent) {
        await onExit?.call();
      }
    });

    if (!openExitOnly) {
      _menu!.addItem(menuItemConnect);
      _menu!.addSeparator();
      final items = TrayMenuMode.getModeItem();
      for (var item in items) {
        _menu!.addItem(item);
      }
      _menu!.addSeparator();
    }

    _menu!.addItem(menuItemOpen);
    _menu!.addItem(menuItemExit);
  }

  void uninit() {
    _menu?.dispose();
  }

  Menu? getMenu() {
    return _menu;
  }
}

class Tray {
  TrayIcon? _trayIcon;
  TrayMenuConnected trayConnected = TrayMenuConnected();
  TrayMenuDisconnected trayDisconnected = TrayMenuDisconnected();
  bool _isConnected = false;

  void init({
    bool openExitOnly = false,
    Future<void> Function()? onOpen,
    Future<void> Function()? onExit,
  }) {
    if (!PlatformUtils.isPC()) {
      return;
    }

    try {
      _trayIcon = TrayIcon.create();
      if (_trayIcon == null) {
        Log.w(" Tray Icon creation failed");
        return;
      }
      _trayIcon!.addListener((event) {
        if (event is TrayIconClickedEvent) {
          onOpen?.call();
        } else if (event is TrayIconRightClickedEvent) {
          _trayIcon!.closeContextMenu();
          _updateContextMenu();
          _trayIcon!.openContextMenu();
        }
      });
      _trayIcon!.icon = ImageAsset.fromAsset(_getIconDisconnected());
      _trayIcon!.setVisible(true);

      if (!Platform.isLinux) {
        _trayIcon!.setTooltip(AppUtils.getName());
      }
      if (Platform.isLinux) {
        _updateContextMenu();
        _trayIcon!.setContextMenuTrigger(ContextMenuTrigger.clicked);
        _trayIcon!.setContextMenuTrigger(ContextMenuTrigger.rightClicked);
      }
    } catch (e) {
      Log.e("Tray Icon initialization exception: $e");
    }

    trayConnected.init(
      openExitOnly: openExitOnly,
      onOpen: onOpen,
      onExit: onExit,
      onDisconnect: () async {
        VpnActionHandler.vpnDisconnect?.call("menu", false);
      },
    );

    trayDisconnected.init(
      openExitOnly: openExitOnly,
      onOpen: onOpen,
      onExit: onExit,
      onConnect: () async {
        VpnActionHandler.vpnConnect?.call("menu", false);
      },
    );
  }

  void dispose() {
    trayConnected.uninit();
    trayDisconnected.uninit();
  }

  void _updateContextMenu() {
    _trayIcon?.setContextMenu(
      _isConnected ? trayConnected.getMenu() : trayDisconnected.getMenu(),
    );
  }

  String _getIconConnected() {
    if (Platform.isWindows) {
      return 'assets/images/tray.ico';
    }
    return 'assets/images/tray.png';
  }

  String _getIconDisconnected() {
    if (Platform.isWindows) {
      return 'assets/images/grey_tray.ico';
    }
    return 'assets/images/grey_tray.png';
  }

  void setConnected(bool connected) {
    if (_trayIcon == null) {
      return;
    }
    if (connected == _isConnected) {
      return;
    }
    _isConnected = connected;
    _trayIcon!.icon = ImageAsset.fromAsset(
      _isConnected ? _getIconConnected() : _getIconDisconnected(),
    );
  }

  void setTitle(String title) {
    if (_trayIcon == null) {
      return;
    }
    _trayIcon!.setTitle(title);
  }
}
