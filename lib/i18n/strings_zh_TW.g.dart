///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsZhTw with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhTw({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zhTw,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-TW>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhTw _root = this; // ignore: unused_field

	@override 
	TranslationsZhTw $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhTw(meta: meta ?? this.$meta);

	// Translations
	@override late final Translations$BackupAndSyncWebdavScreen$zh_TW BackupAndSyncWebdavScreen = Translations$BackupAndSyncWebdavScreen$zh_TW.internal(_root);
	@override late final Translations$LaunchFailedScreen$zh_TW LaunchFailedScreen = Translations$LaunchFailedScreen$zh_TW.internal(_root);
	@override late final Translations$PerAppAndroidScreen$zh_TW PerAppAndroidScreen = Translations$PerAppAndroidScreen$zh_TW.internal(_root);
	@override late final Translations$UserAgreementScreen$zh_TW UserAgreementScreen = Translations$UserAgreementScreen$zh_TW.internal(_root);
	@override late final Translations$NetCheckScreen$zh_TW NetCheckScreen = Translations$NetCheckScreen$zh_TW.internal(_root);
	@override late final Translations$VersionUpdateScreen$zh_TW VersionUpdateScreen = Translations$VersionUpdateScreen$zh_TW.internal(_root);
	@override late final Translations$loginScreen$zh_TW loginScreen = Translations$loginScreen$zh_TW.internal(_root);
	@override late final Translations$main$zh_TW main = Translations$main$zh_TW.internal(_root);
	@override late final Translations$meta$zh_TW meta = Translations$meta$zh_TW.internal(_root);
	@override late final Translations$permission$zh_TW permission = Translations$permission$zh_TW.internal(_root);
	@override late final Translations$tls$zh_TW tls = Translations$tls$zh_TW.internal(_root);
	@override late final Translations$tun$zh_TW tun = Translations$tun$zh_TW.internal(_root);
	@override late final Translations$dns$zh_TW dns = Translations$dns$zh_TW.internal(_root);
	@override late final Translations$sniffer$zh_TW sniffer = Translations$sniffer$zh_TW.internal(_root);
	@override late final Translations$profilePatchMode$zh_TW profilePatchMode = Translations$profilePatchMode$zh_TW.internal(_root);
	@override String get protocolSniff => '協議探測';
	@override String get protocolSniffOverrideDestination => '探測的域名覆蓋連接目標地址';
	@override String get edgeRuntimeNotInstalled => '當前設備尚未安裝Edge WebView2運行時,無法展示頁面,請下載安裝Edge WebView2運行時(x64)後,重啟App再試';
	@override Map<String, String> get locales => {
		'en': 'English',
		'zh-CN': '简体中文',
		'zh-TW': '繁體中文',
		'ja': '日本語',
		'ko': '한국어',
		'ar': 'عربي',
		'ru': 'Русский',
		'fa': 'فارسی',
		'es': 'Español',
	};
}

// Path: BackupAndSyncWebdavScreen
class Translations$BackupAndSyncWebdavScreen$zh_TW implements Translations$BackupAndSyncWebdavScreen$en {
	Translations$BackupAndSyncWebdavScreen$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get webdavServerUrl => '伺服器地址';
	@override String get webdavRequired => '不能為空';
	@override String get webdavLoginFailed => '登錄失敗:';
	@override String get webdavListFailed => '獲取文件列表失敗:';
}

// Path: LaunchFailedScreen
class Translations$LaunchFailedScreen$zh_TW implements Translations$LaunchFailedScreen$en {
	Translations$LaunchFailedScreen$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get invalidProcess => '應用啟動失敗[無效的進程名稱],請重新安裝應用到獨立目錄';
	@override String get invalidProfile => '應用啟動失敗[訪問設定檔失敗],請重新安裝應用';
	@override String get invalidVersion => '應用啟動失敗[無效版本],請重新安裝應用';
	@override String get systemVersionLow => '應用啟動失敗[系統版本過低]';
	@override String get invalidInstallPath => '無效的安裝路徑,請重新安裝到有效路徑';
}

// Path: PerAppAndroidScreen
class Translations$PerAppAndroidScreen$zh_TW implements Translations$PerAppAndroidScreen$en {
	Translations$PerAppAndroidScreen$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get title => '分應用代理';
	@override String get whiteListMode => '白名單模式';
	@override String get whiteListModeTip => '啟用後:僅代理已勾選的App;未啟用:僅代理未勾選的App';
}

// Path: UserAgreementScreen
class Translations$UserAgreementScreen$zh_TW implements Translations$UserAgreementScreen$en {
	Translations$UserAgreementScreen$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get privacyFirst => '您的隱私很重要';
	@override String get agreeAndContinue => '接受並繼續';
}

// Path: NetCheckScreen
class Translations$NetCheckScreen$zh_TW implements Translations$NetCheckScreen$en {
	Translations$NetCheckScreen$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get enterDomain => '請輸入網域名稱';
	@override String get checking => '檢測中...';
	@override String aQueryFailed({required Object p}) => 'A 查詢失敗: ${p}';
	@override String aaaaQueryFailed({required Object p}) => 'AAAA 查詢失敗: ${p}';
	@override String get success => '成功';
	@override String get failed => '失敗';
	@override String get suspectedPollution => '疑似被污染';
	@override String get domainLabel => '網域名稱';
	@override String get checkButton => '檢測';
	@override String get dnsSection => '1. DNS查詢';
	@override String get directHttpSection => '2. HTTP (經由TUN,請先啟用TUN)';
	@override String proxyHttpSection({required Object p}) => '3. HTTP (經由代理,連接埠:${p})';
	@override String get tunNotEnabled => 'TUN 未啟用';
	@override String get routeTableSection => '4. 路由表';
}

