#!/usr/bin/env bash
# Submit a signed DMG for notarization, staple the ticket, and verify it.
#
# Prerequisites (one-time):
#   xcrun notarytool store-credentials "karingx-notary" \
#     --key "<path-to-AuthKey_XXXXXXXXXX.p8>" \
#     --key-id "<key-id>" \
#     --issuer "<issuer-id>"
#
# Usage:
#   ./notarize_dmg.sh [path-to-dmg]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
ARTIFACT_NAME_PREFIX="clashmi"

resolve_default_dmg_path() {
  local version build_name build_number
  version="$(awk '/^version:/{print $2; exit}' "$REPO_ROOT/pubspec.yaml")"
  build_name="${version%%+*}"
  build_number="${version##*+}"
  echo "$REPO_ROOT/dist/${build_name}+${build_number}/${ARTIFACT_NAME_PREFIX}_${build_name}.${build_number}_macos_universal.dmg"
}

DMG_PATH="${1:-$(resolve_default_dmg_path)}"
KEYCHAIN_PROFILE="${NOTARY_PROFILE:-karingx-notary}"
[[ -f "$DMG_PATH" ]] || { echo "error: dmg not found at $DMG_PATH" >&2; exit 1; }

echo "Submitting $DMG_PATH for notarization (profile: $KEYCHAIN_PROFILE)..."
SUBMIT_OUTPUT="$(xcrun notarytool submit "$DMG_PATH" --keychain-profile "$KEYCHAIN_PROFILE" --wait)"
echo "$SUBMIT_OUTPUT"

SUBMISSION_ID="$(echo "$SUBMIT_OUTPUT" | awk '/id:/{print $2; exit}')"
if echo "$SUBMIT_OUTPUT" | grep -q "status: Invalid"; then
  echo "Notarization rejected, fetching detailed log for submission $SUBMISSION_ID..." >&2
  xcrun notarytool log "$SUBMISSION_ID" --keychain-profile "$KEYCHAIN_PROFILE" "$REPO_ROOT/notary_dmg_log.json" || true
  cat "$REPO_ROOT/notary_dmg_log.json" >&2 || true
  exit 1
fi

echo "Stapling notarization ticket..."
xcrun stapler staple "$DMG_PATH"

echo "Verifying..."
xcrun stapler validate "$DMG_PATH"

WORKDIR="$(mktemp -d)"
MOUNTPOINT="$WORKDIR/mount"
MOUNTED=0
mkdir -p "$MOUNTPOINT"
cleanup() {
  if [[ "$MOUNTED" -eq 1 ]]; then
    hdiutil detach "$MOUNTPOINT" -force >/dev/null || true
  fi
  rm -rf "$WORKDIR"
}
trap cleanup EXIT

hdiutil attach "$DMG_PATH" -nobrowse -noautoopen -mountpoint "$MOUNTPOINT" >/dev/null
MOUNTED=1
APP_PATH="$MOUNTPOINT/Clash Mi.app"
[[ -d "$APP_PATH" ]] || { echo "error: Clash Mi.app not found in $DMG_PATH" >&2; exit 1; }
spctl --assess --type execute --context context:primary-signature -vv "$APP_PATH"

echo "Done: $DMG_PATH is notarized and stapled."
