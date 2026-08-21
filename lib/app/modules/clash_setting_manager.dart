// ignore_for_file: unused_catch_stack, empty_catches

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:clashmi/app/clash/clash_config.dart';
import 'package:clashmi/app/clash/clash_http_api.dart';
import 'package:clashmi/app/local_services/vpn_service.dart';
import 'package:clashmi/app/modules/diversion_template_manager.dart';
import 'package:clashmi/app/modules/profile_manager.dart';
import 'package:clashmi/app/runtime/return_result.dart';
import 'package:clashmi/app/utils/app_utils.dart';
import 'package:clashmi/app/utils/did.dart';
import 'package:clashmi/app/utils/file_utils.dart';
import 'package:clashmi/app/utils/log.dart';
import 'package:clashmi/app/utils/path_utils.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:flutter/services.dart';

import 'package:libclash_vpn_service/proxy_manager.dart';
import 'package:path/path.dart' as path;

class ClashSettingManager {
  static final List<void Function()> onEventModeChanged = [];
  static const iNet4Address = "172.19.0.1/30";
  static const iNet6Address = "fdfe:dcbe:9876::1/126";
  static const dnsHijack = "0.0.0.0:53";
  static RawConfig _setting = defaultConfig();
  static final FileSaver _fileSaver = FileSaver();

  static Future<void> init() async {
    ClashHttpApi.getControlPort = () {
      return getControlPort();
    };
    ClashHttpApi.getSecret = () {
      return _setting.Secret ?? "";
    };
    _fileSaver.setSavePath(await PathUtils.serviceCoreSettingFilePath());
    await load();
    await initGeo();
  }

  static Future<void> initGeo() async {
    final homePath = await PathUtils.profileDir();
    final fileNameList = Platform.isIOS
        ? ["geosite.zip", "geoip.zip"]
        : ["geosite.zip", "geoip.zip", "ASN.mmdb"];

    try {
      for (final fileName in fileNameList) {
        final filePath = File(path.join(homePath, fileName));
        final isExists = await filePath.exists();
        if (isExists) {
          final stat = await filePath.stat();
          final dur = DateTime.now().difference(stat.modified);
          if (dur.inDays < 7) {
            continue;
          }
        }

        final data = await rootBundle.load('assets/datas/$fileName');
        List<int> bytes = data.buffer.asUint8List();
        await filePath.writeAsBytes(bytes, flush: true);
      }
    } catch (err) {
      Log.w("ClashSettingManager.initGeo exception ${err.toString()} ");
    }
  }

  static Future<String> getSecretFromDid() async {
    String secret = await Did.getDid();
    return secret.substring(8, 24);
  }

  static Future<void> reload() async {
    await load();
  }

  static RawTun defaultTun() {
    const routeAddress = [
      "1.0.0.0/8",
      "2.0.0.0/7",
      "4.0.0.0/6",
      "8.0.0.0/7",
      "11.0.0.0/8",
      "12.0.0.0/6",
      "16.0.0.0/4",
      "32.0.0.0/3",
      "64.0.0.0/3",
      "96.0.0.0/4",
      "112.0.0.0/5",
      "120.0.0.0/6",
      "124.0.0.0/7",
      "126.0.0.0/8",
      "128.0.0.0/3",
      "160.0.0.0/5",
      "168.0.0.0/8",
      "169.0.0.0/9",
      "169.128.0.0/10",
      "169.192.0.0/11",
      "169.224.0.0/12",
      "169.240.0.0/13",
      "169.248.0.0/14",
      "169.252.0.0/15",
      "169.255.0.0/16",
      "170.0.0.0/7",
      "172.0.0.0/12",
      "172.32.0.0/11",
      "172.64.0.0/10",
      "172.128.0.0/9",
      "173.0.0.0/8",
      "174.0.0.0/7",
      "176.0.0.0/4",
      "192.0.0.0/9",
      "192.128.0.0/11",
      "192.160.0.0/13",
      "192.169.0.0/16",
      "192.170.0.0/15",
      "192.172.0.0/14",
      "192.176.0.0/12",
      "192.192.0.0/10",
      "193.0.0.0/8",
      "194.0.0.0/7",
      "196.0.0.0/6",
      "200.0.0.0/5",
      "208.0.0.0/4",
      "240.0.0.0/5",
      "248.0.0.0/6",
      "252.0.0.0/7",
      "254.0.0.0/8",
      "255.0.0.0/9",
      "255.128.0.0/10",
      "255.192.0.0/11",
      "255.224.0.0/12",
      "255.240.0.0/13",
      "255.248.0.0/14",
      "255.252.0.0/15",
      "255.254.0.0/16",
      "255.255.0.0/17",
      "255.255.128.0/18",
      "255.255.192.0/19",
      "255.255.224.0/20",
      "255.255.240.0/21",
      "255.255.248.0/22",
      "255.255.252.0/23",
      "255.255.254.0/24",
      "255.255.255.0/25",
      "255.255.255.128/26",
      "255.255.255.192/27",
      "255.255.255.224/28",
      "255.255.255.240/29",
      "255.255.255.248/30",
      "255.255.255.252/31",
      "255.255.255.254/32",
      "::/1",
      "8000::/2",
      "c000::/3",
      "e000::/4",
      "f000::/5",
      "f800::/6",
      "fe00::/9",
      "fec0::/10",
    ];
    return RawTun.by(
      OverWrite: true,
      Enable: !Platform.isWindows,
      Stack: ClashTunStack.gvisor.name,
      MTU: 1280,
      Inet4Address: [iNet4Address],
      Inet6Address: [iNet6Address],
      //RouteAddress: routeAddress,
      DNSHijack: [dnsHijack],
      DisableICMPForwarding: true,
    );
  }

  static RawDNS defaultDNS() {
    const List<String> nameServer = [
      "223.5.5.5",
      "119.29.29.29",
      "8.8.8.8",
      "8.8.4.4",
      "1.0.0.1",
      "1.1.1.1",
      "tls://223.5.5.5:853",
      "tls://8.8.8.8",
      "tls://8.8.4.4",
      "tls://1.0.0.1",
      "tls://1.1.1.1",
      "https://dns.alidns.com/dns-query#h3=true",
      "https://mozilla.cloudflare-dns.com/dns-query#DNS&h3=true",
      "quic://dns.adguard.com:784",
      "system",
    ];
    const List<String> defaultNameserver = [
      "223.5.5.5",
      "119.29.29.29",
      "8.8.8.8",
      "8.8.4.4",
      "1.0.0.1",
      "1.1.1.1",
      "system",
    ];
    const List<String> proxyServerNameserver = [
      "223.5.5.5",
      "119.29.29.29",
      "8.8.8.8",
      "8.8.4.4",
      "1.0.0.1",
      "1.1.1.1",
      "tls://8.8.4.4",
      "tls://1.1.1.1",
      "tls://223.5.5.5:853",
      "https://dns.alidns.com/dns-query#h3=true",
    ];
    const List<String> directNameServer = [
      "223.5.5.5",
      "119.29.29.29",
      "8.8.8.8",
      "8.8.4.4",
      "1.0.0.1",
      "1.1.1.1",
      "system",
    ];
    const List<String> fallback = [
      /*"tls://223.5.5.5:853",
        "https://dns.alidns.com/dns-query#h3=true",
        "https://cloudflare-dns.com/dns-query",
        "https://1.12.12.12/dns-query",
        "https://120.53.53.53/dns-query"*/
    ];
    const List<String> fakeIPFilter = [
      "*.lan",
      "*.local",
      "time.*.com",
      "time.*.gov",
      "time.*.edu.cn",
      "time.*.apple.com",
      "time-ios.apple.com",
      "time1.*.com",
      "time2.*.com",
      "time3.*.com",
      "time4.*.com",
      "time5.*.com",
      "time6.*.com",
      "time7.*.com",
      "ntp.*.com",
      "ntp1.*.com",
      "ntp2.*.com",
      "ntp3.*.com",
      "ntp4.*.com",
      "ntp5.*.com",
      "ntp6.*.com",
      "ntp7.*.com",
      "*.time.edu.cn",
      "*.ntp.org.cn",
      "*.pool.ntp.org",
      "+.services.googleapis.cn",
      "+.push.apple.com",
      "time1.cloud.tencent.com",
      "localhost.ptlogin2.qq.com",
      "+.stun.*.*",
      "+.stun.*.*.*",
      "+.stun.*.*.*.*",
      "+.stun.*.*.*.*.*",
      "lens.l.google.com",
      "*.n.n.srv.nintendo.net",
      "+.stun.playstation.net",
      "xbox.*.*.microsoft.com",
      "*.*.xboxlive.com",
      "*.msftncsi.com",
      "*.msftconnecttest.com",
      "*.mcdn.bilivideo.cn",
      "+.bilibili.com",
      "+.bilicdn.com",
      "+.bilivideo.com",
      "+.market.xiaomi.com",
      "WORKGROUP",
    ];

    return RawDNS.by(
      OverWrite: true,
      Enable: true,
      PreferH3: true,
      IPv6: false,
      IPv6Timeout: 300,
      UseHosts: true,
      UseSystemHosts: true,
      RespectRules: false,
      NameServer: nameServer,
      Fallback: fallback,
      FallbackFilter: RawFallbackFilter.by(GeoIP: null),
      Listen: null,
      EnhancedMode: ClashDnsEnhancedMode.fakeIp.name,
      FakeIPRange: "${iNet4Address.split('/')[0]}/16",
      FakeIPFilter: fakeIPFilter,
      FakeIPFilterMode: ClashFakeIPFilterMode.blacklist.name,
      CacheAlgorithm: ClashDnsCacheAlgorithm.arc.name,
      DefaultNameserver: defaultNameserver,
      NameServerPolicy: {},
      ProxyServerNameserver: proxyServerNameserver,
      DirectNameServer: directNameServer,
      DirectNameServerFollowPolicy: false,
    );
  }

  static RawNTP defaultNTP() {
    return RawNTP.by(OverWrite: false, Enable: false);
  }

  static RawSniffer defaultSniffer() {
    return RawSniffer.by(OverWrite: false, Enable: false);
  }

  static RawTLS defaultTLS() {
    return RawTLS.by(
      OverWrite: false,
      Certificate: null,
      PrivateKey: null,
      CustomTrustCert: null,
    );
  }

  static RawExtensionGeoRuleset defaultRawExtensionRuleset() {
    return RawExtensionGeoRuleset.by(
      GeoSiteUrl:
          "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/geo/geosite",
      GeoIpUrl:
          "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/geo/geoip",
      AsnUrl:
          "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/asn",
      UpdateInterval: 2 * 24 * 3600,
      EnableProxy: true,
    );
  }

  static RawExtension defaultExtension() {
    const bypassDomainLocal = ProxyBypassDoaminsDefault;
    List<String> bypassDomainCN = Platform.isAndroid
        ? [
            "*zhihu.com",
            "*zhimg.com",
            "*jd.com",
            "100ime-iat-api.xfyun.cn",
            "*360buyimg.com",
          ]
        : [];

    return RawExtension.by(
      Ruleset: defaultRawExtensionRuleset(),
      Tun: RawExtensionTun.by(
        httpProxy: RawExtensionTunHttpProxy.by(
          Enable: false,
          BypassDomain: bypassDomainLocal + bypassDomainCN,
        ),
        perApp: RawExtensionTunPerApp.by(Enable: false),
      ),
      PprofAddr: null,
    );
  }

  static RawConfig defaultConfig() {
    return RawConfig.by(
      Mode: ClashConfigsMode.rule.name,
      MixedPort: 7890,
      LogLevel: ClashLogLevel.error.name,
      ExternalController: "127.0.0.1:9090",
      IPv6: false,
      DNS: defaultDNS(),
      NTP: defaultNTP(),
      Sniffer: defaultSniffer(),
      TLS: defaultTLS(),
      Tun: defaultTun(),
      Extension: defaultExtension(),
      GlobalClientFingerprint: ClashGlobalClientFingerprint.chrome.name,
      DisableKeepAlive: false,
      KeepAliveIdle: 30,
      KeepAliveInterval: 30,
      FindProcessMode: Platform.isIOS
          ? ClashFindProcessMode.off.name
          : ClashFindProcessMode.always.name,
    );
  }

  static RawConfig defaultConfigNoOverwrite() {
    return RawConfig.by(
      Mode: _setting.Mode,
      MixedPort: _setting.MixedPort,
      LogLevel: _setting.LogLevel,
      ExternalController: _setting.ExternalController,
      Secret: _setting.Secret,
      IPv6: _setting.IPv6,
      DNS: null,
      NTP: null,
      Sniffer: null,
      TLS: null,
      Tun: _setting.Tun,
      Extension: _setting.Extension,
      UnifiedDelay: _setting.UnifiedDelay,
      FindProcessMode: _setting.FindProcessMode,
      Profile: _setting.Profile,
    );
  }

  static Future<void> uninit() async {}

  static Future<void> save() async {
    final map = _setting.toJson();
    MapHelper.removeNullOrEmpty(map, false, false);
    await _fileSaver.saveAsJson(map);
  }

  static Future<ReturnResult<String>> getPatchContent(
    String profileId,
    bool overwrite,
    Map<String, String>? overwriteRule,
    Map<String, ProfileSettingProxyGroup>? overwriteProxyGroups,
    List<String>? appendRules,
  ) async {
    if (Platform.isIOS || Platform.isMacOS) {
      _setting.Tun?.Stack = ClashTunStack.gvisor.name;
    }
    _setting.DNS?.IPv6 = _setting.IPv6;
    if (_setting.IPv6 == true) {
      _setting.Tun?.Inet6Address = [iNet6Address];
    } else {
      _setting.Tun?.Inet6Address = null;
    }
    if (_setting.Tun?.Inet4Address == null ||
        _setting.Tun!.Inet4Address!.isEmpty ||
        !_setting.Tun!.Inet4Address!.first.contains("/")) {
      _setting.Tun?.Inet4Address = [iNet4Address];
    }
    final parts = _setting.Tun?.Inet4Address!.first.split('/');
    if (parts != null && parts.length == 2) {
      _setting.DNS?.FakeIPRange = "${parts[0]}/16";
    }

    _setting.OverWriteRuleProviders = false;
    _setting.OverWriteRules = false;
    _setting.OverWriteSubRules = false;
    _setting.Rules = null;
    _setting.RuleProviders = null;
    _setting.ProxyGroups = null;
    _setting.Extension?.ProfileStoreSelectedPrefix = profileId;
    if (Platform.isIOS) {
      _setting.FindProcessMode = ClashFindProcessMode.off.name;
    }

    if (overwriteRule != null && overwriteRule.isNotEmpty) {
      _setting.OverWriteRuleProviders = true;
      _setting.OverWriteRules = true;
      _setting.OverWriteSubRules = true;

      List<RuleProvider> newAllProviders = [];
      final allProviders = DiversionTemplateManager.getRuleProviders();
      final templates = DiversionTemplateManager.getRuleTemplates();
      Set<String> targets = {};
      for (var template in templates) {
        final target = overwriteRule[template.name];
        if (target != null && target.isNotEmpty) {
          targets.add(target);
          _setting.Rules ??= [];
          final providers = allProviders.where((ele) {
            return template.getProviders().contains(ele.name);
          });
          newAllProviders.addAll(providers);
          for (var rule in template.rules) {
            String ruleWithTarget = "";
            if (rule.endsWith(",NO-RESOLVE")) {
              ruleWithTarget =
                  "${rule.substring(0, rule.length - ",NO-RESOLVE".length)},$target,NO-RESOLVE";
            } else {
              ruleWithTarget = "$rule,$target";
            }

            if (!_setting.Rules!.contains(ruleWithTarget)) {
              _setting.Rules!.add(ruleWithTarget);
            }
          }
        }
      }
      if (newAllProviders.isNotEmpty) {
        _setting.RuleProviders ??= {};
        for (var provider in newAllProviders) {
          _setting.RuleProviders![provider.name] = provider.toJsonNoName();
        }
      }
      if (overwriteProxyGroups != null && overwriteProxyGroups.isNotEmpty) {
        _setting.OverWriteProxyGroups = true;
        final pgTemplates = DiversionTemplateManager.getProxyGroupTemplates();
        _setting.ProxyGroups ??= [];
        for (var template in pgTemplates) {
          final pg = overwriteProxyGroups[template.name];
          if (pg == null) {
            return ReturnResult(
              error: ReturnResultError(
                "${t.meta.proxyGroups} [${template.name}]: not exist",
              ),
            );
          }
          if (pg.proxies.isEmpty) {
            return ReturnResult(
              error: ReturnResultError(
                "${t.meta.proxyGroups} [${template.name}]->[${t.meta.proxyNodeList}] is empty",
              ),
            );
          }
          var newTemplate = template.clone();
          newTemplate.proxies = pg.proxies;
          _setting.ProxyGroups!.add(newTemplate.toJson());
        }
      }
    }
    _setting.Extension?.AppendRules = appendRules;
    if (overwrite) {
      final map = _setting.toJson();
      MapHelper.removeNullOrEmpty(map, true, true);

      const JsonEncoder encoder = JsonEncoder.withIndent('  ');
      String content = encoder.convert(map);
      return ReturnResult(data: content);
    }
    return ReturnResult(data: getPatchFinalContent());
  }

  static String getPatchFinalContent() {
    final setting = defaultConfigNoOverwrite();
    final map = setting.toJson();
    MapHelper.removeNullOrEmpty(map, true, true);
    const JsonEncoder encoder = JsonEncoder.withIndent('  ');
    String content = encoder.convert(map);
    return content;
  }

  static Future<ReturnResultError?> saveCorePatchFinal(
    String profileId,
    bool overwrite,
    Map<String, String>? overwriteRule,
    Map<String, ProfileSettingProxyGroup>? overwriteProxyGroups,
    List<String>? appendRules,
  ) async {
    final result = await getPatchContent(
      profileId,
      overwrite,
      overwriteRule,
      overwriteProxyGroups,
      appendRules,
    );
    if (result.error != null) {
      return result.error;
    }
    String filePath = await PathUtils.serviceCorePatchFinalPath();
    try {
      await File(filePath).writeAsString(result.data!, flush: true);
    } catch (err, stacktrace) {
      return ReturnResultError(err.toString());
    }
    return null;
  }

  static Future<void> load() async {
    String filePath = await PathUtils.serviceCoreSettingFilePath();
    var file = File(filePath);
    bool exists = await file.exists();
    if (exists) {
      try {
        String content = await file.readAsString();
        if (content.isNotEmpty) {
          await _load(content);
        }
      } catch (err, stacktrace) {
        Log.w("ClashSettingManager.load exception ${err.toString()} ");
      }
    } else {
      await save();
    }
    await _initFixed();
  }

  static Future<void> _load(String content) async {
    late RawConfig setting;
    try {
      var config = jsonDecode(content);
      setting = RawConfig.fromJson(config);
    } catch (err, stacktrace) {
      Log.w("ClashSettingManager.load exception ${err.toString()} ");
      _setting = defaultConfig();
      await save();
      return;
    }
    _setting = setting;
    _setting.MixedPort ??= 7890;
    _setting.DNS ??= defaultDNS();
    _setting.NTP ??= defaultNTP();
    _setting.Tun ??= defaultTun();

    _setting.Sniffer ??= defaultSniffer();
    _setting.TLS ??= defaultTLS();
    _setting.Extension ??= defaultExtension();
    if (_setting.Extension?.Tun.perApp.PackageIds != null) {
      _setting.Extension?.Tun.perApp.PackageIds!.removeWhere(
        (element) => element == AppUtils.getId(),
      );
    }

    if (_setting.Extension?.Ruleset.AsnUrl ==
        "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/geo/asn") {
      _setting.Extension?.Ruleset.AsnUrl =
          "https://raw.githubusercontent.com/MetaCubeX/meta-rules-dat/refs/heads/meta/asn";
      await save();
    }
  }

  static Future<void> _initFixed() async {
    if (_setting.Secret == null || _setting.Secret!.isEmpty) {
      _setting.Secret = await getSecretFromDid();
    }
    _setting.UnifiedDelay = true;
    _setting.ExternalUI = "";
    _setting.ExternalUIName = "";
    _setting.ExternalUIURL = "";
    _setting.ExternalControllerCors = null;
    _setting.Tun?.Device = AppUtils.getName();
    _setting.Tun?.AutoRedirect = Platform.isLinux;
    _setting.Tun?.AutoRoute = !Platform.isAndroid;
    _setting.Tun?.AutoDetectInterface = Platform.isWindows || Platform.isLinux;
    _setting.Profile = RawProfile.by(StoreSelected: true, StoreFakeIP: true);
    _setting.Extension?.RuntimeProfileSavePath =
        await PathUtils.serviceCoreRuntimeProfileFilePath();
  }

  static Future<ReturnResultError?> setConfigsMode(
    ClashConfigsMode mode,
  ) async {
    _setting.Mode = mode.name;
    await save();
    for (var callback in onEventModeChanged) {
      callback();
    }

    bool run = await VPNService.getStarted();
    if (!run) {
      return null;
    }
    return await ClashHttpApi.setConfigsMode(mode.name);
  }

  static ClashConfigsMode getConfigsMode() {
    for (var i = 0; i <= ClashConfigsMode.direct.index; ++i) {
      ClashConfigsMode type = ClashConfigsMode.values[i];
      if (type.name == _setting.Mode) {
        return type;
      }
    }

    return ClashConfigsMode.rule;
  }

  static RawConfig getConfig() {
    return _setting;
  }

  static Future<void> reset() async {
    _setting = defaultConfig();
    await _initFixed();
  }

  static int getControlPort() {
    final parts = _setting.ExternalController?.split(':');
    if (parts?.length == 2) {
      return int.tryParse(parts![1]) ?? 0;
    }
    return 0;
  }

  static int getMixedPort() {
    return _setting.MixedPort ?? 7890;
  }
}
