#!/usr/bin/env bash
# Fix notarization "Invalid" caused by missing secure timestamp / get-task-allow
# entitlement, both of which come from `flutter build macos` using an
# xcodebuild `build` action instead of `archive` (Xcode only strips
# get-task-allow and forces a secure timestamp during archive/export).
#
# This re-signs every binary inside the built .app in place (in-place mode)
# or inside an already-built .pkg (repack mode), then re-signs the pkg.
#
# Usage (preferred, before packaging):
#   ./resign_app.sh app [path-to-Clash Mi.app]
#
# Usage (repack an already-built pkg that failed notarization):
#   ./resign_app.sh pkg [input.pkg] [output.pkg]
#
# Any omitted path is derived from the "version:" field in pubspec.yaml
# (e.g. 1.0.30+1602 -> dist/1.0.30+1602/clashmi_1.0.30.1602_macos_universal.pkg),
# matching the --artifact-name pattern used by `fastforge package`. When
# output.pkg is omitted, the input pkg is overwritten in place.

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

APP_NAME="Clash Mi"
APP_BUNDLE_NAME="${APP_NAME}.app"
ARTIFACT_NAME_PREFIX="clashmi"
PKG_IDENTIFIER="com.nebula.clashmi.pkg"

APP_SIGN_IDENTITY="Developer ID Application: SUPERNOVA NEBULA LLC (TNPM9PFX3W)"
INSTALLER_SIGN_IDENTITY="Developer ID Installer: SUPERNOVA NEBULA LLC (TNPM9PFX3W)"
INSTALL_PATH="/Applications"

resove_version(){
  local version build_name build_number
  version="$(awk '/^version:/{print $2; exit}' "$REPO_ROOT/pubspec.yaml")"
  build_name="${version%%+*}"
  build_number="${version##*+}"
  echo "${build_name}.${build_number}"
}

resolve_default_pkg_path() {
  local version build_name build_number
  version="$(awk '/^version:/{print $2; exit}' "$REPO_ROOT/pubspec.yaml")"
  build_name="${version%%+*}"
  build_number="${version##*+}"
  echo "$REPO_ROOT/dist/${build_name}+${build_number}/${ARTIFACT_NAME_PREFIX}_${build_name}.${build_number}_macos_universal.pkg"
}

resolve_default_app_path() {
  echo "$REPO_ROOT/build/macos/Build/Products/Release/${APP_BUNDLE_NAME}"
}

resign_binary() {
  local item="$1"
  local entitlements_file
  entitlements_file="$(mktemp)"

  # Reuse the binary's existing entitlements but strip the debug-only key.
  if codesign -d --entitlements :- "$item" > "$entitlements_file" 2>/dev/null && [[ -s "$entitlements_file" ]]; then
    /usr/libexec/PlistBuddy -c "Delete :com.apple.security.get-task-allow" "$entitlements_file" >/dev/null 2>&1 || true
    codesign --force --options runtime --timestamp \
      --entitlements "$entitlements_file" \
      --sign "$APP_SIGN_IDENTITY" "$item"
  else
    codesign --force --options runtime --timestamp \
      --sign "$APP_SIGN_IDENTITY" "$item"
  fi
  rm -f "$entitlements_file"
}

resign_app_bundle() {
  local app_path="$1"

  echo "Re-signing nested frameworks/dylibs in $app_path ..."
  find "$app_path" -type f \( -name "*.dylib" \) -print0 | while IFS= read -r -d '' item; do
    resign_binary "$item"
  done

  echo "Re-signing nested .framework bundles ..."
  find "$app_path" -type d -name "*.framework" | while IFS= read -r fw; do
    resign_binary "$fw"
  done

  echo "Re-signing system extension(s) ..."
  find "$app_path" -type d -name "*.systemextension" | while IFS= read -r se; do
    local se_bin
    se_bin="$(find "$se/Contents/MacOS" -type f | head -n1)"
    [[ -n "$se_bin" ]] && resign_binary "$se_bin"
    resign_binary "$se"
  done

  echo "Re-signing main executable and app bundle ..."
  local main_bin="$app_path/Contents/MacOS/${APP_NAME}"
  [[ -f "$main_bin" ]] && resign_binary "$main_bin"
  resign_binary "$app_path"

  echo "Verifying deep signature ..."
  codesign --verify --deep --strict --verbose=2 "$app_path"
  codesign -d --entitlements :- "$app_path" | grep -i get-task-allow && \
    { echo "error: get-task-allow still present on $app_path" >&2; exit 1; } || true
}

MODE="${1:?Usage: $0 <app|pkg> [path...]}"

