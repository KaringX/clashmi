// ignore_for_file: non_constant_identifier_names
// https://github.com/MetaCubeX/mihomo/blob/Alpha/docs/config.yaml
import 'dart:io';

import 'package:clashmi/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:tuple/tuple.dart';
part 'clash_config.g.dart';

class MapHelper {
  static Map<String, dynamic> removeNullOrEmpty(
    Map<String, dynamic> object,
    bool removeOverWriteField,
    bool removeNotOverWrite,
  ) {
    Set<String> toRemove = {};
    object.forEach((key, value) {
      if (value == null) {
        toRemove.add(key);
      }

      if (key == "overwrite") {
        if (removeOverWriteField) {
          toRemove.add(key);
        }
        if (removeNotOverWrite) {
          if (value != true) {
            toRemove.add(key);
          }
        }
      } else if (key.startsWith("overwrite-")) {
        toRemove.add(key);
        if (value != true) {
          String originalKey = key.substring("overwrite-".length);
          toRemove.add(originalKey);
        }
      }

      if (value is Map<String, dynamic>) {
        if (value["overwrite"] == false && removeNotOverWrite) {
          value = {};
        } else {
          removeNullOrEmpty(value, removeOverWriteField, removeNotOverWrite);
        }

        if (value.isEmpty) {
          toRemove.add(key);
        }
      }
    });
    for (var item in toRemove) {
      object.remove(item);
    }
    return object;
  }
}

class BoolToTuple {
  static List<Tuple2<String?, String>> toTupleList(BuildContext context) {
    final tcontext = Translations.of(context);
    return [
      Tuple2(null, tcontext.meta.noOverwrite),
      Tuple2("true", tcontext.meta.enable),
      Tuple2("false", tcontext.meta.disable),
    ];
  }

  static String getSelectedString(BuildContext context, bool? key) {
    final list = toTupleList(context);
    for (var item in list) {
      if (item.item1?.toString() == key?.toString()) {
        return item.item2;
      }
    }
    return list[0].item2;
  }

  static bool? getSelectedKey(BuildContext context, String? selected) {
    final list = toTupleList(context);
    for (var item in list) {
      if (item.item1.toString() == selected?.toString()) {
        return item.item1 == null ? null : bool.tryParse(item.item1!);
      }
    }
    return list[0].item1 == null ? null : bool.tryParse(list[0].item1!);
  }
}

enum ClashConfigsMode {
  rule(name: "rule"),
  global(name: "global"),
  direct(name: "direct");

  const ClashConfigsMode({required this.name});
  final String name;
}

enum ClashProtocolType {
  urltest(name: "URLTest"),
  selector(name: "Selector"),
  loadBalance(name: "LoadBalance"),
  fallback(name: "Fallback"),
  relay(name: "Relay"),
  direct(name: "Direct"),
  compatible(name: "Compatible"),
  pass(name: "Pass"),
  passRule(name: "PassRule"),
  reject(name: "Reject"),
  rejectDrop(name: "RejectDrop"),
  dns(name: "Dns");

  const ClashProtocolType({required this.name});
  final String name;

  static List<String> toList() {
    return [
      ClashProtocolType.urltest.name,
      ClashProtocolType.selector.name,
      ClashProtocolType.loadBalance.name,
      ClashProtocolType.fallback.name,
      ClashProtocolType.relay.name,
      ClashProtocolType.direct.name,
      ClashProtocolType.compatible.name,
      ClashProtocolType.pass.name,
      ClashProtocolType.passRule.name,
      ClashProtocolType.reject.name,
      ClashProtocolType.rejectDrop.name,
    ];
  }

  static List<String> RuleToList() {
    return [
      ClashProtocolType.compatible.name,
      ClashProtocolType.pass.name,
      ClashProtocolType.passRule.name,
      ClashProtocolType.reject.name,
      ClashProtocolType.rejectDrop.name,
    ];
  }

  static List<String> GroupToList() {
    return [
      ClashProtocolType.urltest.name,
      ClashProtocolType.selector.name,
      ClashProtocolType.loadBalance.name,
      ClashProtocolType.fallback.name,
      ClashProtocolType.relay.name,
    ];
  }
}

enum ClashDnsEnhancedMode {
  fakeIp(name: "fake-ip"),
  redirHost(name: "redir-host"),
  normal(name: "normal");

  const ClashDnsEnhancedMode({required this.name});
  final String name;

  static List<String> toList() {
    return [
      ClashDnsEnhancedMode.fakeIp.name,
      ClashDnsEnhancedMode.redirHost.name,
      ClashDnsEnhancedMode.normal.name,
    ];
  }

  static List<Tuple2<String?, String>> toTupleList() {
    return [
      Tuple2(
        ClashDnsEnhancedMode.fakeIp.name,
        ClashDnsEnhancedMode.fakeIp.name,
      ),
      Tuple2(
        ClashDnsEnhancedMode.redirHost.name,
        ClashDnsEnhancedMode.redirHost.name,
      ),
      Tuple2(ClashDnsEnhancedMode.normal.name, "normal"),
    ];
  }
}

enum ClashDnsCacheAlgorithm {
  lru(name: "lru"),
  arc(name: "arc");

  const ClashDnsCacheAlgorithm({required this.name});
  final String name;

  static List<String> toList() {
    return [ClashDnsCacheAlgorithm.lru.name, ClashDnsCacheAlgorithm.arc.name];
  }
}

enum ClashFakeIPFilterMode {
  blacklist(name: "blacklist"),
  whitelist(name: "whitelist"),
  rule(name: "rule");

  const ClashFakeIPFilterMode({required this.name});
  final String name;

  static List<String> toList() {
    return [
      ClashFakeIPFilterMode.blacklist.name,
      ClashFakeIPFilterMode.whitelist.name,
      ClashFakeIPFilterMode.rule.name,
    ];
  }
}

