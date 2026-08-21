import 'dart:convert';
import 'dart:io';
import 'package:clashmi/app/local_services/vpn_service.dart';
import 'package:board_service/board_session_persistent.dart';
import 'package:board_service/crypto.dart';
import 'package:board_service/sspanel_uim/sspanel_uim_client.dart'
    as sspanel_client;
import 'package:board_service/v2board/v2board_client.dart' as v2board_client;
import 'package:board_service/xboard/xboard_client.dart' as xboard_client;
import 'package:clashmi/app/modules/board_provider_manager.dart';
import 'package:clashmi/app/modules/clash_setting_manager.dart';
import 'package:clashmi/app/modules/setting_manager.dart';
import 'package:clashmi/app/utils/file_utils.dart';
import 'package:clashmi/app/utils/path_utils.dart';
import 'package:libclash_vpn_service/state.dart';

class BoardSessionLoginError {
  BoardSession? session;
  int? httpStatusCode;
  String? message;

  BoardSessionLoginError({this.session, this.httpStatusCode, this.message});
}

class BoardSession {
  BoardProviderConfig provider;
  String account;
  String authData;
  String subscribeUrl;
  Map<String, dynamic> _data = {};

  v2board_client.V2BoardClient? _v2board;
  xboard_client.XboardClient? _xboard;
  sspanel_client.SSPanelUimClient? _ssPanel;
  BoardSession({
    required this.provider,
    required this.account,
    required this.authData,
    required this.subscribeUrl,
  });
  void updateData(String api, Map<String, dynamic>? data) {
    if (api.isEmpty) {
      _data.clear();
      return;
    }
    _data[api] = data;
  }

  Map<String, dynamic> data() {
    return _data;
  }

  Map<String, String>? headers() {
    if (_v2board != null) {
      return _v2board!.getAuthHeaders();
    } else if (_xboard != null) {
      return _xboard!.getAuthHeaders();
    } else if (_ssPanel != null) {
      return _ssPanel!.getAuthHeaders();
    }
    return null;
  }

  Map<String, String>? cookies() {
    if (_v2board != null) {
      return _v2board!.getAuthCookies();
    } else if (_xboard != null) {
      return _xboard!.getAuthCookies();
    } else if (_ssPanel != null) {
      return _ssPanel!.getAuthCookies();
    }
    return null;
  }

  Map<String, String>? localStorage() {
    if (_v2board != null) {
      return _v2board!.getAuthLocalStorage();
    } else if (_xboard != null) {
      return _xboard!.getAuthLocalStorage();
    } else if (_ssPanel != null) {
      return _ssPanel!.getAuthLocalStorage();
    }
    return null;
  }

  Map<String, dynamic> toJson() => {
    'provider': provider.toJson(),
    'account': account,
    'auth_data': Crypto.encrypt(account, authData),
    'subscribe_url': subscribeUrl,
    'data': _data,
  };
  void fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }
    if (map["provider"] != null) {
      final config = BoardProviderConfig();
      config.fromJson(map["provider"]);
      provider = config;
    }
    account = map["account"] ?? "";
    authData = Crypto.decrypt(account, map["auth_data"] ?? "");
    subscribeUrl = map["subscribe_url"] ?? "";
    _data = map["data"] ?? {};
  }

  v2board_client.V2BoardClient? get v2board => _v2board;
  xboard_client.XboardClient? get xboard => _xboard;
  sspanel_client.SSPanelUimClient? get ssPanel => _ssPanel;
}

class BoardSessionHeadersAndCookies {
  Map<String, String> headers = {};
  List<String> cookies = [];

  BoardSessionHeadersAndCookies(this.headers, this.cookies);
  Map<String, dynamic> toJson() => {'headers': headers, 'cookies': cookies};
  void fromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return;
    }

    cookies = List.from(map["cookies"]);
    final h = map["headers"];
    if (h is Map<String, dynamic>) {
      h.forEach((key, value) {
        headers[key] = value as String;
      });
    }
  }

  void clear() {
    headers.clear();
    cookies.clear();
  }
}

class BoardSessionConfig {
  Map<String, BoardSessionHeadersAndCookies> headersAndCookies = {};
  List<BoardSession> sessions = [];