// Path: VersionUpdateScreen
class Translations$VersionUpdateScreen$zh_TW implements Translations$VersionUpdateScreen$en {
	Translations$VersionUpdateScreen$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String versionReady({required Object p}) => '新版本[${p}]已就緒';
	@override String get update => '重啟更新';
	@override String get cancel => '暫不更新';
}

// Path: loginScreen
class Translations$loginScreen$zh_TW implements Translations$loginScreen$en {
	Translations$loginScreen$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get login => '登錄';
	@override String get register => '註冊賬號';
	@override String get forgotPassword => '忘記密碼';
	@override String get provider => '服務商';
	@override String get providerName => '${_root.loginScreen.provider}編碼/別名/URL';
	@override String get providerNameRequired => '請輸入${_root.loginScreen.provider}編碼/別名/URL';
	@override String get account => '賬號';
	@override String get accountRequired => '請輸入賬號';
	@override String get email => '郵箱';
	@override String get emailRequired => '請輸入郵箱地址';
	@override String get password => '密碼';
	@override String get passwordRequired => '請輸入密碼';
	@override String get validEmailRequired => '請輸入有效的郵箱地址';
	@override String passwordMinLength({required Object minLength}) => '密碼長度至少${minLength}位';
	@override String get unsupportedProvider => '不支持的${_root.loginScreen.provider}';
	@override String get unsupportedProviderType => '不支持的${_root.loginScreen.provider}類型';
	@override String get unActivedProvider => '登入功能未啟用';
	@override String providerLoginSupportRequired({required Object p}) => '編碼/別名請向${_root.loginScreen.provider}索取\n${_root.loginScreen.provider}接入請參考:${p}';
	@override String get providerDisclaimer => '免責聲明:${_root.loginScreen.provider}為第三方服務,與本App無關';
}

// Path: main
class Translations$main$zh_TW implements Translations$main$en {
	Translations$main$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override late final Translations$main$tray$zh_TW tray = Translations$main$tray$zh_TW.internal(_root);
}