enum ClashLogLevel {
  debug(name: "debug"),
  info(name: "info"),
  warning(name: "warning"),
  error(name: "error"),
  silent(name: "silent");

  const ClashLogLevel({required this.name});
  final String name;

  static List<String> toList() {
    return [
      ClashLogLevel.debug.name,
      ClashLogLevel.info.name,
      ClashLogLevel.warning.name,
      ClashLogLevel.error.name,
      ClashLogLevel.silent.name,
    ];
  }
}

enum ClashGlobalClientFingerprint {
  noOverwrite(name: null),
  none(name: "none"),
  random(name: "random"),
  chrome(name: "chrome"),
  firefox(name: "firefox"),
  safari(name: "safari"),
  ios(name: "ios");

  const ClashGlobalClientFingerprint({required this.name});
  final String? name;

  static List<String?> toList() {
    return [
      ClashGlobalClientFingerprint.noOverwrite.name,
      ClashGlobalClientFingerprint.none.name,
      ClashGlobalClientFingerprint.random.name,
      ClashGlobalClientFingerprint.chrome.name,
      ClashGlobalClientFingerprint.firefox.name,
      ClashGlobalClientFingerprint.safari.name,
      ClashGlobalClientFingerprint.ios.name,
    ];
  }

  static List<Tuple2<String?, String>> toTupleList(BuildContext context) {
    final tcontext = Translations.of(context);
    return [
      Tuple2(
        ClashGlobalClientFingerprint.noOverwrite.name,
        tcontext.meta.noOverwrite,
      ),
      Tuple2(
        ClashGlobalClientFingerprint.none.name,
        ClashGlobalClientFingerprint.none.name!,
      ),
      Tuple2(
        ClashGlobalClientFingerprint.random.name,
        ClashGlobalClientFingerprint.random.name!,
      ),
      Tuple2(
        ClashGlobalClientFingerprint.chrome.name,
        ClashGlobalClientFingerprint.chrome.name!,
      ),
      Tuple2(
        ClashGlobalClientFingerprint.firefox.name,
        ClashGlobalClientFingerprint.firefox.name!,
      ),
      Tuple2(
        ClashGlobalClientFingerprint.safari.name,
        ClashGlobalClientFingerprint.safari.name!,
      ),
      Tuple2(
        ClashGlobalClientFingerprint.ios.name,
        ClashGlobalClientFingerprint.ios.name!,
      ),
    ];
  }
}

enum ClashTunStack {
  mixed(name: "mixed"),
  gvisor(name: "gvisor"),
  system(name: "system");

  const ClashTunStack({required this.name});
  final String name;
  static List<String> toList() {
    if (Platform.isIOS || Platform.isMacOS) {
      return [ClashTunStack.gvisor.name];
    }
    return [
      ClashTunStack.gvisor.name,
      ClashTunStack.mixed.name,
      ClashTunStack.system.name,
    ];
  }
}

enum ClashFindProcessMode {
  always(name: "always"),
  strict(name: "strict"),
  off(name: "off");

  const ClashFindProcessMode({required this.name});
  final String name;
  static List<String> toList() {
    return [
      ClashFindProcessMode.always.name,
      ClashFindProcessMode.strict.name,
      ClashFindProcessMode.off.name,
    ];
  }
}

///Extension
@JsonSerializable(explicitToJson: true)
class RawExtensionTunHttpProxy {
  @JsonKey(name: 'enable')
  bool? Enable;
  @JsonKey(name: 'server')
  String? Server;
  @JsonKey(name: 'server_port')
  int? ServerPort;
  @JsonKey(name: 'bypass_domain')
  List<String>? BypassDomain;
  @JsonKey(name: 'match_domain')
  List<String>? MatchDomain;
  @JsonKey(name: 'allow_bypass')
  bool? AllowBypass;

