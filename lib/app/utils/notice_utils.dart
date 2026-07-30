// ignore_for_file: empty_catches, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';

import 'package:clashmi/app/utils/app_utils.dart';
import 'package:clashmi/app/utils/install_referrer_utils.dart';
import 'package:flutter/material.dart';

class RawNoticeItem {
  String platform = "";
  String channel = "";
  String updateTime = "";
  String expireTime = "";
  String title = "";
  String content = "";
  String url = "";
  String versionRegex = "";
  String regionCode = "";

  void fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    platform = map["platform"] ?? "";
    channel = map["channel"] ?? "";
    updateTime = map["update_time"] ?? "";
    expireTime = map["expire_time"] ?? "";
    title = map["title"] ?? "";
    content = map["content"] ?? "";
    url = map["url"] ?? "";
    versionRegex = map["version_regex"] ?? "";
    regionCode = (map["region_code"] ?? "").toLowerCase();
  }
}

abstract final class NoticeUtils {
  static Future<RawNoticeItem?> parseNotice(String data) async {
    final rc =
        WidgetsBinding.instance.platformDispatcher.locale.countryCode ?? "US";
    String regionCode = rc.toLowerCase();
    String version = AppUtils.getBuildinVersion();
    var decodedResponse = jsonDecode(data);
    if (decodedResponse is List) {
      String channelName = await InstallReferrerUtils.getString();
      for (var i in decodedResponse) {
        RawNoticeItem item = RawNoticeItem();
        item.fromJson(i);
        if (item.content.isEmpty && item.url.isEmpty) {
          continue;
        }
        if (item.platform == Platform.operatingSystem) {
          List channels = item.channel.split(",");
          if (channels.contains("*") || channels.contains(channelName)) {
            List regionCodes = item.regionCode.split(",");
            if (item.regionCode.isEmpty ||
                regionCodes.contains("*") ||
                regionCodes.contains(regionCode)) {
              List versions = item.versionRegex.split(",");
              if (item.versionRegex.isEmpty ||
                  versions.contains("*") ||
                  versions.contains(version)) {
                if (item.expireTime.isNotEmpty) {
                  DateTime? date = DateTime.tryParse(item.expireTime);
                  if (date != null && date.isAfter(DateTime.now())) {
                    return item;
                  }
                } else {
                  return item;
                }
              }
            }
          }
        }
      }
    }
    return null;
  }
}
