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
class TranslationsJa with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsJa({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ja,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ja>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsJa _root = this; // ignore: unused_field

	@override 
	TranslationsJa $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsJa(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$BackupAndSyncWebdavScreen$ja BackupAndSyncWebdavScreen = _Translations$BackupAndSyncWebdavScreen$ja._(_root);
	@override late final _Translations$LaunchFailedScreen$ja LaunchFailedScreen = _Translations$LaunchFailedScreen$ja._(_root);
	@override late final _Translations$PerAppAndroidScreen$ja PerAppAndroidScreen = _Translations$PerAppAndroidScreen$ja._(_root);
	@override late final _Translations$UserAgreementScreen$ja UserAgreementScreen = _Translations$UserAgreementScreen$ja._(_root);
	@override late final _Translations$NetCheckScreen$ja NetCheckScreen = _Translations$NetCheckScreen$ja._(_root);
	@override late final _Translations$VersionUpdateScreen$ja VersionUpdateScreen = _Translations$VersionUpdateScreen$ja._(_root);
	@override late final _Translations$loginScreen$ja loginScreen = _Translations$loginScreen$ja._(_root);
	@override late final _Translations$main$ja main = _Translations$main$ja._(_root);
	@override late final _Translations$meta$ja meta = _Translations$meta$ja._(_root);
	@override late final _Translations$permission$ja permission = _Translations$permission$ja._(_root);
	@override late final _Translations$tls$ja tls = _Translations$tls$ja._(_root);
	@override late final _Translations$tun$ja tun = _Translations$tun$ja._(_root);
	@override late final _Translations$dns$ja dns = _Translations$dns$ja._(_root);
	@override late final _Translations$sniffer$ja sniffer = _Translations$sniffer$ja._(_root);
	@override late final _Translations$profilePatchMode$ja profilePatchMode = _Translations$profilePatchMode$ja._(_root);
	@override String get protocolSniff => 'プロトコル検知';
	@override String get protocolSniffOverrideDestination => '検知されたドメイン名で接続先アドレスを上書きする';
	@override String get edgeRuntimeNotInstalled => '現在のデバイスには Edge WebView2 ランタイムがインストールされていないため、ページを表示できません。Edge WebView2 ランタイム (x64) をダウンロードしてインストールし、アプリを再起動してからもう一度お試しください。';
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
class _Translations$BackupAndSyncWebdavScreen$ja implements Translations$BackupAndSyncWebdavScreen$en {
	_Translations$BackupAndSyncWebdavScreen$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get webdavServerUrl => 'サーバーURL';
	@override String get webdavRequired => '空にすることはできません';
	@override String get webdavLoginFailed => 'ログインに失敗しました:';
	@override String get webdavListFailed => 'ファイルリストの取得に失敗しました:';
}

// Path: LaunchFailedScreen
class _Translations$LaunchFailedScreen$ja implements Translations$LaunchFailedScreen$en {
	_Translations$LaunchFailedScreen$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get invalidProcess => 'アプリの起動に失敗しました [無効なプロセス名]。アプリを別のディレクトリに再インストールしてください';
	@override String get invalidProfile => 'アプリの起動に失敗しました [プロファイルへのアクセスに失敗]。アプリを再インストールしてください';
	@override String get invalidVersion => 'アプリの起動に失敗しました [無効なバージョン]。アプリを再インストールしてください';
	@override String get systemVersionLow => 'アプリの起動に失敗しました [システムバージョンが低すぎます]';
	@override String get invalidInstallPath => 'インストールパスが無効です。有効なパスに再インストールしてください';
}

// Path: PerAppAndroidScreen
class _Translations$PerAppAndroidScreen$ja implements Translations$PerAppAndroidScreen$en {
	_Translations$PerAppAndroidScreen$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get title => 'アプリごとのプロキシ';
	@override String get whiteListMode => 'ホワイトリストモード';
	@override String get whiteListModeTip => '有効な場合：チェックされたアプリのみがプロキシされます。無効な場合：チェックされていないアプリのみがプロキシされます';
}

// Path: UserAgreementScreen
class _Translations$UserAgreementScreen$ja implements Translations$UserAgreementScreen$en {
	_Translations$UserAgreementScreen$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get privacyFirst => 'プライバシーを第一に';
	@override String get agreeAndContinue => '同意して続行';
}

// Path: NetCheckScreen
class _Translations$NetCheckScreen$ja implements Translations$NetCheckScreen$en {
	_Translations$NetCheckScreen$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get enterDomain => 'ドメイン名を入力してください';
	@override String get checking => '確認中...';
	@override String aQueryFailed({required Object p}) => 'Aレコード照会失敗: ${p}';
	@override String aaaaQueryFailed({required Object p}) => 'AAAAレコード照会失敗: ${p}';
	@override String get success => '成功';
	@override String get failed => '失敗';
	@override String get suspectedPollution => 'DNS汚染の疑い';
	@override String get domainLabel => 'ドメイン';
	@override String get checkButton => '診断';
	@override String get dnsSection => '1. DNS照会';
	@override String get directHttpSection => '2. HTTP (TUN経由、先にTUNを有効にしてください)';
	@override String proxyHttpSection({required Object p}) => '3. HTTP (プロキシ経由、ポート: ${p})';
	@override String get tunNotEnabled => 'TUN が有効になっていません';
	@override String get routeTableSection => '4. ルートテーブル';
}

// Path: VersionUpdateScreen
class _Translations$VersionUpdateScreen$ja implements Translations$VersionUpdateScreen$en {
	_Translations$VersionUpdateScreen$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String versionReady({required Object p}) => '新しいバージョン [${p}] の準備ができました';
	@override String get update => '再起動して更新';
	@override String get cancel => '今はしない';
}

// Path: loginScreen
class _Translations$loginScreen$ja implements Translations$loginScreen$en {
	_Translations$loginScreen$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get login => 'ログイン';
	@override String get register => 'アカウント登録';
	@override String get forgotPassword => 'パスワードを忘れた';
	@override String get provider => 'プロバイダー';
	@override String get providerName => '${_root.loginScreen.provider}コード/別名/URL';
	@override String get providerNameRequired => '${_root.loginScreen.provider}コード/別名/URLを入力してください';
	@override String get account => 'アカウント';
	@override String get accountRequired => 'アカウントを入力してください';
	@override String get email => 'メール';
	@override String get emailRequired => 'メールアドレスを入力してください';
	@override String get password => 'パスワード';
	@override String get passwordRequired => 'パスワードを入力してください';
	@override String get validEmailRequired => '有効なメールアドレスを入力してください';
	@override String passwordMinLength({required Object minLength}) => 'パスワード長は最低${minLength}文字以上である必要があります';
	@override String get unsupportedProvider => 'サポートされていない${_root.loginScreen.provider}';
	@override String get unsupportedProviderType => 'サポートされていない${_root.loginScreen.provider}タイプ';
	@override String get unActivedProvider => 'ログイン機能は有効化されていません';
	@override String providerLoginSupportRequired({required Object p}) => 'プロバイダーのコード/別名は${_root.loginScreen.provider}にお問い合わせください。\n${_root.loginScreen.provider}連携は次をご参照ください: ${p}';
	@override String get providerDisclaimer => '免責事項:${_root.loginScreen.provider}はサードパーティサービスであり、本アプリとは無関係です';
}

// Path: main
class _Translations$main$ja implements Translations$main$en {
	_Translations$main$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override late final _Translations$main$tray$ja tray = _Translations$main$tray$ja._(_root);
}

// Path: meta
class _Translations$meta$ja implements Translations$meta$en {
	_Translations$meta$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get enable => '有効';
	@override String get disable => '無効';
	@override String get open => '開く';
	@override String get close => '閉じる';
	@override String get quit => '終了';
	@override String get add => '追加';
	@override String get addSuccess => '正常に追加されました';
	@override String addFailed({required Object p}) => '追加に失敗しました: ${p}';
	@override String get remove => '削除';
	@override String get removeConfirm => '本当に削除しますか？';
	@override String get edit => '編集';
	@override String get view => '表示';
	@override String get remark => '備考';
	@override String get byDefault => 'デフォルト';
	@override String get editRemark => '備考を編集';
	@override String get more => '詳細';
	@override String get tips => '情報';
	@override String get selectAll => 'すべて選択';
	@override String get copy => 'コピー';
	@override String get paste => '貼り付け';
	@override String get cut => '切り取り';
	@override String get save => '保存';
	@override String get ok => 'OK';
	@override String get cancel => 'キャンセル';
	@override String get faq => 'よくある質問';
	@override String get doc => 'ドキュメント';
	@override String get htmlTools => 'HTMLツールセット';
	@override String get download => 'ダウンロード';
	@override String get loading => '読み込み中...';
	@override String get days => '日';
	@override String get hours => '時間';
	@override String get minutes => '分';
	@override String get seconds => '秒';
	@override String get milliseconds => 'ミリ秒';
	@override String get protocol => 'プロトコル';
	@override String get search => '検索';
	@override String get custom => 'カスタム';
	@override String get connect => '接続';
	@override String get disconnect => '切断';
	@override String get connected => '接続済み';
	@override String get disconnected => '切断済み';
	@override String get connecting => '接続中';
	@override String get connectTimeout => '接続タイムアウト';
	@override String get timeout => 'タイムアウト';
	@override String get timeoutDuration => 'タイムアウト時間';
	@override String get latency => '遅延';
	@override String get latencyTest => '遅延チェック';
	@override String get networkCheck => 'ネットワーク診断';
	@override String get language => '言語';
	@override String get next => '次へ';
	@override String get done => '完了';
	@override String get apply => '適用';
	@override String get refresh => '更新';
	@override String get retry => '再試行しますか？';
	@override String get update => '更新';
	@override String get updateInterval => '更新間隔';
	@override String updateFailed({required Object p}) => '更新に失敗しました: ${p}';
	@override String get updateInterval5mTips => '最小: 5分';
	@override String get updateIntervalPreferByProfile => 'プロバイダーの設定を優先';
	@override String get none => 'なし';
	@override String get reset => 'リセット';
	@override String get authentication => '認証';
	@override String get submit => '送信';
	@override String get user => 'ユーザー';
	@override String get account => 'アカウント';
	@override String get password => 'パスワード';
	@override String get decryptPassword => '複号化パスワード';
	@override String get required => '必須';
	@override String get go => '続行';
	@override String get sudoPassword => 'sudo パスワード (TUNモードで必要)';
	@override String get other => 'その他';
	@override String get dns => 'DNS';
	@override String get url => 'URL';
	@override String get urlInvalid => '無効なURL';
	@override String get urlCannotEmpty => 'リンクを空にすることはできません';
	@override String get urlTooLong => 'URLが長すぎます (>8182)';
	@override String get copyUrl => 'リンクをコピー';
	@override String get openUrl => 'リンクを開く';
	@override String get shareUrl => 'リンクを共有';
	@override String get coreSettingTips => '注意：設定を変更した後、有効にするには再接続する必要があります';
	@override String get overwrite => '上書き';
	@override String get overwriteCustom => 'カスタム上書き';
	@override String get overwriteAppend => '追加上書き';
	@override String get overwriteTips => 'オリジナルプロファイル <- カスタム上書き <- アプリ上書き';
	@override String get noOverwrite => '上書きしない';
	@override String get overwriteSettings => '上書き設定';
	@override String get diversionTemplates => '転送テンプレート';
	@override String get ruleProviders => 'ルールプロバイダー';
	@override String get ruleTemplates => 'ルールテンプレート';
	@override String get proxyGroupsTemplates => 'プロキシグループテンプレート';
	@override String get proxyGroups => 'プロキシグループ';
	@override String get proxyNodeList => 'プロキシノードリスト';
	@override String proxyNodeFailure({required Object p}) => '以下のプロキシノードは期限切れのため自動的に削除されました: ${p}';
	@override String get externalController => '外部コントローラー';
	@override String get secret => 'シークレット';
	@override String get tcpConcurrent => 'TCP並行ハンドシェイク';
	@override String get globalClientFingerprint => 'TLSグローバルフィンガープリント';
	@override String get allowLanAccess => 'LANデバイスアクセス';
	@override String get mixedPort => '混合プロキシポート';
	@override String get logLevel => 'ログレベル';
	@override String get findProcessMode => 'プロセスマッチングモード';
	@override String get tcpkeepAliveInterval => 'TCPキープアライブ間隔';
	@override String get delayTestUrl => '遅延テストURL';
	@override String get delayTestTimeout => '遅延テストタイムアウト(ms)';
	@override String get tun => 'TUN';
	@override String get ntp => 'NTP';
	@override String get tls => 'TLS';
	@override String get geo => 'GEO';
	@override String get geoDownloadByProxy => 'プロキシ経由でGeo RuleSetをダウンロード';
	@override String get geoRulesetTips => 'Geosite/Geoipは対応するRuleSetに変換されます';
	@override String get asnNotSupportInIosTips => 'iOSシステムのメモリ制限により、IP-ASNおよびSRC-IP-ASNルールはiOSでは無視されます。';
	@override String get sniffer => 'スニッファー';
	@override String get userAgent => 'UserAgent';
	@override String get launchAtStartup => 'スタートアップ時に起動';
	@override String get launchAtStartupRunAsAdmin => 'Clash Miを管理者として再起動してください';
	@override String get tunModeRunAsAdmin => 'TUNモードにはシステム管理者権限が必要です。アプリを管理者として再起動してください';
	@override String get portableMode => 'ポータブルモード';
	@override String get portableModeDisableTips => 'ポータブルモードを終了する必要がある場合は、[clashmi]を終了し、[clashmi.exe]と同じディレクトリにある[portable]フォルダを手動で削除してください';
	@override String get systemProxy => 'システムプロキシ';
	@override String get autoConnectAfterLaunch => '起動後に自動接続';
	@override String get autoConnectAtBoot => 'システム起動後に自動接続';
	@override String get autoConnectAtBootTips => 'システムのサポートが必要です。一部のシステムでは[自動起動]を有効にする必要がある場合があります。';
	@override String get hideAfterLaunch => '起動後にウィンドウを隠す';
	@override String get autoSetSystemProxy => '接続時にシステムプロキシを自動設定';
	@override String get bypassSystemProxy => 'システムプロキシをバイパスすることを許可するドメイン名';
	@override String get excludeFromRecent => '[最近のタスク]から隠す';
	@override String get wakeLock => 'スリープ防止';
	@override String get hideVpn => 'VPNアイコンを隠す';
	@override String get hideVpnTips => 'IPv6を有効にすると、この機能は失敗します';
	@override String get hideDockIcon => 'Dockアイコンを隠す';
	@override String get showTrayTraffic => 'トレイに通信量情報を表示';
	@override String get website => 'ウェブサイト';
	@override String get homePage => 'ホームページ';
	@override String get rule => 'ルール';
	@override String get global => 'グローバル';
	@override String get direct => '直通';
	@override String get block => 'ブロック';
	@override String get qrcode => 'QRコード';
	@override String get qrcodeTooLong => 'テキストが長すぎて表示できません';
	@override String get qrcodeShare => 'QRコードを共有';
	@override String get textToQrcode => 'テキストをQRコードに変換';
	@override String get qrcodeScan => 'QRコードをスキャン';
	@override String get qrcodeScanResult => 'スキャン結果';
	@override String get qrcodeScanFromImage => '画像からスキャン';
	@override String get qrcodeScanResultFailed => '画像の解析に失敗しました。スクリーンショットが有効なQRコードであることを確認してください';
	@override String get qrcodeScanResultEmpty => 'スキャン結果が空です';
	@override String get screenshot => 'スクリーンショット';
	@override String get backupAndSync => 'バックアップと同期';
	@override String get importSuccess => 'インポート成功';
	@override String get rewriteConfirm => 'このファイルは既存のローカル設定を上書きします。続行しますか？';
	@override String get importAndExport => 'インポートとエクスポート';
	@override String get import => 'インポート';
	@override String get importFromUrl => 'URLからインポート';
	@override String get export => 'エクスポート';
	@override String get send => '送信';
	@override String get receive => '受信';
	@override String get sendConfirm => '送信を確認しますか？';
	@override String get continueConnectConfirm => '接続を続行しますか？';
	@override String get termOfUse => '利用規約';
	@override String get privacyPolicy => 'プライバシーポリシー';
	@override String get log => 'ログ';
	@override String get coreLog => 'コアログ';
	@override String get core => 'コア';
	@override String get help => 'ヘルプ';
	@override String get tutorial => 'チュートリアル';
	@override String get board => 'ボード';
	@override String get boardOnline => 'オンラインボードを使用';
	@override String get boardOnlineUrl => 'オンラインボードURL';
	@override String get boardLocalPort => 'ローカルボードポート';
	@override String get alwayOnVPN => '常時接続';
	@override String get disableFontScaler => 'フォントスケーリングを無効にする（再起動後に有効）';
	@override String get autoOrientation => '画面に合わせて回転';
	@override String get restartTakesEffect => '再起動後に有効';
	@override String get reconnectTakesEffect => '再接続後に有効';
	@override String get runtimeProfile => '実行時プロファイル';
	@override String get willCompleteAfterRebootInstall => 'システム拡張機能のインストールを完了するには、デバイスを再起動してください';
	@override String get willCompleteAfterRebootUninstall => 'システム拡張機能のアンインストールを完了するには、デバイスを再起動してください';
	@override String get requestNeedsUserApproval => '1. [システム設定]-[プライバシーとセキュリティ]でClash Miによるシステム拡張機能のインストールを[許可]してください\n2. [システム設定]-[一般]-[ログイン項目と拡張機能]-[ネットワーク拡張機能]で[clashmiServiceSE]を有効にしてください\n完了後に再接続してください';
	@override String get FullDiskAccessPermissionRequired => '[システム設定]-[プライバシーとセキュリティ]-[フルディスクアクセス]でclashmiServiceSEの権限を有効にし、再接続してください。';
	@override String get proxy => 'プロキシ';
	@override String get theme => 'テーマ';
	@override String get tvMode => 'TVモード';
	@override String get autoUpdate => '自動更新';
	@override String get updateChannel => '自動更新チャンネル';
	@override String get onlineCustomerService => 'オンラインカスタマーサポート';
	@override String get subscriptionChannel => '購読チャンネル';
	@override String hasNewVersion({required Object p}) => 'バージョン ${p} に更新';
	@override String get autoDownloadPkg => '更新パッケージを自動ダウンロード';
	@override String get devOptions => '開発者オプション';
	@override String get about => 'このアプリについて';
	@override String get name => '名前';
	@override String get version => 'バージョン';
	@override String get notice => 'お知らせ';
	@override String get sort => '並べ替え';
	@override String get recommended => 'おすすめ';
	@override String innerError({required Object p}) => '内部エラー: ${p}';
	@override String get share => '共有';
	@override String get importFromClipboard => 'クリップボードからインポート';
	@override String get exportToClipboard => 'クリップボードにエクスポート';
	@override String get server => 'サーバー';
	@override String get port => 'ポート';
	@override String get donate => '寄付';
	@override String get setting => '設定';
	@override String get settingCore => 'コア設定';
	@override String get settingApp => 'アプリ設定';
	@override String get coreOverwrite => 'コア上書き';
	@override String get iCloud => 'iCloud';
	@override String get webdav => 'Webdav';
	@override String get lanSync => 'LAN同期';
	@override String get lanSyncNotQuitTips => '同期が完了するまでこのインターフェースを終了しないでください';
	@override String get deviceNoSpace => 'ディスク容量不足';
	@override String get hideSystemApp => 'システムアプリを隠す';
	@override String get hideAppIcon => 'アプリアイコンを隠す';
	@override String get openDir => 'ファイルディレクトリを開く';
	@override String get type => 'タイプ';
	@override String get fileChoose => 'ファイルを選択';
	@override String get filePathCannotEmpty => 'ファイルパスを空にすることはできません';
	@override String fileNotExist({required Object p}) => 'ファイルが存在しません: ${p}';
	@override String fileTypeInvalid({required Object p}) => '無効なファイルタイプ: ${p}';
	@override String get uwpExemption => 'UWPネットワーク分離免除';
	@override String get getProfile => 'プロファイルを取得';
	@override String get buyProfile => 'プロファイルを購入';
	@override String get addProfile => 'プロファイルを追加';
	@override String get myProfiles => 'マイプロファイル';
	@override String get profileEdit => 'プロファイルを編集';
	@override String get profileNeedActive => '先にこのプロファイルを現在のプロファイルに設定し、接続/再接続してください';
	@override String get profileDownloadBackupChannel => 'バックアップダウンロードチャネルを有効化';
	@override String get profileDownloadBackupChannelTips => 'Clash Mi が提供するプロキシダウンロードチャネル（情報は一切保存されません）';
	@override String get profileEditReloadAfterProfileUpdate => 'プロファイル更新後にリロード';
	@override String get profileRulesAppendApplePush => 'Appleプッシュ通知ルールを追加';
	@override String get profileRulesAppendProxyTips => 'ルールは元の設定の [proxy-groups] 内で、タイプが [url-test] または [select] の最初のプロキシに自動設定されます';
	@override String get profileImport => 'プロファイルファイルをインポート';
	@override String get profileAddUrlOrContent => 'プロファイルリンクを追加';
	@override String get profileUrlOrContent => 'Clash設定リンク';
	@override String get profileUrlOrContentHit => 'Clash設定リンク [必須]';
	@override String get profileUrlOrContentCannotEmpty => 'プロファイルリンクを空にすることはできません';
}

// Path: permission
class _Translations$permission$ja implements Translations$permission$en {
	_Translations$permission$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get camera => 'カメラ';
	@override String get screen => '画面録画';
	@override String get appQuery => 'アプリケーションリストを取得';
	@override String request({required Object p}) => '[${p}] 権限をオンにする';
	@override String requestNeed({required Object p}) => '[${p}] 権限をオンにしてください';
}

// Path: tls
class _Translations$tls$ja implements Translations$tls$en {
	_Translations$tls$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get insecure => '証明書の検証をスキップ';
	@override String get certificate => '証明書';
	@override String get privateKey => '秘密鍵';
	@override String get customTrustCert => 'カスタム証明書';
}

// Path: tun
class _Translations$tun$ja implements Translations$tun$en {
	_Translations$tun$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get stack => 'ネットワークスタック';
	@override String get inet4Address => 'IPv4アドレス範囲';
	@override String get inet6Address => 'IPv6アドレス範囲';
	@override String get dnsHijack => 'DNSハイジャック';
	@override String get strictRoute => '厳格なルート';
	@override String get tunDefaultRoute => 'デフォルトルート';
	@override String get icmpForward => 'ICMP転送';
	@override String get allowBypass => 'アプリがVPNをバイパスすることを許可する';
	@override String get appendHttpProxy => 'VPNにHTTPプロキシを追加する';
	@override String get bypassHttpProxyDomain => 'HTTPプロキシをバイパスすることを許可するドメイン';
}

// Path: dns
class _Translations$dns$ja implements Translations$dns$en {
	_Translations$dns$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get listen => 'リスニングアドレス';
	@override String get fakeIp => 'fake-ip';
	@override String get fallback => 'フォールバック';
	@override String get preferH3 => 'DoH H3を優先';
	@override String get useHosts => 'Hostsを使用';
	@override String get useSystemHosts => 'システムHostsを使用';
	@override String get enhancedMode => '拡張モード';
	@override String get fakeIPFilterMode => '${_root.dns.fakeIp} フィルターモード';
	@override String get fakeIPFilter => '${_root.dns.fakeIp} フィルター';
	@override String get respectRules => 'ルールを尊重する';
	@override String get nameServer => 'ネームサーバー';
	@override String get defaultNameServer => '${_root.meta.byDefault} ${_root.dns.nameServer}';
	@override String get proxyNameServer => '${_root.meta.proxy} ${_root.dns.nameServer}';
	@override String get directNameServer => '${_root.meta.direct} ${_root.dns.nameServer}';
	@override String get fallbackNameServer => '${_root.dns.fallback} ${_root.dns.nameServer}';
	@override String get fallbackGeoIp => '${_root.dns.fallback} GeoIp';
	@override String get fallbackGeoIpCode => '${_root.dns.fallback} GeoIpCode';
}

// Path: sniffer
class _Translations$sniffer$ja implements Translations$sniffer$en {
	_Translations$sniffer$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get overrideDest => '上書き';
}

// Path: profilePatchMode
class _Translations$profilePatchMode$ja implements Translations$profilePatchMode$en {
	_Translations$profilePatchMode$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get currentSelected => '現在選択中';
	@override String get overwrite => '内蔵 - 上書き';
	@override String get noOverwrite => '内蔵 - 上書きなし';
}

// Path: main.tray
class _Translations$main$tray$ja implements Translations$main$tray$en {
	_Translations$main$tray$ja._(this._root);

	final TranslationsJa _root; // ignore: unused_field

	// Translations
	@override String get menuOpen => '開く';
	@override String get menuExit => '終了';
}

/// The flat map containing all translations for locale <ja>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsJa {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'BackupAndSyncWebdavScreen.webdavServerUrl' => 'サーバーURL',
			'BackupAndSyncWebdavScreen.webdavRequired' => '空にすることはできません',
			'BackupAndSyncWebdavScreen.webdavLoginFailed' => 'ログインに失敗しました:',
			'BackupAndSyncWebdavScreen.webdavListFailed' => 'ファイルリストの取得に失敗しました:',
			'LaunchFailedScreen.invalidProcess' => 'アプリの起動に失敗しました [無効なプロセス名]。アプリを別のディレクトリに再インストールしてください',
			'LaunchFailedScreen.invalidProfile' => 'アプリの起動に失敗しました [プロファイルへのアクセスに失敗]。アプリを再インストールしてください',
			'LaunchFailedScreen.invalidVersion' => 'アプリの起動に失敗しました [無効なバージョン]。アプリを再インストールしてください',
			'LaunchFailedScreen.systemVersionLow' => 'アプリの起動に失敗しました [システムバージョンが低すぎます]',
			'LaunchFailedScreen.invalidInstallPath' => 'インストールパスが無効です。有効なパスに再インストールしてください',
			'PerAppAndroidScreen.title' => 'アプリごとのプロキシ',
			'PerAppAndroidScreen.whiteListMode' => 'ホワイトリストモード',
			'PerAppAndroidScreen.whiteListModeTip' => '有効な場合：チェックされたアプリのみがプロキシされます。無効な場合：チェックされていないアプリのみがプロキシされます',
			'UserAgreementScreen.privacyFirst' => 'プライバシーを第一に',
			'UserAgreementScreen.agreeAndContinue' => '同意して続行',
			'NetCheckScreen.enterDomain' => 'ドメイン名を入力してください',
			'NetCheckScreen.checking' => '確認中...',
			'NetCheckScreen.aQueryFailed' => ({required Object p}) => 'Aレコード照会失敗: ${p}',
			'NetCheckScreen.aaaaQueryFailed' => ({required Object p}) => 'AAAAレコード照会失敗: ${p}',
			'NetCheckScreen.success' => '成功',
			'NetCheckScreen.failed' => '失敗',
			'NetCheckScreen.suspectedPollution' => 'DNS汚染の疑い',
			'NetCheckScreen.domainLabel' => 'ドメイン',
			'NetCheckScreen.checkButton' => '診断',
			'NetCheckScreen.dnsSection' => '1. DNS照会',
			'NetCheckScreen.directHttpSection' => '2. HTTP (TUN経由、先にTUNを有効にしてください)',
			'NetCheckScreen.proxyHttpSection' => ({required Object p}) => '3. HTTP (プロキシ経由、ポート: ${p})',
			'NetCheckScreen.tunNotEnabled' => 'TUN が有効になっていません',
			'NetCheckScreen.routeTableSection' => '4. ルートテーブル',
			'VersionUpdateScreen.versionReady' => ({required Object p}) => '新しいバージョン [${p}] の準備ができました',
			'VersionUpdateScreen.update' => '再起動して更新',
			'VersionUpdateScreen.cancel' => '今はしない',
			'loginScreen.login' => 'ログイン',
			'loginScreen.register' => 'アカウント登録',
			'loginScreen.forgotPassword' => 'パスワードを忘れた',
			'loginScreen.provider' => 'プロバイダー',
			'loginScreen.providerName' => '${_root.loginScreen.provider}コード/別名/URL',
			'loginScreen.providerNameRequired' => '${_root.loginScreen.provider}コード/別名/URLを入力してください',
			'loginScreen.account' => 'アカウント',
			'loginScreen.accountRequired' => 'アカウントを入力してください',
			'loginScreen.email' => 'メール',
			'loginScreen.emailRequired' => 'メールアドレスを入力してください',
			'loginScreen.password' => 'パスワード',
			'loginScreen.passwordRequired' => 'パスワードを入力してください',
			'loginScreen.validEmailRequired' => '有効なメールアドレスを入力してください',
			'loginScreen.passwordMinLength' => ({required Object minLength}) => 'パスワード長は最低${minLength}文字以上である必要があります',
			'loginScreen.unsupportedProvider' => 'サポートされていない${_root.loginScreen.provider}',
			'loginScreen.unsupportedProviderType' => 'サポートされていない${_root.loginScreen.provider}タイプ',
			'loginScreen.unActivedProvider' => 'ログイン機能は有効化されていません',
			'loginScreen.providerLoginSupportRequired' => ({required Object p}) => 'プロバイダーのコード/別名は${_root.loginScreen.provider}にお問い合わせください。\n${_root.loginScreen.provider}連携は次をご参照ください: ${p}',
			'loginScreen.providerDisclaimer' => '免責事項:${_root.loginScreen.provider}はサードパーティサービスであり、本アプリとは無関係です',
			'main.tray.menuOpen' => '開く',
			'main.tray.menuExit' => '終了',
			'meta.enable' => '有効',
			'meta.disable' => '無効',
			'meta.open' => '開く',
			'meta.close' => '閉じる',
			'meta.quit' => '終了',
			'meta.add' => '追加',
			'meta.addSuccess' => '正常に追加されました',
			'meta.addFailed' => ({required Object p}) => '追加に失敗しました: ${p}',
			'meta.remove' => '削除',
			'meta.removeConfirm' => '本当に削除しますか？',
			'meta.edit' => '編集',
			'meta.view' => '表示',
			'meta.remark' => '備考',
			'meta.byDefault' => 'デフォルト',
			'meta.editRemark' => '備考を編集',
			'meta.more' => '詳細',
			'meta.tips' => '情報',
			'meta.selectAll' => 'すべて選択',
			'meta.copy' => 'コピー',
			'meta.paste' => '貼り付け',
			'meta.cut' => '切り取り',
			'meta.save' => '保存',
			'meta.ok' => 'OK',
			'meta.cancel' => 'キャンセル',
			'meta.faq' => 'よくある質問',
			'meta.doc' => 'ドキュメント',
			'meta.htmlTools' => 'HTMLツールセット',
			'meta.download' => 'ダウンロード',
			'meta.loading' => '読み込み中...',
			'meta.days' => '日',
			'meta.hours' => '時間',
			'meta.minutes' => '分',
			'meta.seconds' => '秒',
			'meta.milliseconds' => 'ミリ秒',
			'meta.protocol' => 'プロトコル',
			'meta.search' => '検索',
			'meta.custom' => 'カスタム',
			'meta.connect' => '接続',
			'meta.disconnect' => '切断',
			'meta.connected' => '接続済み',
			'meta.disconnected' => '切断済み',
			'meta.connecting' => '接続中',
			'meta.connectTimeout' => '接続タイムアウト',
			'meta.timeout' => 'タイムアウト',
			'meta.timeoutDuration' => 'タイムアウト時間',
			'meta.latency' => '遅延',
			'meta.latencyTest' => '遅延チェック',
			'meta.networkCheck' => 'ネットワーク診断',
			'meta.language' => '言語',
			'meta.next' => '次へ',
			'meta.done' => '完了',
			'meta.apply' => '適用',
			'meta.refresh' => '更新',
			'meta.retry' => '再試行しますか？',
			'meta.update' => '更新',
			'meta.updateInterval' => '更新間隔',
			'meta.updateFailed' => ({required Object p}) => '更新に失敗しました: ${p}',
			'meta.updateInterval5mTips' => '最小: 5分',
			'meta.updateIntervalPreferByProfile' => 'プロバイダーの設定を優先',
			'meta.none' => 'なし',
			'meta.reset' => 'リセット',
			'meta.authentication' => '認証',
			'meta.submit' => '送信',
			'meta.user' => 'ユーザー',
			'meta.account' => 'アカウント',
			'meta.password' => 'パスワード',
			'meta.decryptPassword' => '複号化パスワード',
			'meta.required' => '必須',
			'meta.go' => '続行',
			'meta.sudoPassword' => 'sudo パスワード (TUNモードで必要)',
			'meta.other' => 'その他',
			'meta.dns' => 'DNS',
			'meta.url' => 'URL',
			'meta.urlInvalid' => '無効なURL',
			'meta.urlCannotEmpty' => 'リンクを空にすることはできません',
			'meta.urlTooLong' => 'URLが長すぎます (>8182)',
			'meta.copyUrl' => 'リンクをコピー',
			'meta.openUrl' => 'リンクを開く',
			'meta.shareUrl' => 'リンクを共有',
			'meta.coreSettingTips' => '注意：設定を変更した後、有効にするには再接続する必要があります',
			'meta.overwrite' => '上書き',
			'meta.overwriteCustom' => 'カスタム上書き',
			'meta.overwriteAppend' => '追加上書き',
			'meta.overwriteTips' => 'オリジナルプロファイル <- カスタム上書き <- アプリ上書き',
			'meta.noOverwrite' => '上書きしない',
			'meta.overwriteSettings' => '上書き設定',
			'meta.diversionTemplates' => '転送テンプレート',
			'meta.ruleProviders' => 'ルールプロバイダー',
			'meta.ruleTemplates' => 'ルールテンプレート',
			'meta.proxyGroupsTemplates' => 'プロキシグループテンプレート',
			'meta.proxyGroups' => 'プロキシグループ',
			'meta.proxyNodeList' => 'プロキシノードリスト',
			'meta.proxyNodeFailure' => ({required Object p}) => '以下のプロキシノードは期限切れのため自動的に削除されました: ${p}',
			'meta.externalController' => '外部コントローラー',
			'meta.secret' => 'シークレット',
			'meta.tcpConcurrent' => 'TCP並行ハンドシェイク',
			'meta.globalClientFingerprint' => 'TLSグローバルフィンガープリント',
			'meta.allowLanAccess' => 'LANデバイスアクセス',
			'meta.mixedPort' => '混合プロキシポート',
			'meta.logLevel' => 'ログレベル',
			'meta.findProcessMode' => 'プロセスマッチングモード',
			'meta.tcpkeepAliveInterval' => 'TCPキープアライブ間隔',
			'meta.delayTestUrl' => '遅延テストURL',
			'meta.delayTestTimeout' => '遅延テストタイムアウト(ms)',
			'meta.tun' => 'TUN',
			'meta.ntp' => 'NTP',
			'meta.tls' => 'TLS',
			'meta.geo' => 'GEO',
			'meta.geoDownloadByProxy' => 'プロキシ経由でGeo RuleSetをダウンロード',
			'meta.geoRulesetTips' => 'Geosite/Geoipは対応するRuleSetに変換されます',
			'meta.asnNotSupportInIosTips' => 'iOSシステムのメモリ制限により、IP-ASNおよびSRC-IP-ASNルールはiOSでは無視されます。',
			'meta.sniffer' => 'スニッファー',
			'meta.userAgent' => 'UserAgent',
			'meta.launchAtStartup' => 'スタートアップ時に起動',
			'meta.launchAtStartupRunAsAdmin' => 'Clash Miを管理者として再起動してください',
			'meta.tunModeRunAsAdmin' => 'TUNモードにはシステム管理者権限が必要です。アプリを管理者として再起動してください',
			'meta.portableMode' => 'ポータブルモード',
			'meta.portableModeDisableTips' => 'ポータブルモードを終了する必要がある場合は、[clashmi]を終了し、[clashmi.exe]と同じディレクトリにある[portable]フォルダを手動で削除してください',
			'meta.systemProxy' => 'システムプロキシ',
			'meta.autoConnectAfterLaunch' => '起動後に自動接続',
			'meta.autoConnectAtBoot' => 'システム起動後に自動接続',
			'meta.autoConnectAtBootTips' => 'システムのサポートが必要です。一部のシステムでは[自動起動]を有効にする必要がある場合があります。',
			'meta.hideAfterLaunch' => '起動後にウィンドウを隠す',
			'meta.autoSetSystemProxy' => '接続時にシステムプロキシを自動設定',
			'meta.bypassSystemProxy' => 'システムプロキシをバイパスすることを許可するドメイン名',
			'meta.excludeFromRecent' => '[最近のタスク]から隠す',
			'meta.wakeLock' => 'スリープ防止',
			'meta.hideVpn' => 'VPNアイコンを隠す',
			'meta.hideVpnTips' => 'IPv6を有効にすると、この機能は失敗します',
			'meta.hideDockIcon' => 'Dockアイコンを隠す',
			'meta.showTrayTraffic' => 'トレイに通信量情報を表示',
			'meta.website' => 'ウェブサイト',
			'meta.homePage' => 'ホームページ',
			'meta.rule' => 'ルール',
			'meta.global' => 'グローバル',
			'meta.direct' => '直通',
			'meta.block' => 'ブロック',
			'meta.qrcode' => 'QRコード',
			'meta.qrcodeTooLong' => 'テキストが長すぎて表示できません',
			'meta.qrcodeShare' => 'QRコードを共有',
			'meta.textToQrcode' => 'テキストをQRコードに変換',
			'meta.qrcodeScan' => 'QRコードをスキャン',
			'meta.qrcodeScanResult' => 'スキャン結果',
			'meta.qrcodeScanFromImage' => '画像からスキャン',
			'meta.qrcodeScanResultFailed' => '画像の解析に失敗しました。スクリーンショットが有効なQRコードであることを確認してください',
			'meta.qrcodeScanResultEmpty' => 'スキャン結果が空です',
			'meta.screenshot' => 'スクリーンショット',
			'meta.backupAndSync' => 'バックアップと同期',
			'meta.importSuccess' => 'インポート成功',
			'meta.rewriteConfirm' => 'このファイルは既存のローカル設定を上書きします。続行しますか？',
			'meta.importAndExport' => 'インポートとエクスポート',
			'meta.import' => 'インポート',
			'meta.importFromUrl' => 'URLからインポート',
			'meta.export' => 'エクスポート',
			'meta.send' => '送信',
			'meta.receive' => '受信',
			'meta.sendConfirm' => '送信を確認しますか？',
			'meta.continueConnectConfirm' => '接続を続行しますか？',
			'meta.termOfUse' => '利用規約',
			'meta.privacyPolicy' => 'プライバシーポリシー',
			'meta.log' => 'ログ',
			'meta.coreLog' => 'コアログ',
			'meta.core' => 'コア',
			'meta.help' => 'ヘルプ',
			'meta.tutorial' => 'チュートリアル',
			'meta.board' => 'ボード',
			'meta.boardOnline' => 'オンラインボードを使用',
			'meta.boardOnlineUrl' => 'オンラインボードURL',
			'meta.boardLocalPort' => 'ローカルボードポート',
			'meta.alwayOnVPN' => '常時接続',
			'meta.disableFontScaler' => 'フォントスケーリングを無効にする（再起動後に有効）',
			'meta.autoOrientation' => '画面に合わせて回転',
			'meta.restartTakesEffect' => '再起動後に有効',
			'meta.reconnectTakesEffect' => '再接続後に有効',
			'meta.runtimeProfile' => '実行時プロファイル',
			'meta.willCompleteAfterRebootInstall' => 'システム拡張機能のインストールを完了するには、デバイスを再起動してください',
			'meta.willCompleteAfterRebootUninstall' => 'システム拡張機能のアンインストールを完了するには、デバイスを再起動してください',
			'meta.requestNeedsUserApproval' => '1. [システム設定]-[プライバシーとセキュリティ]でClash Miによるシステム拡張機能のインストールを[許可]してください\n2. [システム設定]-[一般]-[ログイン項目と拡張機能]-[ネットワーク拡張機能]で[clashmiServiceSE]を有効にしてください\n完了後に再接続してください',
			'meta.FullDiskAccessPermissionRequired' => '[システム設定]-[プライバシーとセキュリティ]-[フルディスクアクセス]でclashmiServiceSEの権限を有効にし、再接続してください。',
			'meta.proxy' => 'プロキシ',
			'meta.theme' => 'テーマ',
			'meta.tvMode' => 'TVモード',
			'meta.autoUpdate' => '自動更新',
			'meta.updateChannel' => '自動更新チャンネル',
			'meta.onlineCustomerService' => 'オンラインカスタマーサポート',
			'meta.subscriptionChannel' => '購読チャンネル',
			'meta.hasNewVersion' => ({required Object p}) => 'バージョン ${p} に更新',
			'meta.autoDownloadPkg' => '更新パッケージを自動ダウンロード',
			'meta.devOptions' => '開発者オプション',
			'meta.about' => 'このアプリについて',
			'meta.name' => '名前',
			'meta.version' => 'バージョン',
			'meta.notice' => 'お知らせ',
			'meta.sort' => '並べ替え',
			'meta.recommended' => 'おすすめ',
			'meta.innerError' => ({required Object p}) => '内部エラー: ${p}',
			'meta.share' => '共有',
			'meta.importFromClipboard' => 'クリップボードからインポート',
			'meta.exportToClipboard' => 'クリップボードにエクスポート',
			'meta.server' => 'サーバー',
			'meta.port' => 'ポート',
			'meta.donate' => '寄付',
			'meta.setting' => '設定',
			'meta.settingCore' => 'コア設定',
			'meta.settingApp' => 'アプリ設定',
			'meta.coreOverwrite' => 'コア上書き',
			'meta.iCloud' => 'iCloud',
			'meta.webdav' => 'Webdav',
			'meta.lanSync' => 'LAN同期',
			'meta.lanSyncNotQuitTips' => '同期が完了するまでこのインターフェースを終了しないでください',
			'meta.deviceNoSpace' => 'ディスク容量不足',
			'meta.hideSystemApp' => 'システムアプリを隠す',
			'meta.hideAppIcon' => 'アプリアイコンを隠す',
			'meta.openDir' => 'ファイルディレクトリを開く',
			'meta.type' => 'タイプ',
			'meta.fileChoose' => 'ファイルを選択',
			'meta.filePathCannotEmpty' => 'ファイルパスを空にすることはできません',
			'meta.fileNotExist' => ({required Object p}) => 'ファイルが存在しません: ${p}',
			'meta.fileTypeInvalid' => ({required Object p}) => '無効なファイルタイプ: ${p}',
			'meta.uwpExemption' => 'UWPネットワーク分離免除',
			'meta.getProfile' => 'プロファイルを取得',
			'meta.buyProfile' => 'プロファイルを購入',
			'meta.addProfile' => 'プロファイルを追加',
			'meta.myProfiles' => 'マイプロファイル',
			'meta.profileEdit' => 'プロファイルを編集',
			'meta.profileNeedActive' => '先にこのプロファイルを現在のプロファイルに設定し、接続/再接続してください',
			'meta.profileDownloadBackupChannel' => 'バックアップダウンロードチャネルを有効化',
			'meta.profileDownloadBackupChannelTips' => 'Clash Mi が提供するプロキシダウンロードチャネル（情報は一切保存されません）',
			'meta.profileEditReloadAfterProfileUpdate' => 'プロファイル更新後にリロード',
			'meta.profileRulesAppendApplePush' => 'Appleプッシュ通知ルールを追加',
			'meta.profileRulesAppendProxyTips' => 'ルールは元の設定の [proxy-groups] 内で、タイプが [url-test] または [select] の最初のプロキシに自動設定されます',
			'meta.profileImport' => 'プロファイルファイルをインポート',
			'meta.profileAddUrlOrContent' => 'プロファイルリンクを追加',
			'meta.profileUrlOrContent' => 'Clash設定リンク',
			'meta.profileUrlOrContentHit' => 'Clash設定リンク [必須]',
			'meta.profileUrlOrContentCannotEmpty' => 'プロファイルリンクを空にすることはできません',
			'permission.camera' => 'カメラ',
			'permission.screen' => '画面録画',
			'permission.appQuery' => 'アプリケーションリストを取得',
			'permission.request' => ({required Object p}) => '[${p}] 権限をオンにする',
			'permission.requestNeed' => ({required Object p}) => '[${p}] 権限をオンにしてください',
			'tls.insecure' => '証明書の検証をスキップ',
			'tls.certificate' => '証明書',
			'tls.privateKey' => '秘密鍵',
			'tls.customTrustCert' => 'カスタム証明書',
			'tun.stack' => 'ネットワークスタック',
			'tun.inet4Address' => 'IPv4アドレス範囲',
			'tun.inet6Address' => 'IPv6アドレス範囲',
			'tun.dnsHijack' => 'DNSハイジャック',
			'tun.strictRoute' => '厳格なルート',
			'tun.tunDefaultRoute' => 'デフォルトルート',
			'tun.icmpForward' => 'ICMP転送',
			'tun.allowBypass' => 'アプリがVPNをバイパスすることを許可する',
			'tun.appendHttpProxy' => 'VPNにHTTPプロキシを追加する',
			'tun.bypassHttpProxyDomain' => 'HTTPプロキシをバイパスすることを許可するドメイン',
			'dns.listen' => 'リスニングアドレス',
			'dns.fakeIp' => 'fake-ip',
			'dns.fallback' => 'フォールバック',
			'dns.preferH3' => 'DoH H3を優先',
			'dns.useHosts' => 'Hostsを使用',
			'dns.useSystemHosts' => 'システムHostsを使用',
			'dns.enhancedMode' => '拡張モード',
			'dns.fakeIPFilterMode' => '${_root.dns.fakeIp} フィルターモード',
			'dns.fakeIPFilter' => '${_root.dns.fakeIp} フィルター',
			'dns.respectRules' => 'ルールを尊重する',
			'dns.nameServer' => 'ネームサーバー',
			'dns.defaultNameServer' => '${_root.meta.byDefault} ${_root.dns.nameServer}',
			'dns.proxyNameServer' => '${_root.meta.proxy} ${_root.dns.nameServer}',
			'dns.directNameServer' => '${_root.meta.direct} ${_root.dns.nameServer}',
			'dns.fallbackNameServer' => '${_root.dns.fallback} ${_root.dns.nameServer}',
			'dns.fallbackGeoIp' => '${_root.dns.fallback} GeoIp',
			'dns.fallbackGeoIpCode' => '${_root.dns.fallback} GeoIpCode',
			'sniffer.overrideDest' => '上書き',
			'profilePatchMode.currentSelected' => '現在選択中',
			'profilePatchMode.overwrite' => '内蔵 - 上書き',
			'profilePatchMode.noOverwrite' => '内蔵 - 上書きなし',
			'protocolSniff' => 'プロトコル検知',
			'protocolSniffOverrideDestination' => '検知されたドメイン名で接続先アドレスを上書きする',
			'edgeRuntimeNotInstalled' => '現在のデバイスには Edge WebView2 ランタイムがインストールされていないため、ページを表示できません。Edge WebView2 ランタイム (x64) をダウンロードしてインストールし、アプリを再起動してからもう一度お試しください。',
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