// Path: meta
class Translations$meta$zh_TW implements Translations$meta$en {
	Translations$meta$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get enable => '啟用';
	@override String get disable => '禁用';
	@override String get open => '打開';
	@override String get close => '關閉';
	@override String get quit => '退出';
	@override String get add => '添加';
	@override String get addSuccess => '添加成功';
	@override String addFailed({required Object p}) => '添加失敗:${p}';
	@override String get remove => '刪除';
	@override String get removeConfirm => '確認刪除?';
	@override String get edit => '編輯';
	@override String get view => '查看';
	@override String get remark => '備註';
	@override String get byDefault => '預設';
	@override String get editRemark => '修改備註';
	@override String get more => '更多';
	@override String get tips => '提示';
	@override String get selectAll => '全選';
	@override String get copy => '複製';
	@override String get paste => '貼上';
	@override String get cut => '剪切';
	@override String get save => '儲存';
	@override String get ok => '確定';
	@override String get cancel => '取消';
	@override String get faq => '常見問題';
	@override String get doc => '文檔';
	@override String get htmlTools => 'HTML工具集';
	@override String get download => '下載';
	@override String get loading => '載入中...';
	@override String get days => '天';
	@override String get hours => '時';
	@override String get minutes => '分';
	@override String get seconds => '秒';
	@override String get milliseconds => '毫秒';
	@override String get protocol => '協議';
	@override String get search => '搜索';
	@override String get custom => '自定義';
	@override String get connect => '連接';
	@override String get disconnect => '斷開';
	@override String get connected => '已連接';
	@override String get disconnected => '未連接';
	@override String get connecting => '連接中';
	@override String get connectTimeout => '連接超時';
	@override String get timeout => '超時';
	@override String get timeoutDuration => '超時時長';
	@override String get latency => '延遲';
	@override String get latencyTest => '延遲檢測';
	@override String get networkCheck => '網路檢測';
	@override String get language => '語言';
	@override String get next => '下一步';
	@override String get done => '完成';
	@override String get apply => '應用';
	@override String get refresh => '刷新';
	@override String get retry => '是否重試?';
	@override String get update => '更新';
	@override String get updateInterval => '更新時間間隔';
	@override String get updateInterval5mTips => '最小:5m';
	@override String get updateIntervalPreferByProfile => '優先使用服務商(機場)設定';
	@override String updateFailed({required Object p}) => '更新失敗:${p}';
	@override String get none => '無';
	@override String get reset => '重置';
	@override String get authentication => '授權';
	@override String get submit => '提交';
	@override String get user => '用戶';
	@override String get account => '賬號';
	@override String get password => '密碼';
	@override String get decryptPassword => '解密密碼';
	@override String get required => '必填';
	@override String get go => '繼續';
	@override String get sudoPassword => 'sudo 密碼(TUN模式需要)';
	@override String get other => '其他';
	@override String get dns => 'DNS';
	@override String get url => 'URL';
	@override String get urlInvalid => 'URL無效';
	@override String get urlCannotEmpty => 'URL不能為空';
	@override String get urlTooLong => 'URL過長(>8182)';
	@override String get copyUrl => '複製連結';
	@override String get openUrl => '打開連結';
	@override String get shareUrl => '分享連結';
	@override String get coreSettingTips => '注意:修改配置後,需要重新連接才會生效';
	@override String get overwrite => '覆寫';
	@override String get overwriteCustom => '自定義覆寫';
	@override String get overwriteAppend => '追加覆寫';
	@override String get overwriteTips => '原始配置<-自定義覆寫<-App覆寫';
	@override String get noOverwrite => '不覆寫';
	@override String get overwriteSettings => '覆寫設置';
	@override String get diversionTemplates => '分流模板';
	@override String get ruleProviders => '規則提供者';
	@override String get ruleTemplates => '規則模板';
	@override String get proxyGroupsTemplates => '代理組模板';
	@override String get proxyGroups => '代理組';
	@override String get proxyNodeList => '代理節點列表';
	@override String proxyNodeFailure({required Object p}) => '下列代理節點已失效,已自動移除:${p}';
	@override String get externalController => '外部控制';
	@override String get secret => '金鑰';
	@override String get tcpConcurrent => 'TCP併發握手';
	@override String get globalClientFingerprint => 'TLS全局指紋';
	@override String get allowLanAccess => '局域網設備接入';
	@override String get mixedPort => '混合代理端口';
	@override String get logLevel => '日誌等級';
	@override String get findProcessMode => '進程匹配模式';
	@override String get tcpkeepAliveInterval => 'TCP保活時間間隔';
	@override String get delayTestUrl => '延遲測試URL';
	@override String get delayTestTimeout => '延遲測試超時(ms)';
	@override String get tun => 'TUN';
	@override String get ntp => 'NTP';
	@override String get tls => 'TLS';
	@override String get geo => 'GEO';
	@override String get geoDownloadByProxy => '使用代理下載Geo RuleSet';
	@override String get geoRulesetTips => 'Geosite/Geoip 會被轉換成 對應的RuleSet';
	@override String get asnNotSupportInIosTips => '由於iOS系統內存限制,IP-ASN及SRC-IP-ASN規則在iOS上將被忽略';
	@override String get sniffer => '嗅探';
	@override String get userAgent => 'UserAgent';
	@override String get launchAtStartup => '開機啟動';
	@override String get launchAtStartupRunAsAdmin => '請以管理員身份重新啟動Clash Mi';
	@override String get tunModeRunAsAdmin => 'TUN模式需要系統管理員權限,請以管理員身份重新啟動應用';
	@override String get portableMode => '便攜模式';
	@override String get portableModeDisableTips => '如需退出便攜模式,請退出[clashmi]後,手動刪除[clashmi.exe]同目錄下的[portable]文件夾即可';
	@override String get systemProxy => '系統代理';
	@override String get autoConnectAfterLaunch => '啟動後自動連接';
	@override String get autoConnectAtBoot => '系統啟動後自動連接';
	@override String get autoConnectAtBootTips => '需要系統支持,部分系統可能還需要開啟[自啟動]';
	@override String get hideAfterLaunch => '啟動後隱藏窗口';
	@override String get autoSetSystemProxy => '連接後自動設置系統代理';
	@override String get bypassSystemProxy => '允許繞過系統代理的域名';
	@override String get excludeFromRecent => '從[最近任務]中隱藏';
	@override String get wakeLock => '喚醒鎖';
	@override String get hideVpn => '隱藏VPN圖標';
	@override String get hideVpnTips => '開啟IPv6會導致此功能失效';
	@override String get hideDockIcon => '隱藏Dock圖標';
	@override String get showTrayTraffic => '托盤上顯示流量資訊';
	@override String get website => '官網';
	@override String get homePage => '主頁';
	@override String get rule => '規則';
	@override String get global => '全局';
	@override String get direct => '直連';
	@override String get block => '攔截';
	@override String get qrcode => '二維碼';
	@override String get qrcodeTooLong => '文本過長,無法展示';
	@override String get qrcodeShare => '分享二維碼';
	@override String get textToQrcode => '文本轉二維碼';
	@override String get qrcodeScan => '掃描二維碼';
	@override String get qrcodeScanResult => '掃描結果';
	@override String get qrcodeScanFromImage => '打開二維碼圖片';
	@override String get qrcodeScanResultFailed => '解析圖片失敗,請確保截圖為有效的二維碼';
	@override String get qrcodeScanResultEmpty => '掃描結果為空';
	@override String get screenshot => '截圖';
	@override String get backupAndSync => '備份與同步';
	@override String get importSuccess => '匯入成功';
	@override String get rewriteConfirm => '該文件將覆蓋本地已有配置,是否繼續?';
	@override String get importAndExport => '匯入/匯出';
	@override String get import => '匯入';
	@override String get importFromUrl => '從URL匯入';
	@override String get export => '匯出';
	@override String get send => '發送';
	@override String get receive => '接收';
	@override String get sendConfirm => '確認發送?';
	@override String get continueConnectConfirm => '是否繼續連接?';
	@override String get termOfUse => '使用條款';
	@override String get privacyPolicy => '隱私政策';
	@override String get log => '日誌';
	@override String get coreLog => '核心日誌';
	@override String get core => '核心';
	@override String get help => '幫助';
	@override String get tutorial => '使用教程';
	@override String get board => '面板';
	@override String get boardOnline => '使用在線面板';
	@override String get boardOnlineUrl => '在線面板URL';
	@override String get boardLocalPort => '本地面板端口';
	@override String get alwayOnVPN => '始終開啟連線';
	@override String get disableFontScaler => '禁用字體縮放';
	@override String get autoOrientation => '跟隨螢幕旋轉';
	@override String get restartTakesEffect => '重啟生效';
	@override String get reconnectTakesEffect => '重新連接後生效';
	@override String get runtimeProfile => '運行時配置';
	@override String get willCompleteAfterRebootInstall => '請重啟設備,以便完成系統擴展安裝';
	@override String get willCompleteAfterRebootUninstall => '請重啟設備,以便完成系統擴展卸載';
	@override String get requestNeedsUserApproval => '1. 請在[系統設置]-[隱私與安全性]裏[允許] Clash Mi安裝系統擴展\n2. :[系統設置]-[通用]-[登錄項與擴展-網絡擴展]啟用[clashmiServiceSE]\n完成後重新連接';
	@override String get FullDiskAccessPermissionRequired => '請在[系統設置]-[隱私與安全性]-[完全磁盤訪問權限]裏開啟clashmiServiceSE權限後,重新連接';
	@override String get proxy => '代理';
	@override String get theme => '主題';
	@override String get tvMode => 'TV模式';
	@override String get autoUpdate => '自動更新';
	@override String get updateChannel => '自動更新通道';
	@override String get onlineCustomerService => '線上客服';
	@override String get subscriptionChannel => '訂閱頻道';
	@override String hasNewVersion({required Object p}) => '更新版本 ${p}';
	@override String get autoDownloadPkg => '自動下載更新包';
	@override String get devOptions => '開發者選項';
	@override String get about => '關於';
	@override String get name => '名稱';
	@override String get version => '版本';
	@override String get notice => '通知';
	@override String get sort => '排序';
	@override String get recommended => '推薦';
	@override String innerError({required Object p}) => '內部錯誤:${p}';
	@override String get share => '分享';
	@override String get importFromClipboard => '從剪貼簿導入';
	@override String get exportToClipboard => '匯出到剪貼簿';
	@override String get server => '伺服器';
	@override String get port => '端口';
	@override String get donate => '捐助';
	@override String get setting => '設定';
	@override String get settingCore => '核心設定';
	@override String get settingApp => '應用設定';
	@override String get coreOverwrite => '核心覆寫';
	@override String get iCloud => 'iCloud';
	@override String get webdav => 'Webdav';
	@override String get lanSync => '局域網同步';
	@override String get lanSyncNotQuitTips => '同步完成前請勿退出此界面';
	@override String get deviceNoSpace => '磁盤空間不足';
	@override String get hideSystemApp => '隱藏系統應用';
	@override String get hideAppIcon => '隱藏應用圖標';
	@override String get openDir => '打開文件目錄';
	@override String get type => '類型';
	@override String get fileChoose => '選擇文件';
	@override String get filePathCannotEmpty => '文件路徑不能為空';
	@override String fileNotExist({required Object p}) => '文件不存在:${p}';
	@override String fileTypeInvalid({required Object p}) => '無效的文件類型:${p}';
	@override String get uwpExemption => 'UWP網絡隔離豁免';
	@override String get getProfile => '獲取設定';
	@override String get buyProfile => '購買設定';
	@override String get addProfile => '添加設定';
	@override String get myProfiles => '我的設定';
	@override String get profileEdit => '編輯設定';
	@override String get profileNeedActive => '請先將本設定設為目前設定，並開啟連線/重新連線';
	@override String get profileDownloadBackupChannel => '啟用備用下載通道';
	@override String get profileDownloadBackupChannelTips => 'Clash Mi 提供的代理下載通道（不儲存任何資訊）';
	@override String get profileEditReloadAfterProfileUpdate => '設定更新後重新載入';
	@override String get profileRulesAppendApplePush => '附加 Apple 推送通知規則';
	@override String get profileRulesAppendProxyTips => '規則將自動設為原始設定中 [proxy-groups] 內第一個類型為 [url-test] 或 [select] 的代理';
	@override String get profileImport => '匯入設定檔';
	@override String get profileAddUrlOrContent => '添加設定連結';
	@override String get profileUrlOrContent => 'Clash設定連結';
	@override String get profileUrlOrContentHit => 'Clash設定連結[必填]';
	@override String get profileUrlOrContentCannotEmpty => '設定連結不能為空';
}