  Map<String, dynamic> toJson() => {
    'headers_and_cookies': headersAndCookies.map(
      (key, value) => MapEntry(key, value.toJson()),
    ),
    'sessions': sessions.map((s) => s.toJson()).toList(),
  };
  void fromJson(Map<String, dynamic>? map) {
    headersAndCookies.clear();
    sessions.clear();
    if (map == null) {
      return;
    }
    final sessionsMap = map["sessions"];
    if (sessionsMap is List) {
      for (var item in sessionsMap) {
        final session = BoardSession(
          provider: BoardProviderConfig(),
          account: "",
          authData: "",
          subscribeUrl: "",
        );
        session.fromJson(item);
        if (session.provider.id.isEmpty || session.account.isEmpty) {
          continue;
        }
        sessions.add(session);
      }
    }
    final headersAndCookiesMap = map["headers_and_cookies"];
    if (headersAndCookiesMap is Map<String, dynamic>) {
      headersAndCookiesMap.forEach((key, value) {
        final boc = BoardSessionHeadersAndCookies({}, []);
        boc.fromJson(value);
        headersAndCookies[key] = boc;
      });
    }
  }
}

class BoardSessionPersistentManager implements BoardSessionPersistent {
  static final BoardSessionPersistentManager _instance =
      BoardSessionPersistentManager();
  final BoardSessionConfig _config = BoardSessionConfig();

  static final FileSaver _fileSaver = FileSaver();
  List<Function()> onEventReloginRequired = [];

  @override
  void updateLoginAuthData(String id, String account, String authData) {
    if (id.isEmpty || account.isEmpty) {
      return;
    }
    for (int i = 0; i < _config.sessions.length; i++) {
      if (_config.sessions[i].provider.id == id &&
          _config.sessions[i].account == account) {
        _config.sessions[i].authData = authData;
        _config.sessions[i].updateData('', {});
        _save();
        return;
      }
    }
  }

  @override
  void logout(String id, String account) {
    if (id.isEmpty || account.isEmpty) {
      return;
    }
    for (int i = 0; i < _config.sessions.length; i++) {
      if (_config.sessions[i].provider.id == id &&
          _config.sessions[i].account == account) {
        _config.sessions[i].authData = "";
        _config.sessions[i].subscribeUrl = "";
        _config.sessions[i].updateData('', {});
        _save();
        return;
      }
    }
  }

  @override
  void update(String id, String account, String api, dynamic data) {
    if (id.isEmpty || account.isEmpty || api.isEmpty) {
      return;
    }
    for (int i = 0; i < _config.sessions.length; i++) {
      var session = _config.sessions[i];
      if (session.provider.id == id && session.account == account) {
        session.updateData(api, data);
        _save();
        return;
      }
    }
  }

  @override
  void updateSubscribeUrl(String id, String account, String subscribeUrl) {
    if (id.isEmpty || account.isEmpty) {
      return;
    }
    //subscribeUrl = ""; //todo for test
    for (int i = 0; i < _config.sessions.length; i++) {
      var session = _config.sessions[i];
      if (session.provider.id == id && session.account == account) {
        session.subscribeUrl = subscribeUrl;
        _save();
        return;
      }
    }
  }

  @override
  dynamic get(String id, String account, String api) {
    if (id.isEmpty || account.isEmpty || api.isEmpty) {
      return null;
    }
    for (var session in _config.sessions) {
      if (session.provider.id == id && session.account == account) {
        return session.data()[api];
      }
    }
    return null;
  }

  static BoardSessionPersistentManager instance() {
    return _instance;
  }

  static Future<void> init() async {
    _fileSaver.setSavePath(await PathUtils.boardSessionFilePath());
    await _instance._load();
    _instance.onVpnStateChanged();
  }

  void updateHeadersAndCookies(
    String cookie,
    Map<String, String> headers,
    List<String> cookies,
  ) {
    _config.headersAndCookies[cookie] = BoardSessionHeadersAndCookies(
      headers,
      cookies,
    );

    _save();
  }

