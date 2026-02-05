import 'dart:convert';
import 'dart:io';

import 'package:clashmi/app/local_services/vpn_service.dart';
import 'package:clashmi/app/modules/profile_manager.dart';
import 'package:clashmi/app/runtime/return_result.dart';
import 'package:clashmi/app/utils/http_utils.dart';
import 'package:clashmi/app/utils/path_utils.dart';
import 'package:libclash_vpn_service/vpn_service.dart';
import 'package:path/path.dart' as path;

class NodeGroupSummary {
  NodeGroupSummary({required this.id, required this.name});

  final String id;
  final String name;

  factory NodeGroupSummary.fromJson(Map<String, dynamic> json) {
    return NodeGroupSummary(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
    );
  }
}

class NodeDetail {
  NodeDetail({
    required this.version,
    required this.name,
    required this.address,
    required this.port,
    required this.uuid,
    required this.alterId,
    required this.cipher,
    required this.network,
    required this.headerType,
    required this.host,
    required this.path,
    required this.tls,
    required this.sni,
  });

  final String version;
  final String name;
  final String address;
  final int port;
  final String uuid;
  final int alterId;
  final String cipher;
  final String network;
  final String headerType;
  final String host;
  final String path;
  final String tls;
  final String sni;

  factory NodeDetail.fromJson(Map<String, dynamic> json) {
    return NodeDetail(
      version: json['v']?.toString() ?? '',
      name: json['ps']?.toString() ?? '',
      address: json['add']?.toString() ?? '',
      port: int.tryParse(json['port']?.toString() ?? '') ?? 0,
      uuid: json['id']?.toString() ?? '',
      alterId: int.tryParse(json['aid']?.toString() ?? '') ?? 0,
      cipher: json['scy']?.toString() ?? 'auto',
      network: json['net']?.toString() ?? 'tcp',
      headerType: json['type']?.toString() ?? 'none',
      host: json['host']?.toString() ?? '',
      path: json['path']?.toString() ?? '',
      tls: json['tls']?.toString() ?? '',
      sni: json['sni']?.toString() ?? '',
    );
  }
}

class NodeTrafficTotals {
  NodeTrafficTotals({required this.upload, required this.download});

  final num upload;
  final num download;
}

abstract final class NodeDemoManager {
  static const String defaultGroupName = 'PROXY';

  static Future<ReturnResult<List<NodeGroupSummary>>> fetchNodeGroups(
    Uri endpoint, {
    bool mock = false,
  }) async {
    if (mock) {
      return ReturnResult(
        data: [
          NodeGroupSummary(id: 'group-us', name: '美国节点'),
          NodeGroupSummary(id: 'group-hk', name: '香港节点'),
        ],
      );
    }

    final result = await HttpUtils.httpGetRequest(
      endpoint.resolve('/node-groups').toString(),
      null,
      null,
      const Duration(seconds: 15),
      null,
      null,
    );

    if (result.error != null) {
      return ReturnResult(error: result.error);
    }

    try {
      final decoded = jsonDecode(result.data ?? '') as Map<String, dynamic>;
      final items = decoded['items'] as List<dynamic>? ?? [];
      final groups = items
          .map((item) => NodeGroupSummary.fromJson(item))
          .where((group) => group.id.isNotEmpty && group.name.isNotEmpty)
          .toList();
      return ReturnResult(data: groups);
    } catch (err) {
      return ReturnResult(error: ReturnResultError(err.toString()));
    }
  }

  static Future<ReturnResult<String>> runMockDemo() async {
    final groups = await fetchNodeGroups(Uri(), mock: true);
    if (groups.error != null || groups.data == null || groups.data!.isEmpty) {
      return ReturnResult(error: groups.error);
    }
    final detail = await fetchNodeDetail(
      Uri(),
      groups.data!.first.id,
      mock: true,
    );
    if (detail.error != null || detail.data == null) {
      return ReturnResult(error: detail.error);
    }
    return createLocalProfileFromNodeDetail(detail.data!);
  }

  static Future<ReturnResult<NodeDetail>> fetchNodeDetail(
    Uri endpoint,
    String groupId, {
    bool mock = false,
  }) async {
    if (mock) {
      return ReturnResult(
        data: NodeDetail.fromJson({
          'v': '2',
          'ps': 'us',
          'add': 'nature8152.sakfhkgw.com',
          'port': '20009',
          'id': 'e36865f9-6cf1-31c5-b402-79e45cfb63cf',
          'aid': '0',
          'scy': 'auto',
          'net': 'tcp',
          'type': 'none',
          'host': '',
          'path': '',
          'tls': '',
          'sni': '',
        }),
      );
    }

    final result = await HttpUtils.httpGetRequest(
      endpoint.resolve('/node-groups/$groupId').toString(),
      null,
      null,
      const Duration(seconds: 15),
      null,
      null,
    );

    if (result.error != null) {
      return ReturnResult(error: result.error);
    }

    try {
      final decoded = jsonDecode(result.data ?? '') as Map<String, dynamic>;
      return ReturnResult(data: NodeDetail.fromJson(decoded));
    } catch (err) {
      return ReturnResult(error: ReturnResultError(err.toString()));
    }
  }

