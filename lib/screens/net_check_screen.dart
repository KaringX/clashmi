import 'dart:io';

import 'package:clashmi/app/clash/clash_http_api.dart';
import 'package:clashmi/app/modules/clash_setting_manager.dart';
import 'package:clashmi/app/utils/system_utils.dart';
import 'package:clashmi/i18n/strings.g.dart';
import 'package:clashmi/screens/theme_config.dart';
import 'package:clashmi/screens/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NetCheckScreen extends LasyRenderingStatefulWidget {
  static RouteSettings routSettings() {
    return const RouteSettings(name: 'NetCheckScreen');
  }

  const NetCheckScreen({super.key});

  @override
  State<NetCheckScreen> createState() => _NetCheckScreenState();
}

class _NetCheckScreenState extends LasyRenderingState<NetCheckScreen> {
  final TextEditingController _domainController = TextEditingController(
    text: 'example.com',
  );

  bool _checking = false;
  String _dnsResult = '';
  String _directHttpResult = '';
  String _proxyHttpResult = '';
  String _routeTableResult = '';

  @override
  void dispose() {
    _domainController.dispose();
    super.dispose();
  }

  Future<void> _startCheck() async {
    final domain = _domainController.text.trim();
    final tcontext = Translations.of(context);
    if (domain.isEmpty) {
      setState(() {
        _dnsResult = tcontext.NetCheckScreen.enterDomain;
        _directHttpResult = '';
        _proxyHttpResult = '';
      });
      return;
    }

    setState(() {
      _checking = true;
      _dnsResult = tcontext.NetCheckScreen.checking;
      _directHttpResult = tcontext.NetCheckScreen.checking;
      _proxyHttpResult = tcontext.NetCheckScreen.checking;
      _routeTableResult = tcontext.NetCheckScreen.checking;
    });

    final dnsResult = await _checkDns(domain, tcontext);
    if (!mounted) {
      return;
    }
    setState(() {
      _dnsResult = dnsResult;
    });
    String directResult = "";
    final result = await ClashHttpApi.getConfigs();
    if (result.error != null) {
      directResult = result.error!.message;
    } else {
      final configs = result.data!;
      if (configs.tun.enable) {
        directResult = await _checkHttpDirect(domain, tcontext);
      } else {
        directResult = tcontext.NetCheckScreen.tunNotEnabled;
      }
    }

    /*String connections = await FlutterVpnService.clashiApiConnections(true);
    print(connections + "\n");
    try {
      var obj = jsonDecode(connections);
      ClashConnections body = ClashConnections();
      body.fromJson(obj, true);
      for (var item in body.connections) {
        print(
          "start: ${item.start}, rule: ${item.rule}, rulePayload: ${item.rulePayload}, chains: ${item.chains.join(',')}, providerChains: ${item.providerChains.join(',')}",
        );
      }
    } catch (err) {}*/

    if (!mounted) {
      return;
    }
    setState(() {
      _directHttpResult = directResult;
    });
    final proxyResult = await _checkHttpWithMixPort(domain, tcontext);
    if (!mounted) {
      return;
    }
    setState(() {
      _proxyHttpResult = proxyResult;
    });
    if (!Platform.isIOS) {
      final routeTableResult = await SystemUtils.getRouteTable();
      if (!mounted) {
        return;
      }
      setState(() {
        _routeTableResult = routeTableResult;
      });
    }
    setState(() {
      _checking = false;
    });
  }

  Future<String> _checkDns(String domain, Translations tcontext) async {
    final aResult = await ClashHttpApi.dnsQuery(domain, queryType: 'A');
    final aaaaResult = await ClashHttpApi.dnsQuery(domain, queryType: 'AAAA');

    final lines = <String>[];

    if (aResult.error == null) {
      final aList = aResult.data ?? [];
      lines.add(aList.isEmpty ? 'A: <empty>' : 'A: ${aList.join(', ')}');
    } else {
      lines.add(
        tcontext.NetCheckScreen.aQueryFailed(p: aResult.error!.message),
      );
    }

    if (aaaaResult.error == null) {
      final aaaaList = aaaaResult.data ?? [];
      lines.add(
        aaaaList.isEmpty ? 'AAAA: <empty>' : 'AAAA: ${aaaaList.join(', ')}',
      );
    } else {
      lines.add(
        tcontext.NetCheckScreen.aaaaQueryFailed(p: aaaaResult.error!.message),
      );
    }

    return lines.join('\n');
  }

