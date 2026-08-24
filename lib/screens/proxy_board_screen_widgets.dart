import 'dart:io';

import 'package:clashmi/app/clash/clash_config.dart';
import 'package:clashmi/app/clash/clash_http_api.dart';
import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/app/utils/platform_utils.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/widgets/sheet.dart';
import 'package:fast_cached_network_image/fast_cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProxyScreenProxiesNodeWidgetController {
  void Function()? onTesting;

  Future<void> Function()? delayTestFun;
  int Function()? delayTestingFun;
  ProxyScreenProxiesNodeWidgetController({required this.onTesting});
  Future<void> delayTest() async {
    if (delayTestFun != null) {
      return delayTestFun!.call();
    }
  }

  int delayTesting() {
    if (delayTestingFun != null) {
      return delayTestingFun!.call();
    }
    return 0;
  }
}

class ProxyScreenProxiesNodeWidget extends StatefulWidget {
  const ProxyScreenProxiesNodeWidget({
    super.key,
    required this.nodes,
    required this.controller,
  });
  final List<ClashProxiesNode> nodes;
  final ProxyScreenProxiesNodeWidgetController? controller;
  @override
  State<ProxyScreenProxiesNodeWidget> createState() =>
      _ProxyScreenProxiesNodeWidget();
}

