import 'dart:io';

import 'package:flutter/services.dart';

import 'macos_profile_migration.dart';

abstract final class MacOSProfileStorage {
  static const _channel = MethodChannel('com.nebula.clashmi/profile-storage');
  static Future<String>? _directory;

  static Future<String> directory(Directory legacyDirectory) {
    return _directory ??= _prepareDirectory(legacyDirectory);
  }

  static Future<String> _prepareDirectory(Directory legacyDirectory) async {
    final root = await _channel.invokeMethod<String>('directory');
    if (root == null || root.isEmpty) {
      throw StateError('Unable to resolve the macOS profile directory.');
    }
    final directory = await migrateMacOSProfiles(
      legacyDirectory: legacyDirectory,
      storageDirectory: Directory(root),
    );
    return directory.path;
  }

  static Future<bool> updateTunnelConfiguration() async {
    return await _channel.invokeMethod<bool>('updateTunnelConfiguration') ??
        false;
  }
}
