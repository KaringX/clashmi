// Standalone regression tests: dart test/macos_profile_migration_test.dart
// These intentionally require neither Flutter nor the private service plugins.
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import '../lib/app/utils/macos_profile_migration.dart';

void check(bool condition, String message) {
  if (!condition) throw StateError(message);
}

Future<void> expectFailure(Future<void> Function() operation) async {
  try {
    await operation();
  } on FileSystemException {
    return;
  }
  throw StateError('Expected a FileSystemException');
}

Future<void> writeFile(Directory root, String name, String contents) async {
  final file = File('${root.path}/$name');
  await file.parent.create(recursive: true);
  await file.writeAsString(contents);
}

Future<void> checkNoStaging(Directory storage) async {
  final entries = await storage.list(followLinks: false).toList();
  check(
    !entries.any(
      (entry) => entry.path.split('/').last.startsWith('.migration-'),
    ),
    'An incomplete staging directory was left behind',
  );
}

Future<void> withDirectories(
  Future<void> Function(Directory root, Directory legacy, Directory storage)
  test,
) async {
  final root = await Directory.systemTemp.createTemp('clashmi-migration-test-');
  final legacy = await Directory('${root.path}/legacy').create();
  final storage = await Directory('${root.path}/application-support').create();
  try {
    await test(root, legacy, storage);
  } finally {
    await root.delete(recursive: true);
  }
}

Future<void> testCopy() => withDirectories((root, legacy, storage) async {
  await writeFile(legacy, 'setting.json', '{"language":"ru"}');
  await writeFile(legacy, 'profiles/example', 'proxies: []\nrules: []\n');
  await writeFile(
    legacy,
    'profilePatchs/custom',
    'function main(c) { return c; }',
  );
  await writeFile(legacy, 'custom-providers/nested/local.txt', 'example.com');
  final originalBytes = [0, 1, 127, 128, 255, 42];
  await File('${legacy.path}/ASN.mmdb').writeAsBytes(originalBytes);

  final result = await migrateMacOSProfiles(
    legacyDirectory: legacy,
    storageDirectory: storage,
  );
  check(result.path == '${storage.path}/data', 'Wrong published directory');
  for (final name in [
    'setting.json',
    'profiles/example',
    'profilePatchs/custom',
    'custom-providers/nested/local.txt',
    'ASN.mmdb',
  ]) {
    final oldBytes = await File('${legacy.path}/$name').readAsBytes();
    final newBytes = await File('${result.path}/$name').readAsBytes();
    check(base64Encode(newBytes) == base64Encode(oldBytes), 'Changed $name');
  }
  check(await legacy.exists(), 'The legacy directory was removed');
  await checkNoStaging(storage);
});

Future<void> testExistingDestination() => withDirectories((
  root,
  legacy,
  storage,
) async {
  await writeFile(legacy, 'setting.json', 'original');
  final result = await migrateMacOSProfiles(
    legacyDirectory: legacy,
    storageDirectory: storage,
  );
  await writeFile(result, 'setting.json', 'new settings');
  await writeFile(legacy, 'setting.json', 'stale legacy settings');
  await writeFile(legacy, 'should-not-reappear', 'stale');
  final second = await migrateMacOSProfiles(
    legacyDirectory: legacy,
    storageDirectory: storage,
  );
  check(second.path == result.path, 'Repeated migration changed the root');
  check(
    await File('${second.path}/setting.json').readAsString() == 'new settings',
    'Repeated migration overwrote current settings',
  );
  check(
    !await File('${second.path}/should-not-reappear').exists(),
    'Repeated migration merged stale data',
  );
});

