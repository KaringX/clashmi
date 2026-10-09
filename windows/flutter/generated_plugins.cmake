#
# Generated file, do not edit.
#

list(APPEND FLUTTER_PLUGIN_LIST
  file_selector_windows
  flutter_inappwebview_windows
  flutter_js
  flutter_secure_storage_windows
  hotkey_manager_windows
  libclash_vpn_service
  open_dir_windows
  protocol_handler
  screen_capturer_windows
  screen_retriever_windows
  share_plus
  url_launcher_windows
  window_manager
)

list(APPEND FLUTTER_FFI_PLUGIN_LIST
  jni
)

set(PLUGIN_BUNDLED_LIBRARIES)

foreach(plugin ${FLUTTER_PLUGIN_LIST})
  add_subdirectory(flutter/ephemeral/.plugin_symlinks/${plugin}/windows plugins/${plugin})
  target_link_libraries(${BINARY_NAME} PRIVATE ${plugin}_plugin)
  list(APPEND PLUGIN_BUNDLED_LIBRARIES $<TARGET_FILE:${plugin}_plugin>)
  list(APPEND PLUGIN_BUNDLED_LIBRARIES ${${plugin}_bundled_libraries})
endforeach(plugin)

foreach(ffi_plugin ${FLUTTER_FFI_PLUGIN_LIST})
  add_subdirectory(flutter/ephemeral/.plugin_symlinks/${ffi_plugin}/windows plugins/${ffi_plugin})
  list(APPEND PLUGIN_BUNDLED_LIBRARIES ${${ffi_plugin}_bundled_libraries})
endforeach(ffi_plugin)
