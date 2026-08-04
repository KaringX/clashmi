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
class TranslationsZhCn with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZhCn({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zhCn,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh-CN>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZhCn _root = this; // ignore: unused_field

	@override 
	TranslationsZhCn $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZhCn(meta: meta ?? this.$meta);

	// Translations
	@override late final Translations$BackupAndSyncWebdavScreen$zh_CN BackupAndSyncWebdavScreen = Translations$BackupAndSyncWebdavScreen$zh_CN.internal(_root);
	@override late final Translations$LaunchFailedScreen$zh_CN LaunchFailedScreen = Translations$LaunchFailedScreen$zh_CN.internal(_root);
	@override late final Translations$PerAppAndroidScreen$zh_CN PerAppAndroidScreen = Translations$PerAppAndroidScreen$zh_CN.internal(_root);
	@override late final Translations$UserAgreementScreen$zh_CN UserAgreementScreen = Translations$UserAgreementScreen$zh_CN.internal(_root);
	@override late final Translations$NetCheckScreen$zh_CN NetCheckScreen = Translations$NetCheckScreen$zh_CN.internal(_root);
	@override late final Translations$VersionUpdateScreen$zh_CN VersionUpdateScreen = Translations$VersionUpdateScreen$zh_CN.internal(_root);
	@override late final Translations$loginScreen$zh_CN loginScreen = Translations$loginScreen$zh_CN.internal(_root);
	@override late final Translations$main$zh_CN main = Translations$main$zh_CN.internal(_root);
	@override late final Translations$meta$zh_CN meta = Translations$meta$zh_CN.internal(_root);
	@override late final Translations$permission$zh_CN permission = Translations$permission$zh_CN.internal(_root);
	@override late final Translations$tls$zh_CN tls = Translations$tls$zh_CN.internal(_root);
	@override late final Translations$tun$zh_CN tun = Translations$tun$zh_CN.internal(_root);
	@override late final Translations$dns$zh_CN dns = Translations$dns$zh_CN.internal(_root);
	@override late final Translations$sniffer$zh_CN sniffer = Translations$sniffer$zh_CN.internal(_root);
	@override late final Translations$profilePatchMode$zh_CN profilePatchMode = Translations$profilePatchMode$zh_CN.internal(_root);
	@override String get protocolSniff => '协议探测';
	@override String get protocolSniffOverrideDestination => '探测的域名覆盖连接目标地址';
	@override String get edgeRuntimeNotInstalled => '当前设备尚未安装Edge WebView2运行时,无法展示页面,请下载安装Edge WebView2运行时(x64)后,重启App再试';
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
class Translations$BackupAndSyncWebdavScreen$zh_CN implements Translations$BackupAndSyncWebdavScreen$en {
	Translations$BackupAndSyncWebdavScreen$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get webdavServerUrl => '服务器地址';
	@override String get webdavRequired => '不能为空';
	@override String get webdavLoginFailed => '登录失败:';
	@override String get webdavListFailed => '获取文件列表失败:';
}

// Path: LaunchFailedScreen
class Translations$LaunchFailedScreen$zh_CN implements Translations$LaunchFailedScreen$en {
	Translations$LaunchFailedScreen$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get invalidProcess => '应用启动失败[无效的进程名称],请重新安装应用到独立目录';
	@override String get invalidProfile => '应用启动失败[访问配置文件失败],请重新安装应用';
	@override String get invalidVersion => '应用启动失败[无效版本],请重新安装应用';
	@override String get systemVersionLow => '应用启动失败[系统版本过低]';
	@override String get invalidInstallPath => '无效的安装路径,请重新安装到有效路径';
}

// Path: PerAppAndroidScreen
class Translations$PerAppAndroidScreen$zh_CN implements Translations$PerAppAndroidScreen$en {
	Translations$PerAppAndroidScreen$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get title => '分应用代理';
	@override String get whiteListMode => '白名单模式';
	@override String get whiteListModeTip => '启用后:仅代理已勾选的App;未启用:仅代理未勾选的App';
}

// Path: UserAgreementScreen
class Translations$UserAgreementScreen$zh_CN implements Translations$UserAgreementScreen$en {
	Translations$UserAgreementScreen$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get privacyFirst => '您的隐私很重要';
	@override String get agreeAndContinue => '接受并继续';
}

// Path: NetCheckScreen
class Translations$NetCheckScreen$zh_CN implements Translations$NetCheckScreen$en {
	Translations$NetCheckScreen$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get enterDomain => '请输入域名';
	@override String get checking => '检测中...';
	@override String aQueryFailed({required Object p}) => 'A 查询失败: ${p}';
	@override String aaaaQueryFailed({required Object p}) => 'AAAA 查询失败: ${p}';
	@override String get success => '成功';
	@override String get failed => '失败';
	@override String get suspectedPollution => '疑似被污染';
	@override String get domainLabel => '域名';
	@override String get checkButton => '检测';
	@override String get dnsSection => '1. DNS查询';
	@override String get directHttpSection => '2. HTTP (经由TUN,请先开启TUN)';
	@override String proxyHttpSection({required Object p}) => '3. HTTP (经由代理,端口:${p})';
	@override String get tunNotEnabled => 'TUN 未开启';
	@override String get routeTableSection => '4. 路由表';
}

// Path: VersionUpdateScreen
class Translations$VersionUpdateScreen$zh_CN implements Translations$VersionUpdateScreen$en {
	Translations$VersionUpdateScreen$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String versionReady({required Object p}) => '新版本[${p}]已就绪';
	@override String get update => '重启更新';
	@override String get cancel => '暂不更新';
}

// Path: loginScreen
class Translations$loginScreen$zh_CN implements Translations$loginScreen$en {
	Translations$loginScreen$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get login => '登录';
	@override String get register => '注册账号';
	@override String get forgotPassword => '忘记密码';
	@override String get provider => '服务商(机场)';
	@override String get providerName => '${_root.loginScreen.provider}编码/别名/URL';
	@override String get providerNameRequired => '请输入${_root.loginScreen.provider}编码/别名/URL';
	@override String get account => '账号';
	@override String get accountRequired => '请输入账号';
	@override String get email => '邮箱';
	@override String get emailRequired => '请输入邮箱地址';
	@override String get password => '密码';
	@override String get passwordRequired => '请输入密码';
	@override String get validEmailRequired => '请输入有效的邮箱地址';
	@override String passwordMinLength({required Object minLength}) => '密码长度至少${minLength}位';
	@override String get unsupportedProvider => '不支持的${_root.loginScreen.provider}';
	@override String get unsupportedProviderType => '不支持的${_root.loginScreen.provider}类型';
	@override String get unActivedProvider => '登录功能未激活';
	@override String providerLoginSupportRequired({required Object p}) => '编码/别名请找${_root.loginScreen.provider}索要\n${_root.loginScreen.provider}接入请参考:${p}';
	@override String get providerDisclaimer => '免责声明:${_root.loginScreen.provider}为三方服务,与本App无关';
}

// Path: main
class Translations$main$zh_CN implements Translations$main$en {
	Translations$main$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override late final Translations$main$tray$zh_CN tray = Translations$main$tray$zh_CN.internal(_root);
}

// Path: meta
class Translations$meta$zh_CN implements Translations$meta$en {
	Translations$meta$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get enable => '启用';
	@override String get disable => '禁用';
	@override String get open => '打开';
	@override String get close => '关闭';
	@override String get quit => '退出';
	@override String get add => '添加';
	@override String get addSuccess => '添加成功';
	@override String addFailed({required Object p}) => '添加失败:${p}';
	@override String get remove => '删除';
	@override String get removeConfirm => '确认删除?';
	@override String get edit => '编辑';
	@override String get view => '查看';
	@override String get remark => '备注';
	@override String get byDefault => '默认';
	@override String get editRemark => '修改备注';
	@override String get more => '更多';
	@override String get tips => '提示';
	@override String get selectAll => '全选';
	@override String get copy => '拷贝';
	@override String get paste => '粘贴';
	@override String get cut => '剪切';
	@override String get save => '保存';
	@override String get ok => '确定';
	@override String get cancel => '取消';
	@override String get faq => '常见问题';
	@override String get doc => '文档';
	@override String get htmlTools => 'HTML工具集';
	@override String get download => '下载';
	@override String get loading => '加载中...';
	@override String get days => '天';
	@override String get hours => '时';
	@override String get minutes => '分';
	@override String get seconds => '秒';
	@override String get milliseconds => '毫秒';
	@override String get protocol => '协议';
	@override String get search => '搜索';
	@override String get custom => '自定义';
	@override String get connect => '连接';
	@override String get disconnect => '断开';
	@override String get connected => '已连接';
	@override String get disconnected => '未连接';
	@override String get connecting => '连接中';
	@override String get connectTimeout => '连接超时';
	@override String get timeout => '超时';
	@override String get timeoutDuration => '超时时长';
	@override String get latency => '延迟';
	@override String get latencyTest => '延迟检测';
	@override String get networkCheck => '网络检测';
	@override String get language => '语言';
	@override String get next => '下一步';
	@override String get done => '完成';
	@override String get apply => '应用';
	@override String get refresh => '刷新';
	@override String get retry => '是否重试?';
	@override String get update => '更新';
	@override String get updateInterval => '更新时间间隔';
	@override String get updateInterval5mTips => '最小:5m';
	@override String get updateIntervalPreferByProfile => '优先使用服务商(机场)设置';
	@override String updateFailed({required Object p}) => '更新失败:${p}';
	@override String get none => '无';
	@override String get reset => '重置';
	@override String get authentication => '授权';
	@override String get submit => '提交';
	@override String get user => '用户';
	@override String get account => '账号';
	@override String get password => '密码';
	@override String get decryptPassword => '解密密码';
	@override String get required => '必填';
	@override String get go => '继续';
	@override String get sudoPassword => 'sudo 密码(TUN模式需要)';
	@override String get other => '其他';
	@override String get dns => 'DNS';
	@override String get url => 'URL';
	@override String get urlInvalid => 'URL无效';
	@override String get urlCannotEmpty => 'URL不能为空';
	@override String get urlTooLong => 'URL过长(>8182)';
	@override String get copyUrl => '拷贝链接';
	@override String get openUrl => '打开链接';
	@override String get shareUrl => '分享链接';
	@override String get coreSettingTips => '注意:修改配置后,需要重新连接才会生效';
	@override String get overwrite => '覆写';
	@override String get overwriteCustom => '自定义覆写';
	@override String get overwriteAppend => '追加覆写';
	@override String get overwriteTips => '原始配置<-自定义覆写<-App覆写';
	@override String get noOverwrite => '不覆写';
	@override String get overwriteSettings => '覆写设置';
	@override String get diversionTemplates => '分流模板';
	@override String get ruleProviders => '规则提供者';
	@override String get ruleTemplates => '规则模板';
	@override String get proxyGroupsTemplates => '代理组模板';
	@override String get proxyGroups => '代理组';
	@override String get proxyNodeList => '代理节点列表';
	@override String proxyNodeFailure({required Object p}) => '下列代理节点已失效,已自动移除:${p}';
	@override String get externalController => '外部控制';
	@override String get secret => 'Secret';
	@override String get tcpConcurrent => 'TCP并发握手';
	@override String get globalClientFingerprint => 'TLS全局指纹';
	@override String get allowLanAccess => '局域网设备接入';
	@override String get mixedPort => '混合代理端口';
	@override String get logLevel => '日志等级';
	@override String get findProcessMode => '进程匹配模式';
	@override String get tcpkeepAliveInterval => 'TCP保活时间间隔';
	@override String get delayTestUrl => '延迟测试URL';
	@override String get delayTestTimeout => '延迟测试超时(ms)';
	@override String get tun => 'TUN';
	@override String get ntp => 'NTP';
	@override String get tls => 'TLS';
	@override String get geo => 'GEO';
	@override String get geoDownloadByProxy => '使用代理下载Geo RuleSet';
	@override String get geoRulesetTips => 'Geosite/Geoip 会被转换成 对应的RuleSet';
	@override String get asnNotSupportInIosTips => '由于iOS系统内存限制,IP-ASN及SRC-IP-ASN规则在iOS上将被忽略';
	@override String get sniffer => '嗅探';
	@override String get userAgent => 'UserAgent';
	@override String get launchAtStartup => '开机启动';
	@override String get launchAtStartupRunAsAdmin => '请以管理员身份重新启动Clash Mi';
	@override String get tunModeRunAsAdmin => 'TUN模式需要系统管理员权限,请以管理员身份重新启动应用';
	@override String get portableMode => '便携模式';
	@override String get portableModeDisableTips => '如需退出便携模式,请退出[clashmi]后,手动删除[clashmi.exe]同目录下的[portable]文件夹即可';
	@override String get systemProxy => '系统代理';
	@override String get autoConnectAfterLaunch => '启动后自动连接';
	@override String get autoConnectAtBoot => '系统启动后自动连接';
	@override String get autoConnectAtBootTips => '需要系统支持,部分系统可能还需要开启[自启动]';
	@override String get hideAfterLaunch => '启动后隐藏窗口';
	@override String get autoSetSystemProxy => '连接后自动设置系统代理';
	@override String get bypassSystemProxy => '允许绕过系统代理的域名';
	@override String get excludeFromRecent => '从[最近任务]中隐藏';
	@override String get wakeLock => '唤醒锁';
	@override String get hideVpn => '隐藏VPN图标';
	@override String get hideVpnTips => '开启IPv6会导致此功能失效';
	@override String get hideDockIcon => '隐藏Dock图标';
	@override String get showTrayTraffic => '托盘上显示流量信息';
	@override String get website => '官网';
	@override String get homePage => '主页';
	@override String get rule => '规则';
	@override String get global => '全局';
	@override String get direct => '直连';
	@override String get block => '拦截';
	@override String get qrcode => '二维码';
	@override String get qrcodeTooLong => '文本过长,无法展示';
	@override String get qrcodeShare => '分享二维码';
	@override String get textToQrcode => '文本转二维码';
	@override String get qrcodeScan => '扫描二维码';
	@override String get qrcodeScanResult => '扫描结果';
	@override String get qrcodeScanFromImage => '打开二维码图片';
	@override String get qrcodeScanResultFailed => '解析图片失败,请确保截图为有效的二维码';
	@override String get qrcodeScanResultEmpty => '扫描结果为空';
	@override String get screenshot => '截图';
	@override String get backupAndSync => '备份与同步';
	@override String get importSuccess => '导入成功';
	@override String get rewriteConfirm => '该文件将覆盖本地已有配置,是否继续?';
	@override String get importAndExport => '导入/导出';
	@override String get import => '导入';
	@override String get importFromUrl => '从URL导入';
	@override String get export => '导出';
	@override String get send => '发送';
	@override String get receive => '接收';
	@override String get sendConfirm => '确认发送?';
	@override String get continueConnectConfirm => '是否继续连接?';
	@override String get termOfUse => '使用条款';
	@override String get privacyPolicy => '隐私政策';
	@override String get log => '日志';
	@override String get coreLog => '核心日志';
	@override String get core => '核心';
	@override String get help => '帮助';
	@override String get tutorial => '使用教程';
	@override String get board => '面板';
	@override String get boardOnline => '使用在线面板';
	@override String get boardOnlineUrl => '在线面板URL';
	@override String get boardLocalPort => '本地面板端口';
	@override String get alwayOnVPN => '始终开启连接';
	@override String get disableFontScaler => '禁用字体缩放';
	@override String get autoOrientation => '跟随屏幕旋转';
	@override String get restartTakesEffect => '重启生效';
	@override String get reconnectTakesEffect => '重新连接后生效';
	@override String get runtimeProfile => '运行时配置';
	@override String get willCompleteAfterRebootInstall => '请重启设备,以便完成系统扩展安装';
	@override String get willCompleteAfterRebootUninstall => '请重启设备,以便完成系统扩展卸载';
	@override String get requestNeedsUserApproval => '1. 请在[系统设置]-[隐私与安全性]里[允许] Clash Mi安装系统扩展\n2. :[系统设置]-[通用]-[登录项与扩展-网络扩展]启用[clashmiServiceSE]\n完成后重新连接';
	@override String get FullDiskAccessPermissionRequired => '请在[系统设置]-[隐私与安全性]-[完全磁盘访问权限]里开启clashmiServiceSE权限后,重新连接';
	@override String get proxy => '代理';
	@override String get theme => '主题';
	@override String get tvMode => 'TV模式';
	@override String get autoUpdate => '自动更新';
	@override String get updateChannel => '自动更新通道';
	@override String get onlineCustomerService => '在线客服';
	@override String get subscriptionChannel => '订阅频道';
	@override String hasNewVersion({required Object p}) => '更新版本 ${p}';
	@override String get autoDownloadPkg => '自动下载更新包';
	@override String get devOptions => '开发者选项';
	@override String get about => '关于';
	@override String get name => '名称';
	@override String get version => '版本';
	@override String get notice => '通知';
	@override String get sort => '排序';
	@override String get recommended => '推荐';
	@override String innerError({required Object p}) => '内部错误:${p}';
	@override String get share => '分享';
	@override String get importFromClipboard => '从剪贴板导入';
	@override String get exportToClipboard => '导出到剪贴板';
	@override String get server => '服务器';
	@override String get port => '端口';
	@override String get donate => '捐助';
	@override String get setting => '设置';
	@override String get settingCore => '核心设置';
	@override String get settingApp => '应用设置';
	@override String get coreOverwrite => '核心覆写';
	@override String get iCloud => 'iCloud';
	@override String get webdav => 'Webdav';
	@override String get lanSync => '局域网同步';
	@override String get lanSyncNotQuitTips => '同步完成前请勿退出此界面';
	@override String get deviceNoSpace => '磁盘空间不足';
	@override String get hideSystemApp => '隐藏系统应用';
	@override String get hideAppIcon => '隐藏应用图标';
	@override String get openDir => '打开文件目录';
	@override String get type => '类型';
	@override String get fileChoose => '选择文件';
	@override String get filePathCannotEmpty => '文件路径不能为空';
	@override String fileNotExist({required Object p}) => '文件不存在:${p}';
	@override String fileTypeInvalid({required Object p}) => '无效的文件类型:${p}';
	@override String get uwpExemption => 'UWP网络隔离豁免';
	@override String get getProfile => '获取配置';
	@override String get buyProfile => '购买配置';
	@override String get addProfile => '添加配置';
	@override String get myProfiles => '我的配置';
	@override String get profileEdit => '编辑配置';
	@override String get profileNeedActive => '请先将本配置设置为当前配置,并开启连接/重新连接';
	@override String get profileDownloadBackupChannel => '启用备用下载通道';
	@override String get profileDownloadBackupChannelTips => 'Clash Mi提供的代理下载通道(不存储任何信息)';
	@override String get profileEditReloadAfterProfileUpdate => '配置更新后重新加载';
	@override String get profileRulesAppendApplePush => '附加 Apple 推送通知规则';
	@override String get profileRulesAppendProxyTips => '规则将自动设置为原始配置里[proxy-groups]中的第一个类型为[url-test]或[select]的代理';
	@override String get profileImport => '导入配置文件';
	@override String get profileAddUrlOrContent => '添加配置链接';
	@override String get profileUrlOrContent => 'Clash配置链接';
	@override String get profileUrlOrContentHit => 'Clash配置链接[必填]';
	@override String get profileUrlOrContentCannotEmpty => '配置链接不能为空';
}

// Path: permission
class Translations$permission$zh_CN implements Translations$permission$en {
	Translations$permission$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get camera => '摄像头';
	@override String get screen => '屏幕录制';
	@override String get appQuery => '获取应用列表';
	@override String request({required Object p}) => '开启[${p}]权限';
	@override String requestNeed({required Object p}) => '请开启[${p}]权限';
}

// Path: tls
class Translations$tls$zh_CN implements Translations$tls$en {
	Translations$tls$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get insecure => '跳过证书验证';
	@override String get certificate => '证书';
	@override String get privateKey => '私钥';
	@override String get customTrustCert => '自定义证书';
}

// Path: tun
class Translations$tun$zh_CN implements Translations$tun$en {
	Translations$tun$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get stack => '网络栈';
	@override String get inet4Address => 'IPv4地址段';
	@override String get inet6Address => 'IPv6地址段';
	@override String get dnsHijack => 'DNS劫持';
	@override String get strictRoute => '严格路由';
	@override String get tunDefaultRoute => '默认路由';
	@override String get icmpForward => 'ICMP 转发';
	@override String get allowBypass => '允许应用绕过VPN';
	@override String get appendHttpProxy => '附加HTTP代理到VPN';
	@override String get bypassHttpProxyDomain => '允许绕过HTTP代理的域名';
}

// Path: dns
class Translations$dns$zh_CN implements Translations$dns$en {
	Translations$dns$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get listen => '监听地址';
	@override String get fakeIp => 'fake-ip';
	@override String get fallback => 'Fallback';
	@override String get preferH3 => 'DoH H3优先';
	@override String get useHosts => '使用Hosts';
	@override String get useSystemHosts => '使用系统Hosts';
	@override String get enhancedMode => '增强模式';
	@override String get fakeIPFilterMode => '${_root.dns.fakeIp} 过滤模式';
	@override String get fakeIPFilter => '${_root.dns.fakeIp} 过滤';
	@override String get respectRules => '遵守[rules]规则';
	@override String get nameServer => '域名解析服务器';
	@override String get defaultNameServer => '${_root.meta.byDefault} ${_root.dns.nameServer}';
	@override String get proxyNameServer => '${_root.meta.proxy} ${_root.dns.nameServer}';
	@override String get directNameServer => '${_root.meta.direct} ${_root.dns.nameServer}';
	@override String get fallbackNameServer => '${_root.dns.fallback} ${_root.dns.nameServer}';
	@override String get fallbackGeoIp => '${_root.dns.fallback} GeoIp';
	@override String get fallbackGeoIpCode => '${_root.dns.fallback} GeoIp 代码';
}

// Path: sniffer
class Translations$sniffer$zh_CN implements Translations$sniffer$en {
	Translations$sniffer$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get overrideDest => '覆盖';
}

// Path: profilePatchMode
class Translations$profilePatchMode$zh_CN implements Translations$profilePatchMode$en {
	Translations$profilePatchMode$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get currentSelected => '当前选择';
	@override String get overwrite => '内置-覆写';
	@override String get noOverwrite => '内置-不覆写';
}

// Path: main.tray
class Translations$main$tray$zh_CN implements Translations$main$tray$en {
	Translations$main$tray$zh_CN.internal(this._root);

	final TranslationsZhCn _root; // ignore: unused_field

	// Translations
	@override String get menuOpen => '打开';
	@override String get menuExit => '退出';
}

/// The flat map containing all translations for locale <zh-CN>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZhCn {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'BackupAndSyncWebdavScreen.webdavServerUrl' => '服务器地址',
			'BackupAndSyncWebdavScreen.webdavRequired' => '不能为空',
			'BackupAndSyncWebdavScreen.webdavLoginFailed' => '登录失败:',
			'BackupAndSyncWebdavScreen.webdavListFailed' => '获取文件列表失败:',
			'LaunchFailedScreen.invalidProcess' => '应用启动失败[无效的进程名称],请重新安装应用到独立目录',
			'LaunchFailedScreen.invalidProfile' => '应用启动失败[访问配置文件失败],请重新安装应用',
			'LaunchFailedScreen.invalidVersion' => '应用启动失败[无效版本],请重新安装应用',
			'LaunchFailedScreen.systemVersionLow' => '应用启动失败[系统版本过低]',
			'LaunchFailedScreen.invalidInstallPath' => '无效的安装路径,请重新安装到有效路径',
			'PerAppAndroidScreen.title' => '分应用代理',
			'PerAppAndroidScreen.whiteListMode' => '白名单模式',
			'PerAppAndroidScreen.whiteListModeTip' => '启用后:仅代理已勾选的App;未启用:仅代理未勾选的App',
			'UserAgreementScreen.privacyFirst' => '您的隐私很重要',
			'UserAgreementScreen.agreeAndContinue' => '接受并继续',
			'NetCheckScreen.enterDomain' => '请输入域名',
			'NetCheckScreen.checking' => '检测中...',
			'NetCheckScreen.aQueryFailed' => ({required Object p}) => 'A 查询失败: ${p}',
			'NetCheckScreen.aaaaQueryFailed' => ({required Object p}) => 'AAAA 查询失败: ${p}',
			'NetCheckScreen.success' => '成功',
			'NetCheckScreen.failed' => '失败',
			'NetCheckScreen.suspectedPollution' => '疑似被污染',
			'NetCheckScreen.domainLabel' => '域名',
			'NetCheckScreen.checkButton' => '检测',
			'NetCheckScreen.dnsSection' => '1. DNS查询',
			'NetCheckScreen.directHttpSection' => '2. HTTP (经由TUN,请先开启TUN)',
			'NetCheckScreen.proxyHttpSection' => ({required Object p}) => '3. HTTP (经由代理,端口:${p})',
			'NetCheckScreen.tunNotEnabled' => 'TUN 未开启',
			'NetCheckScreen.routeTableSection' => '4. 路由表',
			'VersionUpdateScreen.versionReady' => ({required Object p}) => '新版本[${p}]已就绪',
			'VersionUpdateScreen.update' => '重启更新',
			'VersionUpdateScreen.cancel' => '暂不更新',
			'loginScreen.login' => '登录',
			'loginScreen.register' => '注册账号',
			'loginScreen.forgotPassword' => '忘记密码',
			'loginScreen.provider' => '服务商(机场)',
			'loginScreen.providerName' => '${_root.loginScreen.provider}编码/别名/URL',
			'loginScreen.providerNameRequired' => '请输入${_root.loginScreen.provider}编码/别名/URL',
			'loginScreen.account' => '账号',
			'loginScreen.accountRequired' => '请输入账号',
			'loginScreen.email' => '邮箱',
			'loginScreen.emailRequired' => '请输入邮箱地址',
			'loginScreen.password' => '密码',
			'loginScreen.passwordRequired' => '请输入密码',
			'loginScreen.validEmailRequired' => '请输入有效的邮箱地址',
			'loginScreen.passwordMinLength' => ({required Object minLength}) => '密码长度至少${minLength}位',
			'loginScreen.unsupportedProvider' => '不支持的${_root.loginScreen.provider}',
			'loginScreen.unsupportedProviderType' => '不支持的${_root.loginScreen.provider}类型',
			'loginScreen.unActivedProvider' => '登录功能未激活',
			'loginScreen.providerLoginSupportRequired' => ({required Object p}) => '编码/别名请找${_root.loginScreen.provider}索要\n${_root.loginScreen.provider}接入请参考:${p}',
			'loginScreen.providerDisclaimer' => '免责声明:${_root.loginScreen.provider}为三方服务,与本App无关',
			'main.tray.menuOpen' => '打开',
			'main.tray.menuExit' => '退出',
			'meta.enable' => '启用',
			'meta.disable' => '禁用',
			'meta.open' => '打开',
			'meta.close' => '关闭',
			'meta.quit' => '退出',
			'meta.add' => '添加',
			'meta.addSuccess' => '添加成功',
			'meta.addFailed' => ({required Object p}) => '添加失败:${p}',
			'meta.remove' => '删除',
			'meta.removeConfirm' => '确认删除?',
			'meta.edit' => '编辑',
			'meta.view' => '查看',
			'meta.remark' => '备注',
			'meta.byDefault' => '默认',
			'meta.editRemark' => '修改备注',
			'meta.more' => '更多',
			'meta.tips' => '提示',
			'meta.selectAll' => '全选',
			'meta.copy' => '拷贝',
			'meta.paste' => '粘贴',
			'meta.cut' => '剪切',
			'meta.save' => '保存',
			'meta.ok' => '确定',
			'meta.cancel' => '取消',
			'meta.faq' => '常见问题',
			'meta.doc' => '文档',
			'meta.htmlTools' => 'HTML工具集',
			'meta.download' => '下载',
			'meta.loading' => '加载中...',
			'meta.days' => '天',
			'meta.hours' => '时',
			'meta.minutes' => '分',
			'meta.seconds' => '秒',
			'meta.milliseconds' => '毫秒',
			'meta.protocol' => '协议',
			'meta.search' => '搜索',
			'meta.custom' => '自定义',
			'meta.connect' => '连接',
			'meta.disconnect' => '断开',
			'meta.connected' => '已连接',
			'meta.disconnected' => '未连接',
			'meta.connecting' => '连接中',
			'meta.connectTimeout' => '连接超时',
			'meta.timeout' => '超时',
			'meta.timeoutDuration' => '超时时长',
			'meta.latency' => '延迟',
			'meta.latencyTest' => '延迟检测',
			'meta.networkCheck' => '网络检测',
			'meta.language' => '语言',
			'meta.next' => '下一步',
			'meta.done' => '完成',
			'meta.apply' => '应用',
			'meta.refresh' => '刷新',
			'meta.retry' => '是否重试?',
			'meta.update' => '更新',
			'meta.updateInterval' => '更新时间间隔',
			'meta.updateInterval5mTips' => '最小:5m',
			'meta.updateIntervalPreferByProfile' => '优先使用服务商(机场)设置',
			'meta.updateFailed' => ({required Object p}) => '更新失败:${p}',
			'meta.none' => '无',
			'meta.reset' => '重置',
			'meta.authentication' => '授权',
			'meta.submit' => '提交',
			'meta.user' => '用户',
			'meta.account' => '账号',
			'meta.password' => '密码',
			'meta.decryptPassword' => '解密密码',
			'meta.required' => '必填',
			'meta.go' => '继续',
			'meta.sudoPassword' => 'sudo 密码(TUN模式需要)',
			'meta.other' => '其他',
			'meta.dns' => 'DNS',
			'meta.url' => 'URL',
			'meta.urlInvalid' => 'URL无效',
			'meta.urlCannotEmpty' => 'URL不能为空',
			'meta.urlTooLong' => 'URL过长(>8182)',
			'meta.copyUrl' => '拷贝链接',
			'meta.openUrl' => '打开链接',
			'meta.shareUrl' => '分享链接',
			'meta.coreSettingTips' => '注意:修改配置后,需要重新连接才会生效',
			'meta.overwrite' => '覆写',
			'meta.overwriteCustom' => '自定义覆写',
			'meta.overwriteAppend' => '追加覆写',
			'meta.overwriteTips' => '原始配置<-自定义覆写<-App覆写',
			'meta.noOverwrite' => '不覆写',
			'meta.overwriteSettings' => '覆写设置',
			'meta.diversionTemplates' => '分流模板',
			'meta.ruleProviders' => '规则提供者',
			'meta.ruleTemplates' => '规则模板',
			'meta.proxyGroupsTemplates' => '代理组模板',
			'meta.proxyGroups' => '代理组',
			'meta.proxyNodeList' => '代理节点列表',
			'meta.proxyNodeFailure' => ({required Object p}) => '下列代理节点已失效,已自动移除:${p}',
			'meta.externalController' => '外部控制',
			'meta.secret' => 'Secret',
			'meta.tcpConcurrent' => 'TCP并发握手',
			'meta.globalClientFingerprint' => 'TLS全局指纹',
			'meta.allowLanAccess' => '局域网设备接入',
			'meta.mixedPort' => '混合代理端口',
			'meta.logLevel' => '日志等级',
			'meta.findProcessMode' => '进程匹配模式',
			'meta.tcpkeepAliveInterval' => 'TCP保活时间间隔',
			'meta.delayTestUrl' => '延迟测试URL',
			'meta.delayTestTimeout' => '延迟测试超时(ms)',
			'meta.tun' => 'TUN',
			'meta.ntp' => 'NTP',
			'meta.tls' => 'TLS',
			'meta.geo' => 'GEO',
			'meta.geoDownloadByProxy' => '使用代理下载Geo RuleSet',
			'meta.geoRulesetTips' => 'Geosite/Geoip 会被转换成 对应的RuleSet',
			'meta.asnNotSupportInIosTips' => '由于iOS系统内存限制,IP-ASN及SRC-IP-ASN规则在iOS上将被忽略',
			'meta.sniffer' => '嗅探',
			'meta.userAgent' => 'UserAgent',
			'meta.launchAtStartup' => '开机启动',
			'meta.launchAtStartupRunAsAdmin' => '请以管理员身份重新启动Clash Mi',
			'meta.tunModeRunAsAdmin' => 'TUN模式需要系统管理员权限,请以管理员身份重新启动应用',
			'meta.portableMode' => '便携模式',
			'meta.portableModeDisableTips' => '如需退出便携模式,请退出[clashmi]后,手动删除[clashmi.exe]同目录下的[portable]文件夹即可',
			'meta.systemProxy' => '系统代理',
			'meta.autoConnectAfterLaunch' => '启动后自动连接',
			'meta.autoConnectAtBoot' => '系统启动后自动连接',
			'meta.autoConnectAtBootTips' => '需要系统支持,部分系统可能还需要开启[自启动]',
			'meta.hideAfterLaunch' => '启动后隐藏窗口',
			'meta.autoSetSystemProxy' => '连接后自动设置系统代理',
			'meta.bypassSystemProxy' => '允许绕过系统代理的域名',
			'meta.excludeFromRecent' => '从[最近任务]中隐藏',
			'meta.wakeLock' => '唤醒锁',
			'meta.hideVpn' => '隐藏VPN图标',
			'meta.hideVpnTips' => '开启IPv6会导致此功能失效',
			'meta.hideDockIcon' => '隐藏Dock图标',
			'meta.showTrayTraffic' => '托盘上显示流量信息',
			'meta.website' => '官网',
			'meta.homePage' => '主页',
			'meta.rule' => '规则',
			'meta.global' => '全局',
			'meta.direct' => '直连',
			'meta.block' => '拦截',
			'meta.qrcode' => '二维码',
			'meta.qrcodeTooLong' => '文本过长,无法展示',
			'meta.qrcodeShare' => '分享二维码',
			'meta.textToQrcode' => '文本转二维码',
			'meta.qrcodeScan' => '扫描二维码',
			'meta.qrcodeScanResult' => '扫描结果',
			'meta.qrcodeScanFromImage' => '打开二维码图片',
			'meta.qrcodeScanResultFailed' => '解析图片失败,请确保截图为有效的二维码',
			'meta.qrcodeScanResultEmpty' => '扫描结果为空',
			'meta.screenshot' => '截图',
			'meta.backupAndSync' => '备份与同步',
			'meta.importSuccess' => '导入成功',
			'meta.rewriteConfirm' => '该文件将覆盖本地已有配置,是否继续?',
			'meta.importAndExport' => '导入/导出',
			'meta.import' => '导入',
			'meta.importFromUrl' => '从URL导入',
			'meta.export' => '导出',
			'meta.send' => '发送',
			'meta.receive' => '接收',
			'meta.sendConfirm' => '确认发送?',
			'meta.continueConnectConfirm' => '是否继续连接?',
			'meta.termOfUse' => '使用条款',
			'meta.privacyPolicy' => '隐私政策',
			'meta.log' => '日志',
			'meta.coreLog' => '核心日志',
			'meta.core' => '核心',
			'meta.help' => '帮助',
			'meta.tutorial' => '使用教程',
			'meta.board' => '面板',
			'meta.boardOnline' => '使用在线面板',
			'meta.boardOnlineUrl' => '在线面板URL',
			'meta.boardLocalPort' => '本地面板端口',
			'meta.alwayOnVPN' => '始终开启连接',
			'meta.disableFontScaler' => '禁用字体缩放',
			'meta.autoOrientation' => '跟随屏幕旋转',
			'meta.restartTakesEffect' => '重启生效',
			'meta.reconnectTakesEffect' => '重新连接后生效',
			'meta.runtimeProfile' => '运行时配置',
			'meta.willCompleteAfterRebootInstall' => '请重启设备,以便完成系统扩展安装',
			'meta.willCompleteAfterRebootUninstall' => '请重启设备,以便完成系统扩展卸载',
			'meta.requestNeedsUserApproval' => '1. 请在[系统设置]-[隐私与安全性]里[允许] Clash Mi安装系统扩展\n2. :[系统设置]-[通用]-[登录项与扩展-网络扩展]启用[clashmiServiceSE]\n完成后重新连接',
			'meta.FullDiskAccessPermissionRequired' => '请在[系统设置]-[隐私与安全性]-[完全磁盘访问权限]里开启clashmiServiceSE权限后,重新连接',
			'meta.proxy' => '代理',
			'meta.theme' => '主题',
			'meta.tvMode' => 'TV模式',
			'meta.autoUpdate' => '自动更新',
			'meta.updateChannel' => '自动更新通道',
			'meta.onlineCustomerService' => '在线客服',
			'meta.subscriptionChannel' => '订阅频道',
			'meta.hasNewVersion' => ({required Object p}) => '更新版本 ${p}',
			'meta.autoDownloadPkg' => '自动下载更新包',
			'meta.devOptions' => '开发者选项',
			'meta.about' => '关于',
			'meta.name' => '名称',
			'meta.version' => '版本',
			'meta.notice' => '通知',
			'meta.sort' => '排序',
			'meta.recommended' => '推荐',
			'meta.innerError' => ({required Object p}) => '内部错误:${p}',
			'meta.share' => '分享',
			'meta.importFromClipboard' => '从剪贴板导入',
			'meta.exportToClipboard' => '导出到剪贴板',
			'meta.server' => '服务器',
			'meta.port' => '端口',
			'meta.donate' => '捐助',
			'meta.setting' => '设置',
			'meta.settingCore' => '核心设置',
			'meta.settingApp' => '应用设置',
			'meta.coreOverwrite' => '核心覆写',
			'meta.iCloud' => 'iCloud',
			'meta.webdav' => 'Webdav',
			'meta.lanSync' => '局域网同步',
			'meta.lanSyncNotQuitTips' => '同步完成前请勿退出此界面',
			'meta.deviceNoSpace' => '磁盘空间不足',
			'meta.hideSystemApp' => '隐藏系统应用',
			'meta.hideAppIcon' => '隐藏应用图标',
			'meta.openDir' => '打开文件目录',
			'meta.type' => '类型',
			'meta.fileChoose' => '选择文件',
			'meta.filePathCannotEmpty' => '文件路径不能为空',
			'meta.fileNotExist' => ({required Object p}) => '文件不存在:${p}',
			'meta.fileTypeInvalid' => ({required Object p}) => '无效的文件类型:${p}',
			'meta.uwpExemption' => 'UWP网络隔离豁免',
			'meta.getProfile' => '获取配置',
			'meta.buyProfile' => '购买配置',
			'meta.addProfile' => '添加配置',
			'meta.myProfiles' => '我的配置',
			'meta.profileEdit' => '编辑配置',
			'meta.profileNeedActive' => '请先将本配置设置为当前配置,并开启连接/重新连接',
			'meta.profileDownloadBackupChannel' => '启用备用下载通道',
			'meta.profileDownloadBackupChannelTips' => 'Clash Mi提供的代理下载通道(不存储任何信息)',
			'meta.profileEditReloadAfterProfileUpdate' => '配置更新后重新加载',
			'meta.profileRulesAppendApplePush' => '附加 Apple 推送通知规则',
			'meta.profileRulesAppendProxyTips' => '规则将自动设置为原始配置里[proxy-groups]中的第一个类型为[url-test]或[select]的代理',
			'meta.profileImport' => '导入配置文件',
			'meta.profileAddUrlOrContent' => '添加配置链接',
			'meta.profileUrlOrContent' => 'Clash配置链接',
			'meta.profileUrlOrContentHit' => 'Clash配置链接[必填]',
			'meta.profileUrlOrContentCannotEmpty' => '配置链接不能为空',
			'permission.camera' => '摄像头',
			'permission.screen' => '屏幕录制',
			'permission.appQuery' => '获取应用列表',
			'permission.request' => ({required Object p}) => '开启[${p}]权限',
			'permission.requestNeed' => ({required Object p}) => '请开启[${p}]权限',
			'tls.insecure' => '跳过证书验证',
			'tls.certificate' => '证书',
			'tls.privateKey' => '私钥',
			'tls.customTrustCert' => '自定义证书',
			'tun.stack' => '网络栈',
			'tun.inet4Address' => 'IPv4地址段',
			'tun.inet6Address' => 'IPv6地址段',
			'tun.dnsHijack' => 'DNS劫持',
			'tun.strictRoute' => '严格路由',
			'tun.tunDefaultRoute' => '默认路由',
			'tun.icmpForward' => 'ICMP 转发',
			'tun.allowBypass' => '允许应用绕过VPN',
			'tun.appendHttpProxy' => '附加HTTP代理到VPN',
			'tun.bypassHttpProxyDomain' => '允许绕过HTTP代理的域名',
			'dns.listen' => '监听地址',
			'dns.fakeIp' => 'fake-ip',
			'dns.fallback' => 'Fallback',
			'dns.preferH3' => 'DoH H3优先',
			'dns.useHosts' => '使用Hosts',
			'dns.useSystemHosts' => '使用系统Hosts',
			'dns.enhancedMode' => '增强模式',
			'dns.fakeIPFilterMode' => '${_root.dns.fakeIp} 过滤模式',
			'dns.fakeIPFilter' => '${_root.dns.fakeIp} 过滤',
			'dns.respectRules' => '遵守[rules]规则',
			'dns.nameServer' => '域名解析服务器',
			'dns.defaultNameServer' => '${_root.meta.byDefault} ${_root.dns.nameServer}',
			'dns.proxyNameServer' => '${_root.meta.proxy} ${_root.dns.nameServer}',
			'dns.directNameServer' => '${_root.meta.direct} ${_root.dns.nameServer}',
			'dns.fallbackNameServer' => '${_root.dns.fallback} ${_root.dns.nameServer}',
			'dns.fallbackGeoIp' => '${_root.dns.fallback} GeoIp',
			'dns.fallbackGeoIpCode' => '${_root.dns.fallback} GeoIp 代码',
			'sniffer.overrideDest' => '覆盖',
			'profilePatchMode.currentSelected' => '当前选择',
			'profilePatchMode.overwrite' => '内置-覆写',
			'profilePatchMode.noOverwrite' => '内置-不覆写',
			'protocolSniff' => '协议探测',
			'protocolSniffOverrideDestination' => '探测的域名覆盖连接目标地址',
			'edgeRuntimeNotInstalled' => '当前设备尚未安装Edge WebView2运行时,无法展示页面,请下载安装Edge WebView2运行时(x64)后,重启App再试',
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