Future<void> testExcludedEntries() =>
    withDirectories((root, legacy, storage) async {
      const excluded = [
        'Library/Preferences/old.plist',
        '.com.apple.containermanagerd.metadata.plist',
        'cache.db',
        'cache.db-wal',
        'cache.db-shm',
        'cache.db-journal',
        'service_core.log',
        'service_error.log',
        'service.json',
        'service_core_runtime_profile.yaml',
      ];
      const preserved = [
        'custom-providers/Library/rules.txt',
        'custom-providers/cache.db',
        'custom-providers/service.json',
        'service_core_setting.json',
        'service_core_patch.yaml',
        'service_core_patch_final.json',
        'cache/local-provider.yaml',
        'app.log',
      ];
      for (final name in [...excluded, ...preserved]) {
        await writeFile(legacy, name, name);
      }
      final result = await migrateMacOSProfiles(
        legacyDirectory: legacy,
        storageDirectory: storage,
      );
      for (final name in excluded) {
        check(
          !await File('${result.path}/$name').exists(),
          'Copied excluded $name',
        );
        check(
          await File('${legacy.path}/$name').exists(),
          'Removed original $name',
        );
      }
      for (final name in preserved) {
        check(
          await File('${result.path}/$name').exists(),
          'Lost custom file $name',
        );
      }
    });

Future<void> testSymlinkFailureAndRetry() =>
    withDirectories((root, legacy, storage) async {
      await writeFile(legacy, 'profiles/valid', 'valid profile');
      final external = await Directory('${root.path}/external').create();
      await writeFile(external, 'private', 'do not copy');
      final link = await Link('${legacy.path}/custom-provider')
          .create(external.path);
      await expectFailure(() async {
        await migrateMacOSProfiles(
          legacyDirectory: legacy,
          storageDirectory: storage,
        );
      });
      check(
        !await Directory('${storage.path}/data').exists(),
        'Published partial data',
      );
      await checkNoStaging(storage);
      check(await link.exists(), 'Removed the original symbolic link');
      check(
        await File('${external.path}/private').readAsString() == 'do not copy',
        'Changed the symbolic link target',
      );
      await link.delete();
      final result = await migrateMacOSProfiles(
        legacyDirectory: legacy,
        storageDirectory: storage,
      );
      check(
        await File('${result.path}/profiles/valid').exists(),
        'Retry lost profile',
      );
      await checkNoStaging(storage);
    });

Future<void> testMissingSource() =>
    withDirectories((root, legacy, storage) async {
      await legacy.delete();
      final result = await migrateMacOSProfiles(
        legacyDirectory: legacy,
        storageDirectory: storage,
      );
      check(await result.exists(), 'Fresh installation did not create data');
      check(await result.list().isEmpty, 'Fresh installation was not empty');
      check(
        !await legacy.exists(),
        'Fresh installation modified the legacy location',
      );
    });

Future<void> testInvalidDestinations() =>
    withDirectories((root, legacy, storage) async {
      final destinationFile = File('${storage.path}/data');
      await destinationFile.writeAsString('must stay intact');
      await expectFailure(() async {
        await migrateMacOSProfiles(
          legacyDirectory: legacy,
          storageDirectory: storage,
        );
      });
      check(
        await destinationFile.readAsString() == 'must stay intact',
        'Changed an invalid file destination',
      );
      await destinationFile.delete();
      final external = await Directory('${root.path}/external').create();
      final link = await Link(destinationFile.path).create(external.path);
      await expectFailure(() async {
        await migrateMacOSProfiles(
          legacyDirectory: legacy,
          storageDirectory: storage,
        );
      });
      check(await link.exists(), 'Removed an invalid destination link');
      check(await external.list().isEmpty, 'Wrote through a destination link');
      await checkNoStaging(storage);
    });

Future<void> testInvalidSource() =>
    withDirectories((root, legacy, storage) async {
      await legacy.delete();
      final sourceFile = File(legacy.path);
      await sourceFile.writeAsString('not a directory');
      await expectFailure(() async {
        await migrateMacOSProfiles(
          legacyDirectory: legacy,
          storageDirectory: storage,
        );
      });
      check(
        !await Directory('${storage.path}/data').exists(),
        'Accepted invalid source',
      );
      await checkNoStaging(storage);
      await sourceFile.delete();
      final external = await Directory('${root.path}/external').create();
      await Link(legacy.path).create(external.path);
      await expectFailure(() async {
        await migrateMacOSProfiles(
          legacyDirectory: Directory('${legacy.path}/'),
          storageDirectory: storage,
        );
      });
      await checkNoStaging(storage);
    });

