// ignore_for_file: unused_catch_stack

import 'dart:async';
import 'dart:io';

import 'package:after_layout/after_layout.dart';
import 'package:clashmi/app/clash/clash_http_api.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/dialog_utils.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:clashmi/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';

class ProxyGroupScreenScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return const RouteSettings(name: "ProxyGroupScreenScreen");
  }

  final String name;
  final List<String> proxies;
  final List<ClashProxiesNode> nodes;
  const ProxyGroupScreenScreen({
    super.key,
    required this.name,
    required this.proxies,
    required this.nodes,
  });

  @override
  State<ProxyGroupScreenScreen> createState() => _ProxyGroupScreenScreenState();
}

class _ProxyGroupScreenScreenState
    extends LasyRenderingState<ProxyGroupScreenScreen>
    with AfterLayoutMixin {
  final _searchController = TextEditingController();
  List<ClashProxiesNode> _searchedData = [];
  final List<String> _checked = [];
  List<String> _notExist = [];
  @override
  void initState() {
    Set<String> nodeNames = {};
    for (var node in widget.nodes) {
      nodeNames.add(node.name);
    }

    for (var proxy in widget.proxies) {
      if (nodeNames.contains(proxy)) {
        _checked.add(proxy);
      } else {
        _notExist.add(proxy);
      }
    }
    _loadSearch(null);
    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) async {
    final tcontext = Translations.of(context);
    if (_notExist.isNotEmpty) {
      bool tooMuch = _notExist.length > 5;
      if (tooMuch) {
        _notExist = _notExist.sublist(0, 5);
      }
      String err = "\n[${_notExist.join("\n")}${tooMuch ? "\n..." : ""}]";
      DialogUtils.showAlertDialog(
        context,
        tcontext.meta.proxyNodeFailure(p: err),
        showCopy: true,
        showFAQ: true,
        withVersion: true,
      );
    }
    _notExist.clear();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _loadSearch(String? textVal) {
    if ((textVal != null) && textVal.isNotEmpty) {
      String search = textVal.toLowerCase();
      final data = widget.nodes.where((app) {
        String name = app.name.toLowerCase();
        return name.contains(search);
      }).toList();
      _searchedData = data;
      setState(() {});
    } else {
      _searchedData = widget.nodes;
      setState(() {});
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _searchedData = widget.nodes;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final tcontext = Translations.of(context);
    Size windowSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(preferredSize: Size.zero, child: AppBar()),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.pop(context, _checked),
                      child: const SizedBox(
                        width: 50,
                        height: 30,
                        child: Icon(Icons.arrow_back_ios_outlined, size: 26),
                      ),
                    ),
                    SizedBox(
                      width: windowSize.width - 50 * 2,
                      child: Text(
                        tcontext.meta.proxyNodeList,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: ThemeConfig.kFontWeightTitle,
                          fontSize: ThemeConfig.kFontSizeTitle,
                        ),
                      ),
                    ),
                    const SizedBox(width: 50, height: 30),
                  ],
                ),
              ),
              const SizedBox(height: 10),

              Container(
                margin: const EdgeInsets.only(top: 10),
                padding: const EdgeInsets.only(left: 15, right: 15),
                height: 44,
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: ThemeDefine.kBorderRadius,
                ),
                child: TextFieldEx(
                  controller: _searchController,
                  textInputAction: TextInputAction.done,
                  onChanged: _loadSearch,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    icon: Icon(Icons.search_outlined),
                    hintText: tcontext.meta.search,
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_outlined),
                            onPressed: _clearSearch,
                          )
                        : null,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(child: _loadListView()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loadListView() {
    Size windowSize = MediaQuery.of(context).size;
    return ListView.separated(
      itemCount: _searchedData.length,
      itemBuilder: (BuildContext context, int index) {
        ClashProxiesNode current = _searchedData[index];
        return createWidget(current, index, windowSize);
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 1, thickness: 0.3);
      },
    );
  }

  Widget createWidget(ClashProxiesNode current, int index, Size windowSize) {
    String subtitle = "";
    Color? color;
    if (current.delay != null && current.delay! > 0) {
      subtitle = " (${current.delay} ms)";
      if (current.delay! < 800) {
        color = ThemeDefine.kColorGreenBright;
      } else if (current.delay! < 1500) {
        color = Colors.black;
      } else {
        color = Colors.red;
      }
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Material(
        borderRadius: ThemeDefine.kBorderRadius,
        child: InkWell(
          onTap: () {
            bool value = _checked.contains(current.name);
            if (value != true) {
              _checked.add(current.name);
            } else {
              _checked.remove(current.name);
            }

            setState(() {});
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: 66,
            child: Row(
              children: [
                Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 40,
                              child: Text(
                                (index + 1).toString(),
                                style: TextStyle(
                                  fontSize: ThemeConfig.kFontSizeGroupItem,
                                ),
                              ),
                            ),

                            SizedBox(
                              width: windowSize.width - 120,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    current.name,
                                    style: TextStyle(
                                      fontSize: ThemeConfig.kFontSizeGroupItem,
                                      fontFamily: Platform.isWindows
                                          ? 'Emoji'
                                          : null,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        current.type,
                                        style: TextStyle(
                                          fontSize:
                                              ThemeConfig.kFontSizeGroupItem,
                                        ),
                                      ),
                                      Text(
                                        subtitle,
                                        style: TextStyle(
                                          fontSize:
                                              ThemeConfig.kFontSizeGroupItem,
                                          color: color,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Checkbox(
                              tristate: true,
                              value: _checked.contains(current.name),
                              onChanged: (bool? value) {
                                bool value1 = _checked.contains(current.name);
                                if (value1 != true) {
                                  _checked.add(current.name);
                                } else {
                                  _checked.remove(current.name);
                                }

                                setState(() {});
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