  RawExtensionTunHttpProxy.by({
    this.Enable,
    this.Server,
    this.ServerPort,
    this.BypassDomain,
    this.MatchDomain,
    this.AllowBypass,
  });
  RawExtensionTunHttpProxy(
    this.Enable,
    this.Server,
    this.ServerPort,
    this.BypassDomain,
    this.MatchDomain,
    this.AllowBypass,
  );
  factory RawExtensionTunHttpProxy.fromJson(Map<String, dynamic> json) =>
      _$RawExtensionTunHttpProxyFromJson(json);
  Map<String, dynamic> toJson() => _$RawExtensionTunHttpProxyToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawExtensionTunPerApp {
  @JsonKey(name: 'enable')
  bool? Enable;
  @JsonKey(name: 'white_list')
  bool? WhiteList;
  @JsonKey(name: 'package_ids')
  List<String>? PackageIds;

  RawExtensionTunPerApp.by({this.Enable, this.WhiteList, this.PackageIds});
  RawExtensionTunPerApp(this.Enable, this.WhiteList, this.PackageIds);
  factory RawExtensionTunPerApp.fromJson(Map<String, dynamic> json) =>
      _$RawExtensionTunPerAppFromJson(json);
  Map<String, dynamic> toJson() => _$RawExtensionTunPerAppToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawExtensionGeoRuleset {
  @JsonKey(name: 'geosite_url')
  String? GeoSiteUrl;
  @JsonKey(name: 'geoip_url')
  String? GeoIpUrl;
  @JsonKey(name: 'asn_url')
  String? AsnUrl;
  @JsonKey(name: 'update-interval')
  int? UpdateInterval;
  @JsonKey(name: 'enable-proxy')
  bool? EnableProxy;

  RawExtensionGeoRuleset.by({
    this.GeoSiteUrl,
    this.GeoIpUrl,
    this.AsnUrl,
    this.UpdateInterval,
    this.EnableProxy,
  });
  RawExtensionGeoRuleset(
    this.GeoSiteUrl,
    this.GeoIpUrl,
    this.AsnUrl,
    this.UpdateInterval,
    this.EnableProxy,
  );
  factory RawExtensionGeoRuleset.fromJson(Map<String, dynamic> json) =>
      _$RawExtensionGeoRulesetFromJson(json);
  Map<String, dynamic> toJson() => _$RawExtensionGeoRulesetToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawExtensionTun {
  @JsonKey(name: 'http_proxy')
  RawExtensionTunHttpProxy httpProxy;
  @JsonKey(name: 'per_app')
  RawExtensionTunPerApp perApp;
  @JsonKey(name: 'include_all_networks')
  bool? includeAllNetworks;
  @JsonKey(name: 'exclude_local_networks')
  bool? excludeLocalNetworks;
  @JsonKey(name: 'exclude_cellular_services')
  bool? excludeCellularServices;
  @JsonKey(name: 'exclude_apns')
  bool? excludeApns;
  @JsonKey(name: 'exclude_device_communication')
  bool? excludeDeviceCommunication;
  @JsonKey(name: 'enforce_routes')
  bool? enforceRoutes;
  @JsonKey(name: 'auto_route_use_sub_ranges_by_default')
  bool? autoRouteUseSubRangesByDefault;

  RawExtensionTun.by({
    required this.httpProxy,
    required this.perApp,
    this.includeAllNetworks,
    this.excludeLocalNetworks,
    this.excludeCellularServices,
    this.excludeApns,
    this.excludeDeviceCommunication,
    this.enforceRoutes,
    this.autoRouteUseSubRangesByDefault,
  });
  RawExtensionTun(
    this.httpProxy,
    this.perApp,
    this.autoRouteUseSubRangesByDefault,
  );
  factory RawExtensionTun.fromJson(Map<String, dynamic> json) =>
      _$RawExtensionTunFromJson(json);
  Map<String, dynamic> toJson() => _$RawExtensionTunToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawExtension {
  @JsonKey(name: 'append_rules')
  List<String>? AppendRules;
  @JsonKey(name: 'geo-rule-set')
  RawExtensionGeoRuleset Ruleset;
  @JsonKey(name: 'profile-store-selected-prefix')
  String? ProfileStoreSelectedPrefix;
  @JsonKey(name: 'tun')
  RawExtensionTun Tun;
  @JsonKey(name: 'pprof-addr')
  String? PprofAddr;
  @JsonKey(name: 'proxy-group-replace')
  String? ProxyGroupReplace;
  @JsonKey(name: 'runtime-profile-save-path')
  String? RuntimeProfileSavePath;
  RawExtension.by({
    this.AppendRules,
    required this.Ruleset,
    required this.Tun,
    this.PprofAddr,
    this.ProxyGroupReplace,
    this.RuntimeProfileSavePath,
  });
  RawExtension(
    this.AppendRules,
    this.Ruleset,
    this.Tun,
    this.PprofAddr,
    this.ProxyGroupReplace,
    this.RuntimeProfileSavePath,
  );
  factory RawExtension.fromJson(Map<String, dynamic> json) =>
      _$RawExtensionFromJson(json);
  Map<String, dynamic> toJson() => _$RawExtensionToJson(this);
}

///
@JsonSerializable(explicitToJson: true)
class RawTunnel {
  @JsonKey(name: 'overwrite')
  bool? OverWrite;
  @JsonKey(name: 'network')
  List<String>? Network;
  @JsonKey(name: 'address')
  String? Address;
  @JsonKey(name: 'target')
  String? Target;
  @JsonKey(name: 'proxy')
  String? Proxy;

  RawTunnel.by({
    this.OverWrite,
    this.Network,
    this.Address,
    this.Target,
    this.Proxy,
  });
  RawTunnel(
    this.OverWrite,
    this.Network,
    this.Address,
    this.Target,
    this.Proxy,
  );
  factory RawTunnel.fromJson(Map<String, dynamic> json) =>
      _$RawTunnelFromJson(json);
  Map<String, dynamic> toJson() => _$RawTunnelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawCors {
  @JsonKey(name: 'overwrite')
  bool? OverWrite;
  @JsonKey(name: 'allow-origins')
  List<String>? AllowOrigins;
  @JsonKey(name: 'allow-private-network')
  bool? AllowPrivateNetwork;

  RawCors.by({this.OverWrite, this.AllowOrigins, this.AllowPrivateNetwork});
  RawCors(this.OverWrite, this.AllowOrigins, this.AllowPrivateNetwork);
  factory RawCors.fromJson(Map<String, dynamic> json) =>
      _$RawCorsFromJson(json);
  Map<String, dynamic> toJson() => _$RawCorsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawDNS {
  @JsonKey(name: 'overwrite')
  bool? OverWrite;
  @JsonKey(name: 'enable')
  bool? Enable;
  @JsonKey(name: 'prefer-h3')
  bool? PreferH3;
  @JsonKey(name: 'ipv6')
  bool? IPv6;
  @JsonKey(name: 'ipv6-timeout')
  int? IPv6Timeout;
  @JsonKey(name: 'use-hosts')
  bool? UseHosts;
  @JsonKey(name: 'use-system-hosts')
  bool? UseSystemHosts;
  @JsonKey(name: 'respect-rules')
  bool? RespectRules;
  @JsonKey(name: 'nameserver')
  List<String>? NameServer;
  @JsonKey(name: 'fallback')
  List<String>? Fallback;
  @JsonKey(name: 'fallback-filter')
  RawFallbackFilter? FallbackFilter;
  @JsonKey(name: 'listen')
  String? Listen;
  @JsonKey(name: 'enhanced-mode')
  String? EnhancedMode;
  @JsonKey(name: 'fake-ip-range')
  String? FakeIPRange;
  @JsonKey(name: 'fake-ip-filter')
  List<String>? FakeIPFilter;
  @JsonKey(name: 'fake-ip-filter-mode')
  String? FakeIPFilterMode;
  @JsonKey(name: 'default-nameserver')
  List<String>? DefaultNameserver;
  @JsonKey(name: 'cache-algorithm')
  String? CacheAlgorithm;
  @JsonKey(name: 'overwrite-nameserver-policy')
  bool? OverwriteNameServerPolicy;
  @JsonKey(name: 'nameserver-policy')
  Map<String, dynamic>? NameServerPolicy;
  @JsonKey(name: 'proxy-server-nameserver')
  List<String>? ProxyServerNameserver;
  @JsonKey(name: 'direct-nameserver')
  List<String>? DirectNameServer;
  @JsonKey(name: 'direct-nameserver-follow-policy')
  bool? DirectNameServerFollowPolicy;

  RawDNS.by({
    this.OverWrite,
    this.Enable,
    this.PreferH3,
    this.IPv6,
    this.IPv6Timeout,
    this.UseHosts,
    this.UseSystemHosts,
    this.RespectRules,
    this.NameServer,
    this.Fallback,
    this.FallbackFilter,
    this.Listen,
    this.EnhancedMode,
    this.FakeIPRange,
    this.FakeIPFilter,
    this.FakeIPFilterMode,
    this.DefaultNameserver,
    this.CacheAlgorithm,
    this.NameServerPolicy,
    this.ProxyServerNameserver,
    this.DirectNameServer,
    this.DirectNameServerFollowPolicy,
  });
  RawDNS(
    this.OverWrite,
    this.Enable,
    this.PreferH3,
    this.IPv6,
    this.IPv6Timeout,
    this.UseHosts,
    this.UseSystemHosts,
    this.RespectRules,
    this.NameServer,
    this.Fallback,
    this.FallbackFilter,
    this.Listen,
    this.EnhancedMode,
    this.FakeIPRange,
    this.FakeIPFilter,
    this.FakeIPFilterMode,
    this.DefaultNameserver,
    this.CacheAlgorithm,
    this.NameServerPolicy,
    this.ProxyServerNameserver,
    this.DirectNameServer,
    this.DirectNameServerFollowPolicy,
  );
  factory RawDNS.fromJson(Map<String, dynamic> json) => _$RawDNSFromJson(json);
  Map<String, dynamic> toJson() => _$RawDNSToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawFallbackFilter {
  @JsonKey(name: 'geoip')
  bool? GeoIP;
  @JsonKey(name: 'geoip-code')
  String? GeoIPCode;
  @JsonKey(name: 'ipcidr')
  List<String>? IPCIDR;
  @JsonKey(name: 'domain')
  List<String>? Domain;
  @JsonKey(name: 'domageositein')
  List<String>? GeoSite;

  RawFallbackFilter.by({
    this.GeoIP,
    this.GeoIPCode,
    this.IPCIDR,
    this.Domain,
    this.GeoSite,
  });
  RawFallbackFilter(
    this.GeoIP,
    this.GeoIPCode,
    this.IPCIDR,
    this.Domain,
    this.GeoSite,
  );
  factory RawFallbackFilter.fromJson(Map<String, dynamic> json) =>
      _$RawFallbackFilterFromJson(json);
  Map<String, dynamic> toJson() => _$RawFallbackFilterToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawClashForAndroid {
  @JsonKey(name: 'overwrite')
  bool? OverWrite;
  @JsonKey(name: 'append-system-dns')
  bool? AppendSystemDNS;
  @JsonKey(name: 'ui-subtitle-pattern')
  String? UiSubtitlePattern;

  RawClashForAndroid.by({
    this.OverWrite,
    this.AppendSystemDNS,
    this.UiSubtitlePattern,
  });
  RawClashForAndroid(
    this.OverWrite,
    this.AppendSystemDNS,
    this.UiSubtitlePattern,
  );
  factory RawClashForAndroid.fromJson(Map<String, dynamic> json) =>
      _$RawClashForAndroidFromJson(json);
  Map<String, dynamic> toJson() => _$RawClashForAndroidToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawNTP {
  @JsonKey(name: 'overwrite')
  bool? OverWrite;
  @JsonKey(name: 'enable')
  bool? Enable;
  @JsonKey(name: 'server')
  String? Server;
  @JsonKey(name: 'port')
  int? Port;
  @JsonKey(name: 'interval')
  int? Interval;
  @JsonKey(name: 'dialer-proxy')
  String? DialerProxy;
  @JsonKey(name: 'write-to-system')
  bool? WriteToSystem;

  RawNTP.by({
    this.OverWrite,
    this.Enable,
    this.Server,
    this.Port,
    this.Interval,
    this.DialerProxy,
    this.WriteToSystem,
  });
  RawNTP(
    this.OverWrite,
    this.Enable,
    this.Server,
    this.Port,
    this.Interval,
    this.DialerProxy,
    this.WriteToSystem,
  );
  factory RawNTP.fromJson(Map<String, dynamic> json) => _$RawNTPFromJson(json);
  Map<String, dynamic> toJson() => _$RawNTPToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawTun {
  @JsonKey(name: 'overwrite')
  bool? OverWrite;
  @JsonKey(name: 'enable')
  bool? Enable;
  @JsonKey(name: 'device')
  String? Device;
  @JsonKey(name: 'stack')
  String? Stack;
  @JsonKey(name: 'dns-hijack')
  List<String>? DNSHijack;
  @JsonKey(name: 'auto-route')
  bool? AutoRoute;
  @JsonKey(name: 'auto-detect-interface')
  bool? AutoDetectInterface;
  @JsonKey(name: 'mtu')
  int? MTU;
  @JsonKey(name: 'gso')
  bool? GSO;
  @JsonKey(name: 'gso-max-size')
  int? GSOMaxSize;
  @JsonKey(name: 'inet4-address')
  List<String>? Inet4Address;
  @JsonKey(name: 'inet6-address')
  List<String>? Inet6Address;
  @JsonKey(name: 'iproute2-table-index')
  int? IPRoute2TableIndex;
  @JsonKey(name: 'iproute2-rule-index')
  int? IPRoute2RuleIndex;
  @JsonKey(name: 'auto-redirect')
  bool? AutoRedirect;
  @JsonKey(name: 'auto-redirect-input-mark')
  int? AutoRedirectInputMark;
  @JsonKey(name: 'auto-redirect-output-mark')
  int? AutoRedirectOutputMark;
  @JsonKey(name: 'strict-route')
  bool? StrictRoute;
  @JsonKey(name: 'disable-icmp-forwarding')
  bool? DisableICMPForwarding;
  @JsonKey(name: 'route-address')
  List<String>? RouteAddress;
  @JsonKey(name: 'route-address-set')
  List<String>? RouteAddressSet;
  @JsonKey(name: 'route-exclude-address')
  List<String>? RouteExcludeAddress;
  @JsonKey(name: 'route-exclude-address-set')
  List<String>? RouteExcludeAddressSet;
  @JsonKey(name: 'include-interface')
  List<String>? IncludeInterface;
  @JsonKey(name: 'exclude-interface')
  List<String>? ExcludeInterface;
  @JsonKey(name: 'include-uid')
  List<int>? IncludeUID;
  @JsonKey(name: 'include-uid-range')
  List<String>? IncludeUIDRange;
  @JsonKey(name: 'exclude-uid')
  List<int>? ExcludeUID;
  @JsonKey(name: 'exclude-uid-range')
  List<String>? ExcludeUIDRange;
  @JsonKey(name: 'include-android-user')
  List<int>? IncludeAndroidUser;
  @JsonKey(name: 'include-package')
  List<String>? IncludePackage;
  @JsonKey(name: 'exclude-package')
  List<String>? ExcludePackage;
  @JsonKey(name: 'endpoint-independent-nat')
  bool? EndpointIndependentNat;
  @JsonKey(name: 'udp-timeout')
  int? UDPTimeout;
  @JsonKey(name: 'file-descriptor')
  int? FileDescriptor;
  @JsonKey(name: 'inet4-route-address')
  List<String>? Inet4RouteAddress;
  @JsonKey(name: 'inet6-route-address')
  List<String>? Inet6RouteAddress;
  @JsonKey(name: 'inet4-route-exclude-address')
  List<String>? Inet4RouteExcludeAddress;
  @JsonKey(name: 'inet6-route-exclude-address')
  List<String>? Inet6RouteExcludeAddress;
  RawTun.by({
    this.OverWrite,
    this.Enable,
    this.Device,
    this.Stack,
    this.DNSHijack,
    this.AutoRoute,
    this.AutoDetectInterface,
    this.MTU,
    this.GSO,
    this.GSOMaxSize,
    this.Inet4Address,
    this.Inet6Address,
    this.IPRoute2TableIndex,
    this.IPRoute2RuleIndex,
    this.AutoRedirect,
    this.AutoRedirectInputMark,
    this.AutoRedirectOutputMark,
    this.StrictRoute,
    this.DisableICMPForwarding,
    this.RouteAddress,
    this.RouteAddressSet,
    this.RouteExcludeAddress,
    this.RouteExcludeAddressSet,
    this.IncludeInterface,
    this.ExcludeInterface,
    this.IncludeUID,
    this.IncludeUIDRange,
    this.ExcludeUID,
    this.ExcludeUIDRange,
    this.IncludeAndroidUser,
    this.IncludePackage,
    this.ExcludePackage,
    this.EndpointIndependentNat,
    this.UDPTimeout,
    this.FileDescriptor,
    this.Inet4RouteAddress,
    this.Inet6RouteAddress,
    this.Inet4RouteExcludeAddress,
    this.Inet6RouteExcludeAddress,
  });
  RawTun(
    this.OverWrite,
    this.Enable,
    this.Device,
    this.Stack,
    this.DNSHijack,
    this.AutoRoute,
    this.AutoDetectInterface,
    this.MTU,
    this.GSO,
    this.GSOMaxSize,
    this.Inet4Address,
    this.Inet6Address,
    this.IPRoute2TableIndex,
    this.IPRoute2RuleIndex,
    this.AutoRedirect,
    this.AutoRedirectInputMark,
    this.AutoRedirectOutputMark,
    this.StrictRoute,
    this.DisableICMPForwarding,
    this.RouteAddress,
    this.RouteAddressSet,
    this.RouteExcludeAddress,
    this.RouteExcludeAddressSet,
    this.IncludeInterface,
    this.ExcludeInterface,
    this.IncludeUID,
    this.IncludeUIDRange,
    this.ExcludeUID,
    this.ExcludeUIDRange,
    this.IncludeAndroidUser,
    this.IncludePackage,
    this.ExcludePackage,
    this.EndpointIndependentNat,
    this.UDPTimeout,
    this.FileDescriptor,
    this.Inet4RouteAddress,
    this.Inet6RouteAddress,
    this.Inet4RouteExcludeAddress,
    this.Inet6RouteExcludeAddress,
  );
  factory RawTun.fromJson(Map<String, dynamic> json) => _$RawTunFromJson(json);
  Map<String, dynamic> toJson() => _$RawTunToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawTuicServer {
  @JsonKey(name: 'overwrite')
  bool? OverWrite;
  @JsonKey(name: 'enable')
  bool? Enable;
  @JsonKey(name: 'listen')
  String? Listen;
  @JsonKey(name: 'token')
  List<String>? Token;
  @JsonKey(name: 'users')
  Map<String, String>? Users;
  @JsonKey(name: 'certificate')
  String? Certificate;
  @JsonKey(name: 'private-key')
  String? PrivateKey;
  @JsonKey(name: 'congestion-controller')
  String? CongestionController;
  @JsonKey(name: 'max-idle-time')
  int? MaxIdleTime;
  @JsonKey(name: 'authentication-timeout')
  int? AuthenticationTimeout;
  @JsonKey(name: 'alpn')
  List<String>? ALPN;
  @JsonKey(name: 'max-udp-relay-packet-size')
  int? MaxUdpRelayPacketSize;
  @JsonKey(name: 'cwnd')
  int? CWND;

  RawTuicServer.by({
    this.OverWrite,
    this.Enable,
    this.Listen,
    this.Token,
    this.Users,
    this.Certificate,
    this.PrivateKey,
    this.CongestionController,
    this.MaxIdleTime,
    this.AuthenticationTimeout,
    this.ALPN,
    this.MaxUdpRelayPacketSize,
    this.CWND,
  });
  RawTuicServer(
    this.OverWrite,
    this.Enable,
    this.Listen,
    this.Token,
    this.Users,
    this.Certificate,
    this.PrivateKey,
    this.CongestionController,
    this.MaxIdleTime,
    this.AuthenticationTimeout,
    this.ALPN,
    this.MaxUdpRelayPacketSize,
    this.CWND,
  );
  factory RawTuicServer.fromJson(Map<String, dynamic> json) =>
      _$RawTuicServerFromJson(json);
  Map<String, dynamic> toJson() => _$RawTuicServerToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawIPTables {
  @JsonKey(name: 'overwrite')
  bool? OverWrite;
  @JsonKey(name: 'enable')
  bool? Enable;
  @JsonKey(name: 'inbound-interface')
  String? InboundInterface;
  @JsonKey(name: 'bypass')
  List<String>? Bypass;
  @JsonKey(name: 'dns-redirect')
  bool? DnsRedirect;

  RawIPTables.by({
    this.OverWrite,
    this.Enable,
    this.InboundInterface,
    this.Bypass,
    this.DnsRedirect,
  });
  RawIPTables(
    this.OverWrite,
    this.Enable,
    this.InboundInterface,
    this.Bypass,
    this.DnsRedirect,
  );
  factory RawIPTables.fromJson(Map<String, dynamic> json) =>
      _$RawIPTablesFromJson(json);
  Map<String, dynamic> toJson() => _$RawIPTablesToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawExperimental {
  @JsonKey(name: 'overwrite')
  bool? OverWrite;
  @JsonKey(name: 'fingerprints')
  List<String>? Fingerprints;
  @JsonKey(name: 'quic-go-disable-gso')
  bool? QUICGoDisableGSO;
  @JsonKey(name: 'quic-go-disable-ecn')
  bool? QUICGoDisableECN;
  @JsonKey(name: 'dialer-ip4p-convert')
  bool? IP4PEnable;

  RawExperimental.by({
    this.OverWrite,
    this.Fingerprints,
    this.QUICGoDisableGSO,
    this.QUICGoDisableECN,
    this.IP4PEnable,
  });
  RawExperimental(
    this.OverWrite,
    this.Fingerprints,
    this.QUICGoDisableGSO,
    this.QUICGoDisableECN,
    this.IP4PEnable,
  );
  factory RawExperimental.fromJson(Map<String, dynamic> json) =>
      _$RawExperimentalFromJson(json);
  Map<String, dynamic> toJson() => _$RawExperimentalToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawProfile {
  @JsonKey(name: 'store-selected')
  bool? StoreSelected;
  @JsonKey(name: 'store-fake-ip')
  bool? StoreFakeIP;

  RawProfile.by({this.StoreSelected, this.StoreFakeIP});
  RawProfile(this.StoreSelected, this.StoreFakeIP);
  factory RawProfile.fromJson(Map<String, dynamic> json) =>
      _$RawProfileFromJson(json);
  Map<String, dynamic> toJson() => _$RawProfileToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawGeoXUrl {
  @JsonKey(name: 'overwrite')
  bool? OverWrite;
  @JsonKey(name: 'geoip')
  String? GeoIp;
  @JsonKey(name: 'mmdb')
  String? Mmdb;
  @JsonKey(name: 'asn')
  String? ASN;
  @JsonKey(name: 'geosite')
  String? GeoSite;

  RawGeoXUrl.by({
    this.OverWrite,
    this.GeoIp,
    this.Mmdb,
    this.ASN,
    this.GeoSite,
  });
  RawGeoXUrl(this.OverWrite, this.GeoIp, this.Mmdb, this.ASN, this.GeoSite);
  factory RawGeoXUrl.fromJson(Map<String, dynamic> json) =>
      _$RawGeoXUrlFromJson(json);
  Map<String, dynamic> toJson() => _$RawGeoXUrlToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawSniffer {
  @JsonKey(name: 'overwrite')
  bool? OverWrite;
  @JsonKey(name: 'enable')
  bool? Enable;
  @JsonKey(name: 'override-destination')
  bool? OverrideDest;
  @JsonKey(name: 'sniffing')
  List<String>? Sniffing;
  @JsonKey(name: 'force-domain')
  List<String>? ForceDomain;
  @JsonKey(name: 'skip-src-address')
  List<String>? SkipSrcAddress;
  @JsonKey(name: 'skip-dst-address')
  List<String>? SkipDstAddress;
  @JsonKey(name: 'skip-domain')
  List<String>? SkipDomain;
  @JsonKey(name: 'port-whitelist')
  List<String>? Ports;
  @JsonKey(name: 'force-dns-mapping')
  bool? ForceDnsMapping;
  @JsonKey(name: 'parse-pure-ip')
  bool? ParsePureIp;
  @JsonKey(name: 'sniff')
  Map<String, RawSniffingConfig>? Sniff;

  RawSniffer.by({
    this.OverWrite,
    this.Enable,
    this.OverrideDest,
    this.Sniffing,
    this.ForceDomain,
    this.SkipSrcAddress,
    this.SkipDstAddress,
    this.SkipDomain,
    this.Ports,
    this.ForceDnsMapping,
    this.ParsePureIp,
    this.Sniff,
  });
  RawSniffer(
    this.OverWrite,
    this.Enable,
    this.OverrideDest,
    this.Sniffing,
    this.ForceDomain,
    this.SkipSrcAddress,
    this.SkipDstAddress,
    this.SkipDomain,
    this.Ports,
    this.ForceDnsMapping,
    this.ParsePureIp,
    this.Sniff,
  );
  factory RawSniffer.fromJson(Map<String, dynamic> json) =>
      _$RawSnifferFromJson(json);
  Map<String, dynamic> toJson() => _$RawSnifferToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawSniffingConfig {
  @JsonKey(name: 'ports')
  List<String>? Ports;
  @JsonKey(name: 'override-destination')
  bool? OverrideDest;

  RawSniffingConfig.by({this.Ports, this.OverrideDest});
  RawSniffingConfig(this.Ports, this.OverrideDest);
  factory RawSniffingConfig.fromJson(Map<String, dynamic> json) =>
      _$RawSniffingConfigFromJson(json);
  Map<String, dynamic> toJson() => _$RawSniffingConfigToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawTLS {
  @JsonKey(name: 'overwrite')
  bool? OverWrite;
  @JsonKey(name: 'certificate')
  String? Certificate;
  @JsonKey(name: 'private-key')
  String? PrivateKey;
  @JsonKey(name: 'custom-certifactes')
  List<String>? CustomTrustCert;

  RawTLS.by({
    this.OverWrite,
    this.Certificate,
    this.PrivateKey,
    this.CustomTrustCert,
  });
  RawTLS(
    this.OverWrite,
    this.Certificate,
    this.PrivateKey,
    this.CustomTrustCert,
  );
  factory RawTLS.fromJson(Map<String, dynamic> json) => _$RawTLSFromJson(json);
  Map<String, dynamic> toJson() => _$RawTLSToJson(this);
}

@JsonSerializable(explicitToJson: true)
class RawConfig {
  @JsonKey(name: 'port')
  int? Port;
  @JsonKey(name: 'socks-port')
  int? SocksPort;
  @JsonKey(name: 'redir-port')
  int? RedirPort;
  @JsonKey(name: 'tproxy-port')
  int? TProxyPort;
  @JsonKey(name: 'mixed-port')
  int? MixedPort;
  @JsonKey(name: 'ss-config')
  String? ShadowSocksConfig;
  @JsonKey(name: 'vmess-config')
  String? VmessConfig;
  @JsonKey(name: 'inbound-tfo')
  bool? InboundTfo;
  @JsonKey(name: 'inbound-mptcp')
  bool? InboundMPTCP;
  @JsonKey(name: 'authentication')
  List<String>? Authentication;
  @JsonKey(name: 'skip-auth-prefixes')
  List<String>? SkipAuthPrefixes;
  @JsonKey(name: 'lan-allowed-ips')
  List<String>? LanAllowedIPs;
  @JsonKey(name: 'lan-disallowed-ips')
  List<String>? LanDisAllowedIPs;
  @JsonKey(name: 'allow-lan')
  bool? AllowLan;
  @JsonKey(name: 'bind-address')
  String? BindAddress;
  @JsonKey(name: 'mode')
  String? Mode; //ClashConfigsMode
  @JsonKey(name: 'unified-delay')
  bool? UnifiedDelay;
  @JsonKey(name: 'log-level')
  String? LogLevel;
  @JsonKey(name: 'ipv6')
  bool? IPv6;
  @JsonKey(name: 'external-controller')
  String? ExternalController;
  @JsonKey(name: 'external-controller-pipe')
  String? ExternalControllerPipe;
  @JsonKey(name: 'external-controller-unix')
  String? ExternalControllerUnix;
  @JsonKey(name: 'external-controller-tls')
  String? ExternalControllerTLS;
  @JsonKey(name: 'external-controller-cors')
  RawCors? ExternalControllerCors;
  @JsonKey(name: 'external-ui')
  String? ExternalUI;
  @JsonKey(name: 'external-ui-url')
  String? ExternalUIURL;
  @JsonKey(name: 'external-ui-name')
  String? ExternalUIName;
  @JsonKey(name: 'external-doh-server')
  String? ExternalDohServer;
  @JsonKey(name: 'secret')
  String? Secret;
  @JsonKey(name: 'interface-name')
  String? Interface;
  @JsonKey(name: 'routing-mark')
  int? RoutingMark;
  @JsonKey(name: 'tunnels')
  List<RawTunnel>? Tunnels;
  @JsonKey(name: 'geo-auto-update')
  bool? GeoAutoUpdate;
  @JsonKey(name: 'geo-update-interval')
  int? GeoUpdateInterval;
  @JsonKey(name: 'geodata-mode')
  bool? GeodataMode;
  @JsonKey(name: 'geodata-loader')
  String? GeodataLoader;
  @JsonKey(name: 'geosite-matcher')
  String? GeositeMatcher;
  @JsonKey(name: 'tcp-concurrent')
  bool? TCPConcurrent;
  @JsonKey(name: 'find-process-mode')
  String? FindProcessMode;
  @JsonKey(name: 'global-client-fingerprint')
  String? GlobalClientFingerprint;
  @JsonKey(name: 'global-ua')
  String? GlobalUA;
  @JsonKey(name: 'etag-support')
  bool? ETagSupport;
  @JsonKey(name: 'keep-alive-idle')
  int? KeepAliveIdle;
  @JsonKey(name: 'keep-alive-interval')
  int? KeepAliveInterval;
  @JsonKey(name: 'disable-keep-alive')
  bool? DisableKeepAlive;
  @JsonKey(name: 'overwrite-rule-providers')
  bool? OverWriteRuleProviders;
  @JsonKey(name: 'rule-providers')
  Map<String, dynamic>? RuleProviders;
  @JsonKey(name: 'overwrite-rules')
  bool? OverWriteRules;
  @JsonKey(name: 'rules')
  List<String>? Rules;
  @JsonKey(name: 'overwrite-sub-rules')
  bool? OverWriteSubRules;
  @JsonKey(name: 'sub-rules')
  List<String>? SubRules;
  @JsonKey(name: 'overwrite-proxy-groups')
  bool? OverWriteProxyGroups;
  @JsonKey(name: 'proxy-groups')
  List<dynamic>? ProxyGroups;
  //map[string]map[string]any ProxyProvider  `yaml:"proxy-providers" json:"proxy-providers"`
  //[]map[string]any Proxy                   `yaml:"proxies" json:"proxies"`
  //[]map[string]any ProxyGroup              `yaml:"proxy-groups" json:"proxy-groups"`
  @JsonKey(name: 'overwrite-listeners')
  bool? OverwriteListeners;
  @JsonKey(name: 'listeners')
  Map<String, dynamic>? Listeners;
  @JsonKey(name: 'overwrite-hosts')
  bool? OverWriteHosts;
  @JsonKey(name: 'hosts')
  Map<String, dynamic>? Hosts;
  @JsonKey(name: 'dns')
  RawDNS? DNS;
  @JsonKey(name: 'ntp')
  RawNTP? NTP;
  @JsonKey(name: 'tun')
  RawTun? Tun;
  @JsonKey(name: 'tuic-server')
  RawTuicServer? TuicServer;
  @JsonKey(name: 'iptables')
  RawIPTables? IPTables;
  @JsonKey(name: 'experimental')
  RawExperimental? Experimental;
  @JsonKey(name: 'profile')
  RawProfile? Profile;
  @JsonKey(name: 'geox-url')
  RawGeoXUrl? GeoXUrl;
  @JsonKey(name: 'sniffer')
  RawSniffer? Sniffer;
  @JsonKey(name: 'tls')
  RawTLS? TLS;
  @JsonKey(name: 'clash-for-android')
  RawClashForAndroid? ClashForAndroid;
  @JsonKey(name: 'extension')
  RawExtension? Extension;

  RawConfig.by({
    this.Port,
    this.SocksPort,
    this.RedirPort,
    this.TProxyPort,
    this.MixedPort,
    this.ShadowSocksConfig,
    this.VmessConfig,
    this.InboundTfo,
    this.InboundMPTCP,
    this.Authentication,
    this.SkipAuthPrefixes,
    this.LanAllowedIPs,
    this.LanDisAllowedIPs,
    this.AllowLan,
    this.BindAddress,
    this.Mode,
    this.UnifiedDelay,
    this.LogLevel,
    this.IPv6,
    this.ExternalController,
    this.ExternalControllerPipe,
    this.ExternalControllerUnix,
    this.ExternalControllerTLS,
    this.ExternalControllerCors,
    this.ExternalUI,
    this.ExternalUIURL,
    this.ExternalUIName,
    this.ExternalDohServer,
    this.Secret,
    this.Interface,
    this.RoutingMark,
    this.Tunnels,
    this.GeoAutoUpdate,
    this.GeoUpdateInterval,
    this.GeodataMode,
    this.GeodataLoader,
    this.GeositeMatcher,
    this.TCPConcurrent,
    this.FindProcessMode,
    this.GlobalClientFingerprint,
    this.GlobalUA,
    this.ETagSupport,
    this.KeepAliveIdle,
    this.KeepAliveInterval,
    this.DisableKeepAlive,
    this.OverWriteRuleProviders,
    this.RuleProviders,
    this.OverWriteRules,
    this.Rules,
    this.OverWriteSubRules,
    this.SubRules,
    this.OverWriteProxyGroups,
    this.ProxyGroups,
    this.Listeners,
    this.Hosts,
    this.DNS,
    this.NTP,
    this.Tun,
    this.TuicServer,
    this.IPTables,
    this.Experimental,
    this.Profile,
    this.GeoXUrl,
    this.Sniffer,
    this.TLS,
    this.ClashForAndroid,
    required this.Extension,
  });
  RawConfig(
    this.Port,
    this.SocksPort,
    this.RedirPort,
    this.TProxyPort,
    this.MixedPort,
    this.ShadowSocksConfig,
    this.VmessConfig,
    this.InboundTfo,
    this.InboundMPTCP,
    this.Authentication,
    this.SkipAuthPrefixes,
    this.LanAllowedIPs,
    this.LanDisAllowedIPs,
    this.AllowLan,
    this.BindAddress,
    this.Mode,
    this.UnifiedDelay,
    this.LogLevel,
    this.IPv6,
    this.ExternalController,
    this.ExternalControllerPipe,
    this.ExternalControllerUnix,
    this.ExternalControllerTLS,
    this.ExternalControllerCors,
    this.ExternalUI,
    this.ExternalUIURL,
    this.ExternalUIName,
    this.ExternalDohServer,
    this.Secret,
    this.Interface,
    this.RoutingMark,
    this.Tunnels,
    this.GeoAutoUpdate,
    this.GeoUpdateInterval,
    this.GeodataMode,
    this.GeodataLoader,
    this.GeositeMatcher,
    this.TCPConcurrent,
    this.FindProcessMode,
    this.GlobalClientFingerprint,
    this.GlobalUA,
    this.ETagSupport,
    this.KeepAliveIdle,
    this.KeepAliveInterval,
    this.DisableKeepAlive,
    this.OverWriteRuleProviders,
    this.RuleProviders,
    this.OverWriteRules,
    this.Rules,
    this.OverWriteSubRules,
    this.SubRules,
    this.OverWriteProxyGroups,
    this.ProxyGroups,
    this.Listeners,
    this.Hosts,
    this.DNS,
    this.NTP,
    this.Tun,
    this.TuicServer,
    this.IPTables,
    this.Experimental,
    this.Profile,
    this.GeoXUrl,
    this.Sniffer,
    this.TLS,
    this.ClashForAndroid,
    this.Extension,
  );
  factory RawConfig.fromJson(Map<String, dynamic> json) =>
      _$RawConfigFromJson(json);
  Map<String, dynamic> toJson() => _$RawConfigToJson(this);
}