Future<void> testUnreadableSource() =>
    withDirectories((root, legacy, storage) async {
      final restricted = await Directory('${legacy.path}/restricted').create();
      final source = await Directory('${restricted.path}/profiles').create();
      await writeFile(
        source,
        'saved-profile',
        'must remain accessible after retry',
      );
      final denied = await Process.run('chmod', ['000', restricted.path]);
      check(denied.exitCode == 0, 'Could not set up permission-denied test');
      FileSystemException? failure;
      try {
        try {
          await migrateMacOSProfiles(
            legacyDirectory: source,
            storageDirectory: storage,
          );
        } on FileSystemException catch (error) {
          failure = error;
        }
        check(
          failure?.osError?.errorCode == 13 || failure?.osError?.errorCode == 1,
          'Permission failure was not propagated (run this test as a non-root user)',
        );
        check(
          !await Directory('${storage.path}/data').exists(),
          'An unreadable source was mistaken for a fresh installation',
        );
        await checkNoStaging(storage);
      } finally {
        final restored = await Process.run('chmod', ['700', restricted.path]);
        check(
          restored.exitCode == 0,
          'Could not restore test directory permissions',
        );
      }
      final result = await migrateMacOSProfiles(
        legacyDirectory: source,
        storageDirectory: storage,
      );
      check(
        await File('${result.path}/saved-profile').readAsString() ==
            'must remain accessible after retry',
        'A retry after restoring permissions lost the saved profile',
      );
    });

Future<void> testProcessLock() => withDirectories((
  root,
  legacy,
  storage,
) async {
  final lock = await File('${storage.path}/.migration.lock')
      .open(mode: FileMode.append);
  await lock.lock(FileLock.exclusive);
  var locked = true;
  final process = await Process.start(Platform.resolvedExecutable, [
    Platform.script.toFilePath(),
    '--worker',
    legacy.path,
    storage.path,
  ]);
  final ready = Completer<void>();
  final output = <String>[];
  final subscription = process.stdout
      .transform(utf8.decoder)
      .transform(const LineSplitter())
      .listen((line) {
        output.add(line);
        if (line == 'ready' && !ready.isCompleted) ready.complete();
      });
  final stderr = process.stderr.transform(utf8.decoder).join();
  var exited = false;
  final exitCode = process.exitCode.then((value) {
    exited = true;
    return value;
  });
  try {
    await ready.future.timeout(const Duration(seconds: 10));
    await Future<void>.delayed(const Duration(milliseconds: 200));
    check(!exited, 'A different process ignored the migration lock');
    check(
      !await Directory('${storage.path}/data').exists(),
      'A different process published while the lock was held',
    );
    await writeFile(legacy, 'after-lock', 'complete snapshot');
    await lock.unlock();
    locked = false;
    final code = await exitCode.timeout(const Duration(seconds: 10));
    check(code == 0, 'Migration worker failed: $code ${await stderr} $output');
    check(
      await File('${storage.path}/data/after-lock').readAsString() ==
          'complete snapshot',
      'Migration copied before acquiring the lock',
    );
    await checkNoStaging(storage);
  } finally {
    if (locked) await lock.unlock();
    await lock.close();
    if (!exited) process.kill();
    await subscription.cancel();
  }
});

Future<void> main(List<String> args) async {
  if (args.isNotEmpty && args.first == '--worker') {
    stdout.writeln('ready');
    await migrateMacOSProfiles(
      legacyDirectory: Directory(args[1]),
      storageDirectory: Directory(args[2]),
    );
    return;
  }
  final tests = <String, Future<void> Function()>{
    'copies profiles, patches, providers and binary data without changing source':
        testCopy,
    'keeps completed destination authoritative': testExistingDestination,
    'excludes only root container metadata and disposable runtime files':
        testExcludedEntries,
    'rejects source links, cleans partial staging and permits retry':
        testSymlinkFailureAndRetry,
    'creates an empty destination for a missing legacy directory':
        testMissingSource,
    'rejects file and symbolic-link destinations': testInvalidDestinations,
    'rejects invalid legacy roots including a trailing-slash symbolic link':
        testInvalidSource,
    'propagates permission failures instead of treating them as a fresh install':
        testUnreadableSource,
    'serializes migration against another process': testProcessLock,
  };
  for (final test in tests.entries) {
    await test.value();
    stdout.writeln('PASS ${test.key}');
  }
  stdout.writeln('${tests.length} migration tests passed');
}
