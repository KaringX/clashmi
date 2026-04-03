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
class TranslationsEs with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsEs({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.es,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <es>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsEs _root = this; // ignore: unused_field

	@override 
	TranslationsEs $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsEs(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsBackupAndSyncWebdavScreenEs BackupAndSyncWebdavScreen = _TranslationsBackupAndSyncWebdavScreenEs._(_root);
	@override late final _TranslationsLaunchFailedScreenEs LaunchFailedScreen = _TranslationsLaunchFailedScreenEs._(_root);
	@override late final _TranslationsPerAppAndroidScreenEs PerAppAndroidScreen = _TranslationsPerAppAndroidScreenEs._(_root);
	@override late final _TranslationsUserAgreementScreenEs UserAgreementScreen = _TranslationsUserAgreementScreenEs._(_root);
	@override late final _TranslationsVersionUpdateScreenEs VersionUpdateScreen = _TranslationsVersionUpdateScreenEs._(_root);
	@override late final _TranslationsNetCheckScreenEs NetCheckScreen = _TranslationsNetCheckScreenEs._(_root);
	@override late final _TranslationsMainEs main = _TranslationsMainEs._(_root);
	@override late final _TranslationsMetaEs meta = _TranslationsMetaEs._(_root);
	@override late final _TranslationsPermissionEs permission = _TranslationsPermissionEs._(_root);
	@override late final _TranslationsTlsEs tls = _TranslationsTlsEs._(_root);
	@override late final _TranslationsTunEs tun = _TranslationsTunEs._(_root);
	@override late final _TranslationsDnsEs dns = _TranslationsDnsEs._(_root);
	@override late final _TranslationsSnifferEs sniffer = _TranslationsSnifferEs._(_root);
	@override late final _TranslationsProfilePatchModeEs profilePatchMode = _TranslationsProfilePatchModeEs._(_root);
	@override String get protocolSniff => 'Husmeador de Protocolos';
	@override String get protocolSniffOverrideDestination => 'El nombre de dominio husmeado sobrescribe la dirección de destino de la conexión';
	@override String get edgeRuntimeNotInstalled => 'El dispositivo actual no tiene instalado el tiempo de ejecución de Edge WebView2, por lo que la página no se puede mostrar. Por favor, descargue e instale el tiempo de ejecución de Edge WebView2 (x64), reinicie la App e inténtelo de nuevo.';
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
class _TranslationsBackupAndSyncWebdavScreenEs implements TranslationsBackupAndSyncWebdavScreenEn {
	_TranslationsBackupAndSyncWebdavScreenEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get webdavServerUrl => 'URL del Servidor';
	@override String get webdavRequired => 'No puede estar vacío';
	@override String get webdavLoginFailed => 'Error de inicio de sesión:';
	@override String get webdavListFailed => 'Error al obtener la lista de archivos:';
}

// Path: LaunchFailedScreen
class _TranslationsLaunchFailedScreenEs implements TranslationsLaunchFailedScreenEn {
	_TranslationsLaunchFailedScreenEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get invalidProcess => 'La aplicación no pudo iniciarse [Nombre de proceso no válido], por favor reinstale la aplicación en un directorio separado';
	@override String get invalidProfile => 'La aplicación no pudo iniciarse [Error al acceder al perfil], por favor reinstale la aplicación';
	@override String get invalidVersion => 'La aplicación no pudo iniciarse [Versión no válida], por favor reinstale la aplicación';
	@override String get systemVersionLow => 'La aplicación no pudo iniciarse [Versión del sistema demasiado baja]';
	@override String get invalidInstallPath => 'La ruta de instalación no es válida, por favor reinstale en una ruta válida';
}

// Path: PerAppAndroidScreen
class _TranslationsPerAppAndroidScreenEs implements TranslationsPerAppAndroidScreenEn {
	_TranslationsPerAppAndroidScreenEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get title => 'Proxy por Aplicación';
	@override String get whiteListMode => 'Modo Lista Blanca';
	@override String get whiteListModeTip => 'Cuando está habilitado: solo las aplicaciones marcadas son proxies; cuando no está habilitado: solo las aplicaciones no marcadas son proxies';
}

// Path: UserAgreementScreen
class _TranslationsUserAgreementScreenEs implements TranslationsUserAgreementScreenEn {
	_TranslationsUserAgreementScreenEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get privacyFirst => 'Su privacidad es lo primero';
	@override String get agreeAndContinue => 'Aceptar y Continuar';
}

// Path: VersionUpdateScreen
class _TranslationsVersionUpdateScreenEs implements TranslationsVersionUpdateScreenEn {
	_TranslationsVersionUpdateScreenEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String versionReady({required Object p}) => 'La nueva versión [${p}] está lista';
	@override String get update => 'Reiniciar para Actualizar';
	@override String get cancel => 'Ahora no';
}

// Path: NetCheckScreen
class _TranslationsNetCheckScreenEs implements TranslationsNetCheckScreenEn {
	_TranslationsNetCheckScreenEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get enterDomain => 'Por favor, introduzca un dominio';
	@override String get checking => 'Comprobando...';
	@override String aQueryFailed({required Object p}) => 'Falló una consulta: ${p}';
	@override String aaaaQueryFailed({required Object p}) => 'Falló la consulta AAAA: ${p}';
	@override String get success => 'Éxito';
	@override String get failed => 'Fallido';
	@override String get domainLabel => 'Dominio';
	@override String get checkButton => 'Comprobar';
	@override String get dnsSection => '1. Consulta DNS';
	@override String get directHttpSection => '2. HTTP (vía TUN, habilite TUN primero)';
	@override String proxyHttpSection({required Object p}) => '3. HTTP (vía Proxy, puerto: ${p})';
	@override String get tunNotEnabled => 'TUN no está habilitado';
}

// Path: main
class _TranslationsMainEs implements TranslationsMainEn {
	_TranslationsMainEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsMainTrayEs tray = _TranslationsMainTrayEs._(_root);
}

// Path: meta
class _TranslationsMetaEs implements TranslationsMetaEn {
	_TranslationsMetaEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get enable => 'Habilitar';
	@override String get disable => 'Deshabilitar';
	@override String get open => 'Abrir';
	@override String get close => 'Cerrar';
	@override String get quit => 'Salir';
	@override String get add => 'Añadir';
	@override String get addSuccess => 'Añadido con éxito';
	@override String addFailed({required Object p}) => 'Error al añadir: ${p}';
	@override String get remove => 'Eliminar';
	@override String get removeConfirm => '¿Está seguro de eliminar?';
	@override String get edit => 'Editar';
	@override String get view => 'Ver';
	@override String get remark => 'Observación';
	@override String get byDefault => 'Por defecto';
	@override String get editRemark => 'Editar Observación';
	@override String get more => 'Más';
	@override String get tips => 'Información';
	@override String get selectAll => 'Seleccionar Todo';
	@override String get copy => 'Copiar';
	@override String get paste => 'Pegar';
	@override String get cut => 'Cortar';
	@override String get save => 'Guardar';
	@override String get ok => 'Aceptar';
	@override String get cancel => 'Cancelar';
	@override String get faq => 'Preguntas Frecuentes';
	@override String get doc => 'Documento';
	@override String get htmlTools => 'Herramientas HTML';
	@override String get download => 'Descargar';
	@override String get loading => 'Cargando...';
	@override String get days => 'Días';
	@override String get hours => 'Horas';
	@override String get minutes => 'Minutos';
	@override String get seconds => 'Segundos';
	@override String get protocol => 'Protocolo';
	@override String get search => 'Buscar';
	@override String get custom => 'Personalizado';
	@override String get connect => 'Conectar';
	@override String get disconnect => 'Desconectar';
	@override String get connected => 'Conectado';
	@override String get disconnected => 'Desconectado';
	@override String get connecting => 'Conectando';
	@override String get connectTimeout => 'Tiempo de conexión agotado';
	@override String get timeout => 'Tiempo agotado';
	@override String get timeoutDuration => 'Duración del tiempo agotado';
	@override String get latency => 'Latencia';
	@override String get latencyTest => 'Pruebas de Latencia';
	@override String get networkCheck => 'Comprobación de Red';
	@override String get language => 'Idioma';
	@override String get next => 'Siguiente';
	@override String get done => 'Hecho';
	@override String get apply => 'Aplicar';
	@override String get refresh => 'Actualizar';
	@override String get retry => '¿Reintentar?';
	@override String get update => 'Actualizar';
	@override String get updateInterval => 'Intervalo de actualización';
	@override String updateFailed({required Object p}) => 'Actualización fallida: ${p}';
	@override String get updateInterval5mTips => 'Mínimo: 5m';
	@override String get updateIntervalPreferByProfile => 'Preferir ajustes del proveedor';
	@override String get none => 'Ninguno';
	@override String get reset => 'Restablecer';
	@override String get authentication => 'Autenticación';
	@override String get submit => 'Enviar';
	@override String get user => 'Usuario';
	@override String get account => 'Cuenta';
	@override String get password => 'Contraseña';
	@override String get decryptPassword => 'Descifrar Contraseña';
	@override String get required => 'Requerido';
	@override String get sudoPassword => 'contraseña sudo (requerida para modo TUN)';
	@override String get other => 'Otro';
	@override String get dns => 'DNS';
	@override String get url => 'URL';
	@override String get urlInvalid => 'URL no válida';
	@override String get urlCannotEmpty => 'El enlace no puede estar vacío';
	@override String get urlTooLong => 'La URL es demasiado larga (>8182)';
	@override String get copyUrl => 'Copiar Enlace';
	@override String get openUrl => 'Abrir Enlace';
	@override String get shareUrl => 'Compartir Enlace';
	@override String get coreSettingTips => 'Nota: Después de modificar la configuración, debe reconectar para que surta efecto';
	@override String get overwrite => 'Sobrescribir';
	@override String get overwriteCustom => 'Sobrescritura Personalizada';
	@override String get overwriteTips => 'Perfil Original <- Sobrescritura Personalizada <- Sobrescritura de App';
	@override String get noOverwrite => 'No sobrescribir';
	@override String get overwriteSettings => 'Ajustes de Sobrescritura';
	@override String get diversionTemplates => 'Plantilla de Diversión';
	@override String get ruleProviders => 'Proveedores de Reglas';
	@override String get ruleTemplates => 'Plantillas de Reglas';
	@override String get proxyGroupsTemplates => 'Plantilla de Grupo Proxy';
	@override String get proxyGroups => 'Grupos Proxy';
	@override String get proxyNodeList => 'Lista de Nodos Proxy';
	@override String proxyNodeFailure({required Object p}) => 'Los siguientes nodos proxy han expirado y se han eliminado automáticamente: ${p}';
	@override String get externalController => 'Controlador Externo';
	@override String get secret => 'Secreto';
	@override String get tcpConcurrent => 'Apretón de manos TCP Concurrente';
	@override String get globalClientFingerprint => 'Huella Digital Global TLS';
	@override String get allowLanAccess => 'Acceso a dispositivos LAN';
	@override String get mixedPort => 'Puerto Proxy Mixto';
	@override String get logLevel => 'Nivel de Registro';
	@override String get findProcessMode => 'Modo de Búsqueda de Proceso';
	@override String get tcpkeepAliveInterval => 'Intervalo Keep-alive TCP';
	@override String get delayTestUrl => 'URL de Prueba de Retraso';
	@override String get delayTestTimeout => 'Tiempo de espera de Prueba de Retraso (ms)';
	@override String get tun => 'TUN';
	@override String get ntp => 'NTP';
	@override String get tls => 'TLS';
	@override String get geo => 'GEO';
	@override String get geoDownloadByProxy => 'Descargando Geo RuleSet por proxy';
	@override String get geoRulesetTips => 'Geosite/Geoip se convertirán en el RuleSet correspondiente';
	@override String get asnNotSupportInIosTips => 'Debido a las limitaciones de memoria del sistema iOS, las reglas IP-ASN y SRC-IP-ASN serán ignoradas en iOS.';
	@override String get sniffer => 'Sniffer';
	@override String get userAgent => 'UserAgent';
	@override String get launchAtStartup => 'Iniciar al arrancar';
	@override String get launchAtStartupRunAsAdmin => 'Por favor, reinicie Clash Mi como administrador';
	@override String get tunModeRunAsAdmin => 'El modo TUN requiere permisos de administrador del sistema, por favor reinicie la aplicación como administrador';
	@override String get portableMode => 'Modo Portátil';
	@override String get portableModeDisableTips => 'Si necesita salir del modo portátil, cierre [clashmi] y elimine manualmente la carpeta [portable] en el mismo directorio que [clashmi.exe]';
	@override String get systemProxy => 'Proxy del Sistema';
	@override String get autoConnectAfterLaunch => 'Conexión automática después de iniciar';
	@override String get autoConnectAtBoot => 'Conexión automática después del inicio del sistema';
	@override String get autoConnectAtBootTips => 'Se requiere soporte del sistema; algunos sistemas también pueden requerir que [inicio automático] esté habilitado.';
	@override String get hideAfterLaunch => 'Ocultar ventana después del inicio';
	@override String get autoSetSystemProxy => 'Establecer Proxy del Sistema automáticamente al conectar';
	@override String get bypassSystemProxy => 'Nombres de dominio que pueden omitir el proxy del sistema';
	@override String get excludeFromRecent => 'Ocultar de [Tareas Recientes]';
	@override String get wakeLock => 'Bloqueo de Despertar';
	@override String get hideVpn => 'Ocultar Icono de VPN';
	@override String get hideVpnTips => 'Habilitar IPv6 hará que esta función falle';
	@override String get hideDockIcon => 'Ocultar Icono del Dock';
	@override String get website => 'Sitio Web';
	@override String get rule => 'Regla';
	@override String get global => 'Global';
	@override String get direct => 'Directo';
	@override String get block => 'Bloquear';
	@override String get qrcode => 'Código QR';
	@override String get qrcodeTooLong => 'El texto es demasiado largo para mostrarlo';
	@override String get qrcodeShare => 'Compartir Código QR';
	@override String get textToQrcode => 'Texto a Código QR';
	@override String get qrcodeScan => 'Escanear Código QR';
	@override String get qrcodeScanResult => 'Resultado del Escaneo';
	@override String get qrcodeScanFromImage => 'Escanear desde Imagen';
	@override String get qrcodeScanResultFailed => 'Error al analizar la imagen, por favor asegúrese de que la captura de pantalla es un código QR válido';
	@override String get qrcodeScanResultEmpty => 'El resultado del escaneo está vacío';
	@override String get screenshot => 'Captura de pantalla';
	@override String get backupAndSync => 'Copia de Seguridad y Sincronización';
	@override String get importSuccess => 'Importación Exitosa';
	@override String get rewriteConfirm => 'Este archivo sobrescribirá la configuración local existente. ¿Desea continuar?';
	@override String get importAndExport => 'Importar y Exportar';
	@override String get import => 'Importar';
	@override String get importFromUrl => 'Importar desde URL';
	@override String get export => 'Exportar';
	@override String get send => 'Enviar';
	@override String get receive => 'Recibir';
	@override String get sendConfirm => '¿Confirmar envío?';
	@override String get termOfUse => 'Términos de Servicio';
	@override String get privacyPolicy => 'Política de Privacidad';
	@override String get log => 'Registro';
	@override String get coreLog => 'Registro del Core';
	@override String get core => 'Core';
	@override String get help => 'Ayuda';
	@override String get tutorial => 'Tutorial';
	@override String get board => 'Tablero';
	@override String get boardOnline => 'Usar Tablero en Línea';
	@override String get boardOnlineUrl => 'URL del Tablero en Línea';
	@override String get boardLocalPort => 'Puerto del Tablero Local';
	@override String get disableFontScaler => 'Deshabilitar escalado de fuentes (requiere reiniciar)';
	@override String get autoOrientation => 'Girar con la pantalla';
	@override String get restartTakesEffect => 'El reinicio surte efecto';
	@override String get reconnectTakesEffect => 'La reconexión surte efecto';
	@override String get runtimeProfile => 'Perfil de Tiempo de Ejecución';
	@override String get willCompleteAfterRebootInstall => 'Por favor, reinicie su dispositivo para completar la instalación de la extensión del sistema';
	@override String get willCompleteAfterRebootUninstall => 'Por favor, reinicie su dispositivo para completar la desinstalación de la extensión del sistema';
	@override String get requestNeedsUserApproval => '1. Por favor, [Permitir] que Clash Mi instale extensiones del sistema en [Ajustes del Sistema]-[Privacidad y Seguridad]\n2. [Ajustes del Sistema]-[General]-[Extensiones de Elementos de Inicio]-[Extensión de Red] habilite [clashmiServiceSE]\nreconecte después de completar';
	@override String get FullDiskAccessPermissionRequired => 'Por favor, habilite el permiso clashmiServiceSE en [Ajustes del Sistema]-[Privacidad y Seguridad]-[Acceso Total al Disco] y reconecte.';
	@override String get proxy => 'Proxy';
	@override String get theme => 'Tema';
	@override String get tvMode => 'Modo TV';
	@override String get autoUpdate => 'Actualización Automática';
	@override String get updateChannel => 'Canal de Actualización Automática';
	@override String hasNewVersion({required Object p}) => 'Actualizar Versión ${p}';
	@override String get autoDownloadPkg => 'Descargar Paquetes de Actualización Automáticamente';
	@override String get devOptions => 'Opciones de Desarrollador';
	@override String get about => 'Acerca de';
	@override String get name => 'Nombre';
	@override String get version => 'Versión';
	@override String get notice => 'Aviso';
	@override String get sort => 'Reordenar';
	@override String get recommended => 'Recomendado';
	@override String innerError({required Object p}) => 'Error Interno: ${p}';
	@override String get share => 'Compartir';
	@override String get importFromClipboard => 'Importar desde el Portapapeles';
	@override String get exportToClipboard => 'Exportar al Portapapeles';
	@override String get server => 'Servidor';
	@override String get port => 'Puerto';
	@override String get donate => 'Donar';
	@override String get setting => 'Ajustes';
	@override String get settingCore => 'Ajustes del Core';
	@override String get settingApp => 'Ajustes de la App';
	@override String get coreOverwrite => 'Sobrescritura del Core';
	@override String get iCloud => 'iCloud';
	@override String get webdav => 'Webdav';
	@override String get lanSync => 'Sincronización LAN';
	@override String get lanSyncNotQuitTips => 'No salga de esta interfaz antes de que se complete la sincronización';
	@override String get deviceNoSpace => 'No hay suficiente espacio en disco';
	@override String get hideSystemApp => 'Ocultar Aplicaciones del Sistema';
	@override String get hideAppIcon => 'Ocultar Iconos de App';
	@override String get openDir => 'Abrir Directorio de Archivos';
	@override String get fileChoose => 'Seleccionar Archivo';
	@override String get filePathCannotEmpty => 'La ruta del archivo no puede estar vacía';
	@override String fileNotExist({required Object p}) => 'El archivo no existe: ${p}';
	@override String fileTypeInvalid({required Object p}) => 'Tipo de archivo no válido: ${p}';
	@override String get uwpExemption => 'Exenciones de Aislamiento de Red UWP';
	@override String get getProfile => 'Obtener Perfil';
	@override String get addProfile => 'Añadir Perfil';
	@override String get myProfiles => 'Mis Perfiles';
	@override String get profileEdit => 'Editar Perfil';
	@override String get profileEditReloadAfterProfileUpdate => 'Recargar después de la actualización del perfil';
	@override String get profileImport => 'Importar Archivo de Perfil';
	@override String get profileAddUrlOrContent => 'Añadir Enlace de Perfil';
	@override String get profileUrlOrContent => 'Enlace de Perfil de Clash';
	@override String get profileUrlOrContentHit => 'Enlace de Perfil de Clash [Requerido]';
	@override String get profileUrlOrContentCannotEmpty => 'El enlace del perfil no puede estar vacío';
}

// Path: permission
class _TranslationsPermissionEs implements TranslationsPermissionEn {
	_TranslationsPermissionEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get camera => 'Cámara';
	@override String get screen => 'Grabación de Pantalla';
	@override String get appQuery => 'Obtener Lista de Aplicaciones';
	@override String request({required Object p}) => 'Activar permiso [${p}]';
	@override String requestNeed({required Object p}) => 'Por favor, active el permiso [${p}]';
}

// Path: tls
class _TranslationsTlsEs implements TranslationsTlsEn {
	_TranslationsTlsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get insecure => 'Omitir Verificación de Certificado';
	@override String get certificate => 'Certificado';
	@override String get privateKey => 'Clave Privada';
	@override String get customTrustCert => 'Certificados Personalizados';
}

// Path: tun
class _TranslationsTunEs implements TranslationsTunEn {
	_TranslationsTunEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get stack => 'Pila de red';
	@override String get inet4Address => 'Dirección de Puerta de Enlace IPv4';
	@override String get inet6Address => 'Dirección de Puerta de Enlace IPv6';
	@override String get dnsHijack => 'Secuestro de DNS';
	@override String get strictRoute => 'Ruta Estricta';
	@override String get icmpForward => 'Reenvío ICMP';
	@override String get allowBypass => 'Permitir que las Apps omitan la VPN';
	@override String get appendHttpProxy => 'Añadir Proxy HTTP a la VPN';
	@override String get bypassHttpProxyDomain => 'Dominios permitidos para omitir el proxy HTTP';
}

// Path: dns
class _TranslationsDnsEs implements TranslationsDnsEn {
	_TranslationsDnsEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get listen => 'Escuchar';
	@override String get fakeIp => 'fake-ip';
	@override String get fallback => 'Respaldo';
	@override String get preferH3 => 'Preferir DoH H3';
	@override String get useHosts => 'Usar Hosts';
	@override String get useSystemHosts => 'Usar Hosts del Sistema';
	@override String get enhancedMode => 'Modo Mejorado';
	@override String get fakeIPFilterMode => '${_root.dns.fakeIp} Modo de Filtro';
	@override String get fakeIPFilter => 'Filtro fake-ip';
	@override String get respectRules => 'Respetar Reglas';
	@override String get nameServer => 'Servidor de Nombres';
	@override String get defaultNameServer => '${_root.meta.byDefault} ${_root.dns.nameServer}';
	@override String get proxyNameServer => '${_root.meta.proxy} ${_root.dns.nameServer}';
	@override String get directNameServer => '${_root.meta.direct} ${_root.dns.nameServer}';
	@override String get fallbackNameServer => '${_root.dns.fallback} ${_root.dns.nameServer}';
	@override String get fallbackGeoIp => '${_root.dns.fallback} GeoIp';
	@override String get fallbackGeoIpCode => '${_root.dns.fallback} GeoIpCode';
}

// Path: sniffer
class _TranslationsSnifferEs implements TranslationsSnifferEn {
	_TranslationsSnifferEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get overrideDest => 'Sobrescribir';
}

// Path: profilePatchMode
class _TranslationsProfilePatchModeEs implements TranslationsProfilePatchModeEn {
	_TranslationsProfilePatchModeEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get currentSelected => 'Seleccionado Actual';
	@override String get overwrite => 'Sobrescritura Integrada';
	@override String get noOverwrite => 'Integrada - sin Sobrescritura';
}

// Path: main.tray
class _TranslationsMainTrayEs implements TranslationsMainTrayEn {
	_TranslationsMainTrayEs._(this._root);

	final TranslationsEs _root; // ignore: unused_field

	// Translations
	@override String get menuOpen => 'Abrir';
	@override String get menuExit => 'Salir';
}

/// The flat map containing all translations for locale <es>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsEs {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'BackupAndSyncWebdavScreen.webdavServerUrl' => 'URL del Servidor',
			'BackupAndSyncWebdavScreen.webdavRequired' => 'No puede estar vacío',
			'BackupAndSyncWebdavScreen.webdavLoginFailed' => 'Error de inicio de sesión:',
			'BackupAndSyncWebdavScreen.webdavListFailed' => 'Error al obtener la lista de archivos:',
			'LaunchFailedScreen.invalidProcess' => 'La aplicación no pudo iniciarse [Nombre de proceso no válido], por favor reinstale la aplicación en un directorio separado',
			'LaunchFailedScreen.invalidProfile' => 'La aplicación no pudo iniciarse [Error al acceder al perfil], por favor reinstale la aplicación',
			'LaunchFailedScreen.invalidVersion' => 'La aplicación no pudo iniciarse [Versión no válida], por favor reinstale la aplicación',
			'LaunchFailedScreen.systemVersionLow' => 'La aplicación no pudo iniciarse [Versión del sistema demasiado baja]',
			'LaunchFailedScreen.invalidInstallPath' => 'La ruta de instalación no es válida, por favor reinstale en una ruta válida',
			'PerAppAndroidScreen.title' => 'Proxy por Aplicación',
			'PerAppAndroidScreen.whiteListMode' => 'Modo Lista Blanca',
			'PerAppAndroidScreen.whiteListModeTip' => 'Cuando está habilitado: solo las aplicaciones marcadas son proxies; cuando no está habilitado: solo las aplicaciones no marcadas son proxies',
			'UserAgreementScreen.privacyFirst' => 'Su privacidad es lo primero',
			'UserAgreementScreen.agreeAndContinue' => 'Aceptar y Continuar',
			'VersionUpdateScreen.versionReady' => ({required Object p}) => 'La nueva versión [${p}] está lista',
			'VersionUpdateScreen.update' => 'Reiniciar para Actualizar',
			'VersionUpdateScreen.cancel' => 'Ahora no',
			'NetCheckScreen.enterDomain' => 'Por favor, introduzca un dominio',
			'NetCheckScreen.checking' => 'Comprobando...',
			'NetCheckScreen.aQueryFailed' => ({required Object p}) => 'Falló una consulta: ${p}',
			'NetCheckScreen.aaaaQueryFailed' => ({required Object p}) => 'Falló la consulta AAAA: ${p}',
			'NetCheckScreen.success' => 'Éxito',
			'NetCheckScreen.failed' => 'Fallido',
			'NetCheckScreen.domainLabel' => 'Dominio',
			'NetCheckScreen.checkButton' => 'Comprobar',
			'NetCheckScreen.dnsSection' => '1. Consulta DNS',
			'NetCheckScreen.directHttpSection' => '2. HTTP (vía TUN, habilite TUN primero)',
			'NetCheckScreen.proxyHttpSection' => ({required Object p}) => '3. HTTP (vía Proxy, puerto: ${p})',
			'NetCheckScreen.tunNotEnabled' => 'TUN no está habilitado',
			'main.tray.menuOpen' => 'Abrir',
			'main.tray.menuExit' => 'Salir',
			'meta.enable' => 'Habilitar',
			'meta.disable' => 'Deshabilitar',
			'meta.open' => 'Abrir',
			'meta.close' => 'Cerrar',
			'meta.quit' => 'Salir',
			'meta.add' => 'Añadir',
			'meta.addSuccess' => 'Añadido con éxito',
			'meta.addFailed' => ({required Object p}) => 'Error al añadir: ${p}',
			'meta.remove' => 'Eliminar',
			'meta.removeConfirm' => '¿Está seguro de eliminar?',
			'meta.edit' => 'Editar',
			'meta.view' => 'Ver',
			'meta.remark' => 'Observación',
			'meta.byDefault' => 'Por defecto',
			'meta.editRemark' => 'Editar Observación',
			'meta.more' => 'Más',
			'meta.tips' => 'Información',
			'meta.selectAll' => 'Seleccionar Todo',
			'meta.copy' => 'Copiar',
			'meta.paste' => 'Pegar',
			'meta.cut' => 'Cortar',
			'meta.save' => 'Guardar',
			'meta.ok' => 'Aceptar',
			'meta.cancel' => 'Cancelar',
			'meta.faq' => 'Preguntas Frecuentes',
			'meta.doc' => 'Documento',
			'meta.htmlTools' => 'Herramientas HTML',
			'meta.download' => 'Descargar',
			'meta.loading' => 'Cargando...',
			'meta.days' => 'Días',
			'meta.hours' => 'Horas',
			'meta.minutes' => 'Minutos',
			'meta.seconds' => 'Segundos',
			'meta.protocol' => 'Protocolo',
			'meta.search' => 'Buscar',
			'meta.custom' => 'Personalizado',
			'meta.connect' => 'Conectar',
			'meta.disconnect' => 'Desconectar',
			'meta.connected' => 'Conectado',
			'meta.disconnected' => 'Desconectado',
			'meta.connecting' => 'Conectando',
			'meta.connectTimeout' => 'Tiempo de conexión agotado',
			'meta.timeout' => 'Tiempo agotado',
			'meta.timeoutDuration' => 'Duración del tiempo agotado',
			'meta.latency' => 'Latencia',
			'meta.latencyTest' => 'Pruebas de Latencia',
			'meta.networkCheck' => 'Comprobación de Red',
			'meta.language' => 'Idioma',
			'meta.next' => 'Siguiente',
			'meta.done' => 'Hecho',
			'meta.apply' => 'Aplicar',
			'meta.refresh' => 'Actualizar',
			'meta.retry' => '¿Reintentar?',
			'meta.update' => 'Actualizar',
			'meta.updateInterval' => 'Intervalo de actualización',
			'meta.updateFailed' => ({required Object p}) => 'Actualización fallida: ${p}',
			'meta.updateInterval5mTips' => 'Mínimo: 5m',
			'meta.updateIntervalPreferByProfile' => 'Preferir ajustes del proveedor',
			'meta.none' => 'Ninguno',
			'meta.reset' => 'Restablecer',
			'meta.authentication' => 'Autenticación',
			'meta.submit' => 'Enviar',
			'meta.user' => 'Usuario',
			'meta.account' => 'Cuenta',
			'meta.password' => 'Contraseña',
			'meta.decryptPassword' => 'Descifrar Contraseña',
			'meta.required' => 'Requerido',
			'meta.sudoPassword' => 'contraseña sudo (requerida para modo TUN)',
			'meta.other' => 'Otro',
			'meta.dns' => 'DNS',
			'meta.url' => 'URL',
			'meta.urlInvalid' => 'URL no válida',
			'meta.urlCannotEmpty' => 'El enlace no puede estar vacío',
			'meta.urlTooLong' => 'La URL es demasiado larga (>8182)',
			'meta.copyUrl' => 'Copiar Enlace',
			'meta.openUrl' => 'Abrir Enlace',
			'meta.shareUrl' => 'Compartir Enlace',
			'meta.coreSettingTips' => 'Nota: Después de modificar la configuración, debe reconectar para que surta efecto',
			'meta.overwrite' => 'Sobrescribir',
			'meta.overwriteCustom' => 'Sobrescritura Personalizada',
			'meta.overwriteTips' => 'Perfil Original <- Sobrescritura Personalizada <- Sobrescritura de App',
			'meta.noOverwrite' => 'No sobrescribir',
			'meta.overwriteSettings' => 'Ajustes de Sobrescritura',
			'meta.diversionTemplates' => 'Plantilla de Diversión',
			'meta.ruleProviders' => 'Proveedores de Reglas',
			'meta.ruleTemplates' => 'Plantillas de Reglas',
			'meta.proxyGroupsTemplates' => 'Plantilla de Grupo Proxy',
			'meta.proxyGroups' => 'Grupos Proxy',
			'meta.proxyNodeList' => 'Lista de Nodos Proxy',
			'meta.proxyNodeFailure' => ({required Object p}) => 'Los siguientes nodos proxy han expirado y se han eliminado automáticamente: ${p}',
			'meta.externalController' => 'Controlador Externo',
			'meta.secret' => 'Secreto',
			'meta.tcpConcurrent' => 'Apretón de manos TCP Concurrente',
			'meta.globalClientFingerprint' => 'Huella Digital Global TLS',
			'meta.allowLanAccess' => 'Acceso a dispositivos LAN',
			'meta.mixedPort' => 'Puerto Proxy Mixto',
			'meta.logLevel' => 'Nivel de Registro',
			'meta.findProcessMode' => 'Modo de Búsqueda de Proceso',
			'meta.tcpkeepAliveInterval' => 'Intervalo Keep-alive TCP',
			'meta.delayTestUrl' => 'URL de Prueba de Retraso',
			'meta.delayTestTimeout' => 'Tiempo de espera de Prueba de Retraso (ms)',
			'meta.tun' => 'TUN',
			'meta.ntp' => 'NTP',
			'meta.tls' => 'TLS',
			'meta.geo' => 'GEO',
			'meta.geoDownloadByProxy' => 'Descargando Geo RuleSet por proxy',
			'meta.geoRulesetTips' => 'Geosite/Geoip se convertirán en el RuleSet correspondiente',
			'meta.asnNotSupportInIosTips' => 'Debido a las limitaciones de memoria del sistema iOS, las reglas IP-ASN y SRC-IP-ASN serán ignoradas en iOS.',
			'meta.sniffer' => 'Sniffer',
			'meta.userAgent' => 'UserAgent',
			'meta.launchAtStartup' => 'Iniciar al arrancar',
			'meta.launchAtStartupRunAsAdmin' => 'Por favor, reinicie Clash Mi como administrador',
			'meta.tunModeRunAsAdmin' => 'El modo TUN requiere permisos de administrador del sistema, por favor reinicie la aplicación como administrador',
			'meta.portableMode' => 'Modo Portátil',
			'meta.portableModeDisableTips' => 'Si necesita salir del modo portátil, cierre [clashmi] y elimine manualmente la carpeta [portable] en el mismo directorio que [clashmi.exe]',
			'meta.systemProxy' => 'Proxy del Sistema',
			'meta.autoConnectAfterLaunch' => 'Conexión automática después de iniciar',
			'meta.autoConnectAtBoot' => 'Conexión automática después del inicio del sistema',
			'meta.autoConnectAtBootTips' => 'Se requiere soporte del sistema; algunos sistemas también pueden requerir que [inicio automático] esté habilitado.',
			'meta.hideAfterLaunch' => 'Ocultar ventana después del inicio',
			'meta.autoSetSystemProxy' => 'Establecer Proxy del Sistema automáticamente al conectar',
			'meta.bypassSystemProxy' => 'Nombres de dominio que pueden omitir el proxy del sistema',
			'meta.excludeFromRecent' => 'Ocultar de [Tareas Recientes]',
			'meta.wakeLock' => 'Bloqueo de Despertar',
			'meta.hideVpn' => 'Ocultar Icono de VPN',
			'meta.hideVpnTips' => 'Habilitar IPv6 hará que esta función falle',
			'meta.hideDockIcon' => 'Ocultar Icono del Dock',
			'meta.website' => 'Sitio Web',
			'meta.rule' => 'Regla',
			'meta.global' => 'Global',
			'meta.direct' => 'Directo',
			'meta.block' => 'Bloquear',
			'meta.qrcode' => 'Código QR',
			'meta.qrcodeTooLong' => 'El texto es demasiado largo para mostrarlo',
			'meta.qrcodeShare' => 'Compartir Código QR',
			'meta.textToQrcode' => 'Texto a Código QR',
			'meta.qrcodeScan' => 'Escanear Código QR',
			'meta.qrcodeScanResult' => 'Resultado del Escaneo',
			'meta.qrcodeScanFromImage' => 'Escanear desde Imagen',
			'meta.qrcodeScanResultFailed' => 'Error al analizar la imagen, por favor asegúrese de que la captura de pantalla es un código QR válido',
			'meta.qrcodeScanResultEmpty' => 'El resultado del escaneo está vacío',
			'meta.screenshot' => 'Captura de pantalla',
			'meta.backupAndSync' => 'Copia de Seguridad y Sincronización',
			'meta.importSuccess' => 'Importación Exitosa',
			'meta.rewriteConfirm' => 'Este archivo sobrescribirá la configuración local existente. ¿Desea continuar?',
			'meta.importAndExport' => 'Importar y Exportar',
			'meta.import' => 'Importar',
			'meta.importFromUrl' => 'Importar desde URL',
			'meta.export' => 'Exportar',
			'meta.send' => 'Enviar',
			'meta.receive' => 'Recibir',
			'meta.sendConfirm' => '¿Confirmar envío?',
			'meta.termOfUse' => 'Términos de Servicio',
			'meta.privacyPolicy' => 'Política de Privacidad',
			'meta.log' => 'Registro',
			'meta.coreLog' => 'Registro del Core',
			'meta.core' => 'Core',
			'meta.help' => 'Ayuda',
			'meta.tutorial' => 'Tutorial',
			'meta.board' => 'Tablero',
			'meta.boardOnline' => 'Usar Tablero en Línea',
			'meta.boardOnlineUrl' => 'URL del Tablero en Línea',
			'meta.boardLocalPort' => 'Puerto del Tablero Local',
			'meta.disableFontScaler' => 'Deshabilitar escalado de fuentes (requiere reiniciar)',
			'meta.autoOrientation' => 'Girar con la pantalla',
			'meta.restartTakesEffect' => 'El reinicio surte efecto',
			'meta.reconnectTakesEffect' => 'La reconexión surte efecto',
			'meta.runtimeProfile' => 'Perfil de Tiempo de Ejecución',
			'meta.willCompleteAfterRebootInstall' => 'Por favor, reinicie su dispositivo para completar la instalación de la extensión del sistema',
			'meta.willCompleteAfterRebootUninstall' => 'Por favor, reinicie su dispositivo para completar la desinstalación de la extensión del sistema',
			'meta.requestNeedsUserApproval' => '1. Por favor, [Permitir] que Clash Mi instale extensiones del sistema en [Ajustes del Sistema]-[Privacidad y Seguridad]\n2. [Ajustes del Sistema]-[General]-[Extensiones de Elementos de Inicio]-[Extensión de Red] habilite [clashmiServiceSE]\nreconecte después de completar',
			'meta.FullDiskAccessPermissionRequired' => 'Por favor, habilite el permiso clashmiServiceSE en [Ajustes del Sistema]-[Privacidad y Seguridad]-[Acceso Total al Disco] y reconecte.',
			'meta.proxy' => 'Proxy',
			'meta.theme' => 'Tema',
			'meta.tvMode' => 'Modo TV',
			'meta.autoUpdate' => 'Actualización Automática',
			'meta.updateChannel' => 'Canal de Actualización Automática',
			'meta.hasNewVersion' => ({required Object p}) => 'Actualizar Versión ${p}',
			'meta.autoDownloadPkg' => 'Descargar Paquetes de Actualización Automáticamente',
			'meta.devOptions' => 'Opciones de Desarrollador',
			'meta.about' => 'Acerca de',
			'meta.name' => 'Nombre',
			'meta.version' => 'Versión',
			'meta.notice' => 'Aviso',
			'meta.sort' => 'Reordenar',
			'meta.recommended' => 'Recomendado',
			'meta.innerError' => ({required Object p}) => 'Error Interno: ${p}',
			'meta.share' => 'Compartir',
			'meta.importFromClipboard' => 'Importar desde el Portapapeles',
			'meta.exportToClipboard' => 'Exportar al Portapapeles',
			'meta.server' => 'Servidor',
			'meta.port' => 'Puerto',
			'meta.donate' => 'Donar',
			'meta.setting' => 'Ajustes',
			'meta.settingCore' => 'Ajustes del Core',
			'meta.settingApp' => 'Ajustes de la App',
			'meta.coreOverwrite' => 'Sobrescritura del Core',
			'meta.iCloud' => 'iCloud',
			'meta.webdav' => 'Webdav',
			'meta.lanSync' => 'Sincronización LAN',
			'meta.lanSyncNotQuitTips' => 'No salga de esta interfaz antes de que se complete la sincronización',
			'meta.deviceNoSpace' => 'No hay suficiente espacio en disco',
			'meta.hideSystemApp' => 'Ocultar Aplicaciones del Sistema',
			'meta.hideAppIcon' => 'Ocultar Iconos de App',
			'meta.openDir' => 'Abrir Directorio de Archivos',
			'meta.fileChoose' => 'Seleccionar Archivo',
			'meta.filePathCannotEmpty' => 'La ruta del archivo no puede estar vacía',
			'meta.fileNotExist' => ({required Object p}) => 'El archivo no existe: ${p}',
			'meta.fileTypeInvalid' => ({required Object p}) => 'Tipo de archivo no válido: ${p}',
			'meta.uwpExemption' => 'Exenciones de Aislamiento de Red UWP',
			'meta.getProfile' => 'Obtener Perfil',
			'meta.addProfile' => 'Añadir Perfil',
			'meta.myProfiles' => 'Mis Perfiles',
			'meta.profileEdit' => 'Editar Perfil',
			'meta.profileEditReloadAfterProfileUpdate' => 'Recargar después de la actualización del perfil',
			'meta.profileImport' => 'Importar Archivo de Perfil',
			'meta.profileAddUrlOrContent' => 'Añadir Enlace de Perfil',
			'meta.profileUrlOrContent' => 'Enlace de Perfil de Clash',
			'meta.profileUrlOrContentHit' => 'Enlace de Perfil de Clash [Requerido]',
			'meta.profileUrlOrContentCannotEmpty' => 'El enlace del perfil no puede estar vacío',
			'permission.camera' => 'Cámara',
			'permission.screen' => 'Grabación de Pantalla',
			'permission.appQuery' => 'Obtener Lista de Aplicaciones',
			'permission.request' => ({required Object p}) => 'Activar permiso [${p}]',
			'permission.requestNeed' => ({required Object p}) => 'Por favor, active el permiso [${p}]',
			'tls.insecure' => 'Omitir Verificación de Certificado',
			'tls.certificate' => 'Certificado',
			'tls.privateKey' => 'Clave Privada',
			'tls.customTrustCert' => 'Certificados Personalizados',
			'tun.stack' => 'Pila de red',
			'tun.inet4Address' => 'Dirección de Puerta de Enlace IPv4',
			'tun.inet6Address' => 'Dirección de Puerta de Enlace IPv6',
			'tun.dnsHijack' => 'Secuestro de DNS',
			'tun.strictRoute' => 'Ruta Estricta',
			'tun.icmpForward' => 'Reenvío ICMP',
			'tun.allowBypass' => 'Permitir que las Apps omitan la VPN',
			'tun.appendHttpProxy' => 'Añadir Proxy HTTP a la VPN',
			'tun.bypassHttpProxyDomain' => 'Dominios permitidos para omitir el proxy HTTP',
			'dns.listen' => 'Escuchar',
			'dns.fakeIp' => 'fake-ip',
			'dns.fallback' => 'Respaldo',
			'dns.preferH3' => 'Preferir DoH H3',
			'dns.useHosts' => 'Usar Hosts',
			'dns.useSystemHosts' => 'Usar Hosts del Sistema',
			'dns.enhancedMode' => 'Modo Mejorado',
			'dns.fakeIPFilterMode' => '${_root.dns.fakeIp} Modo de Filtro',
			'dns.fakeIPFilter' => 'Filtro fake-ip',
			'dns.respectRules' => 'Respetar Reglas',
			'dns.nameServer' => 'Servidor de Nombres',
			'dns.defaultNameServer' => '${_root.meta.byDefault} ${_root.dns.nameServer}',
			'dns.proxyNameServer' => '${_root.meta.proxy} ${_root.dns.nameServer}',
			'dns.directNameServer' => '${_root.meta.direct} ${_root.dns.nameServer}',
			'dns.fallbackNameServer' => '${_root.dns.fallback} ${_root.dns.nameServer}',
			'dns.fallbackGeoIp' => '${_root.dns.fallback} GeoIp',
			'dns.fallbackGeoIpCode' => '${_root.dns.fallback} GeoIpCode',
			'sniffer.overrideDest' => 'Sobrescribir',
			'profilePatchMode.currentSelected' => 'Seleccionado Actual',
			'profilePatchMode.overwrite' => 'Sobrescritura Integrada',
			'profilePatchMode.noOverwrite' => 'Integrada - sin Sobrescritura',
			'protocolSniff' => 'Husmeador de Protocolos',
			'protocolSniffOverrideDestination' => 'El nombre de dominio husmeado sobrescribe la dirección de destino de la conexión',
			'edgeRuntimeNotInstalled' => 'El dispositivo actual no tiene instalado el tiempo de ejecución de Edge WebView2, por lo que la página no se puede mostrar. Por favor, descargue e instale el tiempo de ejecución de Edge WebView2 (x64), reinicie la App e inténtelo de nuevo.',
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
