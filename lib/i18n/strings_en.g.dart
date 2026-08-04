///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final Translations$BackupAndSyncWebdavScreen$en BackupAndSyncWebdavScreen = Translations$BackupAndSyncWebdavScreen$en._(_root);
	late final Translations$LaunchFailedScreen$en LaunchFailedScreen = Translations$LaunchFailedScreen$en._(_root);
	late final Translations$PerAppAndroidScreen$en PerAppAndroidScreen = Translations$PerAppAndroidScreen$en._(_root);
	late final Translations$UserAgreementScreen$en UserAgreementScreen = Translations$UserAgreementScreen$en._(_root);
	late final Translations$VersionUpdateScreen$en VersionUpdateScreen = Translations$VersionUpdateScreen$en._(_root);
	late final Translations$NetCheckScreen$en NetCheckScreen = Translations$NetCheckScreen$en._(_root);
	late final Translations$loginScreen$en loginScreen = Translations$loginScreen$en._(_root);
	late final Translations$main$en main = Translations$main$en._(_root);
	late final Translations$meta$en meta = Translations$meta$en._(_root);
	late final Translations$permission$en permission = Translations$permission$en._(_root);
	late final Translations$tls$en tls = Translations$tls$en._(_root);
	late final Translations$tun$en tun = Translations$tun$en._(_root);
	late final Translations$dns$en dns = Translations$dns$en._(_root);
	late final Translations$sniffer$en sniffer = Translations$sniffer$en._(_root);
	late final Translations$profilePatchMode$en profilePatchMode = Translations$profilePatchMode$en._(_root);

	/// en: 'Protocol Sniff'
	String get protocolSniff => 'Protocol Sniff';

	/// en: 'The Sniff domain name override the connection target address'
	String get protocolSniffOverrideDestination => 'The Sniff domain name override the connection target address';

	/// en: 'The current device has not installed the Edge WebView2 runtime, so the page cannot be displayed. Please download and install the Edge WebView2 runtime (x64), restart the App and try again.'
	String get edgeRuntimeNotInstalled => 'The current device has not installed the Edge WebView2 runtime, so the page cannot be displayed. Please download and install the Edge WebView2 runtime (x64), restart the App and try again.';

	Map<String, String> get locales => {
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
class Translations$BackupAndSyncWebdavScreen$en {
	Translations$BackupAndSyncWebdavScreen$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Server Url'
	String get webdavServerUrl => 'Server Url';

	/// en: 'Can not be empty'
	String get webdavRequired => 'Can not be empty';

	/// en: 'Login failed:'
	String get webdavLoginFailed => 'Login failed:';

	/// en: 'Failed to get file list:'
	String get webdavListFailed => 'Failed to get file list:';
}

// Path: LaunchFailedScreen
class Translations$LaunchFailedScreen$en {
	Translations$LaunchFailedScreen$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The app failed to start [Invalid process name], please reinstall the app to a separate directory'
	String get invalidProcess => 'The app failed to start [Invalid process name], please reinstall the app to a separate directory';

	/// en: 'The app failed to start [Failed to access the profile], please reinstall the app'
	String get invalidProfile => 'The app failed to start [Failed to access the profile], please reinstall the app';

	/// en: 'The app failed to start [Invalid version], please reinstall the app'
	String get invalidVersion => 'The app failed to start [Invalid version], please reinstall the app';

	/// en: 'The app failed to start [system version too low]'
	String get systemVersionLow => 'The app failed to start [system version too low]';

	/// en: 'The installation path is invalid, please reinstall it to a valid path'
	String get invalidInstallPath => 'The installation path is invalid, please reinstall it to a valid path';
}

// Path: PerAppAndroidScreen
class Translations$PerAppAndroidScreen$en {
	Translations$PerAppAndroidScreen$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Per-App Proxy'
	String get title => 'Per-App Proxy';

	/// en: 'Whitelist Mode'
	String get whiteListMode => 'Whitelist Mode';

	/// en: 'When enabled: only the apps that have been checked are proxies; when not enabled: only the apps that are not checked are proxies'
	String get whiteListModeTip => 'When enabled: only the apps that have been checked are proxies; when not enabled: only the apps that are not checked are proxies';
}

// Path: UserAgreementScreen
class Translations$UserAgreementScreen$en {
	Translations$UserAgreementScreen$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Your Privacy Comes First'
	String get privacyFirst => 'Your Privacy Comes First';

	/// en: 'Accept & Continue'
	String get agreeAndContinue => 'Accept & Continue';
}

// Path: VersionUpdateScreen
class Translations$VersionUpdateScreen$en {
	Translations$VersionUpdateScreen$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'The new version[$p] is ready'
	String versionReady({required Object p}) => 'The new version[${p}] is ready';

	/// en: 'Restart To Update'
	String get update => 'Restart To Update';

	/// en: 'Not Now'
	String get cancel => 'Not Now';
}

// Path: NetCheckScreen
class Translations$NetCheckScreen$en {
	Translations$NetCheckScreen$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Please enter a domain'
	String get enterDomain => 'Please enter a domain';

	/// en: 'Checking...'
	String get checking => 'Checking...';

	/// en: 'A query failed: $p'
	String aQueryFailed({required Object p}) => 'A query failed: ${p}';

	/// en: 'AAAA query failed: $p'
	String aaaaQueryFailed({required Object p}) => 'AAAA query failed: ${p}';

	/// en: 'Success'
	String get success => 'Success';

	/// en: 'Failed'
	String get failed => 'Failed';

	/// en: 'Suspected DNS poisoning'
	String get suspectedPollution => 'Suspected DNS poisoning';

	/// en: 'Domain'
	String get domainLabel => 'Domain';

	/// en: 'Check'
	String get checkButton => 'Check';

	/// en: '1. DNS Query'
	String get dnsSection => '1. DNS Query';

	/// en: '2. HTTP (via TUN, enable TUN first)'
	String get directHttpSection => '2. HTTP (via TUN, enable TUN first)';

	/// en: '3. HTTP (via Proxy, port: $p)'
	String proxyHttpSection({required Object p}) => '3. HTTP (via Proxy, port: ${p})';

	/// en: 'TUN is not enabled'
	String get tunNotEnabled => 'TUN is not enabled';

	/// en: '4. Route Table'
	String get routeTableSection => '4. Route Table';
}

// Path: loginScreen
class Translations$loginScreen$en {
	Translations$loginScreen$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Login'
	String get login => 'Login';

	/// en: 'Register Account'
	String get register => 'Register Account';

	/// en: 'Forgot Password'
	String get forgotPassword => 'Forgot Password';

	/// en: 'Provider'
	String get provider => 'Provider';

	/// en: 'Provider Code/Alias/URL'
	String get providerName => '${_root.loginScreen.provider} Code/Alias/URL';

	/// en: 'Please enter the Provider code/alias/URL'
	String get providerNameRequired => 'Please enter the ${_root.loginScreen.provider} code/alias/URL';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Please enter account'
	String get accountRequired => 'Please enter account';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Please enter email address'
	String get emailRequired => 'Please enter email address';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Please enter password'
	String get passwordRequired => 'Please enter password';

	/// en: 'Please enter valid email address'
	String get validEmailRequired => 'Please enter valid email address';

	/// en: 'Password length at least $minLength characters'
	String passwordMinLength({required Object minLength}) => 'Password length at least ${minLength} characters';

	/// en: 'Unsupported Provider'
	String get unsupportedProvider => 'Unsupported ${_root.loginScreen.provider}';

	/// en: 'Unsupported Provider type'
	String get unsupportedProviderType => 'Unsupported ${_root.loginScreen.provider} type';

	/// en: 'Login feature is not activated'
	String get unActivedProvider => 'Login feature is not activated';

	/// en: 'Please request the provider code/alias from your Provider. For Provider integration, please refer to: $p'
	String providerLoginSupportRequired({required Object p}) => 'Please request the provider code/alias from your ${_root.loginScreen.provider}.\nFor ${_root.loginScreen.provider} integration, please refer to: ${p}';

	/// en: 'Disclaimer: Provider is a third-party service and is not affiliated with this app'
	String get providerDisclaimer => 'Disclaimer: ${_root.loginScreen.provider} is a third-party service and is not affiliated with this app';
}

// Path: main
class Translations$main$en {
	Translations$main$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final Translations$main$tray$en tray = Translations$main$tray$en._(_root);
}

// Path: meta
class Translations$meta$en {
	Translations$meta$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Enable'
	String get enable => 'Enable';

	/// en: 'Disable'
	String get disable => 'Disable';

	/// en: 'Open'
	String get open => 'Open';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Quit'
	String get quit => 'Quit';

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Added successfully'
	String get addSuccess => 'Added successfully';

	/// en: 'Add failed:$p'
	String addFailed({required Object p}) => 'Add failed:${p}';

	/// en: 'Remove'
	String get remove => 'Remove';

	/// en: 'Are you sure to delete?'
	String get removeConfirm => 'Are you sure to delete?';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'View'
	String get view => 'View';

	/// en: 'Remark'
	String get remark => 'Remark';

	/// en: 'Default'
	String get byDefault => 'Default';

	/// en: 'Edit Remark'
	String get editRemark => 'Edit Remark';

	/// en: 'More'
	String get more => 'More';

	/// en: 'Info'
	String get tips => 'Info';

	/// en: 'Select All'
	String get selectAll => 'Select All';

	/// en: 'Copy'
	String get copy => 'Copy';

	/// en: 'Paste'
	String get paste => 'Paste';

	/// en: 'Cut'
	String get cut => 'Cut';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Ok'
	String get ok => 'Ok';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'FAQ'
	String get faq => 'FAQ';

	/// en: 'Document'
	String get doc => 'Document';

	/// en: 'HTML Toolset'
	String get htmlTools => 'HTML Toolset';

	/// en: 'Download'
	String get download => 'Download';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Days'
	String get days => 'Days';

	/// en: 'Hours'
	String get hours => 'Hours';

	/// en: 'Minutes'
	String get minutes => 'Minutes';

	/// en: 'Seconds'
	String get seconds => 'Seconds';

	/// en: 'Milliseconds'
	String get milliseconds => 'Milliseconds';

	/// en: 'Protocol'
	String get protocol => 'Protocol';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Custom'
	String get custom => 'Custom';

	/// en: 'Connect'
	String get connect => 'Connect';

	/// en: 'Disconnect'
	String get disconnect => 'Disconnect';

	/// en: 'Connected'
	String get connected => 'Connected';

	/// en: 'Disconnected'
	String get disconnected => 'Disconnected';

	/// en: 'Connecting'
	String get connecting => 'Connecting';

	/// en: 'Connect Timeout'
	String get connectTimeout => 'Connect Timeout';

	/// en: 'Timeout'
	String get timeout => 'Timeout';

	/// en: 'Timeout Duration'
	String get timeoutDuration => 'Timeout Duration';

	/// en: 'Latency'
	String get latency => 'Latency';

	/// en: 'Latency Checks'
	String get latencyTest => 'Latency Checks';

	/// en: 'Network Check'
	String get networkCheck => 'Network Check';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'Next'
	String get next => 'Next';

	/// en: 'Done'
	String get done => 'Done';

	/// en: 'Apply'
	String get apply => 'Apply';

	/// en: 'Refresh'
	String get refresh => 'Refresh';

	/// en: 'Retry?'
	String get retry => 'Retry?';

	/// en: 'Update'
	String get update => 'Update';

	/// en: 'Update interval'
	String get updateInterval => 'Update interval';

	/// en: 'Update failed:$p'
	String updateFailed({required Object p}) => 'Update failed:${p}';

	/// en: 'Minimum: 5m'
	String get updateInterval5mTips => 'Minimum: 5m';

	/// en: 'Prefer provider settings'
	String get updateIntervalPreferByProfile => 'Prefer provider settings';

	/// en: 'None'
	String get none => 'None';

	/// en: 'Reset'
	String get reset => 'Reset';

	/// en: 'Authentication'
	String get authentication => 'Authentication';

	/// en: 'Submit'
	String get submit => 'Submit';

	/// en: 'User'
	String get user => 'User';

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Decrypt Password'
	String get decryptPassword => 'Decrypt Password';

	/// en: 'Required'
	String get required => 'Required';

	/// en: 'Continue'
	String get go => 'Continue';

	/// en: 'sudo password (required for TUN mode)'
	String get sudoPassword => 'sudo password (required for TUN mode)';

	/// en: 'Other'
	String get other => 'Other';

	/// en: 'DNS'
	String get dns => 'DNS';

	/// en: 'URL'
	String get url => 'URL';

	/// en: 'Invalid URL'
	String get urlInvalid => 'Invalid URL';

	/// en: 'Link can not be empty'
	String get urlCannotEmpty => 'Link can not be empty';

	/// en: 'URL is too long (>8182)'
	String get urlTooLong => 'URL is too long (>8182)';

	/// en: 'Copy Link'
	String get copyUrl => 'Copy Link';

	/// en: 'Open Link'
	String get openUrl => 'Open Link';

	/// en: 'Share Link'
	String get shareUrl => 'Share Link';

	/// en: 'Note: After modifying the configuration, you need to reconnect to take effect'
	String get coreSettingTips => 'Note: After modifying the configuration, you need to reconnect to take effect';

	/// en: 'Overwrite'
	String get overwrite => 'Overwrite';

	/// en: 'Custom Overwrite'
	String get overwriteCustom => 'Custom Overwrite';

	/// en: 'Append Overwrite'
	String get overwriteAppend => 'Append Overwrite';

	/// en: 'Original Profile <- Custom Overwrite <- App Overwrite'
	String get overwriteTips => 'Original Profile <- Custom Overwrite <- App Overwrite';

	/// en: 'Do not overwrite'
	String get noOverwrite => 'Do not overwrite';

	/// en: 'Overwrite Settings'
	String get overwriteSettings => 'Overwrite Settings';

	/// en: 'Diversion Template'
	String get diversionTemplates => 'Diversion Template';

	/// en: 'Rule Providers'
	String get ruleProviders => 'Rule Providers';

	/// en: 'Rule Templates'
	String get ruleTemplates => 'Rule Templates';

	/// en: 'Proxy Group Template'
	String get proxyGroupsTemplates => 'Proxy Group Template';

	/// en: 'Proxy Group'
	String get proxyGroups => 'Proxy Group';

	/// en: 'Proxy Node list'
	String get proxyNodeList => 'Proxy Node list';

	/// en: 'The following proxy nodes have expired and have been automatically removed: $p'
	String proxyNodeFailure({required Object p}) => 'The following proxy nodes have expired and have been automatically removed: ${p}';

	/// en: 'External Controller'
	String get externalController => 'External Controller';

	/// en: 'Secret'
	String get secret => 'Secret';

	/// en: 'TCP Concurrent Handshake'
	String get tcpConcurrent => 'TCP Concurrent Handshake';

	/// en: 'TLS Global Fingerprint'
	String get globalClientFingerprint => 'TLS Global Fingerprint';

	/// en: 'LAN device access'
	String get allowLanAccess => 'LAN device access';

	/// en: 'Mixed Proxy Port'
	String get mixedPort => 'Mixed Proxy Port';

	/// en: 'Log Level'
	String get logLevel => 'Log Level';

	/// en: 'Find Process Mode'
	String get findProcessMode => 'Find Process Mode';

	/// en: 'TCP Keep-alive Interval'
	String get tcpkeepAliveInterval => 'TCP Keep-alive Interval';

	/// en: 'Delay Test URL'
	String get delayTestUrl => 'Delay Test URL';

	/// en: 'Delay Test Timeout(ms)'
	String get delayTestTimeout => 'Delay Test Timeout(ms)';

	/// en: 'TUN'
	String get tun => 'TUN';

	/// en: 'NTP'
	String get ntp => 'NTP';

	/// en: 'TLS'
	String get tls => 'TLS';

	/// en: 'GEO'
	String get geo => 'GEO';

	/// en: 'Downloading Geo RuleSet by proxy'
	String get geoDownloadByProxy => 'Downloading Geo RuleSet by proxy';

	/// en: 'Geosite/Geoip will be converted into the corresponding RuleSet'
	String get geoRulesetTips => 'Geosite/Geoip will be converted into the corresponding RuleSet';

	/// en: 'Due to iOS system memory limitations, IP-ASN and SRC-IP-ASN rules will be ignored on iOS.'
	String get asnNotSupportInIosTips => 'Due to iOS system memory limitations, IP-ASN and SRC-IP-ASN rules will be ignored on iOS.';

	/// en: 'Sniffer'
	String get sniffer => 'Sniffer';

	/// en: 'UserAgent'
	String get userAgent => 'UserAgent';

	/// en: 'Launch at Startup'
	String get launchAtStartup => 'Launch at Startup';

	/// en: 'Please restart Clash Mi as administrator'
	String get launchAtStartupRunAsAdmin => 'Please restart Clash Mi as administrator';

	/// en: 'The TUN mode requires system administrator permissions, please restart the app as an administrator'
	String get tunModeRunAsAdmin => 'The TUN mode requires system administrator permissions, please restart the app as an administrator';

	/// en: 'Portable Mode'
	String get portableMode => 'Portable Mode';

	/// en: 'If you need to exit portable mode, please exit [clashmi] and manually delete the [portable] folder in the same directory as [clashmi.exe]'
	String get portableModeDisableTips => 'If you need to exit portable mode, please exit [clashmi] and manually delete the [portable] folder in the same directory as [clashmi.exe]';

	/// en: 'System Proxy'
	String get systemProxy => 'System Proxy';

	/// en: 'Auto Connection after Launch'
	String get autoConnectAfterLaunch => 'Auto Connection after Launch';

	/// en: 'Auto Connection after System Startup'
	String get autoConnectAtBoot => 'Auto Connection after System Startup';

	/// en: 'System support is required; some systems may also require [auto-start] to be enabled.'
	String get autoConnectAtBootTips => 'System support is required; some systems may also require [auto-start] to be enabled.';

	/// en: 'Hide window after startup'
	String get hideAfterLaunch => 'Hide window after startup';

	/// en: 'Auto Set System Proxy when Connected'
	String get autoSetSystemProxy => 'Auto Set System Proxy when Connected';

	/// en: 'Domain names that are allowed to bypass the system proxy'
	String get bypassSystemProxy => 'Domain names that are allowed to bypass the system proxy';

	/// en: 'Hide from [Recent Tasks]'
	String get excludeFromRecent => 'Hide from [Recent Tasks]';

	/// en: 'Wake Lock'
	String get wakeLock => 'Wake Lock';

	/// en: 'Hide VPN Icon'
	String get hideVpn => 'Hide VPN Icon';

	/// en: 'Enabling IPv6 will cause this function to fail'
	String get hideVpnTips => 'Enabling IPv6 will cause this function to fail';

	/// en: 'Hide Dock Icon'
	String get hideDockIcon => 'Hide Dock Icon';

	/// en: 'Show traffic info in tray'
	String get showTrayTraffic => 'Show traffic info in tray';

	/// en: 'Website'
	String get website => 'Website';

	/// en: 'Home Page'
	String get homePage => 'Home Page';

	/// en: 'Rule'
	String get rule => 'Rule';

	/// en: 'Global'
	String get global => 'Global';

	/// en: 'Direct'
	String get direct => 'Direct';

	/// en: 'Block'
	String get block => 'Block';

	/// en: 'QR Code'
	String get qrcode => 'QR Code';

	/// en: 'The text is too long to display'
	String get qrcodeTooLong => 'The text is too long to display';

	/// en: 'Share QR Code'
	String get qrcodeShare => 'Share QR Code';

	/// en: 'Text To QR Code'
	String get textToQrcode => 'Text To QR Code';

	/// en: 'Scan QR Code'
	String get qrcodeScan => 'Scan QR Code';

	/// en: 'Scan Result'
	String get qrcodeScanResult => 'Scan Result';

	/// en: 'Scan From Image'
	String get qrcodeScanFromImage => 'Scan From Image';

	/// en: 'Failed to parse the image, please make sure the screenshot is a valid QR code'
	String get qrcodeScanResultFailed => 'Failed to parse the image, please make sure the screenshot is a valid QR code';

	/// en: 'Scan Result is empty'
	String get qrcodeScanResultEmpty => 'Scan Result is empty';

	/// en: 'Screenshot'
	String get screenshot => 'Screenshot';

	/// en: 'Backup and Sync'
	String get backupAndSync => 'Backup and Sync';

	/// en: 'Import Success'
	String get importSuccess => 'Import Success';

	/// en: 'This file will overwrite the existing local configuration. Do you want to continue?'
	String get rewriteConfirm => 'This file will overwrite the existing local configuration. Do you want to continue?';

	/// en: 'Import and Export'
	String get importAndExport => 'Import and Export';

	/// en: 'Import'
	String get import => 'Import';

	/// en: 'Import from URL'
	String get importFromUrl => 'Import from URL';

	/// en: 'Export'
	String get export => 'Export';

	/// en: 'Send'
	String get send => 'Send';

	/// en: 'Receive'
	String get receive => 'Receive';

	/// en: 'Confirm to send?'
	String get sendConfirm => 'Confirm to send?';

	/// en: 'Continue to connect?'
	String get continueConnectConfirm => 'Continue to connect?';

	/// en: 'Terms of Service'
	String get termOfUse => 'Terms of Service';

	/// en: 'Privacy & Policy'
	String get privacyPolicy => 'Privacy & Policy';

	/// en: 'Log'
	String get log => 'Log';

	/// en: 'Core Log'
	String get coreLog => 'Core Log';

	/// en: 'Core'
	String get core => 'Core';

	/// en: 'Help'
	String get help => 'Help';

	/// en: 'Tutorial'
	String get tutorial => 'Tutorial';

	/// en: 'Board'
	String get board => 'Board';

	/// en: 'Use Online Board'
	String get boardOnline => 'Use Online Board';

	/// en: 'Online Board URL'
	String get boardOnlineUrl => 'Online Board URL';

	/// en: 'Local Board Port'
	String get boardLocalPort => 'Local Board Port';

	/// en: 'Always-on Connection'
	String get alwayOnVPN => 'Always-on Connection';

	/// en: 'Disable Font scaling(Restart takes effect)'
	String get disableFontScaler => 'Disable Font scaling(Restart takes effect)';

	/// en: 'Rotate with the screen'
	String get autoOrientation => 'Rotate with the screen';

	/// en: 'Restart takes effect'
	String get restartTakesEffect => 'Restart takes effect';

	/// en: 'Reconnect takes effect'
	String get reconnectTakesEffect => 'Reconnect takes effect';

	/// en: 'Runtime Profile'
	String get runtimeProfile => 'Runtime Profile';

	/// en: 'Please restart your device to complete the system extension installation'
	String get willCompleteAfterRebootInstall => 'Please restart your device to complete the system extension installation';

	/// en: 'Please restart your device to complete the the system extension uninstallation'
	String get willCompleteAfterRebootUninstall => 'Please restart your device to complete the the system extension uninstallation';

	/// en: '1. Please [Allow] Clash Mi to install system extensions in [System Settings]-[Privacy and Security] 2. [System Settings]-[General]-[Login Items Extensions]-[Network Extension] enable [clashmiServiceSE] reconnect after completion'
	String get requestNeedsUserApproval => '1. Please [Allow] Clash Mi to install system extensions in [System Settings]-[Privacy and Security]\n2. [System Settings]-[General]-[Login Items Extensions]-[Network Extension] enable [clashmiServiceSE]\nreconnect after completion';

	/// en: 'Please enable clashmiServiceSE permission in [System Settings]-[Privacy and Security]-[Full Disk Access] and reconnect.'
	String get FullDiskAccessPermissionRequired => 'Please enable clashmiServiceSE permission in [System Settings]-[Privacy and Security]-[Full Disk Access] and reconnect.';

	/// en: 'Proxy'
	String get proxy => 'Proxy';

	/// en: 'Theme'
	String get theme => 'Theme';

	/// en: 'TV Mode'
	String get tvMode => 'TV Mode';

	/// en: 'Auto Update'
	String get autoUpdate => 'Auto Update';

	/// en: 'Auto Update Channel'
	String get updateChannel => 'Auto Update Channel';

	/// en: 'Online Customer Service'
	String get onlineCustomerService => 'Online Customer Service';

	/// en: 'Subscription Channel'
	String get subscriptionChannel => 'Subscription Channel';

	/// en: 'Update Version $p'
	String hasNewVersion({required Object p}) => 'Update Version ${p}';

	/// en: 'Auto Download Update Packages'
	String get autoDownloadPkg => 'Auto Download Update Packages';

	/// en: 'Developer Options'
	String get devOptions => 'Developer Options';

	/// en: 'About'
	String get about => 'About';

	/// en: 'Name'
	String get name => 'Name';

	/// en: 'Version'
	String get version => 'Version';

	/// en: 'Notice'
	String get notice => 'Notice';

	/// en: 'Reorder'
	String get sort => 'Reorder';

	/// en: 'Recommend'
	String get recommended => 'Recommend';

	/// en: 'Inner Error:$p'
	String innerError({required Object p}) => 'Inner Error:${p}';

	/// en: 'Share'
	String get share => 'Share';

	/// en: 'Import From Clipboard'
	String get importFromClipboard => 'Import From Clipboard';

	/// en: 'Export to Clipboard'
	String get exportToClipboard => 'Export to Clipboard';

	/// en: 'Server'
	String get server => 'Server';

	/// en: 'Port'
	String get port => 'Port';

	/// en: 'Donate'
	String get donate => 'Donate';

	/// en: 'Settings'
	String get setting => 'Settings';

	/// en: 'Core Settings'
	String get settingCore => 'Core Settings';

	/// en: 'App Settings'
	String get settingApp => 'App Settings';

	/// en: 'Core Overwrite'
	String get coreOverwrite => 'Core Overwrite';

	/// en: 'iCloud'
	String get iCloud => 'iCloud';

	/// en: 'Webdav'
	String get webdav => 'Webdav';

	/// en: 'LAN Sync'
	String get lanSync => 'LAN Sync';

	/// en: 'Do not exit this interface before synchronization is completed'
	String get lanSyncNotQuitTips => 'Do not exit this interface before synchronization is completed';

	/// en: 'Not enough disk space'
	String get deviceNoSpace => 'Not enough disk space';

	/// en: 'Hide System Apps'
	String get hideSystemApp => 'Hide System Apps';

	/// en: 'Hide App Icons'
	String get hideAppIcon => 'Hide App Icons';

	/// en: 'Open File Directory'
	String get openDir => 'Open File Directory';

	/// en: 'Type'
	String get type => 'Type';

	/// en: 'Select File'
	String get fileChoose => 'Select File';

	/// en: 'The file path can not be empty'
	String get filePathCannotEmpty => 'The file path can not be empty';

	/// en: 'File does not exist:$p'
	String fileNotExist({required Object p}) => 'File does not exist:${p}';

	/// en: 'Invalid file type:$p'
	String fileTypeInvalid({required Object p}) => 'Invalid file type:${p}';

	/// en: 'UWP Network Isolation Exemptions'
	String get uwpExemption => 'UWP Network Isolation Exemptions';

	/// en: 'Get Profile'
	String get getProfile => 'Get Profile';

	/// en: 'Buy Profile'
	String get buyProfile => 'Buy Profile';

	/// en: 'Add Profile'
	String get addProfile => 'Add Profile';

	/// en: 'My Profiles'
	String get myProfiles => 'My Profiles';

	/// en: 'Profile Edit'
	String get profileEdit => 'Profile Edit';

	/// en: 'Please set this profile as the current profile first, then start/reconnect'
	String get profileNeedActive => 'Please set this profile as the current profile first, then start/reconnect';

	/// en: 'Enable backup download channel'
	String get profileDownloadBackupChannel => 'Enable backup download channel';

	/// en: 'Proxy download channel provided by Clash Mi (no information is stored)'
	String get profileDownloadBackupChannelTips => 'Proxy download channel provided by Clash Mi (no information is stored)';

	/// en: 'Reload after Profile update'
	String get profileEditReloadAfterProfileUpdate => 'Reload after Profile update';

	/// en: 'Append Apple Push Notification rules'
	String get profileRulesAppendApplePush => 'Append Apple Push Notification rules';

	/// en: 'Rules will be automatically set to the first proxy in [proxy-groups] of the original config with type [url-test] or [select]'
	String get profileRulesAppendProxyTips => 'Rules will be automatically set to the first proxy in [proxy-groups] of the original config with type [url-test] or [select]';

	/// en: 'Import Profile File'
	String get profileImport => 'Import Profile File';

	/// en: 'Add Profile Link'
	String get profileAddUrlOrContent => 'Add Profile Link';

	/// en: 'Clash Profile Link'
	String get profileUrlOrContent => 'Clash Profile Link';

	/// en: 'Clash Profile Link [Required]'
	String get profileUrlOrContentHit => 'Clash Profile Link [Required]';

	/// en: 'Profile Link can not be empty'
	String get profileUrlOrContentCannotEmpty => 'Profile Link can not be empty';
}

// Path: permission
class Translations$permission$en {
	Translations$permission$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Camera'
	String get camera => 'Camera';

	/// en: 'Screen Recording'
	String get screen => 'Screen Recording';

	/// en: 'Get Application List'
	String get appQuery => 'Get Application List';

	/// en: 'Turn on [$p] permission'
	String request({required Object p}) => 'Turn on [${p}] permission';

	/// en: 'Please Turn on [$p] permission'
	String requestNeed({required Object p}) => 'Please Turn on [${p}] permission';
}

// Path: tls
class Translations$tls$en {
	Translations$tls$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Skip Certificate Verification'
	String get insecure => 'Skip Certificate Verification';

	/// en: 'Certificate'
	String get certificate => 'Certificate';

	/// en: 'Private Key'
	String get privateKey => 'Private Key';

	/// en: 'Custom Certifactes'
	String get customTrustCert => 'Custom Certifactes';
}

// Path: tun
class Translations$tun$en {
	Translations$tun$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Network stack'
	String get stack => 'Network stack';

	/// en: 'IPv4 Gateway Address'
	String get inet4Address => 'IPv4 Gateway Address';

	/// en: 'IPv6 Gateway Address'
	String get inet6Address => 'IPv6 Gateway Address';

	/// en: 'DNS Hijack'
	String get dnsHijack => 'DNS Hijack';

	/// en: 'Strict Route'
	String get strictRoute => 'Strict Route';

	/// en: 'Default Route'
	String get tunDefaultRoute => 'Default Route';

	/// en: 'ICMP Forwarding'
	String get icmpForward => 'ICMP Forwarding';

	/// en: 'Allow Apps to Bypass VPN'
	String get allowBypass => 'Allow Apps to Bypass VPN';

	/// en: 'Append HTTP Proxy to VPN'
	String get appendHttpProxy => 'Append HTTP Proxy to VPN';

	/// en: 'Domains allowed to bypass HTTP proxy'
	String get bypassHttpProxyDomain => 'Domains allowed to bypass HTTP proxy';
}

// Path: dns
class Translations$dns$en {
	Translations$dns$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Listen'
	String get listen => 'Listen';

	/// en: 'fake-ip'
	String get fakeIp => 'fake-ip';

	/// en: 'Fallback'
	String get fallback => 'Fallback';

	/// en: 'Prefer DoH H3'
	String get preferH3 => 'Prefer DoH H3';

	/// en: 'Use Hosts'
	String get useHosts => 'Use Hosts';

	/// en: 'Use System Hosts'
	String get useSystemHosts => 'Use System Hosts';

	/// en: 'Enhanced Mode'
	String get enhancedMode => 'Enhanced Mode';

	/// en: 'fake-ip Filter Mode'
	String get fakeIPFilterMode => '${_root.dns.fakeIp} Filter Mode';

	/// en: 'fake-ip Filter'
	String get fakeIPFilter => 'fake-ip Filter';

	/// en: 'Respect Rules'
	String get respectRules => 'Respect Rules';

	/// en: 'NameServer'
	String get nameServer => 'NameServer';

	/// en: 'Default NameServer'
	String get defaultNameServer => '${_root.meta.byDefault} ${_root.dns.nameServer}';

	/// en: 'Proxy NameServer'
	String get proxyNameServer => '${_root.meta.proxy} ${_root.dns.nameServer}';

	/// en: 'Direct NameServer'
	String get directNameServer => '${_root.meta.direct} ${_root.dns.nameServer}';

	/// en: 'Fallback NameServer'
	String get fallbackNameServer => '${_root.dns.fallback} ${_root.dns.nameServer}';

	/// en: 'Fallback GeoIp'
	String get fallbackGeoIp => '${_root.dns.fallback} GeoIp';

	/// en: 'Fallback GeoIpCode'
	String get fallbackGeoIpCode => '${_root.dns.fallback} GeoIpCode';
}

// Path: sniffer
class Translations$sniffer$en {
	Translations$sniffer$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Override'
	String get overrideDest => 'Override';
}

// Path: profilePatchMode
class Translations$profilePatchMode$en {
	Translations$profilePatchMode$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Current Selected'
	String get currentSelected => 'Current Selected';

	/// en: 'Built-in Overwrite'
	String get overwrite => 'Built-in Overwrite';

	/// en: 'Built-in - no Overwrite'
	String get noOverwrite => 'Built-in - no Overwrite';
}

// Path: main.tray
class Translations$main$tray$en {
	Translations$main$tray$en._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Open'
	String get menuOpen => 'Open';

	/// en: 'Exit'
	String get menuExit => 'Exit';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'BackupAndSyncWebdavScreen.webdavServerUrl' => 'Server Url',
			'BackupAndSyncWebdavScreen.webdavRequired' => 'Can not be empty',
			'BackupAndSyncWebdavScreen.webdavLoginFailed' => 'Login failed:',
			'BackupAndSyncWebdavScreen.webdavListFailed' => 'Failed to get file list:',
			'LaunchFailedScreen.invalidProcess' => 'The app failed to start [Invalid process name], please reinstall the app to a separate directory',
			'LaunchFailedScreen.invalidProfile' => 'The app failed to start [Failed to access the profile], please reinstall the app',
			'LaunchFailedScreen.invalidVersion' => 'The app failed to start [Invalid version], please reinstall the app',
			'LaunchFailedScreen.systemVersionLow' => 'The app failed to start [system version too low]',
			'LaunchFailedScreen.invalidInstallPath' => 'The installation path is invalid, please reinstall it to a valid path',
			'PerAppAndroidScreen.title' => 'Per-App Proxy',
			'PerAppAndroidScreen.whiteListMode' => 'Whitelist Mode',
			'PerAppAndroidScreen.whiteListModeTip' => 'When enabled: only the apps that have been checked are proxies; when not enabled: only the apps that are not checked are proxies',
			'UserAgreementScreen.privacyFirst' => 'Your Privacy Comes First',
			'UserAgreementScreen.agreeAndContinue' => 'Accept & Continue',
			'VersionUpdateScreen.versionReady' => ({required Object p}) => 'The new version[${p}] is ready',
			'VersionUpdateScreen.update' => 'Restart To Update',
			'VersionUpdateScreen.cancel' => 'Not Now',
			'NetCheckScreen.enterDomain' => 'Please enter a domain',
			'NetCheckScreen.checking' => 'Checking...',
			'NetCheckScreen.aQueryFailed' => ({required Object p}) => 'A query failed: ${p}',
			'NetCheckScreen.aaaaQueryFailed' => ({required Object p}) => 'AAAA query failed: ${p}',
			'NetCheckScreen.success' => 'Success',
			'NetCheckScreen.failed' => 'Failed',
			'NetCheckScreen.suspectedPollution' => 'Suspected DNS poisoning',
			'NetCheckScreen.domainLabel' => 'Domain',
			'NetCheckScreen.checkButton' => 'Check',
			'NetCheckScreen.dnsSection' => '1. DNS Query',
			'NetCheckScreen.directHttpSection' => '2. HTTP (via TUN, enable TUN first)',
			'NetCheckScreen.proxyHttpSection' => ({required Object p}) => '3. HTTP (via Proxy, port: ${p})',
			'NetCheckScreen.tunNotEnabled' => 'TUN is not enabled',
			'NetCheckScreen.routeTableSection' => '4. Route Table',
			'loginScreen.login' => 'Login',
			'loginScreen.register' => 'Register Account',
			'loginScreen.forgotPassword' => 'Forgot Password',
			'loginScreen.provider' => 'Provider',
			'loginScreen.providerName' => '${_root.loginScreen.provider} Code/Alias/URL',
			'loginScreen.providerNameRequired' => 'Please enter the ${_root.loginScreen.provider} code/alias/URL',
			'loginScreen.account' => 'Account',
			'loginScreen.accountRequired' => 'Please enter account',
			'loginScreen.email' => 'Email',
			'loginScreen.emailRequired' => 'Please enter email address',
			'loginScreen.password' => 'Password',
			'loginScreen.passwordRequired' => 'Please enter password',
			'loginScreen.validEmailRequired' => 'Please enter valid email address',
			'loginScreen.passwordMinLength' => ({required Object minLength}) => 'Password length at least ${minLength} characters',
			'loginScreen.unsupportedProvider' => 'Unsupported ${_root.loginScreen.provider}',
			'loginScreen.unsupportedProviderType' => 'Unsupported ${_root.loginScreen.provider} type',
			'loginScreen.unActivedProvider' => 'Login feature is not activated',
			'loginScreen.providerLoginSupportRequired' => ({required Object p}) => 'Please request the provider code/alias from your ${_root.loginScreen.provider}.\nFor ${_root.loginScreen.provider} integration, please refer to: ${p}',
			'loginScreen.providerDisclaimer' => 'Disclaimer: ${_root.loginScreen.provider} is a third-party service and is not affiliated with this app',
			'main.tray.menuOpen' => 'Open',
			'main.tray.menuExit' => 'Exit',
			'meta.enable' => 'Enable',
			'meta.disable' => 'Disable',
			'meta.open' => 'Open',
			'meta.close' => 'Close',
			'meta.quit' => 'Quit',
			'meta.add' => 'Add',
			'meta.addSuccess' => 'Added successfully',
			'meta.addFailed' => ({required Object p}) => 'Add failed:${p}',
			'meta.remove' => 'Remove',
			'meta.removeConfirm' => 'Are you sure to delete?',
			'meta.edit' => 'Edit',
			'meta.view' => 'View',
			'meta.remark' => 'Remark',
			'meta.byDefault' => 'Default',
			'meta.editRemark' => 'Edit Remark',
			'meta.more' => 'More',
			'meta.tips' => 'Info',
			'meta.selectAll' => 'Select All',
			'meta.copy' => 'Copy',
			'meta.paste' => 'Paste',
			'meta.cut' => 'Cut',
			'meta.save' => 'Save',
			'meta.ok' => 'Ok',
			'meta.cancel' => 'Cancel',
			'meta.faq' => 'FAQ',
			'meta.doc' => 'Document',
			'meta.htmlTools' => 'HTML Toolset',
			'meta.download' => 'Download',
			'meta.loading' => 'Loading...',
			'meta.days' => 'Days',
			'meta.hours' => 'Hours',
			'meta.minutes' => 'Minutes',
			'meta.seconds' => 'Seconds',
			'meta.milliseconds' => 'Milliseconds',
			'meta.protocol' => 'Protocol',
			'meta.search' => 'Search',
			'meta.custom' => 'Custom',
			'meta.connect' => 'Connect',
			'meta.disconnect' => 'Disconnect',
			'meta.connected' => 'Connected',
			'meta.disconnected' => 'Disconnected',
			'meta.connecting' => 'Connecting',
			'meta.connectTimeout' => 'Connect Timeout',
			'meta.timeout' => 'Timeout',
			'meta.timeoutDuration' => 'Timeout Duration',
			'meta.latency' => 'Latency',
			'meta.latencyTest' => 'Latency Checks',
			'meta.networkCheck' => 'Network Check',
			'meta.language' => 'Language',
			'meta.next' => 'Next',
			'meta.done' => 'Done',
			'meta.apply' => 'Apply',
			'meta.refresh' => 'Refresh',
			'meta.retry' => 'Retry?',
			'meta.update' => 'Update',
			'meta.updateInterval' => 'Update interval',
			'meta.updateFailed' => ({required Object p}) => 'Update failed:${p}',
			'meta.updateInterval5mTips' => 'Minimum: 5m',
			'meta.updateIntervalPreferByProfile' => 'Prefer provider settings',
			'meta.none' => 'None',
			'meta.reset' => 'Reset',
			'meta.authentication' => 'Authentication',
			'meta.submit' => 'Submit',
			'meta.user' => 'User',
			'meta.account' => 'Account',
			'meta.password' => 'Password',
			'meta.decryptPassword' => 'Decrypt Password',
			'meta.required' => 'Required',
			'meta.go' => 'Continue',
			'meta.sudoPassword' => 'sudo password (required for TUN mode)',
			'meta.other' => 'Other',
			'meta.dns' => 'DNS',
			'meta.url' => 'URL',
			'meta.urlInvalid' => 'Invalid URL',
			'meta.urlCannotEmpty' => 'Link can not be empty',
			'meta.urlTooLong' => 'URL is too long (>8182)',
			'meta.copyUrl' => 'Copy Link',
			'meta.openUrl' => 'Open Link',
			'meta.shareUrl' => 'Share Link',
			'meta.coreSettingTips' => 'Note: After modifying the configuration, you need to reconnect to take effect',
			'meta.overwrite' => 'Overwrite',
			'meta.overwriteCustom' => 'Custom Overwrite',
			'meta.overwriteAppend' => 'Append Overwrite',
			'meta.overwriteTips' => 'Original Profile <- Custom Overwrite <- App Overwrite',
			'meta.noOverwrite' => 'Do not overwrite',
			'meta.overwriteSettings' => 'Overwrite Settings',
			'meta.diversionTemplates' => 'Diversion Template',
			'meta.ruleProviders' => 'Rule Providers',
			'meta.ruleTemplates' => 'Rule Templates',
			'meta.proxyGroupsTemplates' => 'Proxy Group Template',
			'meta.proxyGroups' => 'Proxy Group',
			'meta.proxyNodeList' => 'Proxy Node list',
			'meta.proxyNodeFailure' => ({required Object p}) => 'The following proxy nodes have expired and have been automatically removed: ${p}',
			'meta.externalController' => 'External Controller',
			'meta.secret' => 'Secret',
			'meta.tcpConcurrent' => 'TCP Concurrent Handshake',
			'meta.globalClientFingerprint' => 'TLS Global Fingerprint',
			'meta.allowLanAccess' => 'LAN device access',
			'meta.mixedPort' => 'Mixed Proxy Port',
			'meta.logLevel' => 'Log Level',
			'meta.findProcessMode' => 'Find Process Mode',
			'meta.tcpkeepAliveInterval' => 'TCP Keep-alive Interval',
			'meta.delayTestUrl' => 'Delay Test URL',
			'meta.delayTestTimeout' => 'Delay Test Timeout(ms)',
			'meta.tun' => 'TUN',
			'meta.ntp' => 'NTP',
			'meta.tls' => 'TLS',
			'meta.geo' => 'GEO',
			'meta.geoDownloadByProxy' => 'Downloading Geo RuleSet by proxy',
			'meta.geoRulesetTips' => 'Geosite/Geoip will be converted into the corresponding RuleSet',
			'meta.asnNotSupportInIosTips' => 'Due to iOS system memory limitations, IP-ASN and SRC-IP-ASN rules will be ignored on iOS.',
			'meta.sniffer' => 'Sniffer',
			'meta.userAgent' => 'UserAgent',
			'meta.launchAtStartup' => 'Launch at Startup',
			'meta.launchAtStartupRunAsAdmin' => 'Please restart Clash Mi as administrator',
			'meta.tunModeRunAsAdmin' => 'The TUN mode requires system administrator permissions, please restart the app as an administrator',
			'meta.portableMode' => 'Portable Mode',
			'meta.portableModeDisableTips' => 'If you need to exit portable mode, please exit [clashmi] and manually delete the [portable] folder in the same directory as [clashmi.exe]',
			'meta.systemProxy' => 'System Proxy',
			'meta.autoConnectAfterLaunch' => 'Auto Connection after Launch',
			'meta.autoConnectAtBoot' => 'Auto Connection after System Startup',
			'meta.autoConnectAtBootTips' => 'System support is required; some systems may also require [auto-start] to be enabled.',
			'meta.hideAfterLaunch' => 'Hide window after startup',
			'meta.autoSetSystemProxy' => 'Auto Set System Proxy when Connected',
			'meta.bypassSystemProxy' => 'Domain names that are allowed to bypass the system proxy',
			'meta.excludeFromRecent' => 'Hide from [Recent Tasks]',
			'meta.wakeLock' => 'Wake Lock',
			'meta.hideVpn' => 'Hide VPN Icon',
			'meta.hideVpnTips' => 'Enabling IPv6 will cause this function to fail',
			'meta.hideDockIcon' => 'Hide Dock Icon',
			'meta.showTrayTraffic' => 'Show traffic info in tray',
			'meta.website' => 'Website',
			'meta.homePage' => 'Home Page',
			'meta.rule' => 'Rule',
			'meta.global' => 'Global',
			'meta.direct' => 'Direct',
			'meta.block' => 'Block',
			'meta.qrcode' => 'QR Code',
			'meta.qrcodeTooLong' => 'The text is too long to display',
			'meta.qrcodeShare' => 'Share QR Code',
			'meta.textToQrcode' => 'Text To QR Code',
			'meta.qrcodeScan' => 'Scan QR Code',
			'meta.qrcodeScanResult' => 'Scan Result',
			'meta.qrcodeScanFromImage' => 'Scan From Image',
			'meta.qrcodeScanResultFailed' => 'Failed to parse the image, please make sure the screenshot is a valid QR code',
			'meta.qrcodeScanResultEmpty' => 'Scan Result is empty',
			'meta.screenshot' => 'Screenshot',
			'meta.backupAndSync' => 'Backup and Sync',
			'meta.importSuccess' => 'Import Success',
			'meta.rewriteConfirm' => 'This file will overwrite the existing local configuration. Do you want to continue?',
			'meta.importAndExport' => 'Import and Export',
			'meta.import' => 'Import',
			'meta.importFromUrl' => 'Import from URL',
			'meta.export' => 'Export',
			'meta.send' => 'Send',
			'meta.receive' => 'Receive',
			'meta.sendConfirm' => 'Confirm to send?',
			'meta.continueConnectConfirm' => 'Continue to connect?',
			'meta.termOfUse' => 'Terms of Service',
			'meta.privacyPolicy' => 'Privacy & Policy',
			'meta.log' => 'Log',
			'meta.coreLog' => 'Core Log',
			'meta.core' => 'Core',
			'meta.help' => 'Help',
			'meta.tutorial' => 'Tutorial',
			'meta.board' => 'Board',
			'meta.boardOnline' => 'Use Online Board',
			'meta.boardOnlineUrl' => 'Online Board URL',
			'meta.boardLocalPort' => 'Local Board Port',
			'meta.alwayOnVPN' => 'Always-on Connection',
			'meta.disableFontScaler' => 'Disable Font scaling(Restart takes effect)',
			'meta.autoOrientation' => 'Rotate with the screen',
			'meta.restartTakesEffect' => 'Restart takes effect',
			'meta.reconnectTakesEffect' => 'Reconnect takes effect',
			'meta.runtimeProfile' => 'Runtime Profile',
			'meta.willCompleteAfterRebootInstall' => 'Please restart your device to complete the system extension installation',
			'meta.willCompleteAfterRebootUninstall' => 'Please restart your device to complete the the system extension uninstallation',
			'meta.requestNeedsUserApproval' => '1. Please [Allow] Clash Mi to install system extensions in [System Settings]-[Privacy and Security]\n2. [System Settings]-[General]-[Login Items Extensions]-[Network Extension] enable [clashmiServiceSE]\nreconnect after completion',
			'meta.FullDiskAccessPermissionRequired' => 'Please enable clashmiServiceSE permission in [System Settings]-[Privacy and Security]-[Full Disk Access] and reconnect.',
			'meta.proxy' => 'Proxy',
			'meta.theme' => 'Theme',
			'meta.tvMode' => 'TV Mode',
			'meta.autoUpdate' => 'Auto Update',
			'meta.updateChannel' => 'Auto Update Channel',
			'meta.onlineCustomerService' => 'Online Customer Service',
			'meta.subscriptionChannel' => 'Subscription Channel',
			'meta.hasNewVersion' => ({required Object p}) => 'Update Version ${p}',
			'meta.autoDownloadPkg' => 'Auto Download Update Packages',
			'meta.devOptions' => 'Developer Options',
			'meta.about' => 'About',
			'meta.name' => 'Name',
			'meta.version' => 'Version',
			'meta.notice' => 'Notice',
			'meta.sort' => 'Reorder',
			'meta.recommended' => 'Recommend',
			'meta.innerError' => ({required Object p}) => 'Inner Error:${p}',
			'meta.share' => 'Share',
			'meta.importFromClipboard' => 'Import From Clipboard',
			'meta.exportToClipboard' => 'Export to Clipboard',
			'meta.server' => 'Server',
			'meta.port' => 'Port',
			'meta.donate' => 'Donate',
			'meta.setting' => 'Settings',
			'meta.settingCore' => 'Core Settings',
			'meta.settingApp' => 'App Settings',
			'meta.coreOverwrite' => 'Core Overwrite',
			'meta.iCloud' => 'iCloud',
			'meta.webdav' => 'Webdav',
			'meta.lanSync' => 'LAN Sync',
			'meta.lanSyncNotQuitTips' => 'Do not exit this interface before synchronization is completed',
			'meta.deviceNoSpace' => 'Not enough disk space',
			'meta.hideSystemApp' => 'Hide System Apps',
			'meta.hideAppIcon' => 'Hide App Icons',
			'meta.openDir' => 'Open File Directory',
			'meta.type' => 'Type',
			'meta.fileChoose' => 'Select File',
			'meta.filePathCannotEmpty' => 'The file path can not be empty',
			'meta.fileNotExist' => ({required Object p}) => 'File does not exist:${p}',
			'meta.fileTypeInvalid' => ({required Object p}) => 'Invalid file type:${p}',
			'meta.uwpExemption' => 'UWP Network Isolation Exemptions',
			'meta.getProfile' => 'Get Profile',
			'meta.buyProfile' => 'Buy Profile',
			'meta.addProfile' => 'Add Profile',
			'meta.myProfiles' => 'My Profiles',
			'meta.profileEdit' => 'Profile Edit',
			'meta.profileNeedActive' => 'Please set this profile as the current profile first, then start/reconnect',
			'meta.profileDownloadBackupChannel' => 'Enable backup download channel',
			'meta.profileDownloadBackupChannelTips' => 'Proxy download channel provided by Clash Mi (no information is stored)',
			'meta.profileEditReloadAfterProfileUpdate' => 'Reload after Profile update',
			'meta.profileRulesAppendApplePush' => 'Append Apple Push Notification rules',
			'meta.profileRulesAppendProxyTips' => 'Rules will be automatically set to the first proxy in [proxy-groups] of the original config with type [url-test] or [select]',
			'meta.profileImport' => 'Import Profile File',
			'meta.profileAddUrlOrContent' => 'Add Profile Link',
			'meta.profileUrlOrContent' => 'Clash Profile Link',
			'meta.profileUrlOrContentHit' => 'Clash Profile Link [Required]',
			'meta.profileUrlOrContentCannotEmpty' => 'Profile Link can not be empty',
			'permission.camera' => 'Camera',
			'permission.screen' => 'Screen Recording',
			'permission.appQuery' => 'Get Application List',
			'permission.request' => ({required Object p}) => 'Turn on [${p}] permission',
			'permission.requestNeed' => ({required Object p}) => 'Please Turn on [${p}] permission',
			'tls.insecure' => 'Skip Certificate Verification',
			'tls.certificate' => 'Certificate',
			'tls.privateKey' => 'Private Key',
			'tls.customTrustCert' => 'Custom Certifactes',
			'tun.stack' => 'Network stack',
			'tun.inet4Address' => 'IPv4 Gateway Address',
			'tun.inet6Address' => 'IPv6 Gateway Address',
			'tun.dnsHijack' => 'DNS Hijack',
			'tun.strictRoute' => 'Strict Route',
			'tun.tunDefaultRoute' => 'Default Route',
			'tun.icmpForward' => 'ICMP Forwarding',
			'tun.allowBypass' => 'Allow Apps to Bypass VPN',
			'tun.appendHttpProxy' => 'Append HTTP Proxy to VPN',
			'tun.bypassHttpProxyDomain' => 'Domains allowed to bypass HTTP proxy',
			'dns.listen' => 'Listen',
			'dns.fakeIp' => 'fake-ip',
			'dns.fallback' => 'Fallback',
			'dns.preferH3' => 'Prefer DoH H3',
			'dns.useHosts' => 'Use Hosts',
			'dns.useSystemHosts' => 'Use System Hosts',
			'dns.enhancedMode' => 'Enhanced Mode',
			'dns.fakeIPFilterMode' => '${_root.dns.fakeIp} Filter Mode',
			'dns.fakeIPFilter' => 'fake-ip Filter',
			'dns.respectRules' => 'Respect Rules',
			'dns.nameServer' => 'NameServer',
			'dns.defaultNameServer' => '${_root.meta.byDefault} ${_root.dns.nameServer}',
			'dns.proxyNameServer' => '${_root.meta.proxy} ${_root.dns.nameServer}',
			'dns.directNameServer' => '${_root.meta.direct} ${_root.dns.nameServer}',
			'dns.fallbackNameServer' => '${_root.dns.fallback} ${_root.dns.nameServer}',
			'dns.fallbackGeoIp' => '${_root.dns.fallback} GeoIp',
			'dns.fallbackGeoIpCode' => '${_root.dns.fallback} GeoIpCode',
			'sniffer.overrideDest' => 'Override',
			'profilePatchMode.currentSelected' => 'Current Selected',
			'profilePatchMode.overwrite' => 'Built-in Overwrite',
			'profilePatchMode.noOverwrite' => 'Built-in - no Overwrite',
			'protocolSniff' => 'Protocol Sniff',
			'protocolSniffOverrideDestination' => 'The Sniff domain name override the connection target address',
			'edgeRuntimeNotInstalled' => 'The current device has not installed the Edge WebView2 runtime, so the page cannot be displayed. Please download and install the Edge WebView2 runtime (x64), restart the App and try again.',
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