case "$MODE" in
  app)
    APP_PATH="${2:-$(resolve_default_app_path)}"
    resign_app_bundle "$APP_PATH"
    ;;
  pkg)
    PKG_IN="${2:-$(resolve_default_pkg_path)}"
    PKG_OUT="${3:-$PKG_IN}"
    WORKDIR="$(mktemp -d)"
    trap 'rm -rf "$WORKDIR"' EXIT

    echo "Expanding $PKG_IN ..."
    pkgutil --expand-full "$PKG_IN" "$WORKDIR/expanded"

    APP_PATH="$(find "$WORKDIR/expanded" -maxdepth 6 -type d -name "$APP_BUNDLE_NAME" | head -n1)"
    [[ -n "$APP_PATH" ]] || { echo "error: $APP_BUNDLE_NAME not found in $PKG_IN" >&2; exit 1; }

    resign_app_bundle "$APP_PATH"

    echo "Repackaging as $PKG_OUT ..."
    COMPONENT_PKG_NAME="component.pkg"
    COMPONENT_PKG="$WORKDIR/$COMPONENT_PKG_NAME"

    # --root must point at a directory whose contents mirror the install
    # location, so wrap the app one level deeper (package-root/Clash Mi.app)
    # rather than pointing --root at the app itself.
    PACKAGE_ROOT="$WORKDIR/package-root"
    mkdir -p "$PACKAGE_ROOT"
    ditto "$APP_PATH" "$PACKAGE_ROOT/$APP_BUNDLE_NAME"

    # By default pkgbuild marks the bundle relocatable: at install time the
    # installer searches the whole volume (via Launch Services) for any
    # existing bundle with the same identifier -- even one sitting in
    # ~/.Trash -- and installs there instead of --install-location. Force a
    # fixed /Applications install by generating a component plist and
    # disabling relocation. (--analyze requires --root, not --component.)
    COMPONENT_PLIST="$WORKDIR/component.plist"
    pkgbuild --analyze --root "$PACKAGE_ROOT" "$COMPONENT_PLIST"
    /usr/libexec/PlistBuddy -c "Set :0:BundleIsRelocatable false" "$COMPONENT_PLIST"

    pkgbuild --root "$PACKAGE_ROOT" \
      --component-plist "$COMPONENT_PLIST" \
      --identifier "$PKG_IDENTIFIER" \
      --install-location "$INSTALL_PATH" \
      "$COMPONENT_PKG"
    COMPONENT_CHECK="$WORKDIR/component-check"
    pkgutil --expand-full "$COMPONENT_PKG" "$COMPONENT_CHECK"
    [[ -f "$COMPONENT_CHECK/Payload/$APP_BUNDLE_NAME/Contents/MacOS/$APP_NAME" ]] || {
      echo "error: rebuilt component does not contain the Clash Mi executable" >&2
      exit 1
    }
    grep -Eq "install-location=[\"']${INSTALL_PATH}[/\"']" "$COMPONENT_CHECK/PackageInfo" || {
      echo "error: rebuilt component install location is not $INSTALL_PATH" >&2
      exit 1
    }

    # Wrap the component in a distribution package: this forces a system-domain
    # (/Applications) install instead of letting Installer.app default to a
    # per-user "install for me only" (~/Applications) install, and restores
    # the "Clash Mi" title shown in Installer.app.
    DISTRIBUTION_XML="$WORKDIR/Distribution.xml"
    cat > "$DISTRIBUTION_XML" <<EOF
<?xml version="1.0" encoding="utf-8"?>
<installer-gui-script minSpecVersion="1">
    <title>$APP_NAME $(resove_version)</title>
    <options customize="never" require-scripts="false" rootVolumeOnly="true"/>
    <domains enable_anywhere="false" enable_currentUserHome="false" enable_localSystem="true"/>
    <choices-outline>
        <line choice="default"/>
    </choices-outline>
    <choice id="default" visible="false">
        <pkg-ref id="$PKG_IDENTIFIER"/>
    </choice>
    <pkg-ref id="$PKG_IDENTIFIER" version="1.0" onConclusion="none">$COMPONENT_PKG_NAME</pkg-ref>
</installer-gui-script>
EOF
    productbuild --distribution "$DISTRIBUTION_XML" \
      --package-path "$WORKDIR" \
      --sign "$INSTALLER_SIGN_IDENTITY" \
      "$PKG_OUT"

    FINAL_CHECK="$WORKDIR/final-check"
    pkgutil --expand-full "$PKG_OUT" "$FINAL_CHECK"
    FINAL_APP_BIN="$(find "$FINAL_CHECK" -type f -path "*/$APP_BUNDLE_NAME/Contents/MacOS/$APP_NAME" | head -n1)"
    [[ -n "$FINAL_APP_BIN" ]] || {
      echo "error: final package does not contain the Clash Mi executable" >&2
      exit 1
    }
    grep -Eq "install-location=[\"']${INSTALL_PATH}[/\"']" "$FINAL_CHECK"/*/PackageInfo || {
      echo "error: final package install location is not $INSTALL_PATH" >&2
      exit 1
    }
    grep -q "enable_localSystem=\"true\"" "$FINAL_CHECK/Distribution" || {
      echo "error: final package does not force a system-domain (/Applications) install" >&2
      exit 1
    }
    ! grep -q "<relocate>" "$FINAL_CHECK"/*/PackageInfo || {
      echo "error: final package bundle is still relocatable; it may install outside $INSTALL_PATH" >&2
      exit 1
    }

    echo "Done: $PKG_OUT"
    ;;
  *)
    echo "error: mode must be 'app' or 'pkg'" >&2
    exit 1
    ;;
esac
