# macOS storage without Full Disk Access

## Why the storage location changes

The Developer ID build runs its UI as the signed-in user and its packet-tunnel
system extension as root. Reading the user's App Group container from that
extension can fail under macOS privacy protection. [Issue #178](https://github.com/KaringX/clashmi/issues/178#issuecomment-7155294404)
contains a report with TCC denials for `group.com.nebula.clashmi/service.json`.

Static inspection of the official **1.0.33.1905** macOS package found the expected
App Group and application identifiers in both executables and their embedded
provisioning profiles. Missing profile authorization is therefore not an
established explanation for this release. This inspection did not validate the
signatures under macOS policy or reproduce the reported TCC failure.

## Storage and permissions

The macOS UI uses the account's real home directory to locate:

```text
~/Library/Application Support/com.nebula.clashmi/data
```

The containing application directory is private to the user (`0700`). The UI
passes the resulting paths to the system extension; the extension must not
recompute them relative to root's home. Standard sandboxed Foundation home and
Application Support lookups resolve inside the app container, so the account
home must be resolved separately.

The UI retains App Sandbox and requests only this additional filesystem scope:

```xml
<key>com.apple.security.temporary-exception.files.home-relative-path.read-write</key>
<array>
    <string>/Library/Application Support/com.nebula.clashmi/</string>
</array>
```

This is a directory-specific sandbox exception, not Full Disk Access. Both the
leading and trailing slash are required. App Group identity remains available
for existing integration; iOS storage is unchanged. See Apple's
[file-access temporary exception documentation](https://developer.apple.com/library/archive/documentation/Miscellaneous/Reference/EntitlementKeyReference/Chapters/AppSandboxTemporaryExceptionEntitlements.html).

**Security trade-off:** ordinary Application Support storage does not have App
Group container privacy protection against other unsandboxed apps running as the
same user. Mode `0700` protects against other user accounts, not same-user
processes. See Apple's [container protection guidance](https://developer.apple.com/documentation/xcode/protecting-local-app-data-using-containers).
The exception and this trade-off require separate review if Mac App Store
distribution is restored.

## Migration

On first use, application data is copied from the existing App Group into a
staging directory and published as `data` only after copying completes. The old
data is retained. An existing destination is not overwritten on later launches;
a failed migration must not start the app with an empty replacement profile.

Container metadata, disposable `cache.db`, logs, and generated service runtime
files are excluded. Runtime configuration is regenerated with the new paths.
The discarded cache can reset remembered proxy selections. User profiles and
rules must survive migration; the old directory remains available for recovery.

On the first connection or configuration reload after migration, existing VPN
preferences are updated to the new `service.json`. A tunnel still using the old
path is disconnected and started afresh; a hot reload would retain the old
provider configuration. On-demand is disabled during that transition and the
app's configured policy is restored after a successful connection.

Custom YAML, local providers, certificates, or scripts may contain absolute paths
into the old App Group. Update those paths to the new location before use. The
migration deliberately does not perform broad replacements in user content.

## Required signed macOS validation

These checks are **not yet verified**. Use a disposable macOS test account or VM
with a maintainer-signed build and the matching system extension. Do not change
Full Disk Access grants on someone else's active installation.

1. In System Settings > Privacy & Security > Full Disk Access, disable existing
   grants for both Clash Mi and `clashmiServiceSE` in the test environment. Enable
   the network extension normally; disabling system security checks is not a
   substitute for this test.
2. Test a clean installation. Import a profile, connect, confirm working DNS and
   traffic, then disconnect/reconnect. Confirm that no Full Disk Access grant is
   needed and that the new directory has mode `0700`.
3. Test an upgrade with existing subscriptions, custom rules, local providers,
   patches, and downloaded rule data. Confirm preservation of profiles and the
   original directory; confirm generated runtime paths use the new directory.
4. Quit/relaunch the UI, restart the Mac, and reconnect. Exercise on-demand or
   automatic startup if configured, plus subscription/provider refresh and log
   access. Confirm the extension does not depend on the old App Group files.
   Also upgrade with an active tunnel and reload its configuration. Verify that
   the VPN plugin reloads preferences after the native update (no stale manager
   error or reuse of the old path).
5. Test migration failure/interruption and a second launch. Existing data must
   remain recoverable, and completed migration must not be repeated or replaced.
   Check a custom home-directory location and local files with explicit paths.

This contribution was prepared in a Linux environment without macOS/TCC or
Xcode. Full application builds also require the repository's unprovided local
dependencies `../libclash-vpn-service/` and `../board-service/`. Portable checks
can validate migration logic but cannot establish signed NetworkExtension or
TCC behavior; the macOS validation above remains a release gate. Run the portable
migration regression suite with `dart test/macos_profile_migration_test.dart`.
