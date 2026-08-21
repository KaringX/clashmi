// ignore_for_file: unused_catch_stack, empty_catches

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clashmi/app/clash/clash_config.dart' show ClashProtocolType;
import 'package:clashmi/app/utils/file_utils.dart';
import 'package:clashmi/app/utils/log.dart';
import 'package:clashmi/app/utils/path_utils.dart';
import 'package:path/path.dart' as path;

class RuleProviderHttp {
  RuleProviderHttp({
    this.url = "",
    this.format = "",
    this.behavior = "",
    this.interval = const Duration(hours: 12),
  });

  String url;
  String format;
  String behavior;
  Duration? interval;

  Map<String, dynamic> toJson() {
    late String path_;
    final uri = Uri.tryParse(url);
    if (uri != null && uri.path.isNotEmpty) {
      path_ = "./rules/${path.basename(uri.path)}";
    } else {
      path_ = "./rules/${url.hashCode}";
    }
    var ret = {
      'url': url,
      'format': format,
      'behavior': behavior,
      'path': path_,
      'interval': interval?.inSeconds,
    };

    return ret;
  }

  void fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }

    url = map['url'];
    format = map['format'] ?? '';
    behavior = map['behavior'] ?? '';

    int? intervalSeconds = map['interval'];
    if (!getFormats().contains(format)) {
      format = getFormats().first;
    }
    if (!getBehaviors().contains(behavior)) {
      behavior = getBehaviors().first;
    }

    if (intervalSeconds != null) {
      interval = Duration(seconds: intervalSeconds);
    }
    if (interval != null) {
      if (interval!.inMinutes < 10) {
        interval = Duration(hours: 12);
      }
    }
  }

  static RuleProviderHttp fromJsonStatic(Map<String, dynamic>? map) {
    RuleProviderHttp config = RuleProviderHttp();
    config.fromJson(map);
    return config;
  }

  static List<String> getFormats() {
    return ["mrs"];
  }

  static List<String> getBehaviors() {
    return ["domain", "ipcidr"];
  }
}

class RuleProvider {
  RuleProvider({this.name = "", this.type = "", this.http});
  String name = "";
  String type = "";
  RuleProviderHttp? http;

  Map<String, dynamic> toJsonNoName() => {
    'type': type,
    ...http?.toJson() ?? {},
  };
  Map<String, dynamic> toJson() => {
    'name': name,
    'type': type,
    ...http?.toJson() ?? {},
  };
  void fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }

    name = map['name'] ?? '';
    type = map['type'] ?? '';
    if (!getTypes().contains(type)) {
      type = getTypes().first;
    }
    http = RuleProviderHttp.fromJsonStatic(map);
  }

  RuleProvider clone() {
    return RuleProvider(
      name: name,
      type: type,
      http: http == null
          ? null
          : RuleProviderHttp(
              url: http!.url,
              format: http!.format,
              behavior: http!.behavior,
              interval: http!.interval,
            ),
    );
  }

  static List<String> getTypes() {
    return ["http"];
  }
}

class RuleTemplate {
  RuleTemplate({this.name = "", this.rules = const []});
  String name = "";
  List<String> rules = [];

  Map<String, dynamic> toJson() => {'name': name, 'rules': rules};
  void fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    name = map['name'] ?? '';
    rules = List<String>.from(map['rules'] ?? []);
  }

  Set<String> getProviders() {
    Set<String> providers = {};
    for (var rule in rules) {
      List<String> parts = parseRule(rule);
      if (parts[0] == "RULE-SET") {
        providers.add(parts[1]);
      }
    }
    return providers;
  }

  void reorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    if (oldIndex >= rules.length || newIndex >= rules.length) {
      return;
    }
    var item = rules.removeAt(oldIndex);
    rules.insert(newIndex, item);
  }

  RuleTemplate clone() {
    return RuleTemplate(name: name, rules: rules.toList());
  }

  static List<String> getTypes() {
    return [
      "RULE-SET",
      "GEOSITE",
      "GEOIP",
      "IP-ASN",
      "DOMAIN",
      "DOMAIN-SUFFIX",
      "DOMAIN-KEYWORD",
      "DOMAIN-REGEX",
      "IP-CIDR",
      "IP-CIDR6",
      "PROCESS-NAME",
      "PROCESS-NAME-REGEX",
      "AND",
      "OR",
      "NOT",
      "MATCH",
    ];
  }

  static bool needValue(String value) {
    final types = {
      "RULE-SET",
      "GEOSITE",
      "GEOIP",
      "IP-ASN",
      "DOMAIN",
      "DOMAIN-SUFFIX",
      "DOMAIN-KEYWORD",
      "DOMAIN-REGEX",
      "IP-CIDR",
      "IP-CIDR6",
      "PROCESS-NAME",
      "PROCESS-NAME-REGEX",
      "AND",
      "OR",
      "NOT",
    };
    return types.contains(value);
  }

  static bool supportNoResolve(String type) {
    final types = {"RULE-SET", "GEOIP", "IP-ASN", "IP-CIDR", "IP-CIDR6"};
    return types.contains(type);
  }

  static List<String> parseRule(String rule) {
    if (rule.isEmpty) {
      return [];
    }
    return rule.split(",");
  }
}