  Future<String> _checkHttpDirect(String domain, Translations tcontext) async {
    return _checkHttp(domain, tcontext, proxyPort: null);
  }

  Future<String> _checkHttpWithMixPort(
    String domain,
    Translations tcontext,
  ) async {
    final mixPort = ClashSettingManager.getMixedPort();
    return _checkHttp(domain, tcontext, proxyPort: mixPort);
  }

  Future<String> _checkHttp(
    String domain,
    Translations tcontext, {
    int? proxyPort,
  }) async {
    HttpClient? client;
    try {
      final uri = Uri(scheme: 'https', host: domain, path: '/');
      client = HttpClient();
      const timeout = Duration(seconds: 10);
      client.connectionTimeout = timeout;

      if (proxyPort == null) {
        client.findProxy = (uri) => 'DIRECT';
      } else {
        client.findProxy = (uri) => 'PROXY 127.0.0.1:$proxyPort';
      }

      final request = await client.getUrl(uri).timeout(timeout);
      request.headers.set(HttpHeaders.userAgentHeader, 'clashmi-net-check/1.0');
      final response = await request.close().timeout(timeout);

      final statusLine =
          'HTTP Status:${response.statusCode} ${response.reasonPhrase}'.trim();

      if (response.statusCode == 200) {
        final lines = [tcontext.NetCheckScreen.success, 'HTTP Status: 200'];
        return lines.join('\n');
      }

      final lines = [tcontext.NetCheckScreen.failed, statusLine];
      return lines.join('\n');
    } catch (err) {
      return err.toString();
    } finally {
      client?.close(force: true);
    }
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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
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
                    width: windowSize.width - 50 * 3,
                    child: Text(
                      tcontext.meta.networkCheck,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontWeight: ThemeConfig.kFontWeightTitle,
                        fontSize: ThemeConfig.kFontSizeTitle,
                      ),
                    ),
                  ),
                  _checking || _proxyHttpResult.isEmpty
                      ? const SizedBox(width: 50, height: 30)
                      : InkWell(
                          onTap: () async {
                            try {
                              await Clipboard.setData(
                                ClipboardData(
                                  text: [
                                    "OS: ${Platform.operatingSystem}",
                                    '1. DNS:',
                                    _dnsResult,
                                    '2. HTTP Via TUN:',
                                    _directHttpResult,
                                    '3. HTTP Via Proxy:',
                                    _proxyHttpResult,
                                    if (!Platform.isIOS) ...[
                                      '4. Route Table:',
                                      _routeTableResult,
                                    ],
                                  ].join('\n\n'),
                                ),
                              );
                            } catch (e) {}
                          },
                          child: SizedBox(
                            width: 50,
                            height: 30,
                            child: Icon(Icons.copy, size: 26),
                          ),
                        ),
                ],
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextField(
                        controller: _domainController,
                        decoration: InputDecoration(
                          labelText: tcontext.NetCheckScreen.domainLabel,
                          hintText: 'example.com',
                          border: const OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (_) => _startCheck(),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: _checking ? null : _startCheck,
                        child: _checking
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(tcontext.NetCheckScreen.checkButton),
                      ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView(
                          children: [
                            Text(" OS: ${Platform.operatingSystem}"),
                            const SizedBox(height: 12),
                            _buildSection(
                              tcontext.NetCheckScreen.dnsSection,
                              _dnsResult,
                            ),
                            const SizedBox(height: 12),
                            _buildSection(
                              tcontext.NetCheckScreen.directHttpSection,
                              _directHttpResult,
                            ),
                            const SizedBox(height: 12),
                            _buildSection(
                              tcontext.NetCheckScreen.proxyHttpSection(
                                p: ClashSettingManager.getMixedPort(),
                              ),
                              _proxyHttpResult,
                            ),
                            if (!Platform.isIOS) ...[
                              const SizedBox(height: 12),
                              _buildSection(
                                tcontext.NetCheckScreen.routeTableSection,
                                _routeTableResult,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            if (content.isNotEmpty) ...[
              const SizedBox(height: 8),
              SelectableText(content),
            ],
          ],
        ),
      ),
    );
  }
}
