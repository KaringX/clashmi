#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

fastforge package \
  --platform=macos \
  --targets=dmg \
  --build-dart-define=PACKAGE_TARGET=dmg \
  --skip-clean \
  --artifact-name="{{name}}{{#flavor}}_{{flavor}}{{/flavor}}_{{build_name}}{{#has_build_number}}.{{build_number}}{{/has_build_number}}{{#is_profile}}_{{build_mode}}{{/is_profile}}_{{platform}}_universal{{#ext}}.{{ext}}{{/ext}}"

bash "$SCRIPT_DIR/sign_dmg.sh"
bash "$SCRIPT_DIR/notarize_dmg.sh"