// Path: permission
class Translations$permission$zh_TW implements Translations$permission$en {
	Translations$permission$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get camera => '攝像頭';
	@override String get screen => '屏幕錄製';
	@override String get appQuery => '獲取應用列表';
	@override String request({required Object p}) => '開啟[${p}]權限';
	@override String requestNeed({required Object p}) => '請開啟[${p}]權限';
}

// Path: tls
class Translations$tls$zh_TW implements Translations$tls$en {
	Translations$tls$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get insecure => '跳過證書驗證';
	@override String get certificate => '證書';
	@override String get privateKey => '私鑰';
	@override String get customTrustCert => '自定義證書';
}

// Path: tun
class Translations$tun$zh_TW implements Translations$tun$en {
	Translations$tun$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get stack => '網絡棧';
	@override String get inet4Address => 'IPv4位址段';
	@override String get inet6Address => 'IPv6位址段';
	@override String get dnsHijack => 'DNS劫持';
	@override String get strictRoute => '嚴格路由';
	@override String get tunDefaultRoute => '預設路由';
	@override String get icmpForward => 'ICMP 轉發';
	@override String get allowBypass => '允許應用繞過VPN';
	@override String get appendHttpProxy => '附加HTTP代理到VPN';
	@override String get bypassHttpProxyDomain => '允許繞過HTTP代理的域名';
}

// Path: dns
class Translations$dns$zh_TW implements Translations$dns$en {
	Translations$dns$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get listen => '監聽地址';
	@override String get fakeIp => 'fake-ip';
	@override String get fallback => 'Fallback';
	@override String get preferH3 => 'DoH H3優先';
	@override String get useHosts => '使用Hosts';
	@override String get useSystemHosts => '使用系統Hosts';
	@override String get enhancedMode => '增強模式';
	@override String get fakeIPFilterMode => '${_root.dns.fakeIp} 過濾模式';
	@override String get fakeIPFilter => '${_root.dns.fakeIp} 過濾';
	@override String get respectRules => '遵守[rules]規則';
	@override String get nameServer => '域名解析伺服器';
	@override String get defaultNameServer => '${_root.meta.byDefault} ${_root.dns.nameServer}';
	@override String get proxyNameServer => '${_root.meta.proxy} ${_root.dns.nameServer}';
	@override String get directNameServer => '${_root.meta.direct} ${_root.dns.nameServer}';
	@override String get fallbackNameServer => '${_root.dns.fallback} ${_root.dns.nameServer}';
	@override String get fallbackGeoIp => '${_root.dns.fallback} GeoIp';
	@override String get fallbackGeoIpCode => '${_root.dns.fallback} GeoIp 代碼';
}

