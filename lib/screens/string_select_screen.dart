import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/theme_define.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:clashmi/screens/widgets/text_field.dart';
import 'package:flutter/material.dart';

class StringSelectScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routeSettings() {
    return const RouteSettings(name: "StringSelectScreen");
  }

  final String current;
  final List<String> data;
  const StringSelectScreen({
    super.key,
    required this.current,
    required this.data,
  });

  @override
  State<StringSelectScreen> createState() => _StringSelectScreenState();
}

class _StringSelectScreenState extends LasyRenderingState<StringSelectScreen> {
  final List<String> _data = [];
  List<String> _searchedData = [];

  final _searchController = TextEditingController();

  @override
  void initState() {
    _data.addAll(widget.data);
    _searchedData = _data;
    super.initState();
  }

  void _loadSearch(String? textVal) {
    if ((textVal != null) && textVal.isNotEmpty) {
      final data = _data.where((item) {
        return item.toLowerCase().contains(textVal.toLowerCase());
      }).toList();
      _searchedData = data;
      setState(() {});
    } else {
      _searchedData = _data;
      setState(() {});
    }
  }

  void _clearSearch() {
    _searchController.clear();
    _searchedData = _data;
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
    SettingManager.save();
  }

  @override
  Widget build(BuildContext context) {
    final tcontext = Translations.of(context);
    Size windowSize = MediaQuery.of(context).size;

    return PopScope(
      canPop: true,
      child: Scaffold(
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
                        onTap: () => Navigator.pop(context),
                        child: const SizedBox(
                          width: 50,
                          height: 30,
                          child: Icon(Icons.arrow_back_ios_outlined, size: 26),
                        ),
                      ),
                      SizedBox(
                        width: windowSize.width - 50 - 65,
                        child: Text(
                          tcontext.meta.language,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontWeight: ThemeConfig.kFontWeightTitle,
                            fontSize: ThemeConfig.kFontSizeTitle,
                          ),
                        ),
                      ),
                      const SizedBox(width: 50),
                    ],
                  ),
                ),
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
                      focusedBorder: InputBorder.none,
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
      ),
    );
  }

  Widget _loadListView() {
    return Scrollbar(
      thumbVisibility: true,
      child: ListView.separated(
        itemCount: _searchedData.length,
        itemBuilder: (BuildContext context, int index) {
          var current = _searchedData[index];
          return createWidget(current);
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(height: 1, thickness: 0.3);
        },
      ),
    );
  }

  Widget createWidget(String current) {
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      child: Material(
        color: LocaleSettings.currentLocale == current
            ? ThemeDefine.kColorBlue
            : null,
        borderRadius: ThemeDefine.kBorderRadius,
        child: InkWell(
          onTap: () {
            onTapItem(current);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            width: double.infinity,
            height: ThemeConfig.kListItemHeight2,
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
                            Text(
                              current,
                              style: TextStyle(
                                fontSize: ThemeConfig.kFontSizeGroupItem,
                              ),
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

  Future<void> onTapItem(String current) async {
    Navigator.pop(context, current);
  }
}
