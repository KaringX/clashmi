import 'package:flutter/material.dart';
import 'package:clashmi/app/runtime/return_result.dart';
import 'package:clashmi/app/utils/platform_utils.dart';
import 'package:clashmi/app/utils/url_launcher_utils.dart';
import 'package:clashmi/screens/inapp_webview_screen.dart';

class WebviewHelper {
  static Future<bool> loadUrl(
    BuildContext context,
    String url,
    String viewTag, {
    String? title,
    bool useInappWebViewForPC = false,
    bool inappWebViewOpenExternal = false,
    bool refreshWhenLoaded = false,
    Map<String, String>? headers,
    Map<String, String>? cookies,
    Map<String, String>? localStorage,
  }) async {
    if (PlatformUtils.isPC()) {
      if (!useInappWebViewForPC) {
        ReturnResultError? error = await UrlLauncherUtils.loadUrl(url);
        return error != null;
      }
    }

    if (await InAppWebViewScreen.makeSureEnvironmentCreated()) {
      if (!context.mounted) {
        return true;
      }

      await Navigator.push(
        context,
        MaterialPageRoute(
          settings: InAppWebViewScreen.routeSettings(viewTag),
          builder: (context) => InAppWebViewScreen(
            title: title ?? "",
            url: url,
            showOpenExternal: inappWebViewOpenExternal,
            refreshWhenLoaded: refreshWhenLoaded,
            headers: headers,
            cookies: cookies,
            localStorage: localStorage,
          ),
        ),
      );
      return true;
    }
    ReturnResultError? error = await UrlLauncherUtils.loadUrl(url);
    return error != null;
  }
}