// Path: sniffer
class Translations$sniffer$zh_TW implements Translations$sniffer$en {
	Translations$sniffer$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get overrideDest => '覆蓋';
}

// Path: profilePatchMode
class Translations$profilePatchMode$zh_TW implements Translations$profilePatchMode$en {
	Translations$profilePatchMode$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get currentSelected => '當前選擇';
	@override String get overwrite => '內置-覆寫';
	@override String get noOverwrite => '內置-不覆寫';
}

// Path: main.tray
class Translations$main$tray$zh_TW implements Translations$main$tray$en {
	Translations$main$tray$zh_TW.internal(this._root);

	final TranslationsZhTw _root; // ignore: unused_field

	// Translations
	@override String get menuOpen => '打開';
	@override String get menuExit => '退出';
}

/// The flat map containing all translations for locale <zh-TW>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZhTw {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'BackupAndSyncWebdavScreen.webdavServerUrl' => '伺服器地址',
			'BackupAndSyncWebdavScreen.webdavRequired' => '不能為空',
			'BackupAndSyncWebdavScreen.webdavLoginFailed' => '登錄失敗:',
			'BackupAndSyncWebdavScreen.webdavListFailed' => '獲取文件列表失敗:',
			'LaunchFailedScreen.invalidProcess' => '應用啟動失敗[無效的進程名稱],請重新安裝應用到獨立目錄',
			'LaunchFailedScreen.invalidProfile' => '應用啟動失敗[訪問設定檔失敗],請重新安裝應用',
			'LaunchFailedScreen.invalidVersion' => '應用啟動失敗[無效版本],請重新安裝應用',
			'LaunchFailedScreen.systemVersionLow' => '應用啟動失敗[系統版本過低]',
			'LaunchFailedScreen.invalidInstallPath' => '無效的安裝路徑,請重新安裝到有效路徑',
			'PerAppAndroidScreen.title' => '分應用代理',
			'PerAppAndroidScreen.whiteListMode' => '白名單模式',
			'PerAppAndroidScreen.whiteListModeTip' => '啟用後:僅代理已勾選的App;未啟用:僅代理未勾選的App',
			'UserAgreementScreen.privacyFirst' => '您的隱私很重要',
			'UserAgreementScreen.agreeAndContinue' => '接受並繼續',
			'NetCheckScreen.enterDomain' => '請輸入網域名稱',
			'NetCheckScreen.checking' => '檢測中...',
			'NetCheckScreen.aQueryFailed' => ({required Object p}) => 'A 查詢失敗: ${p}',
			'NetCheckScreen.aaaaQueryFailed' => ({required Object p}) => 'AAAA 查詢失敗: ${p}',
			'NetCheckScreen.success' => '成功',
			'NetCheckScreen.failed' => '失敗',
			'NetCheckScreen.suspectedPollution' => '疑似被污染',
			'NetCheckScreen.domainLabel' => '網域名稱',
			'NetCheckScreen.checkButton' => '檢測',
			'NetCheckScreen.dnsSection' => '1. DNS查詢',
			'NetCheckScreen.directHttpSection' => '2. HTTP (經由TUN,請先啟用TUN)',
			'NetCheckScreen.proxyHttpSection' => ({required Object p}) => '3. HTTP (經由代理,連接埠:${p})',
			'NetCheckScreen.tunNotEnabled' => 'TUN 未啟用',
			'NetCheckScreen.routeTableSection' => '4. 路由表',
			'VersionUpdateScreen.versionReady' => ({required Object p}) => '新版本[${p}]已就緒',
			'VersionUpdateScreen.update' => '重啟更新',
			'VersionUpdateScreen.cancel' => '暫不更新',
			'loginScreen.login' => '登錄',
			'loginScreen.register' => '註冊賬號',
			'loginScreen.forgotPassword' => '忘記密碼',
			'loginScreen.provider' => '服務商',
			'loginScreen.providerName' => '${_root.loginScreen.provider}編碼/別名/URL',
			'loginScreen.providerNameRequired' => '請輸入${_root.loginScreen.provider}編碼/別名/URL',
			'loginScreen.account' => '賬號',
			'loginScreen.accountRequired' => '請輸入賬號',
			'loginScreen.email' => '郵箱',
			'loginScreen.emailRequired' => '請輸入郵箱地址',
			'loginScreen.password' => '密碼',
			'loginScreen.passwordRequired' => '請輸入密碼',
			'loginScreen.validEmailRequired' => '請輸入有效的郵箱地址',
			'loginScreen.passwordMinLength' => ({required Object minLength}) => '密碼長度至少${minLength}位',
			'loginScreen.unsupportedProvider' => '不支持的${_root.loginScreen.provider}',
			'loginScreen.unsupportedProviderType' => '不支持的${_root.loginScreen.provider}類型',
			'loginScreen.unActivedProvider' => '登入功能未啟用',
			'loginScreen.providerLoginSupportRequired' => ({required Object p}) => '編碼/別名請向${_root.loginScreen.provider}索取\n${_root.loginScreen.provider}接入請參考:${p}',
			'loginScreen.providerDisclaimer' => '免責聲明:${_root.loginScreen.provider}為第三方服務,與本App無關',
			'main.tray.menuOpen' => '打開',
			'main.tray.menuExit' => '退出',
			'meta.enable' => '啟用',
			'meta.disable' => '禁用',
			'meta.open' => '打開',
			'meta.close' => '關閉',
			'meta.quit' => '退出',
			'meta.add' => '添加',
			'meta.addSuccess' => '添加成功',
			'meta.addFailed' => ({required Object p}) => '添加失敗:${p}',
			'meta.remove' => '刪除',
			'meta.removeConfirm' => '確認刪除?',
			'meta.edit' => '編輯',
			'meta.view' => '查看',
			'meta.remark' => '備註',
			'meta.byDefault' => '預設',
			'meta.editRemark' => '修改備註',
			'meta.more' => '更多',
			'meta.tips' => '提示',
			'meta.selectAll' => '全選',
			'meta.copy' => '複製',
			'meta.paste' => '貼上',
			'meta.cut' => '剪切',
			'meta.save' => '儲存',
			'meta.ok' => '確定',
			'meta.cancel' => '取消',
			'meta.faq' => '常見問題',
			'meta.doc' => '文檔',
			'meta.htmlTools' => 'HTML工具集',
			'meta.download' => '下載',
			'meta.loading' => '載入中...',
			'meta.days' => '天',
			'meta.hours' => '時',
			'meta.minutes' => '分',
			'meta.seconds' => '秒',
			'meta.milliseconds' => '毫秒',
			'meta.protocol' => '協議',
			'meta.search' => '搜索',
			'meta.custom' => '自定義',
			'meta.connect' => '連接',
			'meta.disconnect' => '斷開',
			'meta.connected' => '已連接',
			'meta.disconnected' => '未連接',
			'meta.connecting' => '連接中',
			'meta.connectTimeout' => '連接超時',
			'meta.timeout' => '超時',
			'meta.timeoutDuration' => '超時時長',
			'meta.latency' => '延遲',
			'meta.latencyTest' => '延遲檢測',
			'meta.networkCheck' => '網路檢測',
			'meta.language' => '語言',
			'meta.next' => '下一步',
			'meta.done' => '完成',
			'meta.apply' => '應用',
			'meta.refresh' => '刷新',
			'meta.retry' => '是否重試?',
			'meta.update' => '更新',
			'meta.updateInterval' => '更新時間間隔',
			'meta.updateInterval5mTips' => '最小:5m',
			'meta.updateIntervalPreferByProfile' => '優先使用服務商(機場)設定',
			'meta.updateFailed' => ({required Object p}) => '更新失敗:${p}',
			'meta.none' => '無',
			'meta.reset' => '重置',
			'meta.authentication' => '授權',
			'meta.submit' => '提交',
			'meta.user' => '用戶',
			'meta.account' => '賬號',
			'meta.password' => '密碼',
			'meta.decryptPassword' => '解密密碼',
			'meta.required' => '必填',
			'meta.go' => '繼續',
			'meta.sudoPassword' => 'sudo 密碼(TUN模式需要)',
			'meta.other' => '其他',
			'meta.dns' => 'DNS',
			'meta.url' => 'URL',
			'meta.urlInvalid' => 'URL無效',
			'meta.urlCannotEmpty' => 'URL不能為空',
			'meta.urlTooLong' => 'URL過長(>8182)',
			'meta.copyUrl' => '複製連結',
			'meta.openUrl' => '打開連結',
			'meta.shareUrl' => '分享連結',
			'meta.coreSettingTips' => '注意:修改配置後,需要重新連接才會生效',
			'meta.overwrite' => '覆寫',
			'meta.overwriteCustom' => '自定義覆寫',
			'meta.overwriteAppend' => '追加覆寫',
			'meta.overwriteTips' => '原始配置<-自定義覆寫<-App覆寫',
			'meta.noOverwrite' => '不覆寫',
			'meta.overwriteSettings' => '覆寫設置',
			'meta.diversionTemplates' => '分流模板',
			'meta.ruleProviders' => '規則提供者',
			'meta.ruleTemplates' => '規則模板',
			'meta.proxyGroupsTemplates' => '代理組模板',
			'meta.proxyGroups' => '代理組',
			'meta.proxyNodeList' => '代理節點列表',
			'meta.proxyNodeFailure' => ({required Object p}) => '下列代理節點已失效,已自動移除:${p}',
			'meta.externalController' => '外部控制',
			'meta.secret' => '金鑰',
			'meta.tcpConcurrent' => 'TCP併發握手',
			'meta.globalClientFingerprint' => 'TLS全局指紋',
			'meta.allowLanAccess' => '局域網設備接入',
			'meta.mixedPort' => '混合代理端口',
			'meta.logLevel' => '日誌等級',
			'meta.findProcessMode' => '進程匹配模式',
			'meta.tcpkeepAliveInterval' => 'TCP保活時間間隔',
			'meta.delayTestUrl' => '延遲測試URL',
			'meta.delayTestTimeout' => '延遲測試超時(ms)',
			'meta.tun' => 'TUN',
			'meta.ntp' => 'NTP',
			'meta.tls' => 'TLS',
			'meta.geo' => 'GEO',
			'meta.geoDownloadByProxy' => '使用代理下載Geo RuleSet',
			'meta.geoRulesetTips' => 'Geosite/Geoip 會被轉換成 對應的RuleSet',
			'meta.asnNotSupportInIosTips' => '由於iOS系統內存限制,IP-ASN及SRC-IP-ASN規則在iOS上將被忽略',
			'meta.sniffer' => '嗅探',
			'meta.userAgent' => 'UserAgent',
			'meta.launchAtStartup' => '開機啟動',
			'meta.launchAtStartupRunAsAdmin' => '請以管理員身份重新啟動Clash Mi',
			'meta.tunModeRunAsAdmin' => 'TUN模式需要系統管理員權限,請以管理員身份重新啟動應用',
			'meta.portableMode' => '便攜模式',
			'meta.portableModeDisableTips' => '如需退出便攜模式,請退出[clashmi]後,手動刪除[clashmi.exe]同目錄下的[portable]文件夾即可',
			'meta.systemProxy' => '系統代理',
			'meta.autoConnectAfterLaunch' => '啟動後自動連接',
			'meta.autoConnectAtBoot' => '系統啟動後自動連接',
			'meta.autoConnectAtBootTips' => '需要系統支持,部分系統可能還需要開啟[自啟動]',
			'meta.hideAfterLaunch' => '啟動後隱藏窗口',
			'meta.autoSetSystemProxy' => '連接後自動設置系統代理',
			'meta.bypassSystemProxy' => '允許繞過系統代理的域名',
			'meta.excludeFromRecent' => '從[最近任務]中隱藏',
			'meta.wakeLock' => '喚醒鎖',
			'meta.hideVpn' => '隱藏VPN圖標',
			'meta.hideVpnTips' => '開啟IPv6會導致此功能失效',
			'meta.hideDockIcon' => '隱藏Dock圖標',
			'meta.showTrayTraffic' => '托盤上顯示流量資訊',
			'meta.website' => '官網',
			'meta.homePage' => '主頁',
			'meta.rule' => '規則',
			'meta.global' => '全局',
			'meta.direct' => '直連',
			'meta.block' => '攔截',
			'meta.qrcode' => '二維碼',
			'meta.qrcodeTooLong' => '文本過長,無法展示',
			'meta.qrcodeShare' => '分享二維碼',
			'meta.textToQrcode' => '文本轉二維碼',
			'meta.qrcodeScan' => '掃描二維碼',
			'meta.qrcodeScanResult' => '掃描結果',
			'meta.qrcodeScanFromImage' => '打開二維碼圖片',
			'meta.qrcodeScanResultFailed' => '解析圖片失敗,請確保截圖為有效的二維碼',
			'meta.qrcodeScanResultEmpty' => '掃描結果為空',
			'meta.screenshot' => '截圖',
			'meta.backupAndSync' => '備份與同步',
			'meta.importSuccess' => '匯入成功',
			'meta.rewriteConfirm' => '該文件將覆蓋本地已有配置,是否繼續?',
			'meta.importAndExport' => '匯入/匯出',
			'meta.import' => '匯入',
			'meta.importFromUrl' => '從URL匯入',
			'meta.export' => '匯出',
			'meta.send' => '發送',
			'meta.receive' => '接收',
			'meta.sendConfirm' => '確認發送?',
			'meta.continueConnectConfirm' => '是否繼續連接?',
			'meta.termOfUse' => '使用條款',
			'meta.privacyPolicy' => '隱私政策',
			'meta.log' => '日誌',
			'meta.coreLog' => '核心日誌',
			'meta.core' => '核心',
			'meta.help' => '幫助',
			'meta.tutorial' => '使用教程',
			'meta.board' => '面板',
			'meta.boardOnline' => '使用在線面板',
			'meta.boardOnlineUrl' => '在線面板URL',
			'meta.boardLocalPort' => '本地面板端口',
			'meta.alwayOnVPN' => '始終開啟連線',
			'meta.disableFontScaler' => '禁用字體縮放',
			'meta.autoOrientation' => '跟隨螢幕旋轉',
			'meta.restartTakesEffect' => '重啟生效',
			'meta.reconnectTakesEffect' => '重新連接後生效',
			'meta.runtimeProfile' => '運行時配置',
			'meta.willCompleteAfterRebootInstall' => '請重啟設備,以便完成系統擴展安裝',
			'meta.willCompleteAfterRebootUninstall' => '請重啟設備,以便完成系統擴展卸載',
			'meta.requestNeedsUserApproval' => '1. 請在[系統設置]-[隱私與安全性]裏[允許] Clash Mi安裝系統擴展\n2. :[系統設置]-[通用]-[登錄項與擴展-網絡擴展]啟用[clashmiServiceSE]\n完成後重新連接',
			'meta.FullDiskAccessPermissionRequired' => '請在[系統設置]-[隱私與安全性]-[完全磁盤訪問權限]裏開啟clashmiServiceSE權限後,重新連接',
			'meta.proxy' => '代理',
			'meta.theme' => '主題',
			'meta.tvMode' => 'TV模式',
			'meta.autoUpdate' => '自動更新',
			'meta.updateChannel' => '自動更新通道',
			'meta.onlineCustomerService' => '線上客服',
			'meta.subscriptionChannel' => '訂閱頻道',
			'meta.hasNewVersion' => ({required Object p}) => '更新版本 ${p}',
			'meta.autoDownloadPkg' => '自動下載更新包',
			'meta.devOptions' => '開發者選項',
			'meta.about' => '關於',
			'meta.name' => '名稱',
			'meta.version' => '版本',
			'meta.notice' => '通知',
			'meta.sort' => '排序',
			'meta.recommended' => '推薦',
			'meta.innerError' => ({required Object p}) => '內部錯誤:${p}',
			'meta.share' => '分享',
			'meta.importFromClipboard' => '從剪貼簿導入',
			'meta.exportToClipboard' => '匯出到剪貼簿',
			'meta.server' => '伺服器',
			'meta.port' => '端口',
			'meta.donate' => '捐助',
			'meta.setting' => '設定',
			'meta.settingCore' => '核心設定',
			'meta.settingApp' => '應用設定',
			'meta.coreOverwrite' => '核心覆寫',
			'meta.iCloud' => 'iCloud',
			'meta.webdav' => 'Webdav',
			'meta.lanSync' => '局域網同步',
			'meta.lanSyncNotQuitTips' => '同步完成前請勿退出此界面',
			'meta.deviceNoSpace' => '磁盤空間不足',
			'meta.hideSystemApp' => '隱藏系統應用',
			'meta.hideAppIcon' => '隱藏應用圖標',
			'meta.openDir' => '打開文件目錄',
			'meta.type' => '類型',
			'meta.fileChoose' => '選擇文件',
			'meta.filePathCannotEmpty' => '文件路徑不能為空',
			'meta.fileNotExist' => ({required Object p}) => '文件不存在:${p}',
			'meta.fileTypeInvalid' => ({required Object p}) => '無效的文件類型:${p}',
			'meta.uwpExemption' => 'UWP網絡隔離豁免',
			'meta.getProfile' => '獲取設定',
			'meta.buyProfile' => '購買設定',
			'meta.addProfile' => '添加設定',
			'meta.myProfiles' => '我的設定',
			'meta.profileEdit' => '編輯設定',
			'meta.profileNeedActive' => '請先將本設定設為目前設定，並開啟連線/重新連線',
			'meta.profileDownloadBackupChannel' => '啟用備用下載通道',
			'meta.profileDownloadBackupChannelTips' => 'Clash Mi 提供的代理下載通道（不儲存任何資訊）',
			'meta.profileEditReloadAfterProfileUpdate' => '設定更新後重新載入',
			'meta.profileRulesAppendApplePush' => '附加 Apple 推送通知規則',
			'meta.profileRulesAppendProxyTips' => '規則將自動設為原始設定中 [proxy-groups] 內第一個類型為 [url-test] 或 [select] 的代理',
			'meta.profileImport' => '匯入設定檔',
			'meta.profileAddUrlOrContent' => '添加設定連結',
			'meta.profileUrlOrContent' => 'Clash設定連結',
			'meta.profileUrlOrContentHit' => 'Clash設定連結[必填]',
			'meta.profileUrlOrContentCannotEmpty' => '設定連結不能為空',
			'permission.camera' => '攝像頭',
			'permission.screen' => '屏幕錄製',
			'permission.appQuery' => '獲取應用列表',
			'permission.request' => ({required Object p}) => '開啟[${p}]權限',
			'permission.requestNeed' => ({required Object p}) => '請開啟[${p}]權限',
			'tls.insecure' => '跳過證書驗證',
			'tls.certificate' => '證書',
			'tls.privateKey' => '私鑰',
			'tls.customTrustCert' => '自定義證書',
			'tun.stack' => '網絡棧',
			'tun.inet4Address' => 'IPv4位址段',
			'tun.inet6Address' => 'IPv6位址段',
			'tun.dnsHijack' => 'DNS劫持',
			'tun.strictRoute' => '嚴格路由',
			'tun.tunDefaultRoute' => '預設路由',
			'tun.icmpForward' => 'ICMP 轉發',
			'tun.allowBypass' => '允許應用繞過VPN',
			'tun.appendHttpProxy' => '附加HTTP代理到VPN',
			'tun.bypassHttpProxyDomain' => '允許繞過HTTP代理的域名',
			'dns.listen' => '監聽地址',
			'dns.fakeIp' => 'fake-ip',
			'dns.fallback' => 'Fallback',
			'dns.preferH3' => 'DoH H3優先',
			'dns.useHosts' => '使用Hosts',
			'dns.useSystemHosts' => '使用系統Hosts',
			'dns.enhancedMode' => '增強模式',
			'dns.fakeIPFilterMode' => '${_root.dns.fakeIp} 過濾模式',
			'dns.fakeIPFilter' => '${_root.dns.fakeIp} 過濾',
			'dns.respectRules' => '遵守[rules]規則',
			'dns.nameServer' => '域名解析伺服器',
			'dns.defaultNameServer' => '${_root.meta.byDefault} ${_root.dns.nameServer}',
			'dns.proxyNameServer' => '${_root.meta.proxy} ${_root.dns.nameServer}',
			'dns.directNameServer' => '${_root.meta.direct} ${_root.dns.nameServer}',
			'dns.fallbackNameServer' => '${_root.dns.fallback} ${_root.dns.nameServer}',
			'dns.fallbackGeoIp' => '${_root.dns.fallback} GeoIp',
			'dns.fallbackGeoIpCode' => '${_root.dns.fallback} GeoIp 代碼',
			'sniffer.overrideDest' => '覆蓋',
			'profilePatchMode.currentSelected' => '當前選擇',
			'profilePatchMode.overwrite' => '內置-覆寫',
			'profilePatchMode.noOverwrite' => '內置-不覆寫',
			'protocolSniff' => '協議探測',
			'protocolSniffOverrideDestination' => '探測的域名覆蓋連接目標地址',
			'edgeRuntimeNotInstalled' => '當前設備尚未安裝Edge WebView2運行時,無法展示頁面,請下載安裝Edge WebView2運行時(x64)後,重啟App再試',
			'locales.en' => 'English',
			'locales.zh-CN' => '简体中文',
			'locales.zh-TW' => '繁體中文',
			'locales.ja' => '日本語',
			'locales.ko' => '한국어',
			'locales.ar' => 'عربي',
			'locales.ru' => 'Русский',
			'locales.fa' => 'فارسی',
			'locales.es' => 'Español',
			_ => null,
		};
	}
}
