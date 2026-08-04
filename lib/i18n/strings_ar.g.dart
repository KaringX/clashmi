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
class TranslationsAr with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsAr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ar>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsAr _root = this; // ignore: unused_field

	@override 
	TranslationsAr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsAr(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$BackupAndSyncWebdavScreen$ar BackupAndSyncWebdavScreen = _Translations$BackupAndSyncWebdavScreen$ar._(_root);
	@override late final _Translations$LaunchFailedScreen$ar LaunchFailedScreen = _Translations$LaunchFailedScreen$ar._(_root);
	@override late final _Translations$PerAppAndroidScreen$ar PerAppAndroidScreen = _Translations$PerAppAndroidScreen$ar._(_root);
	@override late final _Translations$UserAgreementScreen$ar UserAgreementScreen = _Translations$UserAgreementScreen$ar._(_root);
	@override late final _Translations$NetCheckScreen$ar NetCheckScreen = _Translations$NetCheckScreen$ar._(_root);
	@override late final _Translations$VersionUpdateScreen$ar VersionUpdateScreen = _Translations$VersionUpdateScreen$ar._(_root);
	@override late final _Translations$loginScreen$ar loginScreen = _Translations$loginScreen$ar._(_root);
	@override late final _Translations$main$ar main = _Translations$main$ar._(_root);
	@override late final _Translations$meta$ar meta = _Translations$meta$ar._(_root);
	@override late final _Translations$permission$ar permission = _Translations$permission$ar._(_root);
	@override late final _Translations$tls$ar tls = _Translations$tls$ar._(_root);
	@override late final _Translations$tun$ar tun = _Translations$tun$ar._(_root);
	@override late final _Translations$dns$ar dns = _Translations$dns$ar._(_root);
	@override late final _Translations$sniffer$ar sniffer = _Translations$sniffer$ar._(_root);
	@override late final _Translations$profilePatchMode$ar profilePatchMode = _Translations$profilePatchMode$ar._(_root);
	@override String get protocolSniff => 'الكشف عن البروتوكول';
	@override String get protocolSniffOverrideDestination => 'يغطي اسم المجال المكتشف عنوان هدف الاتصال';
	@override String get edgeRuntimeNotInstalled => 'لم يتم تثبيت وقت تشغيل Edge WebView2 على الجهاز الحالي ولا يمكن عرض الصفحة، يرجى تنزيل وتثبيت وقت تشغيل Edge WebView2 (x64)، وإعادة تشغيل التطبيق والمحاولة مرة أخرى.';
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
class _Translations$BackupAndSyncWebdavScreen$ar implements Translations$BackupAndSyncWebdavScreen$en {
	_Translations$BackupAndSyncWebdavScreen$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get webdavServerUrl => 'عنوان URL الخادم';
	@override String get webdavRequired => 'لايمكن ان يكون فارغا';
	@override String get webdavLoginFailed => 'فشل تسجيل الدخول:';
	@override String get webdavListFailed => 'فشل في الحصول على قائمة الملفات:';
}

// Path: LaunchFailedScreen
class _Translations$LaunchFailedScreen$ar implements Translations$LaunchFailedScreen$en {
	_Translations$LaunchFailedScreen$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get invalidProcess => 'فشل التطبيق في البدء [اسم عملية غير صالح] ، يرجى إعادة تثبيت التطبيق إلى دليل منفصل';
	@override String get invalidProfile => 'فشل التطبيق في البدء [فشل في الوصول إلى الملف الشخصي] ، يرجى إعادة تثبيت التطبيق';
	@override String get invalidVersion => 'فشل التطبيق في بدء [إصدار غير صالح] ، يرجى إعادة تثبيت التطبيق';
	@override String get systemVersionLow => 'فشل بدء تشغيل التطبيق [إصدار النظام منخفض جدًا]';
	@override String get invalidInstallPath => 'مسار التثبيت غير صالح ، يرجى إعادة تثبيته إلى مسار صالح';
}

// Path: PerAppAndroidScreen
class _Translations$PerAppAndroidScreen$ar implements Translations$PerAppAndroidScreen$en {
	_Translations$PerAppAndroidScreen$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'لكل وكيل تطبيق';
	@override String get whiteListMode => 'وضع القائمة البيضاء';
	@override String get whiteListModeTip => 'عند التمكين: فقط التطبيقات التي تم فحصها هي وكلاء ؛عندما لا يتم تمكينها: فقط التطبيقات التي لم يتم فحصها هي وكلاء';
}

// Path: UserAgreementScreen
class _Translations$UserAgreementScreen$ar implements Translations$UserAgreementScreen$en {
	_Translations$UserAgreementScreen$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get privacyFirst => 'خصوصيتك تأتي أولا';
	@override String get agreeAndContinue => 'قبول ومتابعة';
}

// Path: NetCheckScreen
class _Translations$NetCheckScreen$ar implements Translations$NetCheckScreen$en {
	_Translations$NetCheckScreen$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get enterDomain => 'أدخل اسم النطاق';
	@override String get checking => 'جارٍ الفحص...';
	@override String aQueryFailed({required Object p}) => 'فشل استعلام A: ${p}';
	@override String aaaaQueryFailed({required Object p}) => 'فشل استعلام AAAA: ${p}';
	@override String get success => 'نجاح';
	@override String get failed => 'فشل';
	@override String get suspectedPollution => 'يُشتبه في تسميم DNS';
	@override String get domainLabel => 'النطاق';
	@override String get checkButton => 'فحص';
	@override String get dnsSection => '1. استعلام DNS';
	@override String get directHttpSection => '2. HTTP (عبر TUN، يرجى تفعيل TUN أولاً)';
	@override String proxyHttpSection({required Object p}) => '3. HTTP (عبر الوكيل، المنفذ: ${p})';
	@override String get tunNotEnabled => 'TUN غير مفعّل';
	@override String get routeTableSection => '4. جدول التوجيه';
}

// Path: VersionUpdateScreen
class _Translations$VersionUpdateScreen$ar implements Translations$VersionUpdateScreen$en {
	_Translations$VersionUpdateScreen$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String versionReady({required Object p}) => 'الإصدار الجديد [${p}] جاهز';
	@override String get update => 'أعد التشغيل للتحديث';
	@override String get cancel => 'ليس الآن';
}

// Path: loginScreen
class _Translations$loginScreen$ar implements Translations$loginScreen$en {
	_Translations$loginScreen$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get login => 'دخول';
	@override String get register => 'إنشاء حساب';
	@override String get forgotPassword => 'هل نسيت كلمة المرور';
	@override String get provider => 'مزود الخدمة';
	@override String get providerName => 'رمز/اسم مستعار/URL لـ ${_root.loginScreen.provider}';
	@override String get providerNameRequired => 'يرجى إدخال الرمز/الاسم المستعار/URL لـ ${_root.loginScreen.provider}';
	@override String get account => 'حساب';
	@override String get accountRequired => 'يرجى إدخال الحساب';
	@override String get email => 'البريد الإلكتروني';
	@override String get emailRequired => 'يرجى إدخال عنوان بريدك الإلكتروني';
	@override String get password => 'كلمة المرور';
	@override String get passwordRequired => 'يرجى إدخال كلمة المرور';
	@override String get validEmailRequired => 'يرجى إدخال عنوان بريد إلكتروني صحيح';
	@override String passwordMinLength({required Object minLength}) => 'يجب أن تكون كلمة المرور ${minLength} أحرف على الأقل';
	@override String get unsupportedProvider => '${_root.loginScreen.provider} غير مدعوم';
	@override String get unsupportedProviderType => 'نوع ${_root.loginScreen.provider} غير مدعوم';
	@override String get unActivedProvider => 'ميزة تسجيل الدخول غير مفعلة';
	@override String providerLoginSupportRequired({required Object p}) => 'يرجى طلب رمز/اسم مستعار المزوّد من ${_root.loginScreen.provider}.\nللاطلاع على تكامل ${_root.loginScreen.provider}، راجع: ${p}';
	@override String get providerDisclaimer => 'إخلاء المسؤولية: ${_root.loginScreen.provider} هي خدمة تابعة لطرف ثالث ولا علاقة لها بهذا التطبيق';
}

// Path: main
class _Translations$main$ar implements Translations$main$en {
	_Translations$main$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _Translations$main$tray$ar tray = _Translations$main$tray$ar._(_root);
}

// Path: meta
class _Translations$meta$ar implements Translations$meta$en {
	_Translations$meta$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get enable => 'يُمكَِن';
	@override String get disable => 'إبطال';
	@override String get open => 'يفتح';
	@override String get close => 'إنهاء';
	@override String get quit => 'يترك';
	@override String get add => 'اضف إليه';
	@override String get addSuccess => 'اضيف بنجاح';
	@override String addFailed({required Object p}) => 'إضافة فشل:${p}';
	@override String get remove => 'يمسح';
	@override String get removeConfirm => 'هل انت متأكد من الحذف؟';
	@override String get edit => 'يحرر';
	@override String get view => 'يفحص';
	@override String get remark => 'ملاحظة';
	@override String get byDefault => 'تقصير';
	@override String get editRemark => 'ملاحظات التعديل';
	@override String get more => 'أكثر';
	@override String get tips => 'معلومات';
	@override String get selectAll => 'تحديد الكل';
	@override String get copy => 'ينسخ';
	@override String get paste => 'لصق';
	@override String get cut => 'يقطع';
	@override String get save => 'يحفظ';
	@override String get ok => 'نعم';
	@override String get cancel => 'يلغي';
	@override String get faq => 'أسئلة مكررة';
	@override String get doc => 'وثيقة';
	@override String get htmlTools => 'مجموعة أدوات HTML';
	@override String get download => 'تحميل';
	@override String get loading => 'تحميل...';
	@override String get days => 'أيام';
	@override String get hours => 'ساعات';
	@override String get minutes => 'دقائق';
	@override String get seconds => 'ثانية';
	@override String get milliseconds => 'ميلي ثانية';
	@override String get protocol => 'بروتوكول';
	@override String get search => 'يبحث';
	@override String get custom => 'مخصص';
	@override String get connect => 'يتصل';
	@override String get disconnect => 'قطع الاتصال';
	@override String get connected => 'متصل';
	@override String get disconnected => 'انقطع الاتصال';
	@override String get connecting => 'توصيل';
	@override String get connectTimeout => 'ربط مهلة';
	@override String get timeout => 'نفذ الوقت';
	@override String get timeoutDuration => 'مدة مهلة الانتظار';
	@override String get latency => 'تأخير';
	@override String get latencyTest => 'كشف التأخير';
	@override String get networkCheck => 'فحص الشبكة';
	@override String get language => 'لغة';
	@override String get next => 'التالي';
	@override String get done => 'منتهي';
	@override String get apply => 'يتقدم';
	@override String get refresh => 'ينعش';
	@override String get retry => 'إعادة المحاولة?';
	@override String get update => 'تجديد';
	@override String get updateInterval => 'الفاصل الزمني للتحديث';
	@override String get updateInterval5mTips => 'الحد الأدنى: 5 م';
	@override String get updateIntervalPreferByProfile => 'إعطاء الأولوية لإعدادات المزود';
	@override String updateFailed({required Object p}) => 'فشل التحديث:${p}';
	@override String get none => 'لا أحد';
	@override String get reset => 'إعادة ضبط';
	@override String get authentication => 'التفويض';
	@override String get submit => 'يُقدِّم';
	@override String get user => 'مستخدم';
	@override String get account => 'حساب';
	@override String get password => 'كلمة المرور';
	@override String get decryptPassword => 'فك تشفير كلمة المرور';
	@override String get required => 'مطلوب';
	@override String get go => 'متابعة';
	@override String get sudoPassword => 'كلمة مرور sudo (مطلوبة لوضع TUN)';
	@override String get other => 'آخر';
	@override String get dns => 'DNS';
	@override String get url => 'URL';
	@override String get urlInvalid => 'URL غير صالح';
	@override String get urlCannotEmpty => 'لا يمكن أن يكون الرابط فارغًا';
	@override String get urlTooLong => 'عنوان URL طويل جدًا (>8182)';
	@override String get copyUrl => 'نسخ الرابط';
	@override String get openUrl => 'فتح الرابط';
	@override String get shareUrl => 'شارك الرابط';
	@override String get coreSettingTips => 'ملاحظة: بعد تعديل التكوين، تحتاج إلى إعادة الاتصال حتى يسري مفعوله';
	@override String get overwrite => 'تجاوز';
	@override String get overwriteCustom => 'تجاوزات مخصصة';
	@override String get overwriteAppend => 'تجاوز إضافي';
	@override String get overwriteTips => 'التكوين الأصلي <- تجاوز مخصص <- تجاوز التطبيق';
	@override String get noOverwrite => 'لا تكتب فوق';
	@override String get overwriteSettings => 'تجاوز الإعدادات';
	@override String get diversionTemplates => 'نموذج الفرز';
	@override String get ruleProviders => 'موفر القواعد';
	@override String get ruleTemplates => 'نموذج القاعدة';
	@override String get proxyGroupsTemplates => 'نموذج مجموعة الوكلاء';
	@override String get proxyGroups => 'مجموعة الوكلاء';
	@override String get proxyNodeList => 'قائمة عقد الوكيل';
	@override String proxyNodeFailure({required Object p}) => 'انتهت صلاحية عقد الوكيل التالية وتمت إزالتها تلقائيًا: ${p}';
	@override String get externalController => 'الرقابة الخارجية';
	@override String get secret => 'Secret';
	@override String get tcpConcurrent => 'مصافحة TCP المتزامنة';
	@override String get globalClientFingerprint => 'بصمة TLS العالمية';
	@override String get allowLanAccess => 'الوصول إلى جهاز LAN';
	@override String get mixedPort => 'منفذ الوكيل الهجين';
	@override String get logLevel => 'مستوى السجل';
	@override String get findProcessMode => 'وضع مطابقة العملية';
	@override String get tcpkeepAliveInterval => 'فترة الحفاظ على اتصال TCP';
	@override String get delayTestUrl => 'عنوان URL لاختبار زمن الوصول';
	@override String get delayTestTimeout => 'تأخير مهلة الاختبار (مللي ثانية)';
	@override String get tun => 'TUN';
	@override String get ntp => 'NTP';
	@override String get tls => 'TLS';
	@override String get geo => 'GEO';
	@override String get geoDownloadByProxy => 'تنزيل Geo RuleSet باستخدام وكيل';
	@override String get geoRulesetTips => 'سيتم تحويل Geosite/Geoip إلى مجموعة القواعد المقابلة';
	@override String get asnNotSupportInIosTips => 'بسبب قيود ذاكرة نظام iOS، سيتم تجاهل قواعد IP-ASN وSRC-IP-ASN على نظام iOS.';
	@override String get sniffer => 'شم';
	@override String get userAgent => 'UserAgent';
	@override String get launchAtStartup => 'إطلاق عند بدء التشغيل';
	@override String get launchAtStartupRunAsAdmin => 'يرجى إعادة تشغيل Clash Mi كمسؤول';
	@override String get tunModeRunAsAdmin => 'يتطلب وضع TUN أذونات مسؤول النظام ، يرجى إعادة تشغيل التطبيق كمسؤول';
	@override String get portableMode => 'الوضع المحمول';
	@override String get portableModeDisableTips => 'إذا كنت بحاجة إلى الخروج من الوضع المحمول، فيرجى الخروج من [clashmi] وحذف المجلد [portable] يدويًا في نفس الدليل مثل [clashmi.exe]';
	@override String get systemProxy => 'وكيل النظام';
	@override String get autoConnectAfterLaunch => 'اتصال السيارات بعد الإطلاق';
	@override String get autoConnectAtBoot => 'الاتصال التلقائي بعد بدء تشغيل النظام';
	@override String get autoConnectAtBootTips => 'يجب دعم النظام؛ وقد تتطلب بعض الأنظمة أيضًا تمكين [البدء التلقائي].';
	@override String get hideAfterLaunch => 'إخفاء النافذة بعد بدء التشغيل';
	@override String get autoSetSystemProxy => 'وكيل نظام تعيين تلقائي عند الاتصال';
	@override String get bypassSystemProxy => 'أسماء النطاقات المسموح لها بتجاوز وكيل النظام';
	@override String get excludeFromRecent => 'إخفاء من المهام الأخيرة';
	@override String get wakeLock => 'قفل الاستيقاظ';
	@override String get hideVpn => 'إخفاء أيقونة VPN';
	@override String get hideVpnTips => 'سيؤدي تمكين IPv6 إلى فشل هذه الوظيفة';
	@override String get hideDockIcon => 'إخفاء أيقونة Dock';
	@override String get showTrayTraffic => 'إظهار معلومات حركة المرور في شريط النظام';
	@override String get website => 'موقع إلكتروني';
	@override String get homePage => 'الصفحة الرئيسية';
	@override String get rule => 'قاعدة';
	@override String get global => 'عالمي';
	@override String get direct => 'مباشر';
	@override String get block => 'حاجز';
	@override String get qrcode => 'رمز الاستجابة السريعة';
	@override String get qrcodeTooLong => 'النص طويل جدًا لعرضه';
	@override String get qrcodeShare => 'شارك رمز الاستجابة السريعة';
	@override String get textToQrcode => 'رسالة نصية إلى رمز الاستجابة السريعة';
	@override String get qrcodeScan => 'مسح رمز الاستجابة السريعة';
	@override String get qrcodeScanResult => 'نتيجة المسح';
	@override String get qrcodeScanFromImage => 'مسح من الصورة';
	@override String get qrcodeScanResultFailed => 'فشل في تحليل الصورة ، يرجى التأكد من أن لقطة الشاشة هي رمز QR صالح';
	@override String get qrcodeScanResultEmpty => 'نتيجة الفحص فارغة';
	@override String get screenshot => 'لقطة شاشة';
	@override String get backupAndSync => 'النسخ الاحتياطي والمزامنة';
	@override String get importSuccess => 'استيراد نجاح ';
	@override String get rewriteConfirm => 'سيقوم هذا الملف بكتابة التكوين المحلي الحالي.هل تريد الاستمرار؟';
	@override String get importAndExport => 'استيراد وتصدير';
	@override String get import => 'يستورد';
	@override String get importFromUrl => 'الاستيراد من عنوان URL';
	@override String get export => 'يصدّر';
	@override String get send => 'يرسل';
	@override String get receive => 'تولي';
	@override String get sendConfirm => 'تأكيد الإرسال؟';
	@override String get continueConnectConfirm => 'هل تريد متابعة الاتصال؟';
	@override String get termOfUse => 'شرط الخدمة';
	@override String get privacyPolicy => 'سياسة الخصوصية';
	@override String get log => 'سجل';
	@override String get coreLog => 'سجل النواة';
	@override String get core => 'جوهر';
	@override String get help => 'يساعد';
	@override String get tutorial => 'درس تعليمي';
	@override String get board => 'لوحة';
	@override String get boardOnline => 'استخدام اللوحة عبر الإنترنت';
	@override String get boardOnlineUrl => 'عنوان URL للوحة عبر الإنترنت';
	@override String get boardLocalPort => 'منفذ اللوحة المحلية';
	@override String get alwayOnVPN => 'اتصال مفتوح دائمًا';
	@override String get disableFontScaler => 'تعطيل تحجيم الخط(يسري مفعوله بعد إعادة التشغيل)';
	@override String get autoOrientation => 'Rotate with the screen';
	@override String get restartTakesEffect => 'Restart takes effect';
	@override String get reconnectTakesEffect => 'سيتم تطبيقه بعد إعادة الاتصال.';
	@override String get runtimeProfile => 'تكوين وقت التشغيل';
	@override String get willCompleteAfterRebootInstall => 'يرجى إعادة تشغيل جهازك لإكمال تثبيت توسيع النظام';
	@override String get willCompleteAfterRebootUninstall => 'يرجى إعادة تشغيل جهازك لإكمال إلغاء تثبيت ملحق النظام';
	@override String get requestNeedsUserApproval => '١. يُرجى السماح لـ Clash Mi بتثبيت ملحقات النظام من [إعدادات النظام] - [الخصوصية والأمان]. ٢. : [إعدادات النظام] - [عام] - [عناصر تسجيل الدخول والملحقات - ملحقات الشبكة] فعّل [clashmiServiceSE]. أعد الاتصال بعد الانتهاء.';
	@override String get FullDiskAccessPermissionRequired => 'يرجى تمكين إذن clashmiServiceSE في [إعدادات النظام]-[الخصوصية والأمان]-[الوصول الكامل للقرص] وإعادة الاتصال.';
	@override String get proxy => 'التمثيل';
	@override String get theme => 'سمة';
	@override String get tvMode => 'وضع التلفزيون';
	@override String get autoUpdate => 'التحديثات التلقائية';
	@override String get updateChannel => 'تحديث القنوات تلقائيا';
	@override String get onlineCustomerService => 'خدمة العملاء عبر الإنترنت';
	@override String get subscriptionChannel => 'قناة الاشتراك';
	@override String hasNewVersion({required Object p}) => 'تحديث الإصدار ${p}';
	@override String get autoDownloadPkg => 'تنزيل حزم التحديث تلقائيًا';
	@override String get devOptions => 'خيارات للمطور';
	@override String get about => 'عن';
	@override String get name => 'اسم';
	@override String get version => 'إصدار';
	@override String get notice => 'يلاحظ';
	@override String get sort => 'إعادة ترتيب';
	@override String get recommended => 'يوصي';
	@override String innerError({required Object p}) => 'خطأ داخلي: ${p}';
	@override String get share => 'يشارك';
	@override String get importFromClipboard => 'استيراد من الحافظة';
	@override String get exportToClipboard => 'تصدير إلى الحافظة';
	@override String get server => 'الخادم';
	@override String get port => 'ميناء';
	@override String get donate => 'يتبرع';
	@override String get setting => 'إعدادات';
	@override String get settingCore => 'الإعدادات الأساسية';
	@override String get settingApp => 'إعدادات التطبيق';
	@override String get coreOverwrite => 'تجاوز النواة';
	@override String get iCloud => 'iCloud';
	@override String get webdav => 'Webdav';
	@override String get lanSync => 'LAN SYNC';
	@override String get lanSyncNotQuitTips => 'لا تخرج من هذه الواجهة قبل اكتمال التزامن';
	@override String get deviceNoSpace => 'مساحة غير كافيه في القرص';
	@override String get hideSystemApp => 'إخفاء تطبيقات النظام';
	@override String get hideAppIcon => 'إخفاء أيقونة التطبيق';
	@override String get openDir => 'فتح دليل الملف';
	@override String get type => 'النوع';
	@override String get fileChoose => 'حدد الملف';
	@override String get filePathCannotEmpty => 'لا يمكن أن يكون مسار الملف فارغًا';
	@override String fileNotExist({required Object p}) => 'الملف غير موجود: ${p}';
	@override String fileTypeInvalid({required Object p}) => 'نوع الملف غير صالح:${p}';
	@override String get uwpExemption => 'إعفاء عزل شبكة UWP';
	@override String get getProfile => 'احصل على التكوين';
	@override String get buyProfile => 'شراء ملف تعريف';
	@override String get addProfile => 'إضافة ملف تعريف';
	@override String get myProfiles => 'مظهر';
	@override String get profileEdit => 'تحرير الملف الشخصي';
	@override String get profileNeedActive => 'يرجى أولاً تعيين هذا الملف كملف التعريف الحالي، ثم بدء الاتصال/إعادة الاتصال';
	@override String get profileDownloadBackupChannel => 'تمكين قناة التنزيل الاحتياطية';
	@override String get profileDownloadBackupChannelTips => 'قناة تنزيل عبر الوكيل توفرها Clash Mi (لا يتم تخزين أي معلومات)';
	@override String get profileEditReloadAfterProfileUpdate => 'إعادة التحميل بعد تحديث الملف الشخصي';
	@override String get profileRulesAppendApplePush => 'إضافة قواعد إشعارات Apple Push';
	@override String get profileRulesAppendProxyTips => 'سيتم تعيين القواعد تلقائيًا إلى أول وكيل في [proxy-groups] من التكوين الأصلي يكون نوعه [url-test] أو [select]';
	@override String get profileImport => 'استيراد ملف الملف الشخصي';
	@override String get profileAddUrlOrContent => 'إضافة رابط ملف التعريف';
	@override String get profileUrlOrContent => 'رابط إعداد Clash';
	@override String get profileUrlOrContentHit => 'رابط إعداد Clash [مطلوب]';
	@override String get profileUrlOrContentCannotEmpty => 'لا يمكن أن يكون رابط الملف الشخصي فارغًا';
}

// Path: permission
class _Translations$permission$ar implements Translations$permission$en {
	_Translations$permission$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get camera => 'الكاميرا';
	@override String get screen => 'تسجيل الشاشة';
	@override String get appQuery => 'الحصول على قائمة التطبيقات';
	@override String request({required Object p}) => 'تمكين أذونات [${p}]';
	@override String requestNeed({required Object p}) => 'الرجاء تفعيل إذن [${p}]';
}

// Path: tls
class _Translations$tls$ar implements Translations$tls$en {
	_Translations$tls$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get insecure => 'تخطي التحقق من الشهادة';
	@override String get certificate => 'شهادة';
	@override String get privateKey => 'المفتاح الخاص';
	@override String get customTrustCert => 'شهادات مخصصة';
}

// Path: tun
class _Translations$tun$ar implements Translations$tun$en {
	_Translations$tun$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get stack => 'مكدس الشبكة';
	@override String get inet4Address => 'نطاق عناوين IPv4';
	@override String get inet6Address => 'نطاق عناوين IPv6';
	@override String get dnsHijack => 'اختطاف DNS';
	@override String get strictRoute => 'التوجيه الصارم';
	@override String get tunDefaultRoute => 'المسار الافتراضي';
	@override String get icmpForward => 'توجيه رسائل ICMP';
	@override String get allowBypass => 'السماح للتطبيقات بتجاوز VPN';
	@override String get appendHttpProxy => 'إلحاق وكيل HTTP إلى VPN';
	@override String get bypassHttpProxyDomain => 'المجالات المسموح لها بتجاوز وكيل HTTP';
}

// Path: dns
class _Translations$dns$ar implements Translations$dns$en {
	_Translations$dns$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get listen => 'كلمة الاستماع';
	@override String get fakeIp => 'fake-ip';
	@override String get fallback => 'Fallback';
	@override String get preferH3 => 'أولوية DoH H3';
	@override String get useHosts => 'استخدام المضيفين';
	@override String get useSystemHosts => 'استخدام مضيفات النظام';
	@override String get enhancedMode => 'الوضع المحسّن';
	@override String get fakeIPFilterMode => 'وضع التصفية ${_root.dns.fakeIp}';
	@override String get fakeIPFilter => '${_root.dns.fakeIp} التصفية';
	@override String get respectRules => 'اتبع القواعد';
	@override String get nameServer => 'خادم DNS';
	@override String get defaultNameServer => '${_root.meta.byDefault} ${_root.dns.nameServer}';
	@override String get proxyNameServer => '${_root.meta.proxy} ${_root.dns.nameServer}';
	@override String get directNameServer => '${_root.meta.direct} ${_root.dns.nameServer}';
	@override String get fallbackNameServer => '${_root.dns.fallback} ${_root.dns.nameServer}';
	@override String get fallbackGeoIp => '${_root.dns.fallback} GeoIp';
	@override String get fallbackGeoIpCode => '${_root.dns.fallback} GeoIpCode';
}

// Path: sniffer
class _Translations$sniffer$ar implements Translations$sniffer$en {
	_Translations$sniffer$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get overrideDest => 'غطاء';
}

// Path: profilePatchMode
class _Translations$profilePatchMode$ar implements Translations$profilePatchMode$en {
	_Translations$profilePatchMode$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get currentSelected => 'المحدد الحالي';
	@override String get overwrite => 'التجاوز المدمج';
	@override String get noOverwrite => 'مُدمج - غير قابل للكتابة فوقه';
}

// Path: main.tray
class _Translations$main$tray$ar implements Translations$main$tray$en {
	_Translations$main$tray$ar._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get menuOpen => 'يفتح';
	@override String get menuExit => 'مخرج';
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'BackupAndSyncWebdavScreen.webdavServerUrl' => 'عنوان URL الخادم',
			'BackupAndSyncWebdavScreen.webdavRequired' => 'لايمكن ان يكون فارغا',
			'BackupAndSyncWebdavScreen.webdavLoginFailed' => 'فشل تسجيل الدخول:',
			'BackupAndSyncWebdavScreen.webdavListFailed' => 'فشل في الحصول على قائمة الملفات:',
			'LaunchFailedScreen.invalidProcess' => 'فشل التطبيق في البدء [اسم عملية غير صالح] ، يرجى إعادة تثبيت التطبيق إلى دليل منفصل',
			'LaunchFailedScreen.invalidProfile' => 'فشل التطبيق في البدء [فشل في الوصول إلى الملف الشخصي] ، يرجى إعادة تثبيت التطبيق',
			'LaunchFailedScreen.invalidVersion' => 'فشل التطبيق في بدء [إصدار غير صالح] ، يرجى إعادة تثبيت التطبيق',
			'LaunchFailedScreen.systemVersionLow' => 'فشل بدء تشغيل التطبيق [إصدار النظام منخفض جدًا]',
			'LaunchFailedScreen.invalidInstallPath' => 'مسار التثبيت غير صالح ، يرجى إعادة تثبيته إلى مسار صالح',
			'PerAppAndroidScreen.title' => 'لكل وكيل تطبيق',
			'PerAppAndroidScreen.whiteListMode' => 'وضع القائمة البيضاء',
			'PerAppAndroidScreen.whiteListModeTip' => 'عند التمكين: فقط التطبيقات التي تم فحصها هي وكلاء ؛عندما لا يتم تمكينها: فقط التطبيقات التي لم يتم فحصها هي وكلاء',
			'UserAgreementScreen.privacyFirst' => 'خصوصيتك تأتي أولا',
			'UserAgreementScreen.agreeAndContinue' => 'قبول ومتابعة',
			'NetCheckScreen.enterDomain' => 'أدخل اسم النطاق',
			'NetCheckScreen.checking' => 'جارٍ الفحص...',
			'NetCheckScreen.aQueryFailed' => ({required Object p}) => 'فشل استعلام A: ${p}',
			'NetCheckScreen.aaaaQueryFailed' => ({required Object p}) => 'فشل استعلام AAAA: ${p}',
			'NetCheckScreen.success' => 'نجاح',
			'NetCheckScreen.failed' => 'فشل',
			'NetCheckScreen.suspectedPollution' => 'يُشتبه في تسميم DNS',
			'NetCheckScreen.domainLabel' => 'النطاق',
			'NetCheckScreen.checkButton' => 'فحص',
			'NetCheckScreen.dnsSection' => '1. استعلام DNS',
			'NetCheckScreen.directHttpSection' => '2. HTTP (عبر TUN، يرجى تفعيل TUN أولاً)',
			'NetCheckScreen.proxyHttpSection' => ({required Object p}) => '3. HTTP (عبر الوكيل، المنفذ: ${p})',
			'NetCheckScreen.tunNotEnabled' => 'TUN غير مفعّل',
			'NetCheckScreen.routeTableSection' => '4. جدول التوجيه',
			'VersionUpdateScreen.versionReady' => ({required Object p}) => 'الإصدار الجديد [${p}] جاهز',
			'VersionUpdateScreen.update' => 'أعد التشغيل للتحديث',
			'VersionUpdateScreen.cancel' => 'ليس الآن',
			'loginScreen.login' => 'دخول',
			'loginScreen.register' => 'إنشاء حساب',
			'loginScreen.forgotPassword' => 'هل نسيت كلمة المرور',
			'loginScreen.provider' => 'مزود الخدمة',
			'loginScreen.providerName' => 'رمز/اسم مستعار/URL لـ ${_root.loginScreen.provider}',
			'loginScreen.providerNameRequired' => 'يرجى إدخال الرمز/الاسم المستعار/URL لـ ${_root.loginScreen.provider}',
			'loginScreen.account' => 'حساب',
			'loginScreen.accountRequired' => 'يرجى إدخال الحساب',
			'loginScreen.email' => 'البريد الإلكتروني',
			'loginScreen.emailRequired' => 'يرجى إدخال عنوان بريدك الإلكتروني',
			'loginScreen.password' => 'كلمة المرور',
			'loginScreen.passwordRequired' => 'يرجى إدخال كلمة المرور',
			'loginScreen.validEmailRequired' => 'يرجى إدخال عنوان بريد إلكتروني صحيح',
			'loginScreen.passwordMinLength' => ({required Object minLength}) => 'يجب أن تكون كلمة المرور ${minLength} أحرف على الأقل',
			'loginScreen.unsupportedProvider' => '${_root.loginScreen.provider} غير مدعوم',
			'loginScreen.unsupportedProviderType' => 'نوع ${_root.loginScreen.provider} غير مدعوم',
			'loginScreen.unActivedProvider' => 'ميزة تسجيل الدخول غير مفعلة',
			'loginScreen.providerLoginSupportRequired' => ({required Object p}) => 'يرجى طلب رمز/اسم مستعار المزوّد من ${_root.loginScreen.provider}.\nللاطلاع على تكامل ${_root.loginScreen.provider}، راجع: ${p}',
			'loginScreen.providerDisclaimer' => 'إخلاء المسؤولية: ${_root.loginScreen.provider} هي خدمة تابعة لطرف ثالث ولا علاقة لها بهذا التطبيق',
			'main.tray.menuOpen' => 'يفتح',
			'main.tray.menuExit' => 'مخرج',
			'meta.enable' => 'يُمكَِن',
			'meta.disable' => 'إبطال',
			'meta.open' => 'يفتح',
			'meta.close' => 'إنهاء',
			'meta.quit' => 'يترك',
			'meta.add' => 'اضف إليه',
			'meta.addSuccess' => 'اضيف بنجاح',
			'meta.addFailed' => ({required Object p}) => 'إضافة فشل:${p}',
			'meta.remove' => 'يمسح',
			'meta.removeConfirm' => 'هل انت متأكد من الحذف؟',
			'meta.edit' => 'يحرر',
			'meta.view' => 'يفحص',
			'meta.remark' => 'ملاحظة',
			'meta.byDefault' => 'تقصير',
			'meta.editRemark' => 'ملاحظات التعديل',
			'meta.more' => 'أكثر',
			'meta.tips' => 'معلومات',
			'meta.selectAll' => 'تحديد الكل',
			'meta.copy' => 'ينسخ',
			'meta.paste' => 'لصق',
			'meta.cut' => 'يقطع',
			'meta.save' => 'يحفظ',
			'meta.ok' => 'نعم',
			'meta.cancel' => 'يلغي',
			'meta.faq' => 'أسئلة مكررة',
			'meta.doc' => 'وثيقة',
			'meta.htmlTools' => 'مجموعة أدوات HTML',
			'meta.download' => 'تحميل',
			'meta.loading' => 'تحميل...',
			'meta.days' => 'أيام',
			'meta.hours' => 'ساعات',
			'meta.minutes' => 'دقائق',
			'meta.seconds' => 'ثانية',
			'meta.milliseconds' => 'ميلي ثانية',
			'meta.protocol' => 'بروتوكول',
			'meta.search' => 'يبحث',
			'meta.custom' => 'مخصص',
			'meta.connect' => 'يتصل',
			'meta.disconnect' => 'قطع الاتصال',
			'meta.connected' => 'متصل',
			'meta.disconnected' => 'انقطع الاتصال',
			'meta.connecting' => 'توصيل',
			'meta.connectTimeout' => 'ربط مهلة',
			'meta.timeout' => 'نفذ الوقت',
			'meta.timeoutDuration' => 'مدة مهلة الانتظار',
			'meta.latency' => 'تأخير',
			'meta.latencyTest' => 'كشف التأخير',
			'meta.networkCheck' => 'فحص الشبكة',
			'meta.language' => 'لغة',
			'meta.next' => 'التالي',
			'meta.done' => 'منتهي',
			'meta.apply' => 'يتقدم',
			'meta.refresh' => 'ينعش',
			'meta.retry' => 'إعادة المحاولة?',
			'meta.update' => 'تجديد',
			'meta.updateInterval' => 'الفاصل الزمني للتحديث',
			'meta.updateInterval5mTips' => 'الحد الأدنى: 5 م',
			'meta.updateIntervalPreferByProfile' => 'إعطاء الأولوية لإعدادات المزود',
			'meta.updateFailed' => ({required Object p}) => 'فشل التحديث:${p}',
			'meta.none' => 'لا أحد',
			'meta.reset' => 'إعادة ضبط',
			'meta.authentication' => 'التفويض',
			'meta.submit' => 'يُقدِّم',
			'meta.user' => 'مستخدم',
			'meta.account' => 'حساب',
			'meta.password' => 'كلمة المرور',
			'meta.decryptPassword' => 'فك تشفير كلمة المرور',
			'meta.required' => 'مطلوب',
			'meta.go' => 'متابعة',
			'meta.sudoPassword' => 'كلمة مرور sudo (مطلوبة لوضع TUN)',
			'meta.other' => 'آخر',
			'meta.dns' => 'DNS',
			'meta.url' => 'URL',
			'meta.urlInvalid' => 'URL غير صالح',
			'meta.urlCannotEmpty' => 'لا يمكن أن يكون الرابط فارغًا',
			'meta.urlTooLong' => 'عنوان URL طويل جدًا (>8182)',
			'meta.copyUrl' => 'نسخ الرابط',
			'meta.openUrl' => 'فتح الرابط',
			'meta.shareUrl' => 'شارك الرابط',
			'meta.coreSettingTips' => 'ملاحظة: بعد تعديل التكوين، تحتاج إلى إعادة الاتصال حتى يسري مفعوله',
			'meta.overwrite' => 'تجاوز',
			'meta.overwriteCustom' => 'تجاوزات مخصصة',
			'meta.overwriteAppend' => 'تجاوز إضافي',
			'meta.overwriteTips' => 'التكوين الأصلي <- تجاوز مخصص <- تجاوز التطبيق',
			'meta.noOverwrite' => 'لا تكتب فوق',
			'meta.overwriteSettings' => 'تجاوز الإعدادات',
			'meta.diversionTemplates' => 'نموذج الفرز',
			'meta.ruleProviders' => 'موفر القواعد',
			'meta.ruleTemplates' => 'نموذج القاعدة',
			'meta.proxyGroupsTemplates' => 'نموذج مجموعة الوكلاء',
			'meta.proxyGroups' => 'مجموعة الوكلاء',
			'meta.proxyNodeList' => 'قائمة عقد الوكيل',
			'meta.proxyNodeFailure' => ({required Object p}) => 'انتهت صلاحية عقد الوكيل التالية وتمت إزالتها تلقائيًا: ${p}',
			'meta.externalController' => 'الرقابة الخارجية',
			'meta.secret' => 'Secret',
			'meta.tcpConcurrent' => 'مصافحة TCP المتزامنة',
			'meta.globalClientFingerprint' => 'بصمة TLS العالمية',
			'meta.allowLanAccess' => 'الوصول إلى جهاز LAN',
			'meta.mixedPort' => 'منفذ الوكيل الهجين',
			'meta.logLevel' => 'مستوى السجل',
			'meta.findProcessMode' => 'وضع مطابقة العملية',
			'meta.tcpkeepAliveInterval' => 'فترة الحفاظ على اتصال TCP',
			'meta.delayTestUrl' => 'عنوان URL لاختبار زمن الوصول',
			'meta.delayTestTimeout' => 'تأخير مهلة الاختبار (مللي ثانية)',
			'meta.tun' => 'TUN',
			'meta.ntp' => 'NTP',
			'meta.tls' => 'TLS',
			'meta.geo' => 'GEO',
			'meta.geoDownloadByProxy' => 'تنزيل Geo RuleSet باستخدام وكيل',
			'meta.geoRulesetTips' => 'سيتم تحويل Geosite/Geoip إلى مجموعة القواعد المقابلة',
			'meta.asnNotSupportInIosTips' => 'بسبب قيود ذاكرة نظام iOS، سيتم تجاهل قواعد IP-ASN وSRC-IP-ASN على نظام iOS.',
			'meta.sniffer' => 'شم',
			'meta.userAgent' => 'UserAgent',
			'meta.launchAtStartup' => 'إطلاق عند بدء التشغيل',
			'meta.launchAtStartupRunAsAdmin' => 'يرجى إعادة تشغيل Clash Mi كمسؤول',
			'meta.tunModeRunAsAdmin' => 'يتطلب وضع TUN أذونات مسؤول النظام ، يرجى إعادة تشغيل التطبيق كمسؤول',
			'meta.portableMode' => 'الوضع المحمول',
			'meta.portableModeDisableTips' => 'إذا كنت بحاجة إلى الخروج من الوضع المحمول، فيرجى الخروج من [clashmi] وحذف المجلد [portable] يدويًا في نفس الدليل مثل [clashmi.exe]',
			'meta.systemProxy' => 'وكيل النظام',
			'meta.autoConnectAfterLaunch' => 'اتصال السيارات بعد الإطلاق',
			'meta.autoConnectAtBoot' => 'الاتصال التلقائي بعد بدء تشغيل النظام',
			'meta.autoConnectAtBootTips' => 'يجب دعم النظام؛ وقد تتطلب بعض الأنظمة أيضًا تمكين [البدء التلقائي].',
			'meta.hideAfterLaunch' => 'إخفاء النافذة بعد بدء التشغيل',
			'meta.autoSetSystemProxy' => 'وكيل نظام تعيين تلقائي عند الاتصال',
			'meta.bypassSystemProxy' => 'أسماء النطاقات المسموح لها بتجاوز وكيل النظام',
			'meta.excludeFromRecent' => 'إخفاء من المهام الأخيرة',
			'meta.wakeLock' => 'قفل الاستيقاظ',
			'meta.hideVpn' => 'إخفاء أيقونة VPN',
			'meta.hideVpnTips' => 'سيؤدي تمكين IPv6 إلى فشل هذه الوظيفة',
			'meta.hideDockIcon' => 'إخفاء أيقونة Dock',
			'meta.showTrayTraffic' => 'إظهار معلومات حركة المرور في شريط النظام',
			'meta.website' => 'موقع إلكتروني',
			'meta.homePage' => 'الصفحة الرئيسية',
			'meta.rule' => 'قاعدة',
			'meta.global' => 'عالمي',
			'meta.direct' => 'مباشر',
			'meta.block' => 'حاجز',
			'meta.qrcode' => 'رمز الاستجابة السريعة',
			'meta.qrcodeTooLong' => 'النص طويل جدًا لعرضه',
			'meta.qrcodeShare' => 'شارك رمز الاستجابة السريعة',
			'meta.textToQrcode' => 'رسالة نصية إلى رمز الاستجابة السريعة',
			'meta.qrcodeScan' => 'مسح رمز الاستجابة السريعة',
			'meta.qrcodeScanResult' => 'نتيجة المسح',
			'meta.qrcodeScanFromImage' => 'مسح من الصورة',
			'meta.qrcodeScanResultFailed' => 'فشل في تحليل الصورة ، يرجى التأكد من أن لقطة الشاشة هي رمز QR صالح',
			'meta.qrcodeScanResultEmpty' => 'نتيجة الفحص فارغة',
			'meta.screenshot' => 'لقطة شاشة',
			'meta.backupAndSync' => 'النسخ الاحتياطي والمزامنة',
			'meta.importSuccess' => 'استيراد نجاح ',
			'meta.rewriteConfirm' => 'سيقوم هذا الملف بكتابة التكوين المحلي الحالي.هل تريد الاستمرار؟',
			'meta.importAndExport' => 'استيراد وتصدير',
			'meta.import' => 'يستورد',
			'meta.importFromUrl' => 'الاستيراد من عنوان URL',
			'meta.export' => 'يصدّر',
			'meta.send' => 'يرسل',
			'meta.receive' => 'تولي',
			'meta.sendConfirm' => 'تأكيد الإرسال؟',
			'meta.continueConnectConfirm' => 'هل تريد متابعة الاتصال؟',
			'meta.termOfUse' => 'شرط الخدمة',
			'meta.privacyPolicy' => 'سياسة الخصوصية',
			'meta.log' => 'سجل',
			'meta.coreLog' => 'سجل النواة',
			'meta.core' => 'جوهر',
			'meta.help' => 'يساعد',
			'meta.tutorial' => 'درس تعليمي',
			'meta.board' => 'لوحة',
			'meta.boardOnline' => 'استخدام اللوحة عبر الإنترنت',
			'meta.boardOnlineUrl' => 'عنوان URL للوحة عبر الإنترنت',
			'meta.boardLocalPort' => 'منفذ اللوحة المحلية',
			'meta.alwayOnVPN' => 'اتصال مفتوح دائمًا',
			'meta.disableFontScaler' => 'تعطيل تحجيم الخط(يسري مفعوله بعد إعادة التشغيل)',
			'meta.autoOrientation' => 'Rotate with the screen',
			'meta.restartTakesEffect' => 'Restart takes effect',
			'meta.reconnectTakesEffect' => 'سيتم تطبيقه بعد إعادة الاتصال.',
			'meta.runtimeProfile' => 'تكوين وقت التشغيل',
			'meta.willCompleteAfterRebootInstall' => 'يرجى إعادة تشغيل جهازك لإكمال تثبيت توسيع النظام',
			'meta.willCompleteAfterRebootUninstall' => 'يرجى إعادة تشغيل جهازك لإكمال إلغاء تثبيت ملحق النظام',
			'meta.requestNeedsUserApproval' => '١. يُرجى السماح لـ Clash Mi بتثبيت ملحقات النظام من [إعدادات النظام] - [الخصوصية والأمان]. ٢. : [إعدادات النظام] - [عام] - [عناصر تسجيل الدخول والملحقات - ملحقات الشبكة] فعّل [clashmiServiceSE]. أعد الاتصال بعد الانتهاء.',
			'meta.FullDiskAccessPermissionRequired' => 'يرجى تمكين إذن clashmiServiceSE في [إعدادات النظام]-[الخصوصية والأمان]-[الوصول الكامل للقرص] وإعادة الاتصال.',
			'meta.proxy' => 'التمثيل',
			'meta.theme' => 'سمة',
			'meta.tvMode' => 'وضع التلفزيون',
			'meta.autoUpdate' => 'التحديثات التلقائية',
			'meta.updateChannel' => 'تحديث القنوات تلقائيا',
			'meta.onlineCustomerService' => 'خدمة العملاء عبر الإنترنت',
			'meta.subscriptionChannel' => 'قناة الاشتراك',
			'meta.hasNewVersion' => ({required Object p}) => 'تحديث الإصدار ${p}',
			'meta.autoDownloadPkg' => 'تنزيل حزم التحديث تلقائيًا',
			'meta.devOptions' => 'خيارات للمطور',
			'meta.about' => 'عن',
			'meta.name' => 'اسم',
			'meta.version' => 'إصدار',
			'meta.notice' => 'يلاحظ',
			'meta.sort' => 'إعادة ترتيب',
			'meta.recommended' => 'يوصي',
			'meta.innerError' => ({required Object p}) => 'خطأ داخلي: ${p}',
			'meta.share' => 'يشارك',
			'meta.importFromClipboard' => 'استيراد من الحافظة',
			'meta.exportToClipboard' => 'تصدير إلى الحافظة',
			'meta.server' => 'الخادم',
			'meta.port' => 'ميناء',
			'meta.donate' => 'يتبرع',
			'meta.setting' => 'إعدادات',
			'meta.settingCore' => 'الإعدادات الأساسية',
			'meta.settingApp' => 'إعدادات التطبيق',
			'meta.coreOverwrite' => 'تجاوز النواة',
			'meta.iCloud' => 'iCloud',
			'meta.webdav' => 'Webdav',
			'meta.lanSync' => 'LAN SYNC',
			'meta.lanSyncNotQuitTips' => 'لا تخرج من هذه الواجهة قبل اكتمال التزامن',
			'meta.deviceNoSpace' => 'مساحة غير كافيه في القرص',
			'meta.hideSystemApp' => 'إخفاء تطبيقات النظام',
			'meta.hideAppIcon' => 'إخفاء أيقونة التطبيق',
			'meta.openDir' => 'فتح دليل الملف',
			'meta.type' => 'النوع',
			'meta.fileChoose' => 'حدد الملف',
			'meta.filePathCannotEmpty' => 'لا يمكن أن يكون مسار الملف فارغًا',
			'meta.fileNotExist' => ({required Object p}) => 'الملف غير موجود: ${p}',
			'meta.fileTypeInvalid' => ({required Object p}) => 'نوع الملف غير صالح:${p}',
			'meta.uwpExemption' => 'إعفاء عزل شبكة UWP',
			'meta.getProfile' => 'احصل على التكوين',
			'meta.buyProfile' => 'شراء ملف تعريف',
			'meta.addProfile' => 'إضافة ملف تعريف',
			'meta.myProfiles' => 'مظهر',
			'meta.profileEdit' => 'تحرير الملف الشخصي',
			'meta.profileNeedActive' => 'يرجى أولاً تعيين هذا الملف كملف التعريف الحالي، ثم بدء الاتصال/إعادة الاتصال',
			'meta.profileDownloadBackupChannel' => 'تمكين قناة التنزيل الاحتياطية',
			'meta.profileDownloadBackupChannelTips' => 'قناة تنزيل عبر الوكيل توفرها Clash Mi (لا يتم تخزين أي معلومات)',
			'meta.profileEditReloadAfterProfileUpdate' => 'إعادة التحميل بعد تحديث الملف الشخصي',
			'meta.profileRulesAppendApplePush' => 'إضافة قواعد إشعارات Apple Push',
			'meta.profileRulesAppendProxyTips' => 'سيتم تعيين القواعد تلقائيًا إلى أول وكيل في [proxy-groups] من التكوين الأصلي يكون نوعه [url-test] أو [select]',
			'meta.profileImport' => 'استيراد ملف الملف الشخصي',
			'meta.profileAddUrlOrContent' => 'إضافة رابط ملف التعريف',
			'meta.profileUrlOrContent' => 'رابط إعداد Clash',
			'meta.profileUrlOrContentHit' => 'رابط إعداد Clash [مطلوب]',
			'meta.profileUrlOrContentCannotEmpty' => 'لا يمكن أن يكون رابط الملف الشخصي فارغًا',
			'permission.camera' => 'الكاميرا',
			'permission.screen' => 'تسجيل الشاشة',
			'permission.appQuery' => 'الحصول على قائمة التطبيقات',
			'permission.request' => ({required Object p}) => 'تمكين أذونات [${p}]',
			'permission.requestNeed' => ({required Object p}) => 'الرجاء تفعيل إذن [${p}]',
			'tls.insecure' => 'تخطي التحقق من الشهادة',
			'tls.certificate' => 'شهادة',
			'tls.privateKey' => 'المفتاح الخاص',
			'tls.customTrustCert' => 'شهادات مخصصة',
			'tun.stack' => 'مكدس الشبكة',
			'tun.inet4Address' => 'نطاق عناوين IPv4',
			'tun.inet6Address' => 'نطاق عناوين IPv6',
			'tun.dnsHijack' => 'اختطاف DNS',
			'tun.strictRoute' => 'التوجيه الصارم',
			'tun.tunDefaultRoute' => 'المسار الافتراضي',
			'tun.icmpForward' => 'توجيه رسائل ICMP',
			'tun.allowBypass' => 'السماح للتطبيقات بتجاوز VPN',
			'tun.appendHttpProxy' => 'إلحاق وكيل HTTP إلى VPN',
			'tun.bypassHttpProxyDomain' => 'المجالات المسموح لها بتجاوز وكيل HTTP',
			'dns.listen' => 'كلمة الاستماع',
			'dns.fakeIp' => 'fake-ip',
			'dns.fallback' => 'Fallback',
			'dns.preferH3' => 'أولوية DoH H3',
			'dns.useHosts' => 'استخدام المضيفين',
			'dns.useSystemHosts' => 'استخدام مضيفات النظام',
			'dns.enhancedMode' => 'الوضع المحسّن',
			'dns.fakeIPFilterMode' => 'وضع التصفية ${_root.dns.fakeIp}',
			'dns.fakeIPFilter' => '${_root.dns.fakeIp} التصفية',
			'dns.respectRules' => 'اتبع القواعد',
			'dns.nameServer' => 'خادم DNS',
			'dns.defaultNameServer' => '${_root.meta.byDefault} ${_root.dns.nameServer}',
			'dns.proxyNameServer' => '${_root.meta.proxy} ${_root.dns.nameServer}',
			'dns.directNameServer' => '${_root.meta.direct} ${_root.dns.nameServer}',
			'dns.fallbackNameServer' => '${_root.dns.fallback} ${_root.dns.nameServer}',
			'dns.fallbackGeoIp' => '${_root.dns.fallback} GeoIp',
			'dns.fallbackGeoIpCode' => '${_root.dns.fallback} GeoIpCode',
			'sniffer.overrideDest' => 'غطاء',
			'profilePatchMode.currentSelected' => 'المحدد الحالي',
			'profilePatchMode.overwrite' => 'التجاوز المدمج',
			'profilePatchMode.noOverwrite' => 'مُدمج - غير قابل للكتابة فوقه',
			'protocolSniff' => 'الكشف عن البروتوكول',
			'protocolSniffOverrideDestination' => 'يغطي اسم المجال المكتشف عنوان هدف الاتصال',
			'edgeRuntimeNotInstalled' => 'لم يتم تثبيت وقت تشغيل Edge WebView2 على الجهاز الحالي ولا يمكن عرض الصفحة، يرجى تنزيل وتثبيت وقت تشغيل Edge WebView2 (x64)، وإعادة تشغيل التطبيق والمحاولة مرة أخرى.',
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
