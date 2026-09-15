#!/usr/bin/env bash
#chmod +x macos/packaging/pkg/pkg.sh
set -euo pipefail

fastforge package --platform=macos   --targets=pkg       --build-dart-define=PACKAGE_TARGET=pkg      --skip-clean --artifact-name="{{name}}{{#flavor}}_{{flavor}}{{/flavor}}_{{build_name}}{{#has_build_number}}.{{build_number}}{{/has_build_number}}{{#is_profile}}_{{build_mode}}{{/is_profile}}_{{platform}}_universal{{#ext}}.{{ext}}{{/ext}}"

./macos/packaging/pkg/resign_app.sh pkg

./macos/packaging/pkg/notarize_pkg.sh