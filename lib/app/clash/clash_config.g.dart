// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clash_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RawExtensionTunHttpProxy _$RawExtensionTunHttpProxyFromJson(
  Map<String, dynamic> json,
) => RawExtensionTunHttpProxy(
  json['enable'] as bool?,
  json['server'] as String?,
  (json['server_port'] as num?)?.toInt(),
  (json['bypass_domain'] as List<dynamic>?)?.map((e) => e as String).toList(),
  (json['match_domain'] as List<dynamic>?)?.map((e) => e as String).toList(),
  json['allow_bypass'] as bool?,
);

Map<String, dynamic> _$RawExtensionTunHttpProxyToJson(
  RawExtensionTunHttpProxy instance,
) => <String, dynamic>{
  'enable': instance.Enable,
  'server': instance.Server,
  'server_port': instance.ServerPort,
  'bypass_domain': instance.BypassDomain,
  'match_domain': instance.MatchDomain,
  'allow_bypass': instance.AllowBypass,
};

RawExtensionTunPerApp _$RawExtensionTunPerAppFromJson(
  Map<String, dynamic> json,
) => RawExtensionTunPerApp(
  json['enable'] as bool?,
  json['white_list'] as bool?,
  (json['package_ids'] as List<dynamic>?)?.map((e) => e as String).toList(),
);

Map<String, dynamic> _$RawExtensionTunPerAppToJson(
  RawExtensionTunPerApp instance,
) => <String, dynamic>{
  'enable': instance.Enable,
  'white_list': instance.WhiteList,
  'package_ids': instance.PackageIds,
};

RawExtensionGeoRuleset _$RawExtensionGeoRulesetFromJson(
  Map<String, dynamic> json,
) => RawExtensionGeoRuleset(
  json['geosite_url'] as String?,
  json['geoip_url'] as String?,
  json['asn_url'] as String?,
  (json['update-interval'] as num?)?.toInt(),
  json['enable-proxy'] as bool?,
);

Map<String, dynamic> _$RawExtensionGeoRulesetToJson(
  RawExtensionGeoRuleset instance,
) => <String, dynamic>{
  'geosite_url': instance.GeoSiteUrl,
  'geoip_url': instance.GeoIpUrl,
  'asn_url': instance.AsnUrl,
  'update-interval': instance.UpdateInterval,
  'enable-proxy': instance.EnableProxy,
};

RawExtensionTun _$RawExtensionTunFromJson(Map<String, dynamic> json) =>
    RawExtensionTun(
        RawExtensionTunHttpProxy.fromJson(
          json['http_proxy'] as Map<String, dynamic>,
        ),
        RawExtensionTunPerApp.fromJson(json['per_app'] as Map<String, dynamic>),
        json['auto_route_use_sub_ranges_by_default'] as bool?,
      )
      ..includeAllNetworks = json['include_all_networks'] as bool?
      ..excludeLocalNetworks = json['exclude_local_networks'] as bool?
      ..excludeCellularServices = json['exclude_cellular_services'] as bool?
      ..excludeApns = json['exclude_apns'] as bool?
      ..excludeDeviceCommunication =
          json['exclude_device_communication'] as bool?
      ..enforceRoutes = json['enforce_routes'] as bool?;

Map<String, dynamic> _$RawExtensionTunToJson(RawExtensionTun instance) =>
    <String, dynamic>{
      'http_proxy': instance.httpProxy.toJson(),
      'per_app': instance.perApp.toJson(),
      'include_all_networks': instance.includeAllNetworks,
      'exclude_local_networks': instance.excludeLocalNetworks,
      'exclude_cellular_services': instance.excludeCellularServices,
      'exclude_apns': instance.excludeApns,
      'exclude_device_communication': instance.excludeDeviceCommunication,
      'enforce_routes': instance.enforceRoutes,
      'auto_route_use_sub_ranges_by_default':
          instance.autoRouteUseSubRangesByDefault,
    };

