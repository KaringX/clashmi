#!/usr/bin/env bash
# Notarize and staple a signed .pkg so Gatekeeper accepts it on other Macs.
#
# Prerequisites (one-time), using an App Store Connect API Key
# (generate at https://appstoreconnect.apple.com/access/api, role "Developer" or above):
#   xcrun notarytool store-credentials "karingx-notary" \
#     --key "<path-to-AuthKey_XXXXXXXXXX.p8>" \
#     --key-id "<key-id>" \
#     --issuer "<issuer-id>"
#
# Usage:
#   ./notarize_pkg.sh [path-to-pkg]
#
# If path-to-pkg is omitted, it is derived from the "version:" field in
# pubspec.yaml (e.g. 1.0.30+1602 -> dist/1.0.30+1602/clashmi_1.0.30.1602_macos_universal.pkg),
# matching the --artifact-name pattern used by `fastforge package`.
#
# Requires the pkg to already be signed with the "Developer ID Installer"
# identity configured in macos/packaging/pkg/make_config.yaml.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

ARTIFACT_NAME_PREFIX="clashmi"

resolve_default_pkg_path() {
  local version build_name build_number
  version="$(awk '/^version:/{print $2; exit}' "$REPO_ROOT/pubspec.yaml")"
  build_name="${version%%+*}"
  build_number="${version##*+}"
  echo "$REPO_ROOT/dist/${build_name}+${build_number}/${ARTIFACT_NAME_PREFIX}_${build_name}.${build_number}_macos_universal.pkg"
}

PKG_PATH="${1:-$(resolve_default_pkg_path)}"
KEYCHAIN_PROFILE="${NOTARY_PROFILE:-karingx-notary}"

if [[ ! -f "$PKG_PATH" ]]; then
  echo "error: pkg not found at $PKG_PATH" >&2
  exit 1
fi

echo "Submitting $PKG_PATH for notarization (profile: $KEYCHAIN_PROFILE)..."
SUBMIT_OUTPUT="$(xcrun notarytool submit "$PKG_PATH" --keychain-profile "$KEYCHAIN_PROFILE" --wait)"
echo "$SUBMIT_OUTPUT"

SUBMISSION_ID="$(echo "$SUBMIT_OUTPUT" | awk '/id:/{print $2; exit}')"
if echo "$SUBMIT_OUTPUT" | grep -q "status: Invalid"; then
  echo "Notarization rejected, fetching detailed log for submission $SUBMISSION_ID..." >&2
  xcrun notarytool log "$SUBMISSION_ID" --keychain-profile "$KEYCHAIN_PROFILE" notary_log.json || true
  cat notary_log.json >&2 || true
  exit 1
fi

echo "Stapling notarization ticket..."
xcrun stapler staple "$PKG_PATH"

echo "Verifying..."
spctl --assess --type install -vv "$PKG_PATH"
xcrun stapler validate "$PKG_PATH"

echo "Done: $PKG_PATH is notarized and stapled."
