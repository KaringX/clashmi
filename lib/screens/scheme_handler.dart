import 'package:clashmi/app/runtime/return_result.dart';
import 'package:clashmi/app/utils/app_scheme_actions.dart';
import 'package:clashmi/app/utils/platform_utils.dart';
import 'package:clashmi/app/utils/system_scheme_utils.dart';
import 'package:clashmi/app/utils/url_launcher_utils.dart';
import 'package:clashmi/screens/add_profile_by_url_screen.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/app/utils/vpn_action_handler.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class SchemeHandler {
  static Future<ReturnResultError?> handle(
    BuildContext context,
    String url,
  ) async {
    //clash://install-config?url=https://xxxxx.com/clash/config
    //clash://connect?background=true
    //clash://disconnect
    //clash://reconnect
    Uri? uri = Uri.tryParse(url);
    if (uri == null) {
      return ReturnResultError("parse url failed: $url");
    }
    if (uri.isScheme(SystemSchemeUtils.getClashScheme()) ||
        uri.isScheme(SystemSchemeUtils.getClashMiScheme())) {
      if (uri.host == AppSchemeActions.installConfigAction()) {
        return await _installConfig(context, uri);
      } else if (uri.host == AppSchemeActions.connectAction()) {
        if (VpnActionHandler.vpnConnect != null) {
          bool background = false;
          try {
            background = uri.queryParameters["background"] == "true";
          } catch (err) {}
          VpnActionHandler.vpnConnect!.call("scheme", background);
        }
        return null;
      } else if (uri.host == AppSchemeActions.disconnectAction()) {
        if (VpnActionHandler.vpnDisconnect != null) {
          bool background = false;
          try {
            background = uri.queryParameters["background"] == "true";
          } catch (err) {}
          VpnActionHandler.vpnDisconnect!.call("scheme", background);
        }
        return null;
      } else if (uri.host == AppSchemeActions.reconnectAction()) {
        if (VpnActionHandler.vpnReconnect != null) {
          bool background = false;
          try {
            background = uri.queryParameters["background"] == "true";
          } catch (err) {}
          VpnActionHandler.vpnReconnect!.call("scheme", background);
        }
        return null;
      }
    }

    return ReturnResultError("unsupport scheme: ${uri.scheme}");
  }

  static Future<ReturnResultError?> _installConfig(
    BuildContext context,
    Uri uri,
  ) async {
    if (PlatformUtils.isPC()) {
      await windowManager.show();
    }
    String? name;
    String? url;
    bool? overwrite;
    bool? xhwid;

    if (!context.mounted) {
      return null;
    }
    try {
      name = uri.queryParameters["name"];
      url = uri.queryParameters["url"];
      String? ow = uri.queryParameters["overwrite"];
      if (ow != null) {
        if (ow == "true" || ow == "1" || ow == "yes") {
          overwrite = true;
        } else if (ow == "false" || ow == "0" || ow == "no") {
          overwrite = false;
        }
      }
      String? xh = uri.queryParameters["xhwid"] ?? uri.queryParameters["hwid"];
      if (xh != null) {
        if (xh == "true" || xh == "1" || xh == "yes") {
          xhwid = true;
        } else if (xh == "false" || xh == "0" || xh == "no") {
          xhwid = false;
        }
      }
    } catch (err) {
      DialogUtils.showAlertDialog(
        context,
        err.toString(),
        showCopy: true,
        showFAQ: true,
        withVersion: true,
      );
      return ReturnResultError(err.toString());
    }
    name ??= uri.fragment;
    if (name.isNotEmpty) {
      try {
        name = Uri.decodeComponent(name);
      } catch (err) {}
    }
    if (url != null) {
      try {
        url = Uri.decodeComponent(url);
      } catch (err) {}
    }

    if (url == null || url.isEmpty) {
      return ReturnResultError("url empty");
    }

    if (!context.mounted) {
      return null;
    }
    ReturnResultError? result = await addConfigBySubscriptionLink(
      context,
      url,
      name ?? "",
      overwrite,
      xhwid,
    );

    return result;
  }

  static Future<ReturnResultError?> addConfigBySubscriptionLink(
    BuildContext context,
    String url,
    String name,
    bool? overwrite,
    bool? xhwid,
  ) async {
    int kMaxPush = 1;
    if (AddProfileByUrlScreen.pushed >= kMaxPush) {
      return ReturnResultError("addprofile request already exists");
    }
    UrlLauncherUtils.closeWebview();
    if (!context.mounted) {
      return null;
    }

    bool? ok = await Navigator.push(
      context,
      MaterialPageRoute(
        settings: AddProfileByUrlScreen.routeSettings(),
        builder: (context) => AddProfileByUrlScreen(
          url: url,
          remark: name,
          overwrite: overwrite,
          xhwid: xhwid,
        ),
      ),
    );
    if (ok != true) {
      return ReturnResultError("addprofile failed or canceled by user");
    }
    return null;
  }
}
