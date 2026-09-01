#!/bin/zsh

app_path="/Applications/Clash Mi.app"

if [[ ! -d "$app_path" ]]; then
  osascript -e 'display alert "Clash Mi is not installed" message "Drag Clash Mi.app to Applications before starting it."'
  exit 1
fi

xattr -rd com.apple.quarantine "$app_path" 2>/dev/null || true
xattr -rd com.apple.provenance "$app_path" 2>/dev/null || true
open "$app_path"