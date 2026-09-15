#!/usr/bin/env bash
# Sign the app inside an existing DMG and rebuild the image.
# The DMG itself is not code-signed; its app bundle must be signed before notarization.
#
# Usage:
#   ./sign_dmg.sh [path-to-dmg]

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"
APP_BUNDLE_NAME="Clash Mi.app"
ARTIFACT_NAME_PREFIX="clashmi"

resolve_default_dmg_path() {
  local version build_name build_number
  version="$(awk '/^version:/{print $2; exit}' "$REPO_ROOT/pubspec.yaml")"
  build_name="${version%%+*}"
  build_number="${version##*+}"
  echo "$REPO_ROOT/dist/${build_name}+${build_number}/${ARTIFACT_NAME_PREFIX}_${build_name}.${build_number}_macos_universal.dmg"
}

DMG_PATH="${1:-$(resolve_default_dmg_path)}"
[[ -f "$DMG_PATH" ]] || { echo "error: dmg not found at $DMG_PATH" >&2; exit 1; }

WORKDIR="$(mktemp -d)"
MOUNTPOINT="$WORKDIR/mount"
RW_DMG="$WORKDIR/rw.dmg"
SIGNED_DMG="$WORKDIR/signed.dmg"
MOUNTED=0
mkdir -p "$MOUNTPOINT"

cleanup() {
  if [[ "$MOUNTED" -eq 1 ]]; then
    hdiutil detach "$MOUNTPOINT" -force >/dev/null || true
  fi
  rm -rf "$WORKDIR"
}
trap cleanup EXIT

hdiutil convert "$DMG_PATH" -format UDRW -o "$RW_DMG" >/dev/null
hdiutil attach "$RW_DMG" -nobrowse -noautoopen -mountpoint "$MOUNTPOINT" >/dev/null
MOUNTED=1

APP_PATH="$MOUNTPOINT/$APP_BUNDLE_NAME"
[[ -d "$APP_PATH" ]] || { echo "error: $APP_BUNDLE_NAME not found in $DMG_PATH" >&2; exit 1; }

bash "$REPO_ROOT/macos/packaging/pkg/resign_app.sh" app "$APP_PATH"

hdiutil detach "$MOUNTPOINT" >/dev/null
MOUNTED=0
hdiutil convert "$RW_DMG" -format UDZO -imagekey zlib-level=9 -o "$SIGNED_DMG" >/dev/null
mv "$SIGNED_DMG" "$DMG_PATH"

echo "Done: signed app embedded in $DMG_PATH"
