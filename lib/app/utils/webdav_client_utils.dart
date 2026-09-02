// ignore_for_file: unused_catch_stack
import 'dart:io';

import 'package:dio/io.dart';
import 'package:clashmi/app/runtime/return_result.dart';
import 'package:webdav_client_plus/webdav_client_plus.dart';
import 'package:punycode_converter/punycode_converter.dart' as punycode;

class WebdavClientUtils {
  static const String _prefix = "/clashmi/";
  static bool isInnerError(String message) {
    int? statusCode = message.contains("Status:") == true
        ? int.tryParse(message.split("Status:")[1].split(" ")[1])
        : null;
    if (statusCode == 207 ||
        statusCode == 422 ||
        statusCode == 423 ||
        statusCode == 424 ||
        statusCode == 507 ||
        statusCode == 401 ||
        statusCode == 403 ||
        statusCode == 404 ||
        statusCode == 409 ||
        statusCode == 412) {
      return true;
    }
    return false;
  }

  static Future<ReturnResult<WebdavClient>> connect(
    String? proxyUrl,
    String url,
    String user,
    String password,
  ) async {
    Uri? uri = Uri.tryParse(url.trim());
    try {
      uri = uri?.punyEncoded;
    } catch (err) {}
    if (uri == null) {
      return ReturnResult(
        error: ReturnResultError("Invalid URL:${url.trim()}"),
      );
    }
    var client = WebdavClient(
      url: uri.toString(),
      auth: BasicAuth(user: user.trim(), pwd: password.trim()),
    );
    if (proxyUrl != null && proxyUrl.isNotEmpty) {
      final adapter = IOHttpClientAdapter(
        createHttpClient: () {
          final client = HttpClient()..idleTimeout = const Duration(seconds: 3);
          client.findProxy = (Uri uri) => proxyUrl;
          return client;
        },
      );
      client.setHttpClientAdapter(adapter);
    }
    client.setFollowRedirects(true);

    client.setHeaders({'accept-charset': 'utf-8'});

    // Set the connection server timeout time in milliseconds.
    client.setConnectTimeout(8000);

    // Set send data timeout time in milliseconds.
    /* _client!.setSendTimeout(8000);

    // Set transfer data time in milliseconds.
    _client!.setReceiveTimeout(8000);*/

    // Test whether the service can connect
    try {
      await client.ping();
    } catch (err, stacktrace) {
      return ReturnResult(error: ReturnResultError(err.toString()));
    }
    try {
      await client.mkdir(_prefix);
    } catch (err, stacktrace) {
      return ReturnResult(error: ReturnResultError(err.toString()));
    }
    return ReturnResult(data: client);
  }

  static Future<ReturnResult<List<String>>> list(WebdavClient client) async {
    try {
      final list = await client.readDir(_prefix);
      final names = <String>[];
      for (final item in list) {
        if (item.isDir) continue;
        names.add(item.name);
      }
      return ReturnResult(data: names);
    } catch (err, stacktrace) {
      return ReturnResult(error: ReturnResultError(err.toString()));
    }
  }

  static Future<ReturnResultError?> upload(
    WebdavClient client, {
    required String relativePath,
    required String localPath,
  }) async {
    try {
      await client.writeFile(localPath, _prefix + relativePath);
    } catch (err, stacktrace) {
      return ReturnResultError(err.toString());
    }
    return null;
  }

  static Future<ReturnResultError?> delete(
    WebdavClient client,
    String relativePath,
  ) async {
    try {
      await client.remove(_prefix + relativePath);
    } catch (err, stacktrace) {
      return ReturnResultError(err.toString());
    }
    return null;
  }

  static Future<ReturnResultError?> download(
    WebdavClient client, {
    required String relativePath,
    required String localPath,
  }) async {
    try {
      await client.readFile(_prefix + relativePath, localPath);
    } catch (err, stacktrace) {
      return ReturnResultError(err.toString());
    }
    return null;
  }
}