class ProxyGroupTemplate {
  ProxyGroupTemplate({
    this.name = "",
    this.icon = "",
    this.type = "",
    this.proxies = const [],
  });
  String name = "";
  String icon = "";
  String type = getTypes().first;
  List<String> proxies = [];
  //String proxyRegExps;

  Map<String, dynamic> toJson() => {
    'name': name,
    'icon': icon,
    'type': type,
    'proxies': proxies,
    // 'proxyRegExps': proxyRegExps,
  };
  void fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    name = map['name'] ?? '';
    icon = map['icon'] ?? '';
    type = map['type'] ?? '';
    proxies = List<String>.from(map['proxies'] ?? []);
    //proxyRegExps = List<String>.from(map['proxyRegExps'] ?? []);
    if (!ProxyGroupTemplate.getTypes().contains(type)) {
      type = ProxyGroupTemplate.getTypes().first;
    }
  }

  ProxyGroupTemplate clone() {
    return ProxyGroupTemplate(
      name: name,
      icon: icon,
      type: type,
      proxies: proxies.toList(),
      //proxyRegExps: proxyRegExps.toList(),
    );
  }

  static List<String> getTypes() {
    return ["select", "url-test", "load-balance", "fallback"];
  }

  static String toClashProtocolTypeString(String type) {
    switch (type) {
      case "url-test":
        return ClashProtocolType.urltest.name;
      case "select":
        return ClashProtocolType.selector.name;
      case "load-balance":
        return ClashProtocolType.loadBalance.name;
      case "fallback":
        return ClashProtocolType.fallback.name;
    }
    return "";
  }
}

class DiversionTemplates {
  List<RuleProvider> ruleProviders = [];
  List<RuleTemplate> ruleTemplates = [];
  List<ProxyGroupTemplate> proxyGroupTemplates = [];

  Map<String, dynamic> toJson() => {
    'rule-providers': ruleProviders,
    'rule-templates': ruleTemplates,
    'proxygroup-templates': proxyGroupTemplates,
  };

  void fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }

    final p = map['rule-providers'];
    if (p is List) {
      for (var value in p) {
        RuleProvider ps = RuleProvider();
        ps.fromJson(value);
        ruleProviders.add(ps);
      }
    }
    final t = map['rule-templates'];
    if (t is List) {
      for (var value in t) {
        RuleTemplate rt = RuleTemplate();
        rt.fromJson(value);
        ruleTemplates.add(rt);
      }
    }
    final g = map['proxygroup-templates'];
    if (g is List) {
      for (var value in g) {
        ProxyGroupTemplate rt = ProxyGroupTemplate();
        rt.fromJson(value);
        proxyGroupTemplates.add(rt);
      }
    }
  }
}

class DiversionTemplateManager {
  static final DiversionTemplates _diversionTemplates = DiversionTemplates();

  static final List<void Function(String)> onEventRuleProviderAdd = [];
  static final List<void Function(String)> onEventRuleProviderRemove = [];
  static final List<void Function(String)> onEventRuleTemplateAdd = [];
  static final List<void Function(String)> onEventRuleTemplateRemove = [];
  static final List<void Function(String)> onEventProxyGroupAdd = [];
  static final List<void Function(String)> onEventProxyGroupRemove = [];
  static final FileSaver _fileSaver = FileSaver();

  static Future<void> init() async {
    _fileSaver.setSavePath(await PathUtils.diversionTemplateConfigFilePath());
    await load();
  }

  static Future<void> uninit() async {}
  static Future<void> reload() async {
    _diversionTemplates.ruleProviders.clear();
    _diversionTemplates.ruleTemplates.clear();
    _diversionTemplates.proxyGroupTemplates.clear();
    await load();
  }

  static Future<void> save() async {
    await _fileSaver.saveAsJson(_diversionTemplates);
  }

  static Future<void> load() async {
    String filePath = await PathUtils.diversionTemplateConfigFilePath();
    var file = File(filePath);
    bool exists = await file.exists();
    if (exists) {
      try {
        String content = await file.readAsString();
        if (content.isNotEmpty) {
          var config = jsonDecode(content);
          _diversionTemplates.fromJson(config);
        }
      } catch (err, stacktrace) {
        Log.w("DiversionTemplateManager.load exception ${err.toString()} ");
      }
    } else {
      await save();
    }
  }

  static void removeRuleProviderByName(String name) async {
    for (int i = 0; i < _diversionTemplates.ruleProviders.length; ++i) {
      if (name == _diversionTemplates.ruleProviders[i].name) {
        _diversionTemplates.ruleProviders.removeAt(i);
        break;
      }
    }

    for (var event in onEventRuleProviderRemove) {
      event(name);
    }

    await save();
  }

