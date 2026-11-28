import 'dart:io';

/// Copies legacy macOS profiles into the app's private Application Support
/// directory. The native host creates [storageDirectory] with mode 0700.
///
/// The original directory is left intact. A completed `data` directory is
/// authoritative; partial migrations are never published at that path.
Future<Directory> migrateMacOSProfiles({
  required Directory legacyDirectory,
  required Directory storageDirectory,
}) async {
  final storage = Directory(_withoutTrailingSeparator(storageDirectory.path));
  if (await FileSystemEntity.type(storage.path, followLinks: false) !=
      FileSystemEntityType.directory) {
    throw FileSystemException(
      'The macOS profile storage must be an existing directory, not a link',
      storage.path,
    );
  }

  final destination = Directory.fromUri(storage.uri.resolve('data'));
  final lockFile = File.fromUri(storage.uri.resolve('.migration.lock'));
  final lockType = await FileSystemEntity.type(
    lockFile.path,
    followLinks: false,
  );
  if (lockType != FileSystemEntityType.notFound &&
      lockType != FileSystemEntityType.file) {
    throw FileSystemException(
      'The macOS profile migration lock must be a regular file',
      lockFile.path,
    );
  }

  // Keep this file after unlocking. Removing it would allow another process to
  // lock a different inode while a previous caller still owns the original.
  final lock = await lockFile.open(mode: FileMode.append);
  var locked = false;
  try {
    await lock.lock(FileLock.blockingExclusive);
    locked = true;
    final destinationType = await FileSystemEntity.type(
      destination.path,
      followLinks: false,
    );
    if (destinationType == FileSystemEntityType.directory) {
      return destination;
    }
    if (destinationType != FileSystemEntityType.notFound) {
      throw FileSystemException(
        'The macOS profile destination must be a directory, not a file or link',
        destination.path,
      );
    }

    final staging = await storage.createTemp('.migration-');
    try {
      await _copyDirectory(
        Directory(_withoutTrailingSeparator(legacyDirectory.path)),
        staging,
        isRoot: true,
      );
      await staging.rename(destination.path);
    } catch (error, stackTrace) {
      try {
        await staging.delete(recursive: true);
      } catch (cleanupError) {
        throw FileSystemException(
          'Profile migration failed ($error); could not remove the incomplete '
          'migration directory ($cleanupError)',
          staging.path,
        );
      }
      Error.throwWithStackTrace(error, stackTrace);
    }
    return destination;
  } finally {
    try {
      if (locked) {
        await lock.unlock();
      }
    } finally {
      await lock.close();
    }
  }
}

Future<void> _copyDirectory(
  Directory source,
  Directory destination, {
  bool isRoot = false,
}) async {
  final sourceType = await FileSystemEntity.type(
    source.path,
    followLinks: false,
  );
  if (sourceType == FileSystemEntityType.link) {
    throw FileSystemException(
      'Profile migration does not follow symbolic links',
      source.path,
    );
  }
  if (sourceType != FileSystemEntityType.directory &&
      sourceType != FileSystemEntityType.notFound) {
    throw FileSystemException(
      'The legacy profile location must be a directory',
      source.path,
    );
  }

  final List<FileSystemEntity> entries;
  try {
    entries = await source.list(followLinks: false).toList();
  } on FileSystemException catch (error) {
    // `exists` and `type` can also report false/notFound for permission errors.
    // Only an explicit ENOENT at the legacy root means a fresh installation.
    if (isRoot &&
        sourceType == FileSystemEntityType.notFound &&
        error.osError?.errorCode == 2) {
      return;
    }
    rethrow;
  }

  for (final entry in entries) {
    final name = _basename(entry.path);
    if (isRoot && _isDisposableRootEntry(name)) {
      continue;
    }
    final entryType = await FileSystemEntity.type(
      entry.path,
      followLinks: false,
    );
    final targetPath = '${destination.path}${Platform.pathSeparator}$name';
    if (entryType == FileSystemEntityType.directory) {
      final target = await Directory(targetPath).create();
      await _copyDirectory(Directory(entry.path), target);
    } else if (entryType == FileSystemEntityType.file) {
      await File(entry.path).copy(targetPath);
    } else {
      throw FileSystemException(
        'Profile migration requires regular files and directories; '
        'symbolic links and other file types are not supported',
        entry.path,
      );
    }
  }
}

bool _isDisposableRootEntry(String name) {
  return name == 'Library' ||
      name == '.com.apple.containermanagerd.metadata.plist' ||
      name == 'cache.db' ||
      name.startsWith('cache.db-') ||
      name == 'service_core.log' ||
      name == 'service_error.log' ||
      name == 'service.json' ||
      name == 'service_core_runtime_profile.yaml';
}

String _basename(String path) {
  final value = _withoutTrailingSeparator(path);
  return value.substring(value.lastIndexOf(Platform.pathSeparator) + 1);
}

String _withoutTrailingSeparator(String path) {
  var end = path.length;
  while (end > 1 && path[end - 1] == Platform.pathSeparator) {
    end--;
  }
  return path.substring(0, end);
}