  Future<BoardSession?> getOrCreate(
    BoardProviderConfig provider,
    String account,
  ) async {
    if (provider.id.isEmpty || account.isEmpty) {
      return null;
    }
    final connected = await VPNService.getStarted();
    String? proxyUrl = connected
        ? "127.0.0.1:${ClashSettingManager.getMixedPort()}"
        : null;

    for (int i = 0; i < _config.sessions.length; i++) {
      if (_config.sessions[i].provider.id == provider.id &&
          _config.sessions[i].account == account) {
        _config.sessions[i].provider = provider;
        if (i != 0) {
          _config.sessions.insert(0, _config.sessions.removeAt(i));
          _save();
        }

        if (_config.sessions[0].provider.type == BoardProviderType.v2board) {
          if (_config.sessions[0]._v2board != null) {
            _config.sessions[0]._v2board!.proxyUrl = proxyUrl;
          }
        } else if (_config.sessions[0].provider.type ==
            BoardProviderType.xboard) {
          if (_config.sessions[0]._xboard != null) {
            _config.sessions[0]._xboard!.proxyUrl = proxyUrl;
          }
        } else if (_config.sessions[0].provider.type ==
            BoardProviderType.sspanel) {
          if (_config.sessions[0]._ssPanel != null) {
            _config.sessions[0]._ssPanel!.proxyUrl = proxyUrl;
          }
        }
        return _config.sessions[0];
      }
    }

    final newSession = BoardSession(
      provider: provider,
      account: account,
      authData: "",
      subscribeUrl: "",
    );
    final useagent = newSession.provider.userAgent.isNotEmpty
        ? newSession.provider.userAgent
        : SettingManager.getConfig().userAgent();
    final baseUrl = "https://${provider.domain}";
    if (newSession.provider.type == BoardProviderType.v2board) {
      newSession._v2board = v2board_client.V2BoardClient(
        baseUrl: baseUrl,
        baseDomains: provider.domains,
        id: provider.id,
        persistent: this,
      );
      newSession._v2board!.proxyUrl = proxyUrl;
      newSession._v2board!.userAgent = useagent;
      newSession._v2board!.setVersion(newSession.provider.version);
    } else if (newSession.provider.type == BoardProviderType.xboard) {
      newSession._xboard = xboard_client.XboardClient(
        baseUrl: baseUrl,
        baseDomains: provider.domains,
        id: provider.id,
        persistent: this,
      );
      newSession._xboard!.proxyUrl = proxyUrl;
      newSession._xboard!.userAgent = useagent;
    } else if (newSession.provider.type == BoardProviderType.sspanel) {
      newSession._ssPanel = sspanel_client.SSPanelUimClient(
        baseUrl: baseUrl,
        baseDomains: provider.domains,
        id: provider.id,
        persistent: this,
      );
      newSession._ssPanel!.proxyUrl = proxyUrl;
      newSession._ssPanel!.userAgent = useagent;
    } else {
      return null;
    }

    _config.sessions.insert(0, newSession);
    _save();
    return newSession;
  }

  BoardSession? current() {
    if (_config.sessions.isEmpty) {
      return null;
    }
    return _config.sessions.first;
  }

  Set<String> getAllNames() {
    Set<String> names = {};
    for (var session in _config.sessions) {
      if (session.provider.id.startsWith(
        BoardProviderManager.unknownProviderIdPrefix,
      )) {
        continue;
      }
      names.add(session.provider.name);
    }
    return names;
  }

  BoardSession? getBySubscribeUrl(String url) {
    if (url.isEmpty) {
      return null;
    }
    for (var session in _config.sessions) {
      if (session.provider.id.startsWith(
        BoardProviderManager.unknownProviderIdPrefix,
      )) {
        continue;
      }
      if (session.subscribeUrl == url) {
        return session;
      }
    }
    return null;
  }

  Future<void> updateProviders(List<BoardProviderConfig> providers) async {
    Map<String, BoardProviderConfig> updatedProviderIds = {};
    for (var provider in providers) {
      if (provider.id.startsWith(
        BoardProviderManager.unknownProviderIdPrefix,
      )) {
        continue;
      }
      updatedProviderIds[provider.id] = provider;
    }
    _config.sessions.removeWhere(
      (session) => !updatedProviderIds.containsKey(session.provider.id),
    );
    for (int i = 0; i < _config.sessions.length; i++) {
      _config.sessions[i].provider =
          updatedProviderIds[_config.sessions[i].provider.id]!;
    }
    await _save();
  }

