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
class TranslationsFa with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsFa({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.fa,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <fa>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsFa _root = this; // ignore: unused_field

	@override 
	TranslationsFa $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsFa(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$BackupAndSyncWebdavScreen$fa BackupAndSyncWebdavScreen = _Translations$BackupAndSyncWebdavScreen$fa._(_root);
	@override late final _Translations$LaunchFailedScreen$fa LaunchFailedScreen = _Translations$LaunchFailedScreen$fa._(_root);
	@override late final _Translations$PerAppAndroidScreen$fa PerAppAndroidScreen = _Translations$PerAppAndroidScreen$fa._(_root);
	@override late final _Translations$UserAgreementScreen$fa UserAgreementScreen = _Translations$UserAgreementScreen$fa._(_root);
	@override late final _Translations$NetCheckScreen$fa NetCheckScreen = _Translations$NetCheckScreen$fa._(_root);
	@override late final _Translations$VersionUpdateScreen$fa VersionUpdateScreen = _Translations$VersionUpdateScreen$fa._(_root);
	@override late final _Translations$loginScreen$fa loginScreen = _Translations$loginScreen$fa._(_root);
	@override late final _Translations$main$fa main = _Translations$main$fa._(_root);
	@override late final _Translations$meta$fa meta = _Translations$meta$fa._(_root);
	@override late final _Translations$permission$fa permission = _Translations$permission$fa._(_root);
	@override late final _Translations$tls$fa tls = _Translations$tls$fa._(_root);
	@override late final _Translations$tun$fa tun = _Translations$tun$fa._(_root);
	@override late final _Translations$dns$fa dns = _Translations$dns$fa._(_root);
	@override late final _Translations$sniffer$fa sniffer = _Translations$sniffer$fa._(_root);
	@override late final _Translations$profilePatchMode$fa profilePatchMode = _Translations$profilePatchMode$fa._(_root);
	@override String get protocolSniff => 'تشخیص پروتکل';
	@override String get protocolSniffOverrideDestination => 'نام دامنه شناسایی شده آدرس هدف اتصال را پوشش می دهد';
	@override String get edgeRuntimeNotInstalled => 'زمان اجرا Edge WebView2 روی دستگاه فعلی نصب نشده است و صفحه قابل نمایش نیست لطفاً زمان اجرا Edge WebView2 (x64) را بارگیری و نصب کنید، برنامه را مجدداً راه اندازی کنید و دوباره امتحان کنید.';
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
class _Translations$BackupAndSyncWebdavScreen$fa implements Translations$BackupAndSyncWebdavScreen$en {
	_Translations$BackupAndSyncWebdavScreen$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get webdavServerUrl => 'آدرس URL سرور';
	@override String get webdavRequired => 'نمی‌تواند خالی باشد';
	@override String get webdavLoginFailed => 'ورود ناموفق بود:';
	@override String get webdavListFailed => 'دریافت لیست فایل ناموفق بود:';
}

// Path: LaunchFailedScreen
class _Translations$LaunchFailedScreen$fa implements Translations$LaunchFailedScreen$en {
	_Translations$LaunchFailedScreen$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get invalidProcess => 'اجرای نرم‌افزار ناموفق بود [نام‌ اجرایی پروسه نامعتبر]، لطفا مجدد نرم‌افزار را در دایرکتوری دیگری نصب کنید';
	@override String get invalidProfile => 'اجرای نرم‌افزار ناموفق بود [دسترسی به پروفایل ناموفق بود]، لطفا مجدد نرم افزار را نصب کنید';
	@override String get invalidVersion => 'اجرای نرم‌افزار ناموفق بود [ورژن نامعتبر]، لطفا مجدد نرم‌افزار را نصب کنید';
	@override String get systemVersionLow => 'راه اندازی برنامه ناموفق بود [نسخه سیستم خیلی کم است]';
	@override String get invalidInstallPath => 'مسیر نصب نامعتبر است، لطفا مجدد در مسیر معتبر نصب کنید';
}

// Path: PerAppAndroidScreen
class _Translations$PerAppAndroidScreen$fa implements Translations$PerAppAndroidScreen$en {
	_Translations$PerAppAndroidScreen$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get title => 'پروکسی به‌تفکیک برنامه';
	@override String get whiteListMode => 'حالت لیست سفید';
	@override String get whiteListModeTip => 'وقتی فعال باشد: فقط برنامه‌هایی که انتخاب شده‌اند پروکسی می‌شوند؛ وقتی فعال نباشد: فقط برنامه‌هایی که انتخاب نشده‌اند پروکسی می‌شوند';
}

// Path: UserAgreementScreen
class _Translations$UserAgreementScreen$fa implements Translations$UserAgreementScreen$en {
	_Translations$UserAgreementScreen$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get privacyFirst => 'حریم‌خصوصی شما اولویت دارد';
	@override String get agreeAndContinue => 'پذیرفتن و ادامه';
}

// Path: NetCheckScreen
class _Translations$NetCheckScreen$fa implements Translations$NetCheckScreen$en {
	_Translations$NetCheckScreen$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get enterDomain => 'لطفاً نام دامنه را وارد کنید';
	@override String get checking => 'در حال بررسی...';
	@override String aQueryFailed({required Object p}) => 'خطا در پرس‌وجوی A: ${p}';
	@override String aaaaQueryFailed({required Object p}) => 'خطا در پرس‌وجوی AAAA: ${p}';
	@override String get success => 'موفق';
	@override String get failed => 'ناموفق';
	@override String get suspectedPollution => 'مشکوک به مسمومیت DNS';
	@override String get domainLabel => 'دامنه';
	@override String get checkButton => 'بررسی';
	@override String get dnsSection => '1. پرس‌وجوی DNS';
	@override String get directHttpSection => '2. HTTP (از طریق TUN، ابتدا TUN را فعال کنید)';
	@override String proxyHttpSection({required Object p}) => '3. HTTP (از طریق پروکسی، پورت: ${p})';
	@override String get tunNotEnabled => 'TUN فعال نیست';
	@override String get routeTableSection => '4. جدول مسیریابی';
}

// Path: VersionUpdateScreen
class _Translations$VersionUpdateScreen$fa implements Translations$VersionUpdateScreen$en {
	_Translations$VersionUpdateScreen$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String versionReady({required Object p}) => 'نسخه جدید [${p}] آماده است';
	@override String get update => 'راه‌اندازی مجدد برای به‌روزرسانی';
	@override String get cancel => 'الان‌ نه';
}

// Path: loginScreen
class _Translations$loginScreen$fa implements Translations$loginScreen$en {
	_Translations$loginScreen$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get login => 'ورود';
	@override String get register => 'ایجاد حساب';
	@override String get forgotPassword => 'فراموشی رمز عبور';
	@override String get provider => 'ارائه دهنده خدمات';
	@override String get providerName => 'کد/نام مستعار/URL ${_root.loginScreen.provider}';
	@override String get providerNameRequired => 'لطفا کد/نام مستعار/URL ${_root.loginScreen.provider} را وارد کنید';
	@override String get account => 'حساب';
	@override String get accountRequired => 'لطفا حساب را وارد کنید';
	@override String get email => 'ایمیل';
	@override String get emailRequired => 'لطفا آدرس ایمیل را وارد کنید';
	@override String get password => 'رمز عبور';
	@override String get passwordRequired => 'لطفا رمز عبور را وارد کنید';
	@override String get validEmailRequired => 'لطفا یک آدرس ایمیل معتبر وارد کنید';
	@override String passwordMinLength({required Object minLength}) => 'طول رمز عبور باید حداقل ${minLength} کاراکتر باشد';
	@override String get unsupportedProvider => '${_root.loginScreen.provider} پشتیبانی نمی شود';
	@override String get unsupportedProviderType => 'نوع ${_root.loginScreen.provider} پشتیبانی نمی شود';
	@override String get unActivedProvider => 'قابلیت ورود فعال نشده است';
	@override String providerLoginSupportRequired({required Object p}) => 'لطفاً کد/نام مستعار ارائه‌دهنده را از ${_root.loginScreen.provider} دریافت کنید.\nبرای راهنمای اتصال ${_root.loginScreen.provider} به این لینک مراجعه کنید: ${p}';
	@override String get providerDisclaimer => 'سلب مسئولیت: ${_root.loginScreen.provider} یک سرویس شخص ثالث است و ارتباطی با این برنامه ندارد';
}

// Path: main
class _Translations$main$fa implements Translations$main$en {
	_Translations$main$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override late final _Translations$main$tray$fa tray = _Translations$main$tray$fa._(_root);
}

// Path: meta
class _Translations$meta$fa implements Translations$meta$en {
	_Translations$meta$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get enable => 'فعال‌سازی';
	@override String get disable => 'غیرفعال';
	@override String get open => 'باز کن';
	@override String get close => 'بسته';
	@override String get quit => 'خروج';
	@override String get add => 'افزودن';
	@override String get addSuccess => 'با‌موفقیت اضافه شد';
	@override String addFailed({required Object p}) => 'افزودن ناموفق بود:${p}';
	@override String get remove => 'حذف';
	@override String get removeConfirm => 'آیا از حذف اطمینان دارین؟';
	@override String get edit => 'ویرایش کنید';
	@override String get view => 'بررسی';
	@override String get remark => 'ملاحضات';
	@override String get byDefault => 'پیش‌فرض';
	@override String get editRemark => 'یادداشت های اصلاحی';
	@override String get more => 'بیشتر';
	@override String get tips => 'اطلاعات';
	@override String get selectAll => 'انتخاب همه';
	@override String get copy => 'کپی';
	@override String get paste => 'چسباندن';
	@override String get cut => 'برش';
	@override String get save => 'ذخیره کنید';
	@override String get ok => 'خُب';
	@override String get cancel => 'لغو';
	@override String get faq => 'سوالات متداول';
	@override String get doc => 'سند';
	@override String get htmlTools => 'مجموعه ابزارهای HTML';
	@override String get download => 'دانلود';
	@override String get loading => 'درحال بارگذاری…';
	@override String get days => 'روز';
	@override String get hours => 'ساعت';
	@override String get minutes => 'دقیقه';
	@override String get seconds => 'دومین';
	@override String get milliseconds => 'میلی‌ثانیه';
	@override String get protocol => 'پروتکل';
	@override String get search => 'جستجو';
	@override String get custom => 'سفارشی';
	@override String get connect => 'اتصال';
	@override String get disconnect => 'قطع‌ اتصال';
	@override String get connected => 'وصل شد';
	@override String get disconnected => 'قطع شد';
	@override String get connecting => 'درحال اتصال';
	@override String get connectTimeout => 'اتمام مهلت اتصال';
	@override String get timeout => 'تایم اوت';
	@override String get timeoutDuration => 'مدت زمان وقفه';
	@override String get latency => 'تاخیر';
	@override String get latencyTest => 'بررسی تاخیر';
	@override String get networkCheck => 'بررسی شبکه';
	@override String get language => 'زبان';
	@override String get next => 'بعدی';
	@override String get done => 'انجام‌شد';
	@override String get apply => 'درخواست دادن';
	@override String get refresh => 'بارگذاری مجدد';
	@override String get retry => 'دوباره امتحان کنید؟';
	@override String get update => 'تجدید';
	@override String get updateInterval => 'فاصله‌ی به‌روزرسانی';
	@override String get updateInterval5mTips => 'حداقل: 5 متر';
	@override String get updateIntervalPreferByProfile => 'اولویت با تنظیمات ارائه‌دهنده';
	@override String updateFailed({required Object p}) => 'به‌روزرسانی ناموفق بود:${p}';
	@override String get none => 'هیچ‌کدام';
	@override String get reset => 'ریست';
	@override String get authentication => 'مجوز';
	@override String get submit => 'ارسال';
	@override String get user => 'کاربر';
	@override String get account => 'نام‌کاربری';
	@override String get password => 'رمز‌عبور';
	@override String get decryptPassword => 'دکريپت رمز‌عبور';
	@override String get required => 'الزامی';
	@override String get go => 'ادامه';
	@override String get sudoPassword => 'رمز عبور sudo (برای حالت TUN لازم است)';
	@override String get other => 'دیگر';
	@override String get dns => 'DNS';
	@override String get url => 'URL';
	@override String get urlInvalid => 'URL نامعتبر';
	@override String get urlCannotEmpty => 'لینک نمی‌تواند خالی باشد';
	@override String get urlTooLong => 'URL خیلی طولانی است (>8182)';
	@override String get copyUrl => 'کپی‌کردن لینک';
	@override String get openUrl => 'بازکردن لینک';
	@override String get shareUrl => 'اشتراک لینک';
	@override String get coreSettingTips => 'توجه: پس از تغییر پیکربندی، باید دوباره وصل شوید تا اعمال شود';
	@override String get overwrite => 'لغو';
	@override String get overwriteCustom => 'لغوهای سفارشی';
	@override String get overwriteAppend => 'لغو الحاقی';
	@override String get overwriteTips => 'پیکربندی اصلی <- لغو سفارشی <- لغو برنامه';
	@override String get noOverwrite => 'رونویسی نکنید';
	@override String get overwriteSettings => 'لغو تنظیمات';
	@override String get diversionTemplates => 'الگوی تریاژ';
	@override String get ruleProviders => 'ارائه دهنده قانون';
	@override String get ruleTemplates => 'الگوی قانون';
	@override String get proxyGroupsTemplates => 'الگوی گروه نمایندگان';
	@override String get proxyGroups => 'گروه نمایندگان';
	@override String get proxyNodeList => 'فهرست گره‌های پروکسی';
	@override String proxyNodeFailure({required Object p}) => 'گره‌های پروکسی زیر منقضی شده و به طور خودکار حذف شده‌اند: ${p}';
	@override String get externalController => 'کنترل خارجی';
	@override String get secret => 'Secret';
	@override String get tcpConcurrent => 'دست دادن همزمان TCP';
	@override String get globalClientFingerprint => 'اثر انگشت جهانی TLS';
	@override String get allowLanAccess => 'دسترسی به دستگاه LAN';
	@override String get mixedPort => 'پورت پروکسی هیبریدی';
	@override String get logLevel => 'سطح ورود به سیستم';
	@override String get findProcessMode => 'حالت تطابق فرآیند';
	@override String get tcpkeepAliveInterval => 'فاصله حفظ زنده TCP';
	@override String get delayTestUrl => 'URL تست تأخیر';
	@override String get delayTestTimeout => 'مهلت زمانی تست تاخیری (میلی‌ثانیه)';
	@override String get tun => 'TUN';
	@override String get ntp => 'NTP';
	@override String get tls => 'TLS';
	@override String get geo => 'GEO';
	@override String get geoDownloadByProxy => 'دانلود Geo RuleSet با استفاده از یک پروکسی';
	@override String get geoRulesetTips => 'Geosite/Geoip به RuleSet مربوطه تبدیل می شود';
	@override String get asnNotSupportInIosTips => 'با توجه به محدودیت‌های حافظه سیستم iOS، قوانین IP-ASN و SRC-IP-ASN در iOS نادیده گرفته می‌شوند.';
	@override String get sniffer => 'بو کشیدن';
	@override String get userAgent => 'UserAgent';
	@override String get launchAtStartup => 'اجرا در راه‌اندازی';
	@override String get launchAtStartupRunAsAdmin => 'لطفاً Clash Mi را به عنوان مدیر راه اندازی مجدد کنید';
	@override String get tunModeRunAsAdmin => 'حالت TUN نیازمند مجوز مدیر سیستم می‌باشد لطفا نرم‌افزار را مجدد با حالت مدیر (administrator) راه‌اندازی کنید';
	@override String get portableMode => 'حالت قابل‌حمل';
	@override String get portableModeDisableTips => 'اگر نیاز دارین از حالت قابل‌حمل خارج شوید لطفا از [clashmi] خارج شده و به‌صورت دستی پوشه [portable] هم مسیر با فایل [clashmi.exe] را حذف کنید';
	@override String get systemProxy => 'پروکسی سیستم';
	@override String get autoConnectAfterLaunch => 'اتصال خودکار پس‌از راه‌اندازی';
	@override String get autoConnectAtBoot => 'اتصال خودکار پس از روشن شدن سیستم';
	@override String get autoConnectAtBootTips => 'پشتیبانی سیستم مورد نیاز است؛ برخی سیستم‌ها ممکن است نیاز به فعال بودن [شروع خودکار] نیز داشته باشند.';
	@override String get hideAfterLaunch => 'پنهان کردن پنجره پس از راه اندازی';
	@override String get autoSetSystemProxy => 'تنظیم خودکار حالت پروکسی سیستم پس‌از اتصال';
	@override String get bypassSystemProxy => 'نام های دامنه ای که مجاز به دور زدن پراکسی سیستم هستند';
	@override String get excludeFromRecent => 'پنهان شدن از وظایف اخیر';
	@override String get hideDockIcon => 'پنهان کردن آیکون داک';
	@override String get showTrayTraffic => 'نمایش اطلاعات ترافیک در سینی سیستم';
	@override String get wakeLock => 'قفل بیدارباش';
	@override String get hideVpn => 'مخفی کردن آیکون VPN';
	@override String get hideVpnTips => 'فعال کردن IPv6 باعث از کار افتادن این عملکرد خواهد شد.';
	@override String get website => 'وبسایت';
	@override String get homePage => 'صفحه اصلی';
	@override String get rule => 'قانون';
	@override String get global => 'عمومی';
	@override String get direct => 'مستقیم';
	@override String get block => 'مسدود';
	@override String get qrcode => 'کد QR';
	@override String get qrcodeTooLong => 'متن برای نمایش خیلی طولانی است';
	@override String get qrcodeShare => 'اشتراک کدQR';
	@override String get textToQrcode => 'متن به کد QR';
	@override String get qrcodeScan => 'اسکن QRکد';
	@override String get qrcodeScanResult => 'نتایج اسکن';
	@override String get qrcodeScanFromImage => 'اسکن از عکس';
	@override String get qrcodeScanResultFailed => 'تجزیه عکس ناموفق بود، لطفا مطمعن شوید اسکرین‌شات یک کدQR معتبر است';
	@override String get qrcodeScanResultEmpty => 'نتیجه اسکن خالی است';
	@override String get screenshot => 'اسکرین‌شات';
	@override String get backupAndSync => 'پشتیبان‌گیری و همگام‌سازی';
	@override String get importSuccess => 'افزودن موفق بود';
	@override String get rewriteConfirm => 'این فایل کانفیگ‌های محلی موجود را بازنویسی می‌کند. آیا می‌خواهید ادامه بدین؟';
	@override String get importAndExport => 'وارد‌کردن و خروجی‌گرفتن';
	@override String get import => 'وارد‌کردن';
	@override String get importFromUrl => 'وارد کردن از URL';
	@override String get export => 'خروجی‌گرفتن';
	@override String get send => 'ارسال کنید';
	@override String get receive => 'تصاحب';
	@override String get sendConfirm => 'ارسال را تایید کرد؟';
	@override String get continueConnectConfirm => 'آیا اتصال ادامه یابد؟';
	@override String get termOfUse => 'شرایط استفاده';
	@override String get privacyPolicy => 'سیاست حریم خصوصی';
	@override String get log => 'ورود به سیستم';
	@override String get coreLog => 'گزارش هسته';
	@override String get core => 'هسته';
	@override String get help => 'کمک کند';
	@override String get tutorial => 'آموزش';
	@override String get board => 'پانل';
	@override String get boardOnline => 'با استفاده از پنل آنلاین';
	@override String get boardOnlineUrl => 'آدرس پنل آنلاین';
	@override String get boardLocalPort => 'پورت پانل محلی';
	@override String get alwayOnVPN => 'اتصال همیشه باز';
	@override String get disableFontScaler => 'غیرفعال‌سازی مقیاس‌بندی فونت(با راه‌اندازی مجدد اعمال می‌شود)';
	@override String get autoOrientation => 'چرخش صفحه را دنبال کنید';
	@override String get restartTakesEffect => 'با راه‌اندازی مجدد اعمال می‌شود';
	@override String get reconnectTakesEffect => 'پس از اتصال مجدد، اعمال خواهد شد.';
	@override String get runtimeProfile => 'پیکربندی زمان اجرا';
	@override String get willCompleteAfterRebootInstall => 'لطفاً دستگاه خود را مجدداً راه اندازی کنید تا نصب افزونه سیستم تکمیل شود.';
	@override String get willCompleteAfterRebootUninstall => 'لطفاً دستگاه خود را مجدداً راه‌اندازی کنید تا حذف نصب افزونه سیستم تکمیل شود';
	@override String get requestNeedsUserApproval => '۱. لطفاً به Clash Mi اجازه دهید افزونه‌های سیستمی را در [تنظیمات سیستم] - [حریم خصوصی و امنیت] نصب کند. ۲. : [تنظیمات سیستم] - [عمومی] - [موارد ورود و افزونه‌ها - افزونه‌های شبکه] [clashmiServiceSE] را فعال کنید. پس از اتمام، دوباره متصل شوید.';
	@override String get FullDiskAccessPermissionRequired => 'لطفاً مجوز clashmiServiceSE را در [تنظیمات سیستم]-[حریم خصوصی و امنیت]-[دسترسی کامل به دیسک] فعال کنید و دوباره متصل شوید.';
	@override String get proxy => 'بازیگری';
	@override String get theme => 'موضوع';
	@override String get tvMode => 'حالت تلویزیون';
	@override String get autoUpdate => 'به روز رسانی خودکار';
	@override String get updateChannel => 'کانال به‌روزرسانی خودکار';
	@override String get onlineCustomerService => 'پشتیبانی آنلاین';
	@override String get subscriptionChannel => 'کانال اشتراک';
	@override String hasNewVersion({required Object p}) => 'به‌روزرسانی نسخه ${p} ';
	@override String get autoDownloadPkg => 'دانلود خودکار بسته‌های به‌روزرسانی';
	@override String get devOptions => 'تنظیمات توسعه‌دهندگان';
	@override String get about => 'درباره';
	@override String get name => 'نام';
	@override String get version => 'نسخه';
	@override String get notice => 'اطلاعیه';
	@override String get sort => 'مرتب‌سازی';
	@override String get recommended => 'پیشنهادی';
	@override String innerError({required Object p}) => 'خطای داخلی: ${p}';
	@override String get share => 'اشتراک گذاری';
	@override String get importFromClipboard => 'افزودن از کلیپ‌برد';
	@override String get exportToClipboard => 'صادرات به کلیپ بورد';
	@override String get server => 'سرور';
	@override String get port => 'بندر';
	@override String get donate => 'اهدا کنید';
	@override String get setting => 'تنظیمات';
	@override String get settingCore => 'تنظیمات اصلی';
	@override String get settingApp => 'تنظیمات برنامه';
	@override String get coreOverwrite => 'Core Override';
	@override String get iCloud => 'iCloud';
	@override String get webdav => 'Webdav';
	@override String get lanSync => 'LAN Sync';
	@override String get lanSyncNotQuitTips => 'قبل از تکمیل همگام‌سازی از این قسمت خارج نشوید';
	@override String get deviceNoSpace => 'فضای خالی کافی ندارید';
	@override String get hideSystemApp => 'برنامه های سیستم را مخفی کنید';
	@override String get hideAppIcon => 'پنهان کردن نماد برنامه';
	@override String get openDir => 'بازکردن دایرکتوری فایل';
	@override String get type => 'نوع';
	@override String get fileChoose => 'انتخاب فایل';
	@override String get filePathCannotEmpty => 'مسیر فایل نمی‌تواند خالی باشد';
	@override String fileNotExist({required Object p}) => 'فایل وجود ندارد:${p}';
	@override String fileTypeInvalid({required Object p}) => 'نوع فایل نامعتبر:${p}';
	@override String get uwpExemption => 'معافیت جداسازی شبکه UWP';
	@override String get getProfile => 'پیکربندی را دریافت کنید';
	@override String get buyProfile => 'خرید پروفایل';
	@override String get addProfile => 'افزودن پروفایل';
	@override String get myProfiles => 'پروفایل‌ها';
	@override String get profileEdit => 'ویرایش پروفایل';
	@override String get profileNeedActive => 'ابتدا این پروفایل را به‌عنوان پروفایل فعلی تنظیم کنید، سپس اتصال را فعال/دوباره متصل کنید';
	@override String get profileDownloadBackupChannel => 'فعال‌سازی کانال دانلود پشتیبان';
	@override String get profileDownloadBackupChannelTips => 'کانال دانلود پراکسی ارائه‌شده توسط Clash Mi (هیچ اطلاعاتی ذخیره نمی‌شود)';
	@override String get profileEditReloadAfterProfileUpdate => 'بارگذاری مجدد پس‌از به‌روزرسانی پروفایل';
	@override String get profileRulesAppendApplePush => 'افزودن قوانین اعلان‌های Push اپل';
	@override String get profileRulesAppendProxyTips => 'قوانین به‌صورت خودکار روی نخستین پراکسی با نوع [url-test] یا [select] در [proxy-groups] پیکربندی اصلی تنظیم می‌شوند';
	@override String get profileImport => 'وارد‌کردن فایل پروفایل';
	@override String get profileAddUrlOrContent => 'افزودن لینک پروفایل';
	@override String get profileUrlOrContent => 'پیوند پیکربندی Clash';
	@override String get profileUrlOrContentHit => 'پیوند پیکربندی Clash [الزامی]';
	@override String get profileUrlOrContentCannotEmpty => 'لینک پروفایل نمی‌تواند خالی باشد';
}

// Path: permission
class _Translations$permission$fa implements Translations$permission$en {
	_Translations$permission$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get camera => 'دوربین';
	@override String get screen => 'ضبط صفحه';
	@override String get appQuery => 'Get Application List';
	@override String request({required Object p}) => 'مجوزهای [${p}] را فعال کنید';
	@override String requestNeed({required Object p}) => 'لطفاً مجوز [${p}] را فعال کنید';
}

// Path: tls
class _Translations$tls$fa implements Translations$tls$en {
	_Translations$tls$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get insecure => 'رد شدن از تأیید گواهی';
	@override String get certificate => 'گواهی';
	@override String get privateKey => 'کلید خصوصی';
	@override String get customTrustCert => 'گواهی های سفارشی';
}

// Path: tun
class _Translations$tun$fa implements Translations$tun$en {
	_Translations$tun$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get stack => 'پشته شبکه';
	@override String get inet4Address => 'محدوده آدرس IPv4';
	@override String get inet6Address => 'محدوده آدرس IPv6';
	@override String get dnsHijack => 'ربودن DNS';
	@override String get strictRoute => 'مسیریابی دقیق';
	@override String get tunDefaultRoute => 'مسیر پیش‌فرض';
	@override String get icmpForward => 'ارسال ICMP';
	@override String get allowBypass => 'به برنامه‌ها اجازه دهید VPN را دور بزنند';
	@override String get appendHttpProxy => 'پیوست دادن پروکسی HTTP به وی‌پی‌ان';
	@override String get bypassHttpProxyDomain => 'دامنه ها مجاز به دور زدن پروکسی HTTP هستند';
}

// Path: dns
class _Translations$dns$fa implements Translations$dns$en {
	_Translations$dns$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get listen => 'آدرس گوش دادن';
	@override String get fakeIp => 'fake-ip';
	@override String get fallback => 'Fallback';
	@override String get preferH3 => 'اولویت DoH H3';
	@override String get useHosts => 'استفاده از هاست ها';
	@override String get useSystemHosts => 'استفاده از هاست های سیستم';
	@override String get enhancedMode => 'حالت پیشرفته';
	@override String get fakeIPFilterMode => 'حالت فیلتر ${_root.dns.fakeIp}';
	@override String get fakeIPFilter => 'فیلتر ${_root.dns.fakeIp}';
	@override String get respectRules => 'رعایت قوانین';
	@override String get nameServer => 'سرور DNS';
	@override String get defaultNameServer => '${_root.meta.byDefault} ${_root.dns.nameServer}';
	@override String get proxyNameServer => '${_root.meta.proxy} ${_root.dns.nameServer}';
	@override String get directNameServer => '${_root.meta.direct} ${_root.dns.nameServer}';
	@override String get fallbackNameServer => '${_root.dns.fallback} ${_root.dns.nameServer}';
	@override String get fallbackGeoIp => '${_root.dns.fallback} GeoIp';
	@override String get fallbackGeoIpCode => '${_root.dns.fallback} GeoIpCode';
}

// Path: sniffer
class _Translations$sniffer$fa implements Translations$sniffer$en {
	_Translations$sniffer$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get overrideDest => 'پوشش';
}

// Path: profilePatchMode
class _Translations$profilePatchMode$fa implements Translations$profilePatchMode$en {
	_Translations$profilePatchMode$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get currentSelected => 'فعلی انتخاب شده';
	@override String get overwrite => 'Overwrite داخلی';
	@override String get noOverwrite => 'داخلی - رونویسی نشده است';
}

// Path: main.tray
class _Translations$main$tray$fa implements Translations$main$tray$en {
	_Translations$main$tray$fa._(this._root);

	final TranslationsFa _root; // ignore: unused_field

	// Translations
	@override String get menuOpen => 'بازکردن';
	@override String get menuExit => 'بستن';
}

/// The flat map containing all translations for locale <fa>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsFa {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'BackupAndSyncWebdavScreen.webdavServerUrl' => 'آدرس URL سرور',
			'BackupAndSyncWebdavScreen.webdavRequired' => 'نمی‌تواند خالی باشد',
			'BackupAndSyncWebdavScreen.webdavLoginFailed' => 'ورود ناموفق بود:',
			'BackupAndSyncWebdavScreen.webdavListFailed' => 'دریافت لیست فایل ناموفق بود:',
			'LaunchFailedScreen.invalidProcess' => 'اجرای نرم‌افزار ناموفق بود [نام‌ اجرایی پروسه نامعتبر]، لطفا مجدد نرم‌افزار را در دایرکتوری دیگری نصب کنید',
			'LaunchFailedScreen.invalidProfile' => 'اجرای نرم‌افزار ناموفق بود [دسترسی به پروفایل ناموفق بود]، لطفا مجدد نرم افزار را نصب کنید',
			'LaunchFailedScreen.invalidVersion' => 'اجرای نرم‌افزار ناموفق بود [ورژن نامعتبر]، لطفا مجدد نرم‌افزار را نصب کنید',
			'LaunchFailedScreen.systemVersionLow' => 'راه اندازی برنامه ناموفق بود [نسخه سیستم خیلی کم است]',
			'LaunchFailedScreen.invalidInstallPath' => 'مسیر نصب نامعتبر است، لطفا مجدد در مسیر معتبر نصب کنید',
			'PerAppAndroidScreen.title' => 'پروکسی به‌تفکیک برنامه',
			'PerAppAndroidScreen.whiteListMode' => 'حالت لیست سفید',
			'PerAppAndroidScreen.whiteListModeTip' => 'وقتی فعال باشد: فقط برنامه‌هایی که انتخاب شده‌اند پروکسی می‌شوند؛ وقتی فعال نباشد: فقط برنامه‌هایی که انتخاب نشده‌اند پروکسی می‌شوند',
			'UserAgreementScreen.privacyFirst' => 'حریم‌خصوصی شما اولویت دارد',
			'UserAgreementScreen.agreeAndContinue' => 'پذیرفتن و ادامه',
			'NetCheckScreen.enterDomain' => 'لطفاً نام دامنه را وارد کنید',
			'NetCheckScreen.checking' => 'در حال بررسی...',
			'NetCheckScreen.aQueryFailed' => ({required Object p}) => 'خطا در پرس‌وجوی A: ${p}',
			'NetCheckScreen.aaaaQueryFailed' => ({required Object p}) => 'خطا در پرس‌وجوی AAAA: ${p}',
			'NetCheckScreen.success' => 'موفق',
			'NetCheckScreen.failed' => 'ناموفق',
			'NetCheckScreen.suspectedPollution' => 'مشکوک به مسمومیت DNS',
			'NetCheckScreen.domainLabel' => 'دامنه',
			'NetCheckScreen.checkButton' => 'بررسی',
			'NetCheckScreen.dnsSection' => '1. پرس‌وجوی DNS',
			'NetCheckScreen.directHttpSection' => '2. HTTP (از طریق TUN، ابتدا TUN را فعال کنید)',
			'NetCheckScreen.proxyHttpSection' => ({required Object p}) => '3. HTTP (از طریق پروکسی، پورت: ${p})',
			'NetCheckScreen.tunNotEnabled' => 'TUN فعال نیست',
			'NetCheckScreen.routeTableSection' => '4. جدول مسیریابی',
			'VersionUpdateScreen.versionReady' => ({required Object p}) => 'نسخه جدید [${p}] آماده است',
			'VersionUpdateScreen.update' => 'راه‌اندازی مجدد برای به‌روزرسانی',
			'VersionUpdateScreen.cancel' => 'الان‌ نه',
			'loginScreen.login' => 'ورود',
			'loginScreen.register' => 'ایجاد حساب',
			'loginScreen.forgotPassword' => 'فراموشی رمز عبور',
			'loginScreen.provider' => 'ارائه دهنده خدمات',
			'loginScreen.providerName' => 'کد/نام مستعار/URL ${_root.loginScreen.provider}',
			'loginScreen.providerNameRequired' => 'لطفا کد/نام مستعار/URL ${_root.loginScreen.provider} را وارد کنید',
			'loginScreen.account' => 'حساب',
			'loginScreen.accountRequired' => 'لطفا حساب را وارد کنید',
			'loginScreen.email' => 'ایمیل',
			'loginScreen.emailRequired' => 'لطفا آدرس ایمیل را وارد کنید',
			'loginScreen.password' => 'رمز عبور',
			'loginScreen.passwordRequired' => 'لطفا رمز عبور را وارد کنید',
			'loginScreen.validEmailRequired' => 'لطفا یک آدرس ایمیل معتبر وارد کنید',
			'loginScreen.passwordMinLength' => ({required Object minLength}) => 'طول رمز عبور باید حداقل ${minLength} کاراکتر باشد',
			'loginScreen.unsupportedProvider' => '${_root.loginScreen.provider} پشتیبانی نمی شود',
			'loginScreen.unsupportedProviderType' => 'نوع ${_root.loginScreen.provider} پشتیبانی نمی شود',
			'loginScreen.unActivedProvider' => 'قابلیت ورود فعال نشده است',
			'loginScreen.providerLoginSupportRequired' => ({required Object p}) => 'لطفاً کد/نام مستعار ارائه‌دهنده را از ${_root.loginScreen.provider} دریافت کنید.\nبرای راهنمای اتصال ${_root.loginScreen.provider} به این لینک مراجعه کنید: ${p}',
			'loginScreen.providerDisclaimer' => 'سلب مسئولیت: ${_root.loginScreen.provider} یک سرویس شخص ثالث است و ارتباطی با این برنامه ندارد',
			'main.tray.menuOpen' => 'بازکردن',
			'main.tray.menuExit' => 'بستن',
			'meta.enable' => 'فعال‌سازی',
			'meta.disable' => 'غیرفعال',
			'meta.open' => 'باز کن',
			'meta.close' => 'بسته',
			'meta.quit' => 'خروج',
			'meta.add' => 'افزودن',
			'meta.addSuccess' => 'با‌موفقیت اضافه شد',
			'meta.addFailed' => ({required Object p}) => 'افزودن ناموفق بود:${p}',
			'meta.remove' => 'حذف',
			'meta.removeConfirm' => 'آیا از حذف اطمینان دارین؟',
			'meta.edit' => 'ویرایش کنید',
			'meta.view' => 'بررسی',
			'meta.remark' => 'ملاحضات',
			'meta.byDefault' => 'پیش‌فرض',
			'meta.editRemark' => 'یادداشت های اصلاحی',
			'meta.more' => 'بیشتر',
			'meta.tips' => 'اطلاعات',
			'meta.selectAll' => 'انتخاب همه',
			'meta.copy' => 'کپی',
			'meta.paste' => 'چسباندن',
			'meta.cut' => 'برش',
			'meta.save' => 'ذخیره کنید',
			'meta.ok' => 'خُب',
			'meta.cancel' => 'لغو',
			'meta.faq' => 'سوالات متداول',
			'meta.doc' => 'سند',
			'meta.htmlTools' => 'مجموعه ابزارهای HTML',
			'meta.download' => 'دانلود',
			'meta.loading' => 'درحال بارگذاری…',
			'meta.days' => 'روز',
			'meta.hours' => 'ساعت',
			'meta.minutes' => 'دقیقه',
			'meta.seconds' => 'دومین',
			'meta.milliseconds' => 'میلی‌ثانیه',
			'meta.protocol' => 'پروتکل',
			'meta.search' => 'جستجو',
			'meta.custom' => 'سفارشی',
			'meta.connect' => 'اتصال',
			'meta.disconnect' => 'قطع‌ اتصال',
			'meta.connected' => 'وصل شد',
			'meta.disconnected' => 'قطع شد',
			'meta.connecting' => 'درحال اتصال',
			'meta.connectTimeout' => 'اتمام مهلت اتصال',
			'meta.timeout' => 'تایم اوت',
			'meta.timeoutDuration' => 'مدت زمان وقفه',
			'meta.latency' => 'تاخیر',
			'meta.latencyTest' => 'بررسی تاخیر',
			'meta.networkCheck' => 'بررسی شبکه',
			'meta.language' => 'زبان',
			'meta.next' => 'بعدی',
			'meta.done' => 'انجام‌شد',
			'meta.apply' => 'درخواست دادن',
			'meta.refresh' => 'بارگذاری مجدد',
			'meta.retry' => 'دوباره امتحان کنید؟',
			'meta.update' => 'تجدید',
			'meta.updateInterval' => 'فاصله‌ی به‌روزرسانی',
			'meta.updateInterval5mTips' => 'حداقل: 5 متر',
			'meta.updateIntervalPreferByProfile' => 'اولویت با تنظیمات ارائه‌دهنده',
			'meta.updateFailed' => ({required Object p}) => 'به‌روزرسانی ناموفق بود:${p}',
			'meta.none' => 'هیچ‌کدام',
			'meta.reset' => 'ریست',
			'meta.authentication' => 'مجوز',
			'meta.submit' => 'ارسال',
			'meta.user' => 'کاربر',
			'meta.account' => 'نام‌کاربری',
			'meta.password' => 'رمز‌عبور',
			'meta.decryptPassword' => 'دکريپت رمز‌عبور',
			'meta.required' => 'الزامی',
			'meta.go' => 'ادامه',
			'meta.sudoPassword' => 'رمز عبور sudo (برای حالت TUN لازم است)',
			'meta.other' => 'دیگر',
			'meta.dns' => 'DNS',
			'meta.url' => 'URL',
			'meta.urlInvalid' => 'URL نامعتبر',
			'meta.urlCannotEmpty' => 'لینک نمی‌تواند خالی باشد',
			'meta.urlTooLong' => 'URL خیلی طولانی است (>8182)',
			'meta.copyUrl' => 'کپی‌کردن لینک',
			'meta.openUrl' => 'بازکردن لینک',
			'meta.shareUrl' => 'اشتراک لینک',
			'meta.coreSettingTips' => 'توجه: پس از تغییر پیکربندی، باید دوباره وصل شوید تا اعمال شود',
			'meta.overwrite' => 'لغو',
			'meta.overwriteCustom' => 'لغوهای سفارشی',
			'meta.overwriteAppend' => 'لغو الحاقی',
			'meta.overwriteTips' => 'پیکربندی اصلی <- لغو سفارشی <- لغو برنامه',
			'meta.noOverwrite' => 'رونویسی نکنید',
			'meta.overwriteSettings' => 'لغو تنظیمات',
			'meta.diversionTemplates' => 'الگوی تریاژ',
			'meta.ruleProviders' => 'ارائه دهنده قانون',
			'meta.ruleTemplates' => 'الگوی قانون',
			'meta.proxyGroupsTemplates' => 'الگوی گروه نمایندگان',
			'meta.proxyGroups' => 'گروه نمایندگان',
			'meta.proxyNodeList' => 'فهرست گره‌های پروکسی',
			'meta.proxyNodeFailure' => ({required Object p}) => 'گره‌های پروکسی زیر منقضی شده و به طور خودکار حذف شده‌اند: ${p}',
			'meta.externalController' => 'کنترل خارجی',
			'meta.secret' => 'Secret',
			'meta.tcpConcurrent' => 'دست دادن همزمان TCP',
			'meta.globalClientFingerprint' => 'اثر انگشت جهانی TLS',
			'meta.allowLanAccess' => 'دسترسی به دستگاه LAN',
			'meta.mixedPort' => 'پورت پروکسی هیبریدی',
			'meta.logLevel' => 'سطح ورود به سیستم',
			'meta.findProcessMode' => 'حالت تطابق فرآیند',
			'meta.tcpkeepAliveInterval' => 'فاصله حفظ زنده TCP',
			'meta.delayTestUrl' => 'URL تست تأخیر',
			'meta.delayTestTimeout' => 'مهلت زمانی تست تاخیری (میلی‌ثانیه)',
			'meta.tun' => 'TUN',
			'meta.ntp' => 'NTP',
			'meta.tls' => 'TLS',
			'meta.geo' => 'GEO',
			'meta.geoDownloadByProxy' => 'دانلود Geo RuleSet با استفاده از یک پروکسی',
			'meta.geoRulesetTips' => 'Geosite/Geoip به RuleSet مربوطه تبدیل می شود',
			'meta.asnNotSupportInIosTips' => 'با توجه به محدودیت‌های حافظه سیستم iOS، قوانین IP-ASN و SRC-IP-ASN در iOS نادیده گرفته می‌شوند.',
			'meta.sniffer' => 'بو کشیدن',
			'meta.userAgent' => 'UserAgent',
			'meta.launchAtStartup' => 'اجرا در راه‌اندازی',
			'meta.launchAtStartupRunAsAdmin' => 'لطفاً Clash Mi را به عنوان مدیر راه اندازی مجدد کنید',
			'meta.tunModeRunAsAdmin' => 'حالت TUN نیازمند مجوز مدیر سیستم می‌باشد لطفا نرم‌افزار را مجدد با حالت مدیر (administrator) راه‌اندازی کنید',
			'meta.portableMode' => 'حالت قابل‌حمل',
			'meta.portableModeDisableTips' => 'اگر نیاز دارین از حالت قابل‌حمل خارج شوید لطفا از [clashmi] خارج شده و به‌صورت دستی پوشه [portable] هم مسیر با فایل [clashmi.exe] را حذف کنید',
			'meta.systemProxy' => 'پروکسی سیستم',
			'meta.autoConnectAfterLaunch' => 'اتصال خودکار پس‌از راه‌اندازی',
			'meta.autoConnectAtBoot' => 'اتصال خودکار پس از روشن شدن سیستم',
			'meta.autoConnectAtBootTips' => 'پشتیبانی سیستم مورد نیاز است؛ برخی سیستم‌ها ممکن است نیاز به فعال بودن [شروع خودکار] نیز داشته باشند.',
			'meta.hideAfterLaunch' => 'پنهان کردن پنجره پس از راه اندازی',
			'meta.autoSetSystemProxy' => 'تنظیم خودکار حالت پروکسی سیستم پس‌از اتصال',
			'meta.bypassSystemProxy' => 'نام های دامنه ای که مجاز به دور زدن پراکسی سیستم هستند',
			'meta.excludeFromRecent' => 'پنهان شدن از وظایف اخیر',
			'meta.hideDockIcon' => 'پنهان کردن آیکون داک',
			'meta.showTrayTraffic' => 'نمایش اطلاعات ترافیک در سینی سیستم',
			'meta.wakeLock' => 'قفل بیدارباش',
			'meta.hideVpn' => 'مخفی کردن آیکون VPN',
			'meta.hideVpnTips' => 'فعال کردن IPv6 باعث از کار افتادن این عملکرد خواهد شد.',
			'meta.website' => 'وبسایت',
			'meta.homePage' => 'صفحه اصلی',
			'meta.rule' => 'قانون',
			'meta.global' => 'عمومی',
			'meta.direct' => 'مستقیم',
			'meta.block' => 'مسدود',
			'meta.qrcode' => 'کد QR',
			'meta.qrcodeTooLong' => 'متن برای نمایش خیلی طولانی است',
			'meta.qrcodeShare' => 'اشتراک کدQR',
			'meta.textToQrcode' => 'متن به کد QR',
			'meta.qrcodeScan' => 'اسکن QRکد',
			'meta.qrcodeScanResult' => 'نتایج اسکن',
			'meta.qrcodeScanFromImage' => 'اسکن از عکس',
			'meta.qrcodeScanResultFailed' => 'تجزیه عکس ناموفق بود، لطفا مطمعن شوید اسکرین‌شات یک کدQR معتبر است',
			'meta.qrcodeScanResultEmpty' => 'نتیجه اسکن خالی است',
			'meta.screenshot' => 'اسکرین‌شات',
			'meta.backupAndSync' => 'پشتیبان‌گیری و همگام‌سازی',
			'meta.importSuccess' => 'افزودن موفق بود',
			'meta.rewriteConfirm' => 'این فایل کانفیگ‌های محلی موجود را بازنویسی می‌کند. آیا می‌خواهید ادامه بدین؟',
			'meta.importAndExport' => 'وارد‌کردن و خروجی‌گرفتن',
			'meta.import' => 'وارد‌کردن',
			'meta.importFromUrl' => 'وارد کردن از URL',
			'meta.export' => 'خروجی‌گرفتن',
			'meta.send' => 'ارسال کنید',
			'meta.receive' => 'تصاحب',
			'meta.sendConfirm' => 'ارسال را تایید کرد؟',
			'meta.continueConnectConfirm' => 'آیا اتصال ادامه یابد؟',
			'meta.termOfUse' => 'شرایط استفاده',
			'meta.privacyPolicy' => 'سیاست حریم خصوصی',
			'meta.log' => 'ورود به سیستم',
			'meta.coreLog' => 'گزارش هسته',
			'meta.core' => 'هسته',
			'meta.help' => 'کمک کند',
			'meta.tutorial' => 'آموزش',
			'meta.board' => 'پانل',
			'meta.boardOnline' => 'با استفاده از پنل آنلاین',
			'meta.boardOnlineUrl' => 'آدرس پنل آنلاین',
			'meta.boardLocalPort' => 'پورت پانل محلی',
			'meta.alwayOnVPN' => 'اتصال همیشه باز',
			'meta.disableFontScaler' => 'غیرفعال‌سازی مقیاس‌بندی فونت(با راه‌اندازی مجدد اعمال می‌شود)',
			'meta.autoOrientation' => 'چرخش صفحه را دنبال کنید',
			'meta.restartTakesEffect' => 'با راه‌اندازی مجدد اعمال می‌شود',
			'meta.reconnectTakesEffect' => 'پس از اتصال مجدد، اعمال خواهد شد.',
			'meta.runtimeProfile' => 'پیکربندی زمان اجرا',
			'meta.willCompleteAfterRebootInstall' => 'لطفاً دستگاه خود را مجدداً راه اندازی کنید تا نصب افزونه سیستم تکمیل شود.',
			'meta.willCompleteAfterRebootUninstall' => 'لطفاً دستگاه خود را مجدداً راه‌اندازی کنید تا حذف نصب افزونه سیستم تکمیل شود',
			'meta.requestNeedsUserApproval' => '۱. لطفاً به Clash Mi اجازه دهید افزونه‌های سیستمی را در [تنظیمات سیستم] - [حریم خصوصی و امنیت] نصب کند. ۲. : [تنظیمات سیستم] - [عمومی] - [موارد ورود و افزونه‌ها - افزونه‌های شبکه] [clashmiServiceSE] را فعال کنید. پس از اتمام، دوباره متصل شوید.',
			'meta.FullDiskAccessPermissionRequired' => 'لطفاً مجوز clashmiServiceSE را در [تنظیمات سیستم]-[حریم خصوصی و امنیت]-[دسترسی کامل به دیسک] فعال کنید و دوباره متصل شوید.',
			'meta.proxy' => 'بازیگری',
			'meta.theme' => 'موضوع',
			'meta.tvMode' => 'حالت تلویزیون',
			'meta.autoUpdate' => 'به روز رسانی خودکار',
			'meta.updateChannel' => 'کانال به‌روزرسانی خودکار',
			'meta.onlineCustomerService' => 'پشتیبانی آنلاین',
			'meta.subscriptionChannel' => 'کانال اشتراک',
			'meta.hasNewVersion' => ({required Object p}) => 'به‌روزرسانی نسخه ${p} ',
			'meta.autoDownloadPkg' => 'دانلود خودکار بسته‌های به‌روزرسانی',
			'meta.devOptions' => 'تنظیمات توسعه‌دهندگان',
			'meta.about' => 'درباره',
			'meta.name' => 'نام',
			'meta.version' => 'نسخه',
			'meta.notice' => 'اطلاعیه',
			'meta.sort' => 'مرتب‌سازی',
			'meta.recommended' => 'پیشنهادی',
			'meta.innerError' => ({required Object p}) => 'خطای داخلی: ${p}',
			'meta.share' => 'اشتراک گذاری',
			'meta.importFromClipboard' => 'افزودن از کلیپ‌برد',
			'meta.exportToClipboard' => 'صادرات به کلیپ بورد',
			'meta.server' => 'سرور',
			'meta.port' => 'بندر',
			'meta.donate' => 'اهدا کنید',
			'meta.setting' => 'تنظیمات',
			'meta.settingCore' => 'تنظیمات اصلی',
			'meta.settingApp' => 'تنظیمات برنامه',
			'meta.coreOverwrite' => 'Core Override',
			'meta.iCloud' => 'iCloud',
			'meta.webdav' => 'Webdav',
			'meta.lanSync' => 'LAN Sync',
			'meta.lanSyncNotQuitTips' => 'قبل از تکمیل همگام‌سازی از این قسمت خارج نشوید',
			'meta.deviceNoSpace' => 'فضای خالی کافی ندارید',
			'meta.hideSystemApp' => 'برنامه های سیستم را مخفی کنید',
			'meta.hideAppIcon' => 'پنهان کردن نماد برنامه',
			'meta.openDir' => 'بازکردن دایرکتوری فایل',
			'meta.type' => 'نوع',
			'meta.fileChoose' => 'انتخاب فایل',
			'meta.filePathCannotEmpty' => 'مسیر فایل نمی‌تواند خالی باشد',
			'meta.fileNotExist' => ({required Object p}) => 'فایل وجود ندارد:${p}',
			'meta.fileTypeInvalid' => ({required Object p}) => 'نوع فایل نامعتبر:${p}',
			'meta.uwpExemption' => 'معافیت جداسازی شبکه UWP',
			'meta.getProfile' => 'پیکربندی را دریافت کنید',
			'meta.buyProfile' => 'خرید پروفایل',
			'meta.addProfile' => 'افزودن پروفایل',
			'meta.myProfiles' => 'پروفایل‌ها',
			'meta.profileEdit' => 'ویرایش پروفایل',
			'meta.profileNeedActive' => 'ابتدا این پروفایل را به‌عنوان پروفایل فعلی تنظیم کنید، سپس اتصال را فعال/دوباره متصل کنید',
			'meta.profileDownloadBackupChannel' => 'فعال‌سازی کانال دانلود پشتیبان',
			'meta.profileDownloadBackupChannelTips' => 'کانال دانلود پراکسی ارائه‌شده توسط Clash Mi (هیچ اطلاعاتی ذخیره نمی‌شود)',
			'meta.profileEditReloadAfterProfileUpdate' => 'بارگذاری مجدد پس‌از به‌روزرسانی پروفایل',
			'meta.profileRulesAppendApplePush' => 'افزودن قوانین اعلان‌های Push اپل',
			'meta.profileRulesAppendProxyTips' => 'قوانین به‌صورت خودکار روی نخستین پراکسی با نوع [url-test] یا [select] در [proxy-groups] پیکربندی اصلی تنظیم می‌شوند',
			'meta.profileImport' => 'وارد‌کردن فایل پروفایل',
			'meta.profileAddUrlOrContent' => 'افزودن لینک پروفایل',
			'meta.profileUrlOrContent' => 'پیوند پیکربندی Clash',
			'meta.profileUrlOrContentHit' => 'پیوند پیکربندی Clash [الزامی]',
			'meta.profileUrlOrContentCannotEmpty' => 'لینک پروفایل نمی‌تواند خالی باشد',
			'permission.camera' => 'دوربین',
			'permission.screen' => 'ضبط صفحه',
			'permission.appQuery' => 'Get Application List',
			'permission.request' => ({required Object p}) => 'مجوزهای [${p}] را فعال کنید',
			'permission.requestNeed' => ({required Object p}) => 'لطفاً مجوز [${p}] را فعال کنید',
			'tls.insecure' => 'رد شدن از تأیید گواهی',
			'tls.certificate' => 'گواهی',
			'tls.privateKey' => 'کلید خصوصی',
			'tls.customTrustCert' => 'گواهی های سفارشی',
			'tun.stack' => 'پشته شبکه',
			'tun.inet4Address' => 'محدوده آدرس IPv4',
			'tun.inet6Address' => 'محدوده آدرس IPv6',
			'tun.dnsHijack' => 'ربودن DNS',
			'tun.strictRoute' => 'مسیریابی دقیق',
			'tun.tunDefaultRoute' => 'مسیر پیش‌فرض',
			'tun.icmpForward' => 'ارسال ICMP',
			'tun.allowBypass' => 'به برنامه‌ها اجازه دهید VPN را دور بزنند',
			'tun.appendHttpProxy' => 'پیوست دادن پروکسی HTTP به وی‌پی‌ان',
			'tun.bypassHttpProxyDomain' => 'دامنه ها مجاز به دور زدن پروکسی HTTP هستند',
			'dns.listen' => 'آدرس گوش دادن',
			'dns.fakeIp' => 'fake-ip',
			'dns.fallback' => 'Fallback',
			'dns.preferH3' => 'اولویت DoH H3',
			'dns.useHosts' => 'استفاده از هاست ها',
			'dns.useSystemHosts' => 'استفاده از هاست های سیستم',
			'dns.enhancedMode' => 'حالت پیشرفته',
			'dns.fakeIPFilterMode' => 'حالت فیلتر ${_root.dns.fakeIp}',
			'dns.fakeIPFilter' => 'فیلتر ${_root.dns.fakeIp}',
			'dns.respectRules' => 'رعایت قوانین',
			'dns.nameServer' => 'سرور DNS',
			'dns.defaultNameServer' => '${_root.meta.byDefault} ${_root.dns.nameServer}',
			'dns.proxyNameServer' => '${_root.meta.proxy} ${_root.dns.nameServer}',
			'dns.directNameServer' => '${_root.meta.direct} ${_root.dns.nameServer}',
			'dns.fallbackNameServer' => '${_root.dns.fallback} ${_root.dns.nameServer}',
			'dns.fallbackGeoIp' => '${_root.dns.fallback} GeoIp',
			'dns.fallbackGeoIpCode' => '${_root.dns.fallback} GeoIpCode',
			'sniffer.overrideDest' => 'پوشش',
			'profilePatchMode.currentSelected' => 'فعلی انتخاب شده',
			'profilePatchMode.overwrite' => 'Overwrite داخلی',
			'profilePatchMode.noOverwrite' => 'داخلی - رونویسی نشده است',
			'protocolSniff' => 'تشخیص پروتکل',
			'protocolSniffOverrideDestination' => 'نام دامنه شناسایی شده آدرس هدف اتصال را پوشش می دهد',
			'edgeRuntimeNotInstalled' => 'زمان اجرا Edge WebView2 روی دستگاه فعلی نصب نشده است و صفحه قابل نمایش نیست لطفاً زمان اجرا Edge WebView2 (x64) را بارگیری و نصب کنید، برنامه را مجدداً راه اندازی کنید و دوباره امتحان کنید.',
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
