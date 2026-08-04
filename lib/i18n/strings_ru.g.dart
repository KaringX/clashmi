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
class TranslationsRu with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsRu({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ru,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ru>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsRu _root = this; // ignore: unused_field

	@override 
	TranslationsRu $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsRu(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$BackupAndSyncWebdavScreen$ru BackupAndSyncWebdavScreen = _Translations$BackupAndSyncWebdavScreen$ru._(_root);
	@override late final _Translations$LaunchFailedScreen$ru LaunchFailedScreen = _Translations$LaunchFailedScreen$ru._(_root);
	@override late final _Translations$PerAppAndroidScreen$ru PerAppAndroidScreen = _Translations$PerAppAndroidScreen$ru._(_root);
	@override late final _Translations$UserAgreementScreen$ru UserAgreementScreen = _Translations$UserAgreementScreen$ru._(_root);
	@override late final _Translations$NetCheckScreen$ru NetCheckScreen = _Translations$NetCheckScreen$ru._(_root);
	@override late final _Translations$VersionUpdateScreen$ru VersionUpdateScreen = _Translations$VersionUpdateScreen$ru._(_root);
	@override late final _Translations$loginScreen$ru loginScreen = _Translations$loginScreen$ru._(_root);
	@override late final _Translations$main$ru main = _Translations$main$ru._(_root);
	@override late final _Translations$meta$ru meta = _Translations$meta$ru._(_root);
	@override late final _Translations$permission$ru permission = _Translations$permission$ru._(_root);
	@override late final _Translations$tls$ru tls = _Translations$tls$ru._(_root);
	@override late final _Translations$tun$ru tun = _Translations$tun$ru._(_root);
	@override late final _Translations$dns$ru dns = _Translations$dns$ru._(_root);
	@override late final _Translations$sniffer$ru sniffer = _Translations$sniffer$ru._(_root);
	@override late final _Translations$profilePatchMode$ru profilePatchMode = _Translations$profilePatchMode$ru._(_root);
	@override String get protocolSniff => 'Определение протокола';
	@override String get protocolSniffOverrideDestination => 'Обнаруженное имя домена перезаписывает целевой адрес подключения.';
	@override String get edgeRuntimeNotInstalled => 'Среда выполнения Edge WebView2 не установлена ​​на текущем устройстве, и страница не может быть отображена. Загрузите и установите среду выполнения Edge WebView2 (x64), перезапустите приложение и повторите попытку.';
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
class _Translations$BackupAndSyncWebdavScreen$ru implements Translations$BackupAndSyncWebdavScreen$en {
	_Translations$BackupAndSyncWebdavScreen$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get webdavServerUrl => 'Адрес сервера';
	@override String get webdavRequired => 'Не может быть пустым';
	@override String get webdavLoginFailed => 'Ошибка входа:';
	@override String get webdavListFailed => 'Не удалось получить список файлов:';
}

// Path: LaunchFailedScreen
class _Translations$LaunchFailedScreen$ru implements Translations$LaunchFailedScreen$en {
	_Translations$LaunchFailedScreen$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get invalidProcess => 'Не удалось запустить приложение [Неверное имя процесса], переустановите приложение в отдельную папку';
	@override String get invalidProfile => 'Не удалось запустить приложение [Не удалось получить доступ к профилю], переустановите приложение';
	@override String get invalidVersion => 'Не удалось запустить приложение [Неверная версия], переустановите приложение';
	@override String get systemVersionLow => 'Не удалось запустить приложение [Слишком низкая версия системы]';
	@override String get invalidInstallPath => 'Путь установки недействителен, переустановите его по допустимому пути';
}

// Path: PerAppAndroidScreen
class _Translations$PerAppAndroidScreen$ru implements Translations$PerAppAndroidScreen$en {
	_Translations$PerAppAndroidScreen$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get title => 'Проксируемые приложения';
	@override String get whiteListMode => 'Режим белого списка';
	@override String get whiteListModeTip => 'Если включено: перенаправляются через прокси-сервер только те приложения, которые были отмечены. Если выключено: перенаправляются через прокси-сервер только те приложения, которые не были отмечены.';
}

// Path: UserAgreementScreen
class _Translations$UserAgreementScreen$ru implements Translations$UserAgreementScreen$en {
	_Translations$UserAgreementScreen$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get privacyFirst => 'Ваша конфиденциальность превыше всего';
	@override String get agreeAndContinue => 'Принять и продолжить';
}

// Path: NetCheckScreen
class _Translations$NetCheckScreen$ru implements Translations$NetCheckScreen$en {
	_Translations$NetCheckScreen$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get enterDomain => 'Введите доменное имя';
	@override String get checking => 'Проверка...';
	@override String aQueryFailed({required Object p}) => 'Ошибка запроса A: ${p}';
	@override String aaaaQueryFailed({required Object p}) => 'Ошибка запроса AAAA: ${p}';
	@override String get success => 'Успех';
	@override String get failed => 'Ошибка';
	@override String get suspectedPollution => 'Подозрение на DNS-отравление';
	@override String get domainLabel => 'Домен';
	@override String get checkButton => 'Проверить';
	@override String get dnsSection => '1. DNS-запрос';
	@override String get directHttpSection => '2. HTTP (через TUN, сначала включите TUN)';
	@override String proxyHttpSection({required Object p}) => '3. HTTP (через прокси, порт: ${p})';
	@override String get tunNotEnabled => 'TUN не включён';
	@override String get routeTableSection => '4. Таблица маршрутов';
}

// Path: VersionUpdateScreen
class _Translations$VersionUpdateScreen$ru implements Translations$VersionUpdateScreen$en {
	_Translations$VersionUpdateScreen$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String versionReady({required Object p}) => 'Новая версия [${p}] доступна';
	@override String get update => 'Перезапустить';
	@override String get cancel => 'Не сейчас';
}

// Path: loginScreen
class _Translations$loginScreen$ru implements Translations$loginScreen$en {
	_Translations$loginScreen$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get login => 'Вход';
	@override String get register => 'Зарегистрировать аккаунт';
	@override String get forgotPassword => 'Забыли пароль';
	@override String get provider => 'Провайдер';
	@override String get providerName => 'Код/алиас/URL ${_root.loginScreen.provider}';
	@override String get providerNameRequired => 'Пожалуйста, введите код/алиас/URL ${_root.loginScreen.provider}';
	@override String get account => 'Аккаунт';
	@override String get accountRequired => 'Пожалуйста, введите аккаунт';
	@override String get email => 'Электронная почта';
	@override String get emailRequired => 'Пожалуйста, введите адрес электронной почты';
	@override String get password => 'Пароль';
	@override String get passwordRequired => 'Пожалуйста, введите пароль';
	@override String get validEmailRequired => 'Пожалуйста, введите действительный адрес электронной почты';
	@override String passwordMinLength({required Object minLength}) => 'Длина пароля должна быть не менее ${minLength} символов';
	@override String get unsupportedProvider => 'Неподдерживаемый ${_root.loginScreen.provider}';
	@override String get unsupportedProviderType => 'Неподдерживаемый тип ${_root.loginScreen.provider}';
	@override String get unActivedProvider => 'Функция входа не активирована';
	@override String providerLoginSupportRequired({required Object p}) => 'Запросите код/алиас провайдера у вашего ${_root.loginScreen.provider}.\nИнструкцию по интеграции с ${_root.loginScreen.provider} смотрите: ${p}';
	@override String get providerDisclaimer => 'Отказ от ответственности: ${_root.loginScreen.provider} — это сторонний сервис и не связан с этим приложением';
}

// Path: main
class _Translations$main$ru implements Translations$main$en {
	_Translations$main$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override late final _Translations$main$tray$ru tray = _Translations$main$tray$ru._(_root);
}

// Path: meta
class _Translations$meta$ru implements Translations$meta$en {
	_Translations$meta$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get enable => 'Включить';
	@override String get disable => 'Запретить';
	@override String get open => 'Открыть';
	@override String get close => 'Закрыть';
	@override String get quit => 'Выйти';
	@override String get add => 'Добавить';
	@override String get addSuccess => 'Добавлено успешно';
	@override String addFailed({required Object p}) => 'Ошибка при добавлении:${p}';
	@override String get remove => 'Удалить';
	@override String get removeConfirm => 'Подтверждаете удаление?';
	@override String get edit => 'Редактировать';
	@override String get view => 'Просмотр';
	@override String get remark => 'Примечание';
	@override String get byDefault => 'по умолчанию';
	@override String get editRemark => 'Заметки об изменениях';
	@override String get more => 'Больше';
	@override String get tips => 'Инфо';
	@override String get selectAll => 'Выбрать все';
	@override String get copy => 'Скопировать';
	@override String get paste => 'Вставить';
	@override String get cut => 'Вырезать';
	@override String get save => 'Сохранить';
	@override String get ok => 'Ок';
	@override String get cancel => 'Закрыть';
	@override String get faq => 'Часто задаваемые вопросы (FAQ)';
	@override String get doc => 'документ';
	@override String get htmlTools => 'HTML Toolset';
	@override String get download => 'Скачать';
	@override String get loading => 'Загрузка...';
	@override String get days => 'дни';
	@override String get hours => 'часы';
	@override String get minutes => 'минуты';
	@override String get seconds => 'секунды';
	@override String get milliseconds => 'миллисекунды';
	@override String get protocol => 'Протокол';
	@override String get search => 'Поиск';
	@override String get custom => 'Настроить самостоятельно';
	@override String get connect => 'Соединить';
	@override String get disconnect => 'Отключить';
	@override String get connected => 'Подключено';
	@override String get disconnected => 'Отключено';
	@override String get connecting => 'Подключение';
	@override String get connectTimeout => 'Таймаут при соединении';
	@override String get timeout => 'Тайм-аут';
	@override String get timeoutDuration => 'Длительность тайм-аута';
	@override String get latency => 'Задерживать';
	@override String get latencyTest => 'Обнаружение задержки';
	@override String get networkCheck => 'Проверка сети';
	@override String get language => 'Язык';
	@override String get next => 'Дальше';
	@override String get done => 'Готово';
	@override String get apply => 'Применить';
	@override String get refresh => 'Обновить';
	@override String get retry => 'Хотите попробовать еще раз?';
	@override String get update => 'Обновить';
	@override String get updateInterval => 'Интервал обновления';
	@override String get updateInterval5mTips => 'Минимум: 5 м';
	@override String get updateIntervalPreferByProfile => 'Приоритет настроек провайдера';
	@override String updateFailed({required Object p}) => 'Не удалось обновить:${p}';
	@override String get none => 'Ничего не делать';
	@override String get reset => 'Перезагрузить';
	@override String get authentication => 'Авторизация';
	@override String get submit => 'Отправить';
	@override String get user => 'Пользователь';
	@override String get account => 'Аккаунт';
	@override String get password => 'Пароль';
	@override String get decryptPassword => 'Пароль расшифровки';
	@override String get required => 'Необходимо';
	@override String get go => 'Продолжить';
	@override String get sudoPassword => 'Пароль sudo (требуется для режима TUN)';
	@override String get other => 'Другой';
	@override String get dns => 'DNS';
	@override String get url => 'URL';
	@override String get urlInvalid => 'Неверный URL';
	@override String get urlCannotEmpty => 'Ссылка не может быть пустой';
	@override String get urlTooLong => 'URL слишком длинный (>8182)';
	@override String get copyUrl => 'Скопировать ссылку';
	@override String get openUrl => 'Открыть ссылку';
	@override String get shareUrl => 'Поделиться ссылкой';
	@override String get coreSettingTips => 'Примечание: После изменения конфигурации необходимо повторно подключиться, чтобы изменения вступили в силу.';
	@override String get overwrite => 'Переопределить';
	@override String get overwriteCustom => 'Пользовательские переопределения';
	@override String get overwriteAppend => 'Дополнительное переопределение';
	@override String get overwriteTips => 'Исходная конфигурация <- Пользовательское переопределение <- Переопределение приложения';
	@override String get noOverwrite => 'Не перезаписывать';
	@override String get overwriteSettings => 'Переопределить настройки';
	@override String get diversionTemplates => 'Шаблон сортировки пациентов';
	@override String get ruleProviders => 'Поставщик правил';
	@override String get ruleTemplates => 'Шаблон правила';
	@override String get proxyGroupsTemplates => 'Шаблон группы агентов';
	@override String get proxyGroups => 'Группа агентов';
	@override String get proxyNodeList => 'Список прокси-узлов';
	@override String proxyNodeFailure({required Object p}) => 'Срок действия следующих прокси-узлов истек, и они были автоматически удалены: ${p}';
	@override String get externalController => 'Внешнее управление';
	@override String get secret => 'Пароль';
	@override String get tcpConcurrent => 'Параллельное TCP-подтверждение';
	@override String get globalClientFingerprint => 'Глобальный отпечаток пальца TLS';
	@override String get allowLanAccess => 'Доступ к локальной сети устройства';
	@override String get mixedPort => 'Порт mixed-прокси';
	@override String get logLevel => 'Уровень журнала';
	@override String get findProcessMode => 'Режим поиска процесса';
	@override String get tcpkeepAliveInterval => 'Интервал проверки активности TCP';
	@override String get delayTestUrl => 'URL-адрес теста задержки';
	@override String get delayTestTimeout => 'Время ожидания теста задержки (мс)';
	@override String get tun => 'TUN';
	@override String get ntp => 'NTP';
	@override String get tls => 'TLS';
	@override String get geo => 'GEO';
	@override String get geoDownloadByProxy => 'Загрузка гео-правил через прокси';
	@override String get geoRulesetTips => 'Geosite/Geoip будет преобразован в соответствующий RuleSet';
	@override String get asnNotSupportInIosTips => 'Из-за ограничений памяти системы iOS правила IP-ASN и SRC-IP-ASN будут игнорироваться в iOS.';
	@override String get sniffer => 'Обнаружение доменов';
	@override String get userAgent => 'UserAgent';
	@override String get launchAtStartup => 'Запуск при включении';
	@override String get launchAtStartupRunAsAdmin => 'Пожалуйста, перезапустите Clash Mi от имени администратора.';
	@override String get tunModeRunAsAdmin => 'Для режима TUN требуются права администратора. Перезапустите приложение от имени администратора';
	@override String get portableMode => 'Портативный режим';
	@override String get portableModeDisableTips => 'Если вам нужно выйти из портативного режима, выйдите из [clashmi] и вручную удалите папку [portable] в том же каталоге, что и [clashmi.exe]';
	@override String get systemProxy => 'Системный прокси';
	@override String get autoConnectAfterLaunch => 'Автоматическое подключение после запуска';
	@override String get autoConnectAtBoot => 'Автоматическое подключение после запуска системы';
	@override String get autoConnectAtBootTips => 'Требуется поддержка системы; некоторые системы также могут потребовать включения [автозапуска].';
	@override String get hideAfterLaunch => 'Скрыть окно после запуска';
	@override String get autoSetSystemProxy => 'Установить системный прокси после подключения';
	@override String get bypassSystemProxy => 'Доменные имена, которым разрешено обходить системный прокси-сервер';
	@override String get excludeFromRecent => 'Скрыть из недавних задач';
	@override String get wakeLock => 'Блокировка пробуждения';
	@override String get hideVpn => 'Скрыть значок VPN';
	@override String get hideVpnTips => 'Включение IPv6 приведет к сбою этой функции.';
	@override String get hideDockIcon => 'Скрыть значок дока';
	@override String get showTrayTraffic => 'Показывать трафик в трее';
	@override String get website => 'Веб-сайт';
	@override String get homePage => 'Главная';
	@override String get rule => 'Правила';
	@override String get global => 'Глобально';
	@override String get direct => 'Напрямую';
	@override String get block => 'Блокировать';
	@override String get qrcode => 'QR-код';
	@override String get qrcodeTooLong => 'Слишком большой текст для отображения';
	@override String get qrcodeShare => 'Поделиться QR-кодом';
	@override String get textToQrcode => 'Преобразование текста в QR-код';
	@override String get qrcodeScan => 'Сканировать QR-код';
	@override String get qrcodeScanResult => 'Результат сканирования';
	@override String get qrcodeScanFromImage => 'Открыть';
	@override String get qrcodeScanResultFailed => 'Не удалось проанализировать изображение. Убедитесь, что снимок экрана представляет собой действительный QR-код.';
	@override String get qrcodeScanResultEmpty => 'Пустой результат сканирования.';
	@override String get screenshot => 'Скриншот';
	@override String get backupAndSync => 'Резервное копирование и синхронизация';
	@override String get importSuccess => 'Импорт выполнен успешно';
	@override String get rewriteConfirm => 'Этот файл перезапишет существующую локальную профиль. Продолжить?';
	@override String get importAndExport => 'Импорт и экспорт';
	@override String get import => 'Импорт';
	@override String get importFromUrl => 'Импорт из URL';
	@override String get export => 'Экспорт';
	@override String get send => 'Передать';
	@override String get receive => 'Принять';
	@override String get sendConfirm => 'Подтверждаете передачу?';
	@override String get continueConnectConfirm => 'Продолжить подключение?';
	@override String get termOfUse => 'Условия использования';
	@override String get privacyPolicy => 'Политика конфиденциальности';
	@override String get log => 'Журнал';
	@override String get coreLog => 'Журнал ядра';
	@override String get core => 'Ядро';
	@override String get help => 'Помощь';
	@override String get tutorial => 'Руководство';
	@override String get board => 'Панель';
	@override String get boardOnline => 'Использование онлайн-панели';
	@override String get boardOnlineUrl => 'URL-адрес онлайн-панели';
	@override String get boardLocalPort => 'Порт локальной панели';
	@override String get alwayOnVPN => 'VPN всегда включен';
	@override String get disableFontScaler => 'Отключить масштабирование шрифта';
	@override String get autoOrientation => 'Следовать за поворотом экрана';
	@override String get restartTakesEffect => 'Требуется перезапуск';
	@override String get reconnectTakesEffect => 'Изменения вступят в силу после повторного подключения.';
	@override String get runtimeProfile => 'Конфигурация времени выполнения';
	@override String get willCompleteAfterRebootInstall => 'Пожалуйста, перезагрузите устройство, чтобы завершить установку расширения системы.';
	@override String get willCompleteAfterRebootUninstall => 'Пожалуйста, перезагрузите устройство, чтобы завершить удаление системного расширения.';
	@override String get requestNeedsUserApproval => '1. Пожалуйста, [разрешите] Clash Mi устанавливать системные расширения в [Системные настройки] - [Конфиденциальность и безопасность]. 2. : [Системные настройки] - [Основные] - [Элементы входа и расширения - Сетевые расширения] Включите [clashmiServiceSE]. После завершения подключитесь снова.';
	@override String get FullDiskAccessPermissionRequired => 'Включите разрешение clashmiServiceSE в [Системные настройки]-[Конфиденциальность и безопасность]-[Полный доступ к диску] и переподключитесь.';
	@override String get proxy => 'Прокси';
	@override String get theme => 'Тема';
	@override String get tvMode => 'Режим ТВ';
	@override String get autoUpdate => 'Автоматические обновления';
	@override String get updateChannel => 'Канал автоматического обновления';
	@override String get onlineCustomerService => 'Онлайн-служба поддержки';
	@override String get subscriptionChannel => 'Канал подписки';
	@override String hasNewVersion({required Object p}) => 'Обновить версию ${p}';
	@override String get autoDownloadPkg => 'Автоматически загружать пакеты обновлений';
	@override String get devOptions => 'Параметры разработчика';
	@override String get about => 'О приложении';
	@override String get name => 'Название';
	@override String get version => 'Версия';
	@override String get notice => 'Уведомления';
	@override String get sort => 'Отсортировать';
	@override String get recommended => 'Рекомендуемые';
	@override String innerError({required Object p}) => 'Внутренняя ошибка:${p}';
	@override String get share => 'Поделиться';
	@override String get importFromClipboard => 'Импорт из буфера обмена';
	@override String get exportToClipboard => 'Экспорт в буфер обмена';
	@override String get server => 'Сервер';
	@override String get port => 'Порт';
	@override String get donate => 'Пожертвовать';
	@override String get setting => 'Настройки';
	@override String get settingCore => 'Настройки ядра';
	@override String get settingApp => 'Настройки приложения';
	@override String get coreOverwrite => 'Переопределение ядра';
	@override String get iCloud => 'iCloud';
	@override String get webdav => 'Webdav';
	@override String get lanSync => 'Синхронизация по локальной сети';
	@override String get lanSyncNotQuitTips => 'Не выходите из этого окна до завершения синхронизации.';
	@override String get deviceNoSpace => 'Недостаточно места на диске';
	@override String get hideSystemApp => 'Скрыть системные приложения';
	@override String get hideAppIcon => 'Скрыть значок приложения';
	@override String get openDir => 'Открыть каталог файлов';
	@override String get type => 'Тип';
	@override String get fileChoose => 'Выбрать файл';
	@override String get filePathCannotEmpty => 'Путь к файлу не может быть пустым';
	@override String fileNotExist({required Object p}) => 'Файла не существует:${p}';
	@override String fileTypeInvalid({required Object p}) => 'Неверный тип файла:${p}';
	@override String get uwpExemption => 'Исключение из изоляции сети UWP';
	@override String get getProfile => 'Получить профиль';
	@override String get buyProfile => 'Купить профиль';
	@override String get addProfile => 'Добавить профиль';
	@override String get myProfiles => 'Профили';
	@override String get profileEdit => 'Редактирование профилей';
	@override String get profileNeedActive => 'Сначала сделайте этот профиль текущим, затем включите подключение/переподключитесь';
	@override String get profileDownloadBackupChannel => 'Включить резервный канал загрузки';
	@override String get profileDownloadBackupChannelTips => 'Прокси-канал загрузки, предоставляемый Clash Mi (никакая информация не сохраняется)';
	@override String get profileEditReloadAfterProfileUpdate => 'Перезагрузить после обновления профиля';
	@override String get profileRulesAppendApplePush => 'Добавить правила Push-уведомлений Apple';
	@override String get profileRulesAppendProxyTips => 'Правила будут автоматически установлены на первый прокси в [proxy-groups] исходной конфигурации с типом [url-test] или [select]';
	@override String get profileImport => 'Импорт файла конфигурации';
	@override String get profileAddUrlOrContent => 'Добавление подписки';
	@override String get profileUrlOrContent => 'Ссылка на профиль Clash';
	@override String get profileUrlOrContentHit => 'Ссылка на профиль Clash [обязательно]';
	@override String get profileUrlOrContentCannotEmpty => 'Ссылка на подписку не может быть пустой';
}

// Path: permission
class _Translations$permission$ru implements Translations$permission$en {
	_Translations$permission$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get camera => 'Камера';
	@override String get screen => 'Запись экрана';
	@override String get appQuery => 'Получить список приложений';
	@override String request({required Object p}) => 'Включить разрешения [${p}]';
	@override String requestNeed({required Object p}) => 'Пожалуйста, включите разрешение [${p}]';
}

// Path: tls
class _Translations$tls$ru implements Translations$tls$en {
	_Translations$tls$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get insecure => 'Пропустить проверку сертификата';
	@override String get certificate => 'Сертификат';
	@override String get privateKey => 'Закрытый ключ';
	@override String get customTrustCert => 'Индивидуальные сертификаты';
}

// Path: tun
class _Translations$tun$ru implements Translations$tun$en {
	_Translations$tun$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get stack => 'Сетевой стек';
	@override String get inet4Address => 'Диапазон IPv4-адресов';
	@override String get inet6Address => 'Диапазон IPv6-адресов';
	@override String get dnsHijack => 'Перехват DNS';
	@override String get strictRoute => 'Строгая маршрутизация';
	@override String get tunDefaultRoute => 'Маршрут по умолчанию';
	@override String get icmpForward => 'Пересылка ICMP';
	@override String get allowBypass => 'Разрешить приложениям обходить VPN';
	@override String get appendHttpProxy => 'Подключите HTTP-прокси к VPN';
	@override String get bypassHttpProxyDomain => 'Домены, которым разрешено обходить HTTP-прокси';
}

// Path: dns
class _Translations$dns$ru implements Translations$dns$en {
	_Translations$dns$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get listen => 'Аудиторское обращение';
	@override String get fakeIp => 'fake-ip';
	@override String get fallback => 'Fallback';
	@override String get preferH3 => 'Приоритет DoH H3';
	@override String get useHosts => 'Использование хостов';
	@override String get useSystemHosts => 'Использование системных хостов';
	@override String get enhancedMode => 'Расширенный режим';
	@override String get fakeIPFilterMode => '${_root.dns.fakeIp} режим фильтра';
	@override String get fakeIPFilter => '${_root.dns.fakeIp} фильтрация';
	@override String get respectRules => 'Соблюдайте правила.';
	@override String get nameServer => 'DNS-сервер';
	@override String get defaultNameServer => '${_root.meta.byDefault} ${_root.dns.nameServer}';
	@override String get proxyNameServer => '${_root.meta.proxy} ${_root.dns.nameServer}';
	@override String get directNameServer => '${_root.meta.direct} ${_root.dns.nameServer}';
	@override String get fallbackNameServer => '${_root.dns.fallback} ${_root.dns.nameServer}';
	@override String get fallbackGeoIp => '${_root.dns.fallback} GeoIp';
	@override String get fallbackGeoIpCode => '${_root.dns.fallback} GeoIpCode';
}

// Path: sniffer
class _Translations$sniffer$ru implements Translations$sniffer$en {
	_Translations$sniffer$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get overrideDest => 'Переназначить';
}

// Path: profilePatchMode
class _Translations$profilePatchMode$ru implements Translations$profilePatchMode$en {
	_Translations$profilePatchMode$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get currentSelected => 'Текущий сервер';
	@override String get overwrite => 'Встроенная функция переопределения';
	@override String get noOverwrite => 'Встроенный - не перезаписывается';
}

// Path: main.tray
class _Translations$main$tray$ru implements Translations$main$tray$en {
	_Translations$main$tray$ru._(this._root);

	final TranslationsRu _root; // ignore: unused_field

	// Translations
	@override String get menuOpen => 'Открыть';
	@override String get menuExit => 'Выйти';
}

/// The flat map containing all translations for locale <ru>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsRu {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'BackupAndSyncWebdavScreen.webdavServerUrl' => 'Адрес сервера',
			'BackupAndSyncWebdavScreen.webdavRequired' => 'Не может быть пустым',
			'BackupAndSyncWebdavScreen.webdavLoginFailed' => 'Ошибка входа:',
			'BackupAndSyncWebdavScreen.webdavListFailed' => 'Не удалось получить список файлов:',
			'LaunchFailedScreen.invalidProcess' => 'Не удалось запустить приложение [Неверное имя процесса], переустановите приложение в отдельную папку',
			'LaunchFailedScreen.invalidProfile' => 'Не удалось запустить приложение [Не удалось получить доступ к профилю], переустановите приложение',
			'LaunchFailedScreen.invalidVersion' => 'Не удалось запустить приложение [Неверная версия], переустановите приложение',
			'LaunchFailedScreen.systemVersionLow' => 'Не удалось запустить приложение [Слишком низкая версия системы]',
			'LaunchFailedScreen.invalidInstallPath' => 'Путь установки недействителен, переустановите его по допустимому пути',
			'PerAppAndroidScreen.title' => 'Проксируемые приложения',
			'PerAppAndroidScreen.whiteListMode' => 'Режим белого списка',
			'PerAppAndroidScreen.whiteListModeTip' => 'Если включено: перенаправляются через прокси-сервер только те приложения, которые были отмечены. Если выключено: перенаправляются через прокси-сервер только те приложения, которые не были отмечены.',
			'UserAgreementScreen.privacyFirst' => 'Ваша конфиденциальность превыше всего',
			'UserAgreementScreen.agreeAndContinue' => 'Принять и продолжить',
			'NetCheckScreen.enterDomain' => 'Введите доменное имя',
			'NetCheckScreen.checking' => 'Проверка...',
			'NetCheckScreen.aQueryFailed' => ({required Object p}) => 'Ошибка запроса A: ${p}',
			'NetCheckScreen.aaaaQueryFailed' => ({required Object p}) => 'Ошибка запроса AAAA: ${p}',
			'NetCheckScreen.success' => 'Успех',
			'NetCheckScreen.failed' => 'Ошибка',
			'NetCheckScreen.suspectedPollution' => 'Подозрение на DNS-отравление',
			'NetCheckScreen.domainLabel' => 'Домен',
			'NetCheckScreen.checkButton' => 'Проверить',
			'NetCheckScreen.dnsSection' => '1. DNS-запрос',
			'NetCheckScreen.directHttpSection' => '2. HTTP (через TUN, сначала включите TUN)',
			'NetCheckScreen.proxyHttpSection' => ({required Object p}) => '3. HTTP (через прокси, порт: ${p})',
			'NetCheckScreen.tunNotEnabled' => 'TUN не включён',
			'NetCheckScreen.routeTableSection' => '4. Таблица маршрутов',
			'VersionUpdateScreen.versionReady' => ({required Object p}) => 'Новая версия [${p}] доступна',
			'VersionUpdateScreen.update' => 'Перезапустить',
			'VersionUpdateScreen.cancel' => 'Не сейчас',
			'loginScreen.login' => 'Вход',
			'loginScreen.register' => 'Зарегистрировать аккаунт',
			'loginScreen.forgotPassword' => 'Забыли пароль',
			'loginScreen.provider' => 'Провайдер',
			'loginScreen.providerName' => 'Код/алиас/URL ${_root.loginScreen.provider}',
			'loginScreen.providerNameRequired' => 'Пожалуйста, введите код/алиас/URL ${_root.loginScreen.provider}',
			'loginScreen.account' => 'Аккаунт',
			'loginScreen.accountRequired' => 'Пожалуйста, введите аккаунт',
			'loginScreen.email' => 'Электронная почта',
			'loginScreen.emailRequired' => 'Пожалуйста, введите адрес электронной почты',
			'loginScreen.password' => 'Пароль',
			'loginScreen.passwordRequired' => 'Пожалуйста, введите пароль',
			'loginScreen.validEmailRequired' => 'Пожалуйста, введите действительный адрес электронной почты',
			'loginScreen.passwordMinLength' => ({required Object minLength}) => 'Длина пароля должна быть не менее ${minLength} символов',
			'loginScreen.unsupportedProvider' => 'Неподдерживаемый ${_root.loginScreen.provider}',
			'loginScreen.unsupportedProviderType' => 'Неподдерживаемый тип ${_root.loginScreen.provider}',
			'loginScreen.unActivedProvider' => 'Функция входа не активирована',
			'loginScreen.providerLoginSupportRequired' => ({required Object p}) => 'Запросите код/алиас провайдера у вашего ${_root.loginScreen.provider}.\nИнструкцию по интеграции с ${_root.loginScreen.provider} смотрите: ${p}',
			'loginScreen.providerDisclaimer' => 'Отказ от ответственности: ${_root.loginScreen.provider} — это сторонний сервис и не связан с этим приложением',
			'main.tray.menuOpen' => 'Открыть',
			'main.tray.menuExit' => 'Выйти',
			'meta.enable' => 'Включить',
			'meta.disable' => 'Запретить',
			'meta.open' => 'Открыть',
			'meta.close' => 'Закрыть',
			'meta.quit' => 'Выйти',
			'meta.add' => 'Добавить',
			'meta.addSuccess' => 'Добавлено успешно',
			'meta.addFailed' => ({required Object p}) => 'Ошибка при добавлении:${p}',
			'meta.remove' => 'Удалить',
			'meta.removeConfirm' => 'Подтверждаете удаление?',
			'meta.edit' => 'Редактировать',
			'meta.view' => 'Просмотр',
			'meta.remark' => 'Примечание',
			'meta.byDefault' => 'по умолчанию',
			'meta.editRemark' => 'Заметки об изменениях',
			'meta.more' => 'Больше',
			'meta.tips' => 'Инфо',
			'meta.selectAll' => 'Выбрать все',
			'meta.copy' => 'Скопировать',
			'meta.paste' => 'Вставить',
			'meta.cut' => 'Вырезать',
			'meta.save' => 'Сохранить',
			'meta.ok' => 'Ок',
			'meta.cancel' => 'Закрыть',
			'meta.faq' => 'Часто задаваемые вопросы (FAQ)',
			'meta.doc' => 'документ',
			'meta.htmlTools' => 'HTML Toolset',
			'meta.download' => 'Скачать',
			'meta.loading' => 'Загрузка...',
			'meta.days' => 'дни',
			'meta.hours' => 'часы',
			'meta.minutes' => 'минуты',
			'meta.seconds' => 'секунды',
			'meta.milliseconds' => 'миллисекунды',
			'meta.protocol' => 'Протокол',
			'meta.search' => 'Поиск',
			'meta.custom' => 'Настроить самостоятельно',
			'meta.connect' => 'Соединить',
			'meta.disconnect' => 'Отключить',
			'meta.connected' => 'Подключено',
			'meta.disconnected' => 'Отключено',
			'meta.connecting' => 'Подключение',
			'meta.connectTimeout' => 'Таймаут при соединении',
			'meta.timeout' => 'Тайм-аут',
			'meta.timeoutDuration' => 'Длительность тайм-аута',
			'meta.latency' => 'Задерживать',
			'meta.latencyTest' => 'Обнаружение задержки',
			'meta.networkCheck' => 'Проверка сети',
			'meta.language' => 'Язык',
			'meta.next' => 'Дальше',
			'meta.done' => 'Готово',
			'meta.apply' => 'Применить',
			'meta.refresh' => 'Обновить',
			'meta.retry' => 'Хотите попробовать еще раз?',
			'meta.update' => 'Обновить',
			'meta.updateInterval' => 'Интервал обновления',
			'meta.updateInterval5mTips' => 'Минимум: 5 м',
			'meta.updateIntervalPreferByProfile' => 'Приоритет настроек провайдера',
			'meta.updateFailed' => ({required Object p}) => 'Не удалось обновить:${p}',
			'meta.none' => 'Ничего не делать',
			'meta.reset' => 'Перезагрузить',
			'meta.authentication' => 'Авторизация',
			'meta.submit' => 'Отправить',
			'meta.user' => 'Пользователь',
			'meta.account' => 'Аккаунт',
			'meta.password' => 'Пароль',
			'meta.decryptPassword' => 'Пароль расшифровки',
			'meta.required' => 'Необходимо',
			'meta.go' => 'Продолжить',
			'meta.sudoPassword' => 'Пароль sudo (требуется для режима TUN)',
			'meta.other' => 'Другой',
			'meta.dns' => 'DNS',
			'meta.url' => 'URL',
			'meta.urlInvalid' => 'Неверный URL',
			'meta.urlCannotEmpty' => 'Ссылка не может быть пустой',
			'meta.urlTooLong' => 'URL слишком длинный (>8182)',
			'meta.copyUrl' => 'Скопировать ссылку',
			'meta.openUrl' => 'Открыть ссылку',
			'meta.shareUrl' => 'Поделиться ссылкой',
			'meta.coreSettingTips' => 'Примечание: После изменения конфигурации необходимо повторно подключиться, чтобы изменения вступили в силу.',
			'meta.overwrite' => 'Переопределить',
			'meta.overwriteCustom' => 'Пользовательские переопределения',
			'meta.overwriteAppend' => 'Дополнительное переопределение',
			'meta.overwriteTips' => 'Исходная конфигурация <- Пользовательское переопределение <- Переопределение приложения',
			'meta.noOverwrite' => 'Не перезаписывать',
			'meta.overwriteSettings' => 'Переопределить настройки',
			'meta.diversionTemplates' => 'Шаблон сортировки пациентов',
			'meta.ruleProviders' => 'Поставщик правил',
			'meta.ruleTemplates' => 'Шаблон правила',
			'meta.proxyGroupsTemplates' => 'Шаблон группы агентов',
			'meta.proxyGroups' => 'Группа агентов',
			'meta.proxyNodeList' => 'Список прокси-узлов',
			'meta.proxyNodeFailure' => ({required Object p}) => 'Срок действия следующих прокси-узлов истек, и они были автоматически удалены: ${p}',
			'meta.externalController' => 'Внешнее управление',
			'meta.secret' => 'Пароль',
			'meta.tcpConcurrent' => 'Параллельное TCP-подтверждение',
			'meta.globalClientFingerprint' => 'Глобальный отпечаток пальца TLS',
			'meta.allowLanAccess' => 'Доступ к локальной сети устройства',
			'meta.mixedPort' => 'Порт mixed-прокси',
			'meta.logLevel' => 'Уровень журнала',
			'meta.findProcessMode' => 'Режим поиска процесса',
			'meta.tcpkeepAliveInterval' => 'Интервал проверки активности TCP',
			'meta.delayTestUrl' => 'URL-адрес теста задержки',
			'meta.delayTestTimeout' => 'Время ожидания теста задержки (мс)',
			'meta.tun' => 'TUN',
			'meta.ntp' => 'NTP',
			'meta.tls' => 'TLS',
			'meta.geo' => 'GEO',
			'meta.geoDownloadByProxy' => 'Загрузка гео-правил через прокси',
			'meta.geoRulesetTips' => 'Geosite/Geoip будет преобразован в соответствующий RuleSet',
			'meta.asnNotSupportInIosTips' => 'Из-за ограничений памяти системы iOS правила IP-ASN и SRC-IP-ASN будут игнорироваться в iOS.',
			'meta.sniffer' => 'Обнаружение доменов',
			'meta.userAgent' => 'UserAgent',
			'meta.launchAtStartup' => 'Запуск при включении',
			'meta.launchAtStartupRunAsAdmin' => 'Пожалуйста, перезапустите Clash Mi от имени администратора.',
			'meta.tunModeRunAsAdmin' => 'Для режима TUN требуются права администратора. Перезапустите приложение от имени администратора',
			'meta.portableMode' => 'Портативный режим',
			'meta.portableModeDisableTips' => 'Если вам нужно выйти из портативного режима, выйдите из [clashmi] и вручную удалите папку [portable] в том же каталоге, что и [clashmi.exe]',
			'meta.systemProxy' => 'Системный прокси',
			'meta.autoConnectAfterLaunch' => 'Автоматическое подключение после запуска',
			'meta.autoConnectAtBoot' => 'Автоматическое подключение после запуска системы',
			'meta.autoConnectAtBootTips' => 'Требуется поддержка системы; некоторые системы также могут потребовать включения [автозапуска].',
			'meta.hideAfterLaunch' => 'Скрыть окно после запуска',
			'meta.autoSetSystemProxy' => 'Установить системный прокси после подключения',
			'meta.bypassSystemProxy' => 'Доменные имена, которым разрешено обходить системный прокси-сервер',
			'meta.excludeFromRecent' => 'Скрыть из недавних задач',
			'meta.wakeLock' => 'Блокировка пробуждения',
			'meta.hideVpn' => 'Скрыть значок VPN',
			'meta.hideVpnTips' => 'Включение IPv6 приведет к сбою этой функции.',
			'meta.hideDockIcon' => 'Скрыть значок дока',
			'meta.showTrayTraffic' => 'Показывать трафик в трее',
			'meta.website' => 'Веб-сайт',
			'meta.homePage' => 'Главная',
			'meta.rule' => 'Правила',
			'meta.global' => 'Глобально',
			'meta.direct' => 'Напрямую',
			'meta.block' => 'Блокировать',
			'meta.qrcode' => 'QR-код',
			'meta.qrcodeTooLong' => 'Слишком большой текст для отображения',
			'meta.qrcodeShare' => 'Поделиться QR-кодом',
			'meta.textToQrcode' => 'Преобразование текста в QR-код',
			'meta.qrcodeScan' => 'Сканировать QR-код',
			'meta.qrcodeScanResult' => 'Результат сканирования',
			'meta.qrcodeScanFromImage' => 'Открыть',
			'meta.qrcodeScanResultFailed' => 'Не удалось проанализировать изображение. Убедитесь, что снимок экрана представляет собой действительный QR-код.',
			'meta.qrcodeScanResultEmpty' => 'Пустой результат сканирования.',
			'meta.screenshot' => 'Скриншот',
			'meta.backupAndSync' => 'Резервное копирование и синхронизация',
			'meta.importSuccess' => 'Импорт выполнен успешно',
			'meta.rewriteConfirm' => 'Этот файл перезапишет существующую локальную профиль. Продолжить?',
			'meta.importAndExport' => 'Импорт и экспорт',
			'meta.import' => 'Импорт',
			'meta.importFromUrl' => 'Импорт из URL',
			'meta.export' => 'Экспорт',
			'meta.send' => 'Передать',
			'meta.receive' => 'Принять',
			'meta.sendConfirm' => 'Подтверждаете передачу?',
			'meta.continueConnectConfirm' => 'Продолжить подключение?',
			'meta.termOfUse' => 'Условия использования',
			'meta.privacyPolicy' => 'Политика конфиденциальности',
			'meta.log' => 'Журнал',
			'meta.coreLog' => 'Журнал ядра',
			'meta.core' => 'Ядро',
			'meta.help' => 'Помощь',
			'meta.tutorial' => 'Руководство',
			'meta.board' => 'Панель',
			'meta.boardOnline' => 'Использование онлайн-панели',
			'meta.boardOnlineUrl' => 'URL-адрес онлайн-панели',
			'meta.boardLocalPort' => 'Порт локальной панели',
			'meta.alwayOnVPN' => 'VPN всегда включен',
			'meta.disableFontScaler' => 'Отключить масштабирование шрифта',
			'meta.autoOrientation' => 'Следовать за поворотом экрана',
			'meta.restartTakesEffect' => 'Требуется перезапуск',
			'meta.reconnectTakesEffect' => 'Изменения вступят в силу после повторного подключения.',
			'meta.runtimeProfile' => 'Конфигурация времени выполнения',
			'meta.willCompleteAfterRebootInstall' => 'Пожалуйста, перезагрузите устройство, чтобы завершить установку расширения системы.',
			'meta.willCompleteAfterRebootUninstall' => 'Пожалуйста, перезагрузите устройство, чтобы завершить удаление системного расширения.',
			'meta.requestNeedsUserApproval' => '1. Пожалуйста, [разрешите] Clash Mi устанавливать системные расширения в [Системные настройки] - [Конфиденциальность и безопасность]. 2. : [Системные настройки] - [Основные] - [Элементы входа и расширения - Сетевые расширения] Включите [clashmiServiceSE]. После завершения подключитесь снова.',
			'meta.FullDiskAccessPermissionRequired' => 'Включите разрешение clashmiServiceSE в [Системные настройки]-[Конфиденциальность и безопасность]-[Полный доступ к диску] и переподключитесь.',
			'meta.proxy' => 'Прокси',
			'meta.theme' => 'Тема',
			'meta.tvMode' => 'Режим ТВ',
			'meta.autoUpdate' => 'Автоматические обновления',
			'meta.updateChannel' => 'Канал автоматического обновления',
			'meta.onlineCustomerService' => 'Онлайн-служба поддержки',
			'meta.subscriptionChannel' => 'Канал подписки',
			'meta.hasNewVersion' => ({required Object p}) => 'Обновить версию ${p}',
			'meta.autoDownloadPkg' => 'Автоматически загружать пакеты обновлений',
			'meta.devOptions' => 'Параметры разработчика',
			'meta.about' => 'О приложении',
			'meta.name' => 'Название',
			'meta.version' => 'Версия',
			'meta.notice' => 'Уведомления',
			'meta.sort' => 'Отсортировать',
			'meta.recommended' => 'Рекомендуемые',
			'meta.innerError' => ({required Object p}) => 'Внутренняя ошибка:${p}',
			'meta.share' => 'Поделиться',
			'meta.importFromClipboard' => 'Импорт из буфера обмена',
			'meta.exportToClipboard' => 'Экспорт в буфер обмена',
			'meta.server' => 'Сервер',
			'meta.port' => 'Порт',
			'meta.donate' => 'Пожертвовать',
			'meta.setting' => 'Настройки',
			'meta.settingCore' => 'Настройки ядра',
			'meta.settingApp' => 'Настройки приложения',
			'meta.coreOverwrite' => 'Переопределение ядра',
			'meta.iCloud' => 'iCloud',
			'meta.webdav' => 'Webdav',
			'meta.lanSync' => 'Синхронизация по локальной сети',
			'meta.lanSyncNotQuitTips' => 'Не выходите из этого окна до завершения синхронизации.',
			'meta.deviceNoSpace' => 'Недостаточно места на диске',
			'meta.hideSystemApp' => 'Скрыть системные приложения',
			'meta.hideAppIcon' => 'Скрыть значок приложения',
			'meta.openDir' => 'Открыть каталог файлов',
			'meta.type' => 'Тип',
			'meta.fileChoose' => 'Выбрать файл',
			'meta.filePathCannotEmpty' => 'Путь к файлу не может быть пустым',
			'meta.fileNotExist' => ({required Object p}) => 'Файла не существует:${p}',
			'meta.fileTypeInvalid' => ({required Object p}) => 'Неверный тип файла:${p}',
			'meta.uwpExemption' => 'Исключение из изоляции сети UWP',
			'meta.getProfile' => 'Получить профиль',
			'meta.buyProfile' => 'Купить профиль',
			'meta.addProfile' => 'Добавить профиль',
			'meta.myProfiles' => 'Профили',
			'meta.profileEdit' => 'Редактирование профилей',
			'meta.profileNeedActive' => 'Сначала сделайте этот профиль текущим, затем включите подключение/переподключитесь',
			'meta.profileDownloadBackupChannel' => 'Включить резервный канал загрузки',
			'meta.profileDownloadBackupChannelTips' => 'Прокси-канал загрузки, предоставляемый Clash Mi (никакая информация не сохраняется)',
			'meta.profileEditReloadAfterProfileUpdate' => 'Перезагрузить после обновления профиля',
			'meta.profileRulesAppendApplePush' => 'Добавить правила Push-уведомлений Apple',
			'meta.profileRulesAppendProxyTips' => 'Правила будут автоматически установлены на первый прокси в [proxy-groups] исходной конфигурации с типом [url-test] или [select]',
			'meta.profileImport' => 'Импорт файла конфигурации',
			'meta.profileAddUrlOrContent' => 'Добавление подписки',
			'meta.profileUrlOrContent' => 'Ссылка на профиль Clash',
			'meta.profileUrlOrContentHit' => 'Ссылка на профиль Clash [обязательно]',
			'meta.profileUrlOrContentCannotEmpty' => 'Ссылка на подписку не может быть пустой',
			'permission.camera' => 'Камера',
			'permission.screen' => 'Запись экрана',
			'permission.appQuery' => 'Получить список приложений',
			'permission.request' => ({required Object p}) => 'Включить разрешения [${p}]',
			'permission.requestNeed' => ({required Object p}) => 'Пожалуйста, включите разрешение [${p}]',
			'tls.insecure' => 'Пропустить проверку сертификата',
			'tls.certificate' => 'Сертификат',
			'tls.privateKey' => 'Закрытый ключ',
			'tls.customTrustCert' => 'Индивидуальные сертификаты',
			'tun.stack' => 'Сетевой стек',
			'tun.inet4Address' => 'Диапазон IPv4-адресов',
			'tun.inet6Address' => 'Диапазон IPv6-адресов',
			'tun.dnsHijack' => 'Перехват DNS',
			'tun.strictRoute' => 'Строгая маршрутизация',
			'tun.tunDefaultRoute' => 'Маршрут по умолчанию',
			'tun.icmpForward' => 'Пересылка ICMP',
			'tun.allowBypass' => 'Разрешить приложениям обходить VPN',
			'tun.appendHttpProxy' => 'Подключите HTTP-прокси к VPN',
			'tun.bypassHttpProxyDomain' => 'Домены, которым разрешено обходить HTTP-прокси',
			'dns.listen' => 'Аудиторское обращение',
			'dns.fakeIp' => 'fake-ip',
			'dns.fallback' => 'Fallback',
			'dns.preferH3' => 'Приоритет DoH H3',
			'dns.useHosts' => 'Использование хостов',
			'dns.useSystemHosts' => 'Использование системных хостов',
			'dns.enhancedMode' => 'Расширенный режим',
			'dns.fakeIPFilterMode' => '${_root.dns.fakeIp} режим фильтра',
			'dns.fakeIPFilter' => '${_root.dns.fakeIp} фильтрация',
			'dns.respectRules' => 'Соблюдайте правила.',
			'dns.nameServer' => 'DNS-сервер',
			'dns.defaultNameServer' => '${_root.meta.byDefault} ${_root.dns.nameServer}',
			'dns.proxyNameServer' => '${_root.meta.proxy} ${_root.dns.nameServer}',
			'dns.directNameServer' => '${_root.meta.direct} ${_root.dns.nameServer}',
			'dns.fallbackNameServer' => '${_root.dns.fallback} ${_root.dns.nameServer}',
			'dns.fallbackGeoIp' => '${_root.dns.fallback} GeoIp',
			'dns.fallbackGeoIpCode' => '${_root.dns.fallback} GeoIpCode',
			'sniffer.overrideDest' => 'Переназначить',
			'profilePatchMode.currentSelected' => 'Текущий сервер',
			'profilePatchMode.overwrite' => 'Встроенная функция переопределения',
			'profilePatchMode.noOverwrite' => 'Встроенный - не перезаписывается',
			'protocolSniff' => 'Определение протокола',
			'protocolSniffOverrideDestination' => 'Обнаруженное имя домена перезаписывает целевой адрес подключения.',
			'edgeRuntimeNotInstalled' => 'Среда выполнения Edge WebView2 не установлена ​​на текущем устройстве, и страница не может быть отображена. Загрузите и установите среду выполнения Edge WebView2 (x64), перезапустите приложение и повторите попытку.',
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