  static void removeRuleTemplateByName(String name) async {
    for (int i = 0; i < _diversionTemplates.ruleTemplates.length; ++i) {
      if (name == _diversionTemplates.ruleTemplates[i].name) {
        _diversionTemplates.ruleTemplates.removeAt(i);
        break;
      }
    }

    for (var event in onEventRuleTemplateRemove) {
      event(name);
    }

    await save();
  }

  static void removeProxyGroupTemplateByName(String name) async {
    for (int i = 0; i < _diversionTemplates.proxyGroupTemplates.length; ++i) {
      if (name == _diversionTemplates.proxyGroupTemplates[i].name) {
        _diversionTemplates.proxyGroupTemplates.removeAt(i);
        break;
      }
    }

    for (var event in onEventProxyGroupRemove) {
      event(name);
    }

    await save();
  }

  static RuleProvider? getRuleProviderByName(String name) {
    for (var provider in _diversionTemplates.ruleProviders) {
      if (provider.name == name) {
        return provider;
      }
    }
    return null;
  }

  static RuleTemplate? getRuleTemplateByName(String name) {
    for (var template in _diversionTemplates.ruleTemplates) {
      if (template.name == name) {
        return template;
      }
    }
    return null;
  }

  static ProxyGroupTemplate? getProxyGroupTemplateByName(String name) {
    for (var template in _diversionTemplates.proxyGroupTemplates) {
      if (template.name == name) {
        return template;
      }
    }
    return null;
  }

  static List<RuleProvider> getRuleProviders() {
    return _diversionTemplates.ruleProviders;
  }

  static List<RuleTemplate> getRuleTemplates() {
    return _diversionTemplates.ruleTemplates;
  }

  static List<ProxyGroupTemplate> getProxyGroupTemplates() {
    return _diversionTemplates.proxyGroupTemplates;
  }

  static Set<String> getRuleProvidersNames() {
    return _diversionTemplates.ruleProviders
        .map((element) => element.name)
        .toSet();
  }

  static Set<String> getRuleTemplatesNames() {
    return _diversionTemplates.ruleTemplates
        .map((element) => element.name)
        .toSet();
  }

  static Set<String> getProxyGroupTemplatesNames() {
    return _diversionTemplates.proxyGroupTemplates
        .map((element) => element.name)
        .toSet();
  }

  static void addRuleProvider(RuleProvider provider) {
    _diversionTemplates.ruleProviders.add(provider);
  }

  static void addRuleTemplate(RuleTemplate template) {
    _diversionTemplates.ruleTemplates.add(template);
  }

  static void addProxyGroupTemplate(ProxyGroupTemplate template) {
    _diversionTemplates.proxyGroupTemplates.add(template);
  }

  static void updateRuleProvider(String name, RuleProvider provider) {
    for (int i = 0; i < _diversionTemplates.ruleProviders.length; ++i) {
      if (name == _diversionTemplates.ruleProviders[i].name) {
        _diversionTemplates.ruleProviders[i] = provider;
        break;
      }
    }
  }

  static void updateRuleTemplate(String name, RuleTemplate template) {
    for (int i = 0; i < _diversionTemplates.ruleTemplates.length; ++i) {
      if (name == _diversionTemplates.ruleTemplates[i].name) {
        _diversionTemplates.ruleTemplates[i] = template;
        break;
      }
    }
  }

  static void updateProxyGroupTemplate(
    String name,
    ProxyGroupTemplate template,
  ) {
    for (int i = 0; i < _diversionTemplates.proxyGroupTemplates.length; ++i) {
      if (name == _diversionTemplates.proxyGroupTemplates[i].name) {
        _diversionTemplates.proxyGroupTemplates[i] = template;
        break;
      }
    }
  }

  static void reorderRuleProvider(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    if (oldIndex >= _diversionTemplates.ruleProviders.length ||
        newIndex >= _diversionTemplates.ruleProviders.length) {
      return;
    }
    var item = _diversionTemplates.ruleProviders.removeAt(oldIndex);
    _diversionTemplates.ruleProviders.insert(newIndex, item);
  }

  static void reorderRuleTemplates(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    if (oldIndex >= _diversionTemplates.ruleTemplates.length ||
        newIndex >= _diversionTemplates.ruleTemplates.length) {
      return;
    }
    var item = _diversionTemplates.ruleTemplates.removeAt(oldIndex);
    _diversionTemplates.ruleTemplates.insert(newIndex, item);
  }

  static void reorderProxyGroupTemplates(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    if (oldIndex >= _diversionTemplates.proxyGroupTemplates.length ||
        newIndex >= _diversionTemplates.proxyGroupTemplates.length) {
      return;
    }
    var item = _diversionTemplates.proxyGroupTemplates.removeAt(oldIndex);
    _diversionTemplates.proxyGroupTemplates.insert(newIndex, item);
  }
}