  Future<void> _updateProvider(
    BoardSession session,
    BoardProviderConfig provider,
  ) async {
    final connected = await VPNService.getStarted();
    final proxyUrl = connected
        ? "127.0.0.1:${ClashSettingManager.getMixedPort()}"
        : null;

    final useagent = provider.userAgent.isNotEmpty
        ? provider.userAgent
        : SettingManager.getConfig().userAgent();
    final baseUrl = "https://${provider.domain}";
    if (session.provider.type == BoardProviderType.v2board) {
      session._v2board ??= v2board_client.V2BoardClient(
        baseUrl: baseUrl,
        baseDomains: provider.domains,
        id: provider.id,
        persistent: this,
      );
      session._v2board!.proxyUrl = proxyUrl;
      session._v2board!.baseUrl = baseUrl;
      session._v2board!.userAgent = useagent;
      session._v2board!.setVersion(provider.version);
      session._v2board!.setAccount(session.account);
      session._v2board!.setAuthToken(session.authData);
    } else if (session.provider.type == BoardProviderType.xboard) {
      session._xboard ??= xboard_client.XboardClient(
        baseUrl: baseUrl,
        baseDomains: provider.domains,
        id: provider.id,
        persistent: this,
      );
      session._xboard!.proxyUrl = proxyUrl;
      session._xboard!.baseUrl = baseUrl;
      session._xboard!.userAgent = useagent;
      session._xboard!.setAccount(session.account);
      session._xboard!.setAuthToken(session.authData);
    } else if (session.provider.type == BoardProviderType.sspanel) {
      session._ssPanel ??= sspanel_client.SSPanelUimClient(
        baseUrl: baseUrl,
        baseDomains: provider.domains,
        id: provider.id,
        persistent: this,
      );
      session._ssPanel!.proxyUrl = proxyUrl;
      session._ssPanel!.baseUrl = baseUrl;
      session._ssPanel!.userAgent = useagent;
      session._ssPanel!.setAccount(session.account);
      session._ssPanel!.setAuthToken(session.authData);
    } else {
      return;
    }
    session.provider = provider;
  }

  Future<void> _save() async {
    await _fileSaver.saveAsJson(_config);
  }

  Future<void> _load() async {
    _config.sessions.clear();
    _config.headersAndCookies.clear();

    final filePath = await PathUtils.boardSessionFilePath();
    final file = File(filePath);
    if (!await file.exists()) {
      await _save();
      return;
    }
    final content = await file.readAsString();
    if (content.isEmpty) {
      return;
    }
    final dynamic jsonData = json.decode(content);
    if (jsonData is! Map<String, dynamic>) {
      return;
    }
    _config.fromJson(jsonData);
    for (var session in _config.sessions) {
      await _updateProvider(session, session.provider);
      if (session.provider.botCookie.isNotEmpty) {
        final headersAndCookies =
            _config.headersAndCookies[session.provider.botCookie];
        if (headersAndCookies != null) {
          if (session.provider.type == BoardProviderType.v2board) {
            session.v2board?.setHeadersAndCookiesForBot(
              headersAndCookies.headers,
              headersAndCookies.cookies,
            );
          } else if (session.provider.type == BoardProviderType.xboard) {
            session.xboard?.setHeadersAndCookiesForBot(
              headersAndCookies.headers,
              headersAndCookies.cookies,
            );
          } else if (session.provider.type == BoardProviderType.sspanel) {
            session.ssPanel?.setHeadersAndCookiesForBot(
              headersAndCookies.headers,
              headersAndCookies.cookies,
            );
          }
        }
      }
    }
  }

  void onVpnStateChanged() {
    VPNService.onEventStateChanged.add((
      FlutterVpnServiceState state,
      Map<String, String> params,
    ) async {
      if (state != FlutterVpnServiceState.connected &&
          state != FlutterVpnServiceState.disconnected) {
        return;
      }
      final proxyUrl = state == FlutterVpnServiceState.connected
          ? "127.0.0.1:${ClashSettingManager.getMixedPort()}"
          : null;
      for (int i = 0; i < _instance._config.sessions.length; i++) {
        if (_instance._config.sessions[i]._v2board != null) {
          _instance._config.sessions[i]._v2board!.proxyUrl = proxyUrl;
        } else if (_instance._config.sessions[i]._xboard != null) {
          _instance._config.sessions[i]._xboard!.proxyUrl = proxyUrl;
        } else if (_instance._config.sessions[i]._ssPanel != null) {
          _instance._config.sessions[i]._ssPanel!.proxyUrl = proxyUrl;
        }
      }
    });
  }

  void relogin() {
    for (var callback in onEventReloginRequired) {
      callback.call();
    }
  }
}