class _ProxyScreenProxiesNodeWidget
    extends State<ProxyScreenProxiesNodeWidget> {
  late List<ClashProxiesNode> _nodes;
  final Set<String> _nodesTesting = {};

  @override
  void initState() {
    widget.controller?.delayTestFun = () async {
      return delayTest();
    };
    widget.controller?.delayTestingFun = () {
      return _nodesTesting.length;
    };
    _nodes = widget.nodes.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size windowSize = MediaQuery.of(context).size;
    double iconSize = 20;
    var widgets = [];
    for (var node in _nodes) {
      if (!ClashProtocolType.GroupToList().contains(node.type)) {
        continue;
      }
      if (node.hidden) {
        continue;
      }
      String subtitle = "";
      Color? color;
      if (node.delay != null && node.delay! > 0) {
        subtitle = "(${node.delay} ms)";
        if (node.delay! < 800) {
          color = ThemeDefine.kColorGreenBright;
        } else if (node.delay! < 1500) {
          color = Colors.black;
        } else {
          color = Colors.red;
        }
      }

      widgets.add(
        ListTile(
          title: node.icon.isNotEmpty
              ? Row(
                  children: [
                    FastCachedImage(
                      url: node.icon,
                      width: 16,
                      height: 16,
                      cacheWidth: 64,
                      cacheHeight: 64,
                      loadingBuilder: (context, loadingProgress) {
                        return SizedBox.shrink();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return SizedBox.shrink();
                      },
                    ),
                    SizedBox(width: 5),
                    Text(
                      node.name,
                      style: TextStyle(
                        fontFamily: Platform.isWindows ? 'Emoji' : null,
                      ),
                    ),
                  ],
                )
              : Text(
                  node.name,
                  style: TextStyle(
                    fontFamily: Platform.isWindows ? 'Emoji' : null,
                  ),
                ),
          subtitle: !_nodesTesting.contains(node.name)
              ? (node.delay == null
                    ? Text(node.type)
                    : Row(
                        children: [
                          Text(node.type),
                          SizedBox(width: 5),
                          Text(subtitle, style: TextStyle(color: color)),
                        ],
                      ))
              : Row(
                  children: [
                    Text(node.type),
                    SizedBox(width: 5),
                    SizedBox(
                      height: 16,
                      width: 16,
                      child: RepaintBoundary(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                ),
          trailing: SizedBox(
            width: windowSize.width * 0.4,
            child: Row(
              children: [
                SizedBox(
                  width: windowSize.width * 0.4 - iconSize,
                  child: Text(
                    node.now,
                    textAlign: TextAlign.right,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: Platform.isWindows ? 'Emoji' : null,
                    ),
                  ),
                ),
                Icon(Icons.keyboard_arrow_right, size: iconSize),
              ],
            ),
          ),
          minVerticalPadding: 10,
          onTap: () {
            showNodeSelect(node);
          },
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Scrollbar(
          child: ListView.separated(
            itemBuilder: (_, index) {
              return widgets[index];
            },
            separatorBuilder: (BuildContext context, int index) {
              return const Divider(height: 1, thickness: 0.3);
            },
            itemCount: widgets.length,
          ),
        ),
      ),
    );
  }

  void showNodeSelect(ClashProxiesNode selectNode) {
    Size windowSize = MediaQuery.of(context).size;
    var widgets = [];

    List<ClashProxiesNode> newNodes = [];
    for (var p in selectNode.all) {
      for (var n in _nodes) {
        if (n.name == p) {
          newNodes.add(n);
          break;
        }
      }
    }

    if (SettingManager.getConfig().ui.delayTestSort) {
      newNodes.sort((a, b) {
        if (a.delay == null || b.delay == null) {
          return 1;
        }

        return a.delay! - b.delay!;
      });
    }
    for (int i = 0; i < newNodes.length; ++i) {
      final node = newNodes[i];
      String subtitle = "";
      Color? color;
      if (node.delay != null && node.delay! > 0) {
        subtitle = "(${node.delay} ms)";
        if (node.delay! < 800) {
          color = ThemeDefine.kColorGreenBright;
        } else if (node.delay! < 1500) {
          color = Colors.black;
        } else {
          color = Colors.red;
        }
      } else if (node.delayErr != null && node.delayErr!.isNotEmpty) {
        subtitle = "(${node.delayErr})";
        color = Colors.red;
      }

      widgets.add(
        ListTile(
          title: node.icon.isNotEmpty
              ? Row(
                  children: [
                    Text("${i + 1}"),
                    SizedBox(width: 5),
                    FastCachedImage(
                      url: node.icon,
                      width: 16,
                      height: 16,
                      cacheWidth: 16,
                      cacheHeight: 16,
                      loadingBuilder: (context, loadingProgress) {
                        return SizedBox.shrink();
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return SizedBox.shrink();
                      },
                    ),
                    SizedBox(width: 5),
                    Text(
                      node.name,
                      style: TextStyle(
                        fontFamily: Platform.isWindows ? 'Emoji' : null,
                      ),
                    ),
                  ],
                )
              : Text(
                  "${i + 1} ${node.name}",
                  style: TextStyle(
                    fontFamily: Platform.isWindows ? 'Emoji' : null,
                  ),
                ),
          subtitle: subtitle.isEmpty
              ? Text(node.type)
              : Row(
                  children: [
                    Text(node.type),
                    SizedBox(width: 5),
                    Tooltip(
                      message: node.delayErr ?? "",
                      child: InkWell(
                        child: Text(subtitle, style: TextStyle(color: color)),
                        onTap: () async {
                          Navigator.of(context).pop();
                          delayTest(nodeName: node.name);
                          if (node.delayErr != null &&
                              node.delayErr!.isNotEmpty) {
                            try {
                              await Clipboard.setData(
                                ClipboardData(text: node.delayErr!),
                              );
                            } catch (e) {}
                          }
                        },
                      ),
                    ),
                  ],
                ),
          selected: selectNode.now == node.name,
          selectedColor: ThemeDefine.kColorBlue,
          onTap: () async {
            var error = await ClashHttpApi.setProxiesNode(
              selectNode.name,
              node.name,
            );
            if (!mounted) {
              return;
            }
            if (error != null) {
              DialogUtils.showAlertDialog(context, error.message);
              return;
            }

            selectNode.now = node.name;
            Navigator.of(context).pop();
            setState(() {});
          },
        ),
      );
    }
    showSheet(
      context: context,
      body: SizedBox(
        height: windowSize.height - 200,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Scrollbar(
            child: ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return widgets[index];
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(height: 1, thickness: 0.3);
              },
              itemCount: widgets.length,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> delayTest({String nodeName = ""}) async {
    final setting = SettingManager.getConfig();
    _nodesTesting.clear();
    for (var node in _nodes) {
      if (nodeName.isNotEmpty) {
        if (node.name == nodeName) {
          _nodesTesting.add(node.name);
        }
      } else {
        _nodesTesting.add(node.name);
      }
    }
    widget.controller?.onTesting?.call();

    var nextIndex = 0;
    Future<void> testNext() async {
      while (nextIndex < _nodes.length) {
        final node = _nodes[nextIndex++];
        if (nodeName.isNotEmpty) {
          if (node.name != nodeName) {
            continue;
          }
        }

        if (!ClashProtocolType.RuleToList().contains(node.type)) {
          final result = await ClashHttpApi.getDelay(
            node.name,
            url: setting.delayTestUrl,
            timeout: Duration(milliseconds: setting.delayTestTimeout),
          );

          node.delay = result.data;
          node.delayErr = result.error?.message;
        }

        _nodesTesting.remove(node.name);
        if (!mounted) {
          return;
        }

        widget.controller?.onTesting?.call();
      }
    }

    int maxConcurrentTests = PlatformUtils.isPC() ? 10 : 5;
    await Future.wait([
      for (var i = 0; i < maxConcurrentTests; ++i) testNext(),
    ]);
    widget.controller?.onTesting?.call();
  }
}