  static Map<String, dynamic> buildVmessProxy(NodeDetail detail) {
    final tlsEnabled = _parseBool(detail.tls);
    final proxy = <String, dynamic>{
      'name': detail.name,
      'type': 'vmess',
      'server': detail.address,
      'port': detail.port,
      'uuid': detail.uuid,
      'alterId': detail.alterId,
      'cipher': detail.cipher,
      'udp': true,
      'network': detail.network,
      'tls': tlsEnabled,
    };

    if (detail.sni.isNotEmpty) {
      proxy['servername'] = detail.sni;
    }

    if (detail.network == 'ws') {
      final wsOpts = <String, dynamic>{
        'path': detail.path.isNotEmpty ? detail.path : '/',
      };
      if (detail.host.isNotEmpty) {
        wsOpts['headers'] = {'Host': detail.host};
      }
      proxy['ws-opts'] = wsOpts;
    }

    return proxy;
  }

  static String buildClashProfileYaml(
    NodeDetail detail, {
    String groupName = defaultGroupName,
  }) {
    final proxy = buildVmessProxy(detail);
    final config = <String, dynamic>{
      'port': 7890,
      'socks-port': 7891,
      'allow-lan': true,
      'mode': 'rule',
      'log-level': 'info',
      'proxies': [proxy],
      'proxy-groups': [
        {
          'name': groupName,
          'type': 'select',
          'proxies': [detail.name, 'DIRECT'],
        },
      ],
      'rules': ['MATCH,$groupName'],
    };

    return _yamlEncode(config);
  }

  static Future<ReturnResult<String>> createLocalProfileFromNodeDetail(
    NodeDetail detail, {
    String remark = 'Demo Node Profile',
  }) async {
    final yaml = buildClashProfileYaml(detail);
    final cacheDir = await PathUtils.cacheDir();
    final filePath = path.join(
      cacheDir,
      'demo_node_${DateTime.now().millisecondsSinceEpoch}.yaml',
    );
    final file = File(filePath);
    await file.writeAsString(yaml);
    final err = await ProfileManager.addLocal(filePath, remark: remark);
    if (err != null) {
      return ReturnResult(error: err);
    }
    return ReturnResult(data: filePath);
  }

  static Future<ReturnResult<NodeTrafficTotals>> getUsedTrafficTotals() async {
    final state = await VPNService.getState();
    if (state != FlutterVpnServiceState.connected) {
      return ReturnResult(
        error: ReturnResultError('core not connected'),
      );
    }

    final connections = await FlutterVpnService.clashiApiConnections(false);
    try {
      final decoded = jsonDecode(connections) as Map<String, dynamic>;
      final upload = decoded['uploadTotal'] as num? ?? 0;
      final download = decoded['downloadTotal'] as num? ?? 0;
      return ReturnResult(
        data: NodeTrafficTotals(upload: upload, download: download),
      );
    } catch (err) {
      return ReturnResult(error: ReturnResultError(err.toString()));
    }
  }

  static bool _parseBool(String value) {
    final lower = value.toLowerCase();
    return lower == 'true' || lower == '1' || lower == 'tls';
  }

  static String _yamlEncode(dynamic value, {int indent = 0}) {
    final buffer = StringBuffer();
    _writeYaml(buffer, value, indent);
    return buffer.toString();
  }

  static void _writeYaml(StringBuffer buffer, dynamic value, int indent) {
    if (value is Map<String, dynamic>) {
      value.forEach((key, entry) {
        buffer.write('${'  ' * indent}$key:');
        if (_isScalar(entry)) {
          buffer.write(' ${_formatScalar(entry)}\n');
        } else {
          buffer.write('\n');
          _writeYaml(buffer, entry, indent + 1);
        }
      });
      return;
    }

    if (value is List) {
      for (final entry in value) {
        buffer.write('${'  ' * indent}-');
        if (_isScalar(entry)) {
          buffer.write(' ${_formatScalar(entry)}\n');
        } else {
          buffer.write('\n');
          _writeYaml(buffer, entry, indent + 1);
        }
      }
      return;
    }

    buffer.write('${'  ' * indent}${_formatScalar(value)}\n');
  }

  static bool _isScalar(dynamic value) {
    return value == null || value is String || value is num || value is bool;
  }

  static String _formatScalar(dynamic value) {
    if (value == null) {
      return 'null';
    }
    if (value is bool || value is num) {
      return value.toString();
    }
    if (value is String) {
      if (value.isEmpty) {
        return '""';
      }
      final escaped = value.replaceAll('"', '\\"');
      return '"$escaped"';
    }
    return value.toString();
  }
}