RawExtension _$RawExtensionFromJson(Map<String, dynamic> json) =>
    RawExtension(
        (json['append_rules'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        RawExtensionGeoRuleset.fromJson(
          json['geo-rule-set'] as Map<String, dynamic>,
        ),
        RawExtensionTun.fromJson(json['tun'] as Map<String, dynamic>),
        json['age-secret-key'] as String?,
        json['pprof-addr'] as String?,
        json['proxy-group-replace'] as String?,
        json['runtime-profile-save-path'] as String?,
      )
      ..ProfileStoreSelectedPrefix =
          json['profile-store-selected-prefix'] as String?;

Map<String, dynamic> _$RawExtensionToJson(RawExtension instance) =>
    <String, dynamic>{
      'append_rules': instance.AppendRules,
      'geo-rule-set': instance.Ruleset.toJson(),
      'profile-store-selected-prefix': instance.ProfileStoreSelectedPrefix,
      'tun': instance.Tun.toJson(),
      'age-secret-key': instance.AgeSecretKey,
      'pprof-addr': instance.PprofAddr,
      'proxy-group-replace': instance.ProxyGroupReplace,
      'runtime-profile-save-path': instance.RuntimeProfileSavePath,
    };

RawTunnel _$RawTunnelFromJson(Map<String, dynamic> json) => RawTunnel(
  json['overwrite'] as bool?,
  (json['network'] as List<dynamic>?)?.map((e) => e as String).toList(),
  json['address'] as String?,
  json['target'] as String?,
  json['proxy'] as String?,
);

Map<String, dynamic> _$RawTunnelToJson(RawTunnel instance) => <String, dynamic>{
  'overwrite': instance.OverWrite,
  'network': instance.Network,
  'address': instance.Address,
  'target': instance.Target,
  'proxy': instance.Proxy,
};

RawCors _$RawCorsFromJson(Map<String, dynamic> json) => RawCors(
  json['overwrite'] as bool?,
  (json['allow-origins'] as List<dynamic>?)?.map((e) => e as String).toList(),
  json['allow-private-network'] as bool?,
);

Map<String, dynamic> _$RawCorsToJson(RawCors instance) => <String, dynamic>{
  'overwrite': instance.OverWrite,
  'allow-origins': instance.AllowOrigins,
  'allow-private-network': instance.AllowPrivateNetwork,
};

RawDNS _$RawDNSFromJson(Map<String, dynamic> json) => RawDNS(
  json['overwrite'] as bool?,
  json['enable'] as bool?,
  json['prefer-h3'] as bool?,
  json['ipv6'] as bool?,
  (json['ipv6-timeout'] as num?)?.toInt(),
  json['use-hosts'] as bool?,
  json['use-system-hosts'] as bool?,
  json['respect-rules'] as bool?,
  (json['nameserver'] as List<dynamic>?)?.map((e) => e as String).toList(),
  (json['fallback'] as List<dynamic>?)?.map((e) => e as String).toList(),
  json['fallback-filter'] == null
      ? null
      : RawFallbackFilter.fromJson(
          json['fallback-filter'] as Map<String, dynamic>,
        ),
  json['listen'] as String?,
  json['enhanced-mode'] as String?,
  json['fake-ip-range'] as String?,
  (json['fake-ip-filter'] as List<dynamic>?)?.map((e) => e as String).toList(),
  json['fake-ip-filter-mode'] as String?,
  (json['default-nameserver'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  json['cache-algorithm'] as String?,
  json['nameserver-policy'] as Map<String, dynamic>?,
  (json['proxy-server-nameserver'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  (json['direct-nameserver'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  json['direct-nameserver-follow-policy'] as bool?,
)..OverwriteNameServerPolicy = json['overwrite-nameserver-policy'] as bool?;

Map<String, dynamic> _$RawDNSToJson(RawDNS instance) => <String, dynamic>{
  'overwrite': instance.OverWrite,
  'enable': instance.Enable,
  'prefer-h3': instance.PreferH3,
  'ipv6': instance.IPv6,
  'ipv6-timeout': instance.IPv6Timeout,
  'use-hosts': instance.UseHosts,
  'use-system-hosts': instance.UseSystemHosts,
  'respect-rules': instance.RespectRules,
  'nameserver': instance.NameServer,
  'fallback': instance.Fallback,
  'fallback-filter': instance.FallbackFilter?.toJson(),
  'listen': instance.Listen,
  'enhanced-mode': instance.EnhancedMode,
  'fake-ip-range': instance.FakeIPRange,
  'fake-ip-filter': instance.FakeIPFilter,
  'fake-ip-filter-mode': instance.FakeIPFilterMode,
  'default-nameserver': instance.DefaultNameserver,
  'cache-algorithm': instance.CacheAlgorithm,
  'overwrite-nameserver-policy': instance.OverwriteNameServerPolicy,
  'nameserver-policy': instance.NameServerPolicy,
  'proxy-server-nameserver': instance.ProxyServerNameserver,
  'direct-nameserver': instance.DirectNameServer,
  'direct-nameserver-follow-policy': instance.DirectNameServerFollowPolicy,
};

RawFallbackFilter _$RawFallbackFilterFromJson(Map<String, dynamic> json) =>
    RawFallbackFilter(
      json['geoip'] as bool?,
      json['geoip-code'] as String?,
      (json['ipcidr'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['domain'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['domageositein'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$RawFallbackFilterToJson(RawFallbackFilter instance) =>
    <String, dynamic>{
      'geoip': instance.GeoIP,
      'geoip-code': instance.GeoIPCode,
      'ipcidr': instance.IPCIDR,
      'domain': instance.Domain,
      'domageositein': instance.GeoSite,
    };

RawClashForAndroid _$RawClashForAndroidFromJson(Map<String, dynamic> json) =>
    RawClashForAndroid(
      json['overwrite'] as bool?,
      json['append-system-dns'] as bool?,
      json['ui-subtitle-pattern'] as String?,
    );

Map<String, dynamic> _$RawClashForAndroidToJson(RawClashForAndroid instance) =>
    <String, dynamic>{
      'overwrite': instance.OverWrite,
      'append-system-dns': instance.AppendSystemDNS,
      'ui-subtitle-pattern': instance.UiSubtitlePattern,
    };

RawNTP _$RawNTPFromJson(Map<String, dynamic> json) => RawNTP(
  json['overwrite'] as bool?,
  json['enable'] as bool?,
  json['server'] as String?,
  (json['port'] as num?)?.toInt(),
  (json['interval'] as num?)?.toInt(),
  json['dialer-proxy'] as String?,
  json['write-to-system'] as bool?,
);

Map<String, dynamic> _$RawNTPToJson(RawNTP instance) => <String, dynamic>{
  'overwrite': instance.OverWrite,
  'enable': instance.Enable,
  'server': instance.Server,
  'port': instance.Port,
  'interval': instance.Interval,
  'dialer-proxy': instance.DialerProxy,
  'write-to-system': instance.WriteToSystem,
};

RawTun _$RawTunFromJson(Map<String, dynamic> json) => RawTun(
  json['overwrite'] as bool?,
  json['enable'] as bool?,
  json['device'] as String?,
  json['stack'] as String?,
  (json['dns-hijack'] as List<dynamic>?)?.map((e) => e as String).toList(),
  json['auto-route'] as bool?,
  json['auto-detect-interface'] as bool?,
  (json['mtu'] as num?)?.toInt(),
  json['gso'] as bool?,
  (json['gso-max-size'] as num?)?.toInt(),
  (json['inet4-address'] as List<dynamic>?)?.map((e) => e as String).toList(),
  (json['inet6-address'] as List<dynamic>?)?.map((e) => e as String).toList(),
  (json['iproute2-table-index'] as num?)?.toInt(),
  (json['iproute2-rule-index'] as num?)?.toInt(),
  json['auto-redirect'] as bool?,
  (json['auto-redirect-input-mark'] as num?)?.toInt(),
  (json['auto-redirect-output-mark'] as num?)?.toInt(),
  json['strict-route'] as bool?,
  json['disable-icmp-forwarding'] as bool?,
  (json['route-address'] as List<dynamic>?)?.map((e) => e as String).toList(),
  (json['route-address-set'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  (json['route-exclude-address'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  (json['route-exclude-address-set'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  (json['include-interface'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  (json['exclude-interface'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  (json['include-uid'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  (json['include-uid-range'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  (json['exclude-uid'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  (json['exclude-uid-range'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  (json['include-android-user'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
  (json['include-package'] as List<dynamic>?)?.map((e) => e as String).toList(),
  (json['exclude-package'] as List<dynamic>?)?.map((e) => e as String).toList(),
  json['endpoint-independent-nat'] as bool?,
  (json['udp-timeout'] as num?)?.toInt(),
  (json['file-descriptor'] as num?)?.toInt(),
  (json['inet4-route-address'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  (json['inet6-route-address'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  (json['inet4-route-exclude-address'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  (json['inet6-route-exclude-address'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$RawTunToJson(RawTun instance) => <String, dynamic>{
  'overwrite': instance.OverWrite,
  'enable': instance.Enable,
  'device': instance.Device,
  'stack': instance.Stack,
  'dns-hijack': instance.DNSHijack,
  'auto-route': instance.AutoRoute,
  'auto-detect-interface': instance.AutoDetectInterface,
  'mtu': instance.MTU,
  'gso': instance.GSO,
  'gso-max-size': instance.GSOMaxSize,
  'inet4-address': instance.Inet4Address,
  'inet6-address': instance.Inet6Address,
  'iproute2-table-index': instance.IPRoute2TableIndex,
  'iproute2-rule-index': instance.IPRoute2RuleIndex,
  'auto-redirect': instance.AutoRedirect,
  'auto-redirect-input-mark': instance.AutoRedirectInputMark,
  'auto-redirect-output-mark': instance.AutoRedirectOutputMark,
  'strict-route': instance.StrictRoute,
  'disable-icmp-forwarding': instance.DisableICMPForwarding,
  'route-address': instance.RouteAddress,
  'route-address-set': instance.RouteAddressSet,
  'route-exclude-address': instance.RouteExcludeAddress,
  'route-exclude-address-set': instance.RouteExcludeAddressSet,
  'include-interface': instance.IncludeInterface,
  'exclude-interface': instance.ExcludeInterface,
  'include-uid': instance.IncludeUID,
  'include-uid-range': instance.IncludeUIDRange,
  'exclude-uid': instance.ExcludeUID,
  'exclude-uid-range': instance.ExcludeUIDRange,
  'include-android-user': instance.IncludeAndroidUser,
  'include-package': instance.IncludePackage,
  'exclude-package': instance.ExcludePackage,
  'endpoint-independent-nat': instance.EndpointIndependentNat,
  'udp-timeout': instance.UDPTimeout,
  'file-descriptor': instance.FileDescriptor,
  'inet4-route-address': instance.Inet4RouteAddress,
  'inet6-route-address': instance.Inet6RouteAddress,
  'inet4-route-exclude-address': instance.Inet4RouteExcludeAddress,
  'inet6-route-exclude-address': instance.Inet6RouteExcludeAddress,
};

RawTuicServer _$RawTuicServerFromJson(Map<String, dynamic> json) =>
    RawTuicServer(
      json['overwrite'] as bool?,
      json['enable'] as bool?,
      json['listen'] as String?,
      (json['token'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['users'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ),
      json['certificate'] as String?,
      json['private-key'] as String?,
      json['congestion-controller'] as String?,
      (json['max-idle-time'] as num?)?.toInt(),
      (json['authentication-timeout'] as num?)?.toInt(),
      (json['alpn'] as List<dynamic>?)?.map((e) => e as String).toList(),
      (json['max-udp-relay-packet-size'] as num?)?.toInt(),
      (json['cwnd'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RawTuicServerToJson(RawTuicServer instance) =>
    <String, dynamic>{
      'overwrite': instance.OverWrite,
      'enable': instance.Enable,
      'listen': instance.Listen,
      'token': instance.Token,
      'users': instance.Users,
      'certificate': instance.Certificate,
      'private-key': instance.PrivateKey,
      'congestion-controller': instance.CongestionController,
      'max-idle-time': instance.MaxIdleTime,
      'authentication-timeout': instance.AuthenticationTimeout,
      'alpn': instance.ALPN,
      'max-udp-relay-packet-size': instance.MaxUdpRelayPacketSize,
      'cwnd': instance.CWND,
    };

RawIPTables _$RawIPTablesFromJson(Map<String, dynamic> json) => RawIPTables(
  json['overwrite'] as bool?,
  json['enable'] as bool?,
  json['inbound-interface'] as String?,
  (json['bypass'] as List<dynamic>?)?.map((e) => e as String).toList(),
  json['dns-redirect'] as bool?,
);

Map<String, dynamic> _$RawIPTablesToJson(RawIPTables instance) =>
    <String, dynamic>{
      'overwrite': instance.OverWrite,
      'enable': instance.Enable,
      'inbound-interface': instance.InboundInterface,
      'bypass': instance.Bypass,
      'dns-redirect': instance.DnsRedirect,
    };

RawExperimental _$RawExperimentalFromJson(Map<String, dynamic> json) =>
    RawExperimental(
      json['overwrite'] as bool?,
      (json['fingerprints'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      json['quic-go-disable-gso'] as bool?,
      json['quic-go-disable-ecn'] as bool?,
      json['dialer-ip4p-convert'] as bool?,
    );

Map<String, dynamic> _$RawExperimentalToJson(RawExperimental instance) =>
    <String, dynamic>{
      'overwrite': instance.OverWrite,
      'fingerprints': instance.Fingerprints,
      'quic-go-disable-gso': instance.QUICGoDisableGSO,
      'quic-go-disable-ecn': instance.QUICGoDisableECN,
      'dialer-ip4p-convert': instance.IP4PEnable,
    };

RawProfile _$RawProfileFromJson(Map<String, dynamic> json) =>
    RawProfile(json['store-selected'] as bool?, json['store-fake-ip'] as bool?);

Map<String, dynamic> _$RawProfileToJson(RawProfile instance) =>
    <String, dynamic>{
      'store-selected': instance.StoreSelected,
      'store-fake-ip': instance.StoreFakeIP,
    };

RawGeoXUrl _$RawGeoXUrlFromJson(Map<String, dynamic> json) => RawGeoXUrl(
  json['overwrite'] as bool?,
  json['geoip'] as String?,
  json['mmdb'] as String?,
  json['asn'] as String?,
  json['geosite'] as String?,
);

Map<String, dynamic> _$RawGeoXUrlToJson(RawGeoXUrl instance) =>
    <String, dynamic>{
      'overwrite': instance.OverWrite,
      'geoip': instance.GeoIp,
      'mmdb': instance.Mmdb,
      'asn': instance.ASN,
      'geosite': instance.GeoSite,
    };

RawSniffer _$RawSnifferFromJson(Map<String, dynamic> json) => RawSniffer(
  json['overwrite'] as bool?,
  json['enable'] as bool?,
  json['override-destination'] as bool?,
  (json['sniffing'] as List<dynamic>?)?.map((e) => e as String).toList(),
  (json['force-domain'] as List<dynamic>?)?.map((e) => e as String).toList(),
  (json['skip-src-address'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  (json['skip-dst-address'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  (json['skip-domain'] as List<dynamic>?)?.map((e) => e as String).toList(),
  (json['port-whitelist'] as List<dynamic>?)?.map((e) => e as String).toList(),
  json['force-dns-mapping'] as bool?,
  json['parse-pure-ip'] as bool?,
  (json['sniff'] as Map<String, dynamic>?)?.map(
    (k, e) =>
        MapEntry(k, RawSniffingConfig.fromJson(e as Map<String, dynamic>)),
  ),
);

Map<String, dynamic> _$RawSnifferToJson(RawSniffer instance) =>
    <String, dynamic>{
      'overwrite': instance.OverWrite,
      'enable': instance.Enable,
      'override-destination': instance.OverrideDest,
      'sniffing': instance.Sniffing,
      'force-domain': instance.ForceDomain,
      'skip-src-address': instance.SkipSrcAddress,
      'skip-dst-address': instance.SkipDstAddress,
      'skip-domain': instance.SkipDomain,
      'port-whitelist': instance.Ports,
      'force-dns-mapping': instance.ForceDnsMapping,
      'parse-pure-ip': instance.ParsePureIp,
      'sniff': instance.Sniff?.map((k, e) => MapEntry(k, e.toJson())),
    };

RawSniffingConfig _$RawSniffingConfigFromJson(Map<String, dynamic> json) =>
    RawSniffingConfig(
      (json['ports'] as List<dynamic>?)?.map((e) => e as String).toList(),
      json['override-destination'] as bool?,
    );

Map<String, dynamic> _$RawSniffingConfigToJson(RawSniffingConfig instance) =>
    <String, dynamic>{
      'ports': instance.Ports,
      'override-destination': instance.OverrideDest,
    };

RawTLS _$RawTLSFromJson(Map<String, dynamic> json) => RawTLS(
  json['overwrite'] as bool?,
  json['certificate'] as String?,
  json['private-key'] as String?,
  (json['custom-certifactes'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$RawTLSToJson(RawTLS instance) => <String, dynamic>{
  'overwrite': instance.OverWrite,
  'certificate': instance.Certificate,
  'private-key': instance.PrivateKey,
  'custom-certifactes': instance.CustomTrustCert,
};

RawConfig _$RawConfigFromJson(Map<String, dynamic> json) =>
    RawConfig(
        (json['port'] as num?)?.toInt(),
        (json['socks-port'] as num?)?.toInt(),
        (json['redir-port'] as num?)?.toInt(),
        (json['tproxy-port'] as num?)?.toInt(),
        (json['mixed-port'] as num?)?.toInt(),
        json['ss-config'] as String?,
        json['vmess-config'] as String?,
        json['inbound-tfo'] as bool?,
        json['inbound-mptcp'] as bool?,
        (json['authentication'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        (json['skip-auth-prefixes'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        (json['lan-allowed-ips'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        (json['lan-disallowed-ips'] as List<dynamic>?)
            ?.map((e) => e as String)
            .toList(),
        json['allow-lan'] as bool?,
        json['bind-address'] as String?,
        json['mode'] as String?,
        json['unified-delay'] as bool?,
        json['log-level'] as String?,
        json['ipv6'] as bool?,
        json['external-controller'] as String?,
        json['external-controller-pipe'] as String?,
        json['external-controller-unix'] as String?,
        json['external-controller-tls'] as String?,
        json['external-controller-cors'] == null
            ? null
            : RawCors.fromJson(
                json['external-controller-cors'] as Map<String, dynamic>,
              ),
        json['external-ui'] as String?,
        json['external-ui-url'] as String?,
        json['external-ui-name'] as String?,
        json['external-doh-server'] as String?,
        json['secret'] as String?,
        json['interface-name'] as String?,
        (json['routing-mark'] as num?)?.toInt(),
        (json['tunnels'] as List<dynamic>?)
            ?.map((e) => RawTunnel.fromJson(e as Map<String, dynamic>))
            .toList(),
        json['geo-auto-update'] as bool?,
        (json['geo-update-interval'] as num?)?.toInt(),
        json['geodata-mode'] as bool?,
        json['geodata-loader'] as String?,
        json['geosite-matcher'] as String?,
        json['tcp-concurrent'] as bool?,
        json['find-process-mode'] as String?,
        json['global-client-fingerprint'] as String?,
        json['global-ua'] as String?,
        json['etag-support'] as bool?,
        (json['keep-alive-idle'] as num?)?.toInt(),
        (json['keep-alive-interval'] as num?)?.toInt(),
        json['disable-keep-alive'] as bool?,
        json['overwrite-rule-providers'] as bool?,
        json['rule-providers'] as Map<String, dynamic>?,
        json['overwrite-rules'] as bool?,
        (json['rules'] as List<dynamic>?)?.map((e) => e as String).toList(),
        json['overwrite-sub-rules'] as bool?,
        (json['sub-rules'] as List<dynamic>?)?.map((e) => e as String).toList(),
        json['overwrite-proxy-groups'] as bool?,
        json['proxy-groups'] as List<dynamic>?,
        json['listeners'] as Map<String, dynamic>?,
        json['hosts'] as Map<String, dynamic>?,
        json['dns'] == null
            ? null
            : RawDNS.fromJson(json['dns'] as Map<String, dynamic>),
        json['ntp'] == null
            ? null
            : RawNTP.fromJson(json['ntp'] as Map<String, dynamic>),
        json['tun'] == null
            ? null
            : RawTun.fromJson(json['tun'] as Map<String, dynamic>),
        json['tuic-server'] == null
            ? null
            : RawTuicServer.fromJson(
                json['tuic-server'] as Map<String, dynamic>,
              ),
        json['iptables'] == null
            ? null
            : RawIPTables.fromJson(json['iptables'] as Map<String, dynamic>),
        json['experimental'] == null
            ? null
            : RawExperimental.fromJson(
                json['experimental'] as Map<String, dynamic>,
              ),
        json['profile'] == null
            ? null
            : RawProfile.fromJson(json['profile'] as Map<String, dynamic>),
        json['geox-url'] == null
            ? null
            : RawGeoXUrl.fromJson(json['geox-url'] as Map<String, dynamic>),
        json['sniffer'] == null
            ? null
            : RawSniffer.fromJson(json['sniffer'] as Map<String, dynamic>),
        json['tls'] == null
            ? null
            : RawTLS.fromJson(json['tls'] as Map<String, dynamic>),
        json['clash-for-android'] == null
            ? null
            : RawClashForAndroid.fromJson(
                json['clash-for-android'] as Map<String, dynamic>,
              ),
        json['extension'] == null
            ? null
            : RawExtension.fromJson(json['extension'] as Map<String, dynamic>),
      )
      ..OverwriteListeners = json['overwrite-listeners'] as bool?
      ..OverWriteHosts = json['overwrite-hosts'] as bool?;

Map<String, dynamic> _$RawConfigToJson(RawConfig instance) => <String, dynamic>{
  'port': instance.Port,
  'socks-port': instance.SocksPort,
  'redir-port': instance.RedirPort,
  'tproxy-port': instance.TProxyPort,
  'mixed-port': instance.MixedPort,
  'ss-config': instance.ShadowSocksConfig,
  'vmess-config': instance.VmessConfig,
  'inbound-tfo': instance.InboundTfo,
  'inbound-mptcp': instance.InboundMPTCP,
  'authentication': instance.Authentication,
  'skip-auth-prefixes': instance.SkipAuthPrefixes,
  'lan-allowed-ips': instance.LanAllowedIPs,
  'lan-disallowed-ips': instance.LanDisAllowedIPs,
  'allow-lan': instance.AllowLan,
  'bind-address': instance.BindAddress,
  'mode': instance.Mode,
  'unified-delay': instance.UnifiedDelay,
  'log-level': instance.LogLevel,
  'ipv6': instance.IPv6,
  'external-controller': instance.ExternalController,
  'external-controller-pipe': instance.ExternalControllerPipe,
  'external-controller-unix': instance.ExternalControllerUnix,
  'external-controller-tls': instance.ExternalControllerTLS,
  'external-controller-cors': instance.ExternalControllerCors?.toJson(),
  'external-ui': instance.ExternalUI,
  'external-ui-url': instance.ExternalUIURL,
  'external-ui-name': instance.ExternalUIName,
  'external-doh-server': instance.ExternalDohServer,
  'secret': instance.Secret,
  'interface-name': instance.Interface,
  'routing-mark': instance.RoutingMark,
  'tunnels': instance.Tunnels?.map((e) => e.toJson()).toList(),
  'geo-auto-update': instance.GeoAutoUpdate,
  'geo-update-interval': instance.GeoUpdateInterval,
  'geodata-mode': instance.GeodataMode,
  'geodata-loader': instance.GeodataLoader,
  'geosite-matcher': instance.GeositeMatcher,
  'tcp-concurrent': instance.TCPConcurrent,
  'find-process-mode': instance.FindProcessMode,
  'global-client-fingerprint': instance.GlobalClientFingerprint,
  'global-ua': instance.GlobalUA,
  'etag-support': instance.ETagSupport,
  'keep-alive-idle': instance.KeepAliveIdle,
  'keep-alive-interval': instance.KeepAliveInterval,
  'disable-keep-alive': instance.DisableKeepAlive,
  'overwrite-rule-providers': instance.OverWriteRuleProviders,
  'rule-providers': instance.RuleProviders,
  'overwrite-rules': instance.OverWriteRules,
  'rules': instance.Rules,
  'overwrite-sub-rules': instance.OverWriteSubRules,
  'sub-rules': instance.SubRules,
  'overwrite-proxy-groups': instance.OverWriteProxyGroups,
  'proxy-groups': instance.ProxyGroups,
  'overwrite-listeners': instance.OverwriteListeners,
  'listeners': instance.Listeners,
  'overwrite-hosts': instance.OverWriteHosts,
  'hosts': instance.Hosts,
  'dns': instance.DNS?.toJson(),
  'ntp': instance.NTP?.toJson(),
  'tun': instance.Tun?.toJson(),
  'tuic-server': instance.TuicServer?.toJson(),
  'iptables': instance.IPTables?.toJson(),
  'experimental': instance.Experimental?.toJson(),
  'profile': instance.Profile?.toJson(),
  'geox-url': instance.GeoXUrl?.toJson(),
  'sniffer': instance.Sniffer?.toJson(),
  'tls': instance.TLS?.toJson(),
  'clash-for-android': instance.ClashForAndroid?.toJson(),
  'extension': instance.Extension?.toJson(),
};
