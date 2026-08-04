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
class TranslationsKo with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsKo({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ko,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ko>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsKo _root = this; // ignore: unused_field

	@override 
	TranslationsKo $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsKo(meta: meta ?? this.$meta);

	// Translations
	@override late final _Translations$BackupAndSyncWebdavScreen$ko BackupAndSyncWebdavScreen = _Translations$BackupAndSyncWebdavScreen$ko._(_root);
	@override late final _Translations$LaunchFailedScreen$ko LaunchFailedScreen = _Translations$LaunchFailedScreen$ko._(_root);
	@override late final _Translations$PerAppAndroidScreen$ko PerAppAndroidScreen = _Translations$PerAppAndroidScreen$ko._(_root);
	@override late final _Translations$UserAgreementScreen$ko UserAgreementScreen = _Translations$UserAgreementScreen$ko._(_root);
	@override late final _Translations$NetCheckScreen$ko NetCheckScreen = _Translations$NetCheckScreen$ko._(_root);
	@override late final _Translations$VersionUpdateScreen$ko VersionUpdateScreen = _Translations$VersionUpdateScreen$ko._(_root);
	@override late final _Translations$loginScreen$ko loginScreen = _Translations$loginScreen$ko._(_root);
	@override late final _Translations$main$ko main = _Translations$main$ko._(_root);
	@override late final _Translations$meta$ko meta = _Translations$meta$ko._(_root);
	@override late final _Translations$permission$ko permission = _Translations$permission$ko._(_root);
	@override late final _Translations$tls$ko tls = _Translations$tls$ko._(_root);
	@override late final _Translations$tun$ko tun = _Translations$tun$ko._(_root);
	@override late final _Translations$dns$ko dns = _Translations$dns$ko._(_root);
	@override late final _Translations$sniffer$ko sniffer = _Translations$sniffer$ko._(_root);
	@override late final _Translations$profilePatchMode$ko profilePatchMode = _Translations$profilePatchMode$ko._(_root);
	@override String get protocolSniff => '프로토콜 스니핑';
	@override String get protocolSniffOverrideDestination => '스니핑된 도메인 이름으로 연결 대상 주소 덮어쓰기';
	@override String get edgeRuntimeNotInstalled => '현재 장치에 Edge WebView2 런타임이 설치되어 있지 않아 페이지를 표시할 수 없습니다. Edge WebView2 런타임(x64)을 다운로드하여 설치하고 앱을 다시 시작한 후 다시 시도하십시오。';
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
class _Translations$BackupAndSyncWebdavScreen$ko implements Translations$BackupAndSyncWebdavScreen$en {
	_Translations$BackupAndSyncWebdavScreen$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get webdavServerUrl => '서버 URL';
	@override String get webdavRequired => '비워둘 수 없습니다';
	@override String get webdavLoginFailed => '로그인 실패:';
	@override String get webdavListFailed => '파일 목록을 가져오지 못했습니다:';
}

// Path: LaunchFailedScreen
class _Translations$LaunchFailedScreen$ko implements Translations$LaunchFailedScreen$en {
	_Translations$LaunchFailedScreen$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get invalidProcess => '앱 시작 실패 [유효하지 않은 프로세스 이름], 앱을 별도의 디렉토리에 다시 설치하십시오';
	@override String get invalidProfile => '앱 시작 실패 [프로필 액세스 실패], 앱을 다시 설치하십시오';
	@override String get invalidVersion => '앱 시작 실패 [유효하지 않은 버전], 앱을 다시 설치하십시오';
	@override String get systemVersionLow => '앱 시작 실패 [시스템 버전이 너무 낮음]';
	@override String get invalidInstallPath => '설치 경로가 유효하지 않습니다. 유효한 경로에 다시 설치하십시오';
}

// Path: PerAppAndroidScreen
class _Translations$PerAppAndroidScreen$ko implements Translations$PerAppAndroidScreen$en {
	_Translations$PerAppAndroidScreen$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get title => '앱별 프록시';
	@override String get whiteListMode => '화이트리스트 모드';
	@override String get whiteListModeTip => '활성화 시: 체크된 앱만 프록시됩니다. 비활성화 시: 체크되지 않은 앱만 프록시됩니다';
}

// Path: UserAgreementScreen
class _Translations$UserAgreementScreen$ko implements Translations$UserAgreementScreen$en {
	_Translations$UserAgreementScreen$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get privacyFirst => '개인 정보 보호 우선';
	@override String get agreeAndContinue => '동의 및 계속';
}

// Path: NetCheckScreen
class _Translations$NetCheckScreen$ko implements Translations$NetCheckScreen$en {
	_Translations$NetCheckScreen$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get enterDomain => '도메인 이름을 입력하세요';
	@override String get checking => '점검 중...';
	@override String aQueryFailed({required Object p}) => 'A 쿼리 실패: ${p}';
	@override String aaaaQueryFailed({required Object p}) => 'AAAA 쿼리 실패: ${p}';
	@override String get success => '성공';
	@override String get failed => '실패';
	@override String get suspectedPollution => 'DNS 오염 의심';
	@override String get domainLabel => '도메인';
	@override String get checkButton => '점검';
	@override String get dnsSection => '1. DNS 조회';
	@override String get directHttpSection => '2. HTTP (TUN 경유, TUN 먼저 활성화 필요)';
	@override String proxyHttpSection({required Object p}) => '3. HTTP (프록시 경유, 포트: ${p})';
	@override String get tunNotEnabled => 'TUN이 활성화되지 않았습니다';
	@override String get routeTableSection => '4. 라우팅 테이블';
}

// Path: VersionUpdateScreen
class _Translations$VersionUpdateScreen$ko implements Translations$VersionUpdateScreen$en {
	_Translations$VersionUpdateScreen$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String versionReady({required Object p}) => '새 버전 [${p}]이 준비되었습니다';
	@override String get update => '업데이트를 위해 재시작';
	@override String get cancel => '나중에';
}

// Path: loginScreen
class _Translations$loginScreen$ko implements Translations$loginScreen$en {
	_Translations$loginScreen$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get login => '로그인';
	@override String get register => '계정 가입';
	@override String get forgotPassword => '비밀번호 찾기';
	@override String get provider => '서비스 제공자';
	@override String get providerName => '${_root.loginScreen.provider} 코드/별칭/URL';
	@override String get providerNameRequired => '${_root.loginScreen.provider} 코드/별칭/URL을 입력하세요';
	@override String get account => '계정';
	@override String get accountRequired => '계정을 입력하세요';
	@override String get email => '이메일';
	@override String get emailRequired => '이메일 주소를 입력하세요';
	@override String get password => '비밀번호';
	@override String get passwordRequired => '비밀번호를 입력하세요';
	@override String get validEmailRequired => '유효한 이메일 주소를 입력하세요';
	@override String passwordMinLength({required Object minLength}) => '비밀번호 길이는 최소 ${minLength}자 이상이어야 합니다';
	@override String get unsupportedProvider => '지원되지 않는 ${_root.loginScreen.provider}';
	@override String get unsupportedProviderType => '지원되지 않는 ${_root.loginScreen.provider} 유형';
	@override String get unActivedProvider => '로그인 기능이 활성화되어 있지 않습니다';
	@override String providerLoginSupportRequired({required Object p}) => '공급자 코드/별칭은 ${_root.loginScreen.provider}에 문의해 주세요.\n${_root.loginScreen.provider} 연동은 다음을 참고하세요: ${p}';
	@override String get providerDisclaimer => '면책 조항: ${_root.loginScreen.provider}는 제3자 서비스이며, 본 앱과는 무관합니다';
}

// Path: main
class _Translations$main$ko implements Translations$main$en {
	_Translations$main$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override late final _Translations$main$tray$ko tray = _Translations$main$tray$ko._(_root);
}

// Path: meta
class _Translations$meta$ko implements Translations$meta$en {
	_Translations$meta$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get enable => '활성화';
	@override String get disable => '비활성화';
	@override String get open => '열기';
	@override String get close => '닫기';
	@override String get quit => '종료';
	@override String get add => '추가';
	@override String get addSuccess => '성공적으로 추가되었습니다';
	@override String addFailed({required Object p}) => '추가 실패: ${p}';
	@override String get remove => '제거';
	@override String get removeConfirm => '정말로 삭제하시겠습니까?';
	@override String get edit => '편집';
	@override String get view => '보기';
	@override String get remark => '메모';
	@override String get byDefault => '기본값';
	@override String get editRemark => '메모 편집';
	@override String get more => '더 보기';
	@override String get tips => '정보';
	@override String get selectAll => '전체 선택';
	@override String get copy => '복사';
	@override String get paste => '반죽';
	@override String get cut => '자르다';
	@override String get save => '저장';
	@override String get ok => '확인';
	@override String get cancel => '취소';
	@override String get faq => '자주 묻는 질문';
	@override String get doc => '문서';
	@override String get htmlTools => 'HTML 툴셋';
	@override String get download => '다운로드';
	@override String get loading => '로드 중...';
	@override String get days => '일';
	@override String get hours => '시간';
	@override String get minutes => '분';
	@override String get seconds => '초';
	@override String get milliseconds => '밀리초';
	@override String get protocol => '프로토콜';
	@override String get search => '검색';
	@override String get custom => '사용자 정의';
	@override String get connect => '연결';
	@override String get disconnect => '연결 해제';
	@override String get connected => '연결됨';
	@override String get disconnected => '연결 해제됨';
	@override String get connecting => '연결 중';
	@override String get connectTimeout => '연결 시간 초과';
	@override String get timeout => '시간 초과';
	@override String get timeoutDuration => '시간 초과 기간';
	@override String get latency => '지연 시간';
	@override String get latencyTest => '지연 시간 확인';
	@override String get networkCheck => '네트워크 점검';
	@override String get language => '언어';
	@override String get next => '다음';
	@override String get done => '완료';
	@override String get apply => '적용';
	@override String get refresh => '새로고침';
	@override String get retry => '다시 시도하시겠습니까?';
	@override String get update => '업데이트';
	@override String get updateInterval => '업데이트 간격';
	@override String updateFailed({required Object p}) => '업데이트 실패: ${p}';
	@override String get updateInterval5mTips => '최소: 5분';
	@override String get updateIntervalPreferByProfile => '공급자 설정 우선';
	@override String get none => '없음';
	@override String get reset => '초기화';
	@override String get authentication => '인증';
	@override String get submit => '제출';
	@override String get user => '사용자';
	@override String get account => '계정';
	@override String get password => '비밀번호';
	@override String get decryptPassword => '복호화 비밀번호';
	@override String get required => '필수';
	@override String get go => '계속';
	@override String get sudoPassword => 'sudo 비밀번호 (TUN 모드에 필요)';
	@override String get other => '기타';
	@override String get dns => 'DNS';
	@override String get url => 'URL';
	@override String get urlInvalid => '유효하지 않은 URL';
	@override String get urlCannotEmpty => '링크는 비워둘 수 없습니다';
	@override String get urlTooLong => 'URL이 너무 깁니다 (>8182)';
	@override String get copyUrl => '링크 복사';
	@override String get openUrl => '링크 열기';
	@override String get shareUrl => '링크 공유';
	@override String get coreSettingTips => '참고: 설정을 수정한 후 적용하려면 다시 연결해야 합니다';
	@override String get overwrite => '덮어쓰기';
	@override String get overwriteCustom => '사용자 정의 덮어쓰기';
	@override String get overwriteAppend => '추가 덮어쓰기';
	@override String get overwriteTips => '원본 프로필 <- 사용자 정의 덮어쓰기 <- 앱 덮어쓰기';
	@override String get noOverwrite => '덮어쓰지 않음';
	@override String get overwriteSettings => '덮어쓰기 설정';
	@override String get diversionTemplates => '전환 템플릿';
	@override String get ruleProviders => '규칙 공급자';
	@override String get ruleTemplates => '규칙 템플릿';
	@override String get proxyGroupsTemplates => '프록시 그룹 템플릿';
	@override String get proxyGroups => '프록시 그룹';
	@override String get proxyNodeList => '프록시 노드 목록';
	@override String proxyNodeFailure({required Object p}) => '다음 프록시 노드가 만료되어 자동으로 제거되었습니다: ${p}';
	@override String get externalController => '외부 컨트롤러';
	@override String get secret => '비밀번호(Secret)';
	@override String get tcpConcurrent => 'TCP 동시 핸드셰이크';
	@override String get globalClientFingerprint => 'TLS 글로벌 핑거프린트';
	@override String get allowLanAccess => 'LAN 장치 액세스';
	@override String get mixedPort => '혼합 프록시 포트';
	@override String get logLevel => '로그 레벨';
	@override String get findProcessMode => '프로세스 매칭 모드';
	@override String get tcpkeepAliveInterval => 'TCP Keep-alive 간격';
	@override String get delayTestUrl => '지연 테스트 URL';
	@override String get delayTestTimeout => '지연 테스트 시간 초과(ms)';
	@override String get tun => 'TUN';
	@override String get ntp => 'NTP';
	@override String get tls => 'TLS';
	@override String get geo => 'GEO';
	@override String get geoDownloadByProxy => '프록시를 통해 Geo RuleSet 다운로드';
	@override String get geoRulesetTips => 'Geosite/Geoip는 해당 RuleSet으로 변환됩니다';
	@override String get asnNotSupportInIosTips => 'iOS 시스템 메모리 제한으로 인해 IP-ASN 및 SRC-IP-ASN 규칙은 iOS에서 무시됩니다.';
	@override String get sniffer => '스니퍼';
	@override String get userAgent => 'UserAgent';
	@override String get launchAtStartup => '시작 시 실행';
	@override String get launchAtStartupRunAsAdmin => 'Clash Mi를 관리자 권한으로 다시 시작하십시오';
	@override String get tunModeRunAsAdmin => 'TUN 모드는 시스템 관리자 권한이 필요합니다. 앱을 관리자 권한으로 다시 시작하십시오';
	@override String get portableMode => '포터블 모드';
	@override String get portableModeDisableTips => '포터블 모드를 종료해야 하는 경우 [clashmi]를 종료하고 [clashmi.exe]와 동일한 디렉토리에 있는 [portable] 폴더를 수동으로 삭제하십시오';
	@override String get systemProxy => '시스템 프록시';
	@override String get autoConnectAfterLaunch => '실행 후 자동 연결';
	@override String get autoConnectAtBoot => '시스템 시작 후 자동 연결';
	@override String get autoConnectAtBootTips => '시스템 지원이 필요합니다. 일부 시스템에서는 [자동 시작]을 활성화해야 할 수도 있습니다.';
	@override String get hideAfterLaunch => '실행 후 창 숨기기';
	@override String get autoSetSystemProxy => '연결 시 시스템 프록시 자동 설정';
	@override String get bypassSystemProxy => '시스템 프록시를 우회하도록 허용된 도메인 이름';
	@override String get excludeFromRecent => '[최근 작업]에서 숨기기';
	@override String get wakeLock => '절전 모드 방지';
	@override String get hideVpn => 'VPN 아이콘 숨기기';
	@override String get hideVpnTips => 'IPv6를 활성화하면 이 기능이 작동하지 않습니다';
	@override String get hideDockIcon => 'Dock 아이콘 숨기기';
	@override String get showTrayTraffic => '트레이에 트래픽 정보 표시';
	@override String get website => '웹사이트';
	@override String get homePage => '홈페이지';
	@override String get rule => '규칙';
	@override String get global => '글로벌';
	@override String get direct => '직접 연결';
	@override String get block => '차단';
	@override String get qrcode => 'QR 코드';
	@override String get qrcodeTooLong => '텍스트가 너무 길어 표시할 수 없습니다';
	@override String get qrcodeShare => 'QR 코드 공유';
	@override String get textToQrcode => '텍스트를 QR 코드로 변환';
	@override String get qrcodeScan => 'QR 코드 스캔';
	@override String get qrcodeScanResult => '스캔 결과';
	@override String get qrcodeScanFromImage => '이미지에서 스캔';
	@override String get qrcodeScanResultFailed => '이미지 분석 실패. 스크린샷이 유효한 QR 코드인지 확인하십시오';
	@override String get qrcodeScanResultEmpty => '스캔 결과가 비어 있습니다';
	@override String get screenshot => '스크린샷';
	@override String get backupAndSync => '백업 및 동기화';
	@override String get importSuccess => '가져오기 성공';
	@override String get rewriteConfirm => '이 파일은 기존 로컬 설정을 덮어씁니다. 계속하시겠습니까?';
	@override String get importAndExport => '가져오기 및 내보내기';
	@override String get import => '가져오기';
	@override String get importFromUrl => 'URL에서 가져오기';
	@override String get export => '내보내기';
	@override String get send => '보내기';
	@override String get receive => '받기';
	@override String get sendConfirm => '보내기를 확인하시겠습니까?';
	@override String get continueConnectConfirm => '계속 연결하시겠습니까?';
	@override String get termOfUse => '서비스 약관';
	@override String get privacyPolicy => '개인정보 보호정책';
	@override String get log => '로그';
	@override String get coreLog => '코어 로그';
	@override String get core => '코어';
	@override String get help => '도움말';
	@override String get tutorial => '튜토리얼';
	@override String get board => '보드';
	@override String get boardOnline => '온라인 보드 사용';
	@override String get boardOnlineUrl => '온라인 보드 URL';
	@override String get boardLocalPort => '로컬 보드 포트';
	@override String get alwayOnVPN => '상시 연결';
	@override String get disableFontScaler => '글꼴 크기 조정 비활성화 (재시작 후 적용)';
	@override String get autoOrientation => '화면 방향에 따라 회전';
	@override String get restartTakesEffect => '재시작 후 적용';
	@override String get reconnectTakesEffect => '다시 연결 후 적용';
	@override String get runtimeProfile => '런타임 프로필';
	@override String get willCompleteAfterRebootInstall => '시스템 확장 설치를 완료하려면 장치를 재시작하십시오';
	@override String get willCompleteAfterRebootUninstall => '시스템 확장 제거를 완료하려면 장치를 재시작하십시오';
	@override String get requestNeedsUserApproval => '1. [시스템 설정]-[개인정보 보호 및 보안]에서 Clash Mi의 시스템 확장 설치를 [허용]하십시오\n2. [시스템 설정]-[일반]-[로그인 항목 및 확장 프로그램]-[네트워크 확장 프로그램]에서 [clashmiServiceSE]를 활성화하십시오\n완료 후 다시 연결하십시오';
	@override String get FullDiskAccessPermissionRequired => '[시스템 설정]-[개인정보 보호 및 보안]-[전체 디스크 액세스]에서 clashmiServiceSE 권한을 활성화하고 다시 연결하십시오.';
	@override String get proxy => '프록시';
	@override String get theme => '테마';
	@override String get tvMode => 'TV 모드';
	@override String get autoUpdate => '자동 업데이트';
	@override String get updateChannel => '자동 업데이트 채널';
	@override String get onlineCustomerService => '온라인 고객센터';
	@override String get subscriptionChannel => '구독 채널';
	@override String hasNewVersion({required Object p}) => '버전 ${p}로 업데이트';
	@override String get autoDownloadPkg => '업데이트 패키지 자동 다운로드';
	@override String get devOptions => '개발자 옵션';
	@override String get about => '정보';
	@override String get name => '이름';
	@override String get version => '버전';
	@override String get notice => '공지사항';
	@override String get sort => '정렬';
	@override String get recommended => '추천';
	@override String innerError({required Object p}) => '내부 오류: ${p}';
	@override String get share => '공유';
	@override String get importFromClipboard => '클립보드에서 가져오기';
	@override String get exportToClipboard => '클립보드로 내보내기';
	@override String get server => '서버';
	@override String get port => '포트';
	@override String get donate => '후원';
	@override String get setting => '설정';
	@override String get settingCore => '코어 설정';
	@override String get settingApp => '앱 설정';
	@override String get coreOverwrite => '코어 덮어쓰기';
	@override String get iCloud => 'iCloud';
	@override String get webdav => 'Webdav';
	@override String get lanSync => 'LAN 동기화';
	@override String get lanSyncNotQuitTips => '동기화가 완료될 때까지 이 화면을 종료하지 마십시오';
	@override String get deviceNoSpace => '디스크 공간 부족';
	@override String get hideSystemApp => '시스템 앱 숨기기';
	@override String get hideAppIcon => '앱 아이콘 숨기기';
	@override String get openDir => '파일 디렉토리 열기';
	@override String get type => '유형';
	@override String get fileChoose => '파일 선택';
	@override String get filePathCannotEmpty => '파일 경로는 비워둘 수 없습니다';
	@override String fileNotExist({required Object p}) => '파일이 존재하지 않습니다: ${p}';
	@override String fileTypeInvalid({required Object p}) => '유효하지 않은 파일 형식: ${p}';
	@override String get uwpExemption => 'UWP 네트워크 격리 면제';
	@override String get getProfile => '프로필 가져오기';
	@override String get buyProfile => '프로필 구매';
	@override String get addProfile => '프로필 추가';
	@override String get myProfiles => '내 프로필';
	@override String get profileEdit => '프로필 편집';
	@override String get profileNeedActive => '먼저 이 프로필을 현재 프로필로 설정한 뒤 연결/재연결하세요';
	@override String get profileDownloadBackupChannel => '백업 다운로드 채널 사용';
	@override String get profileDownloadBackupChannelTips => 'Clash Mi에서 제공하는 프록시 다운로드 채널(어떤 정보도 저장하지 않음)';
	@override String get profileEditReloadAfterProfileUpdate => '프로필 업데이트 후 다시 로드';
	@override String get profileRulesAppendApplePush => 'Apple 푸시 알림 규칙 추가';
	@override String get profileRulesAppendProxyTips => '규칙은 원본 설정의 [proxy-groups]에서 [url-test] 또는 [select] 유형의 첫 번째 프록시로 자동 설정됩니다';
	@override String get profileImport => '프로필 파일 가져오기';
	@override String get profileAddUrlOrContent => '프로필 링크 추가';
	@override String get profileUrlOrContent => 'Clash 설정 링크';
	@override String get profileUrlOrContentHit => 'Clash 설정 링크 [필수]';
	@override String get profileUrlOrContentCannotEmpty => '프로필 링크는 비워둘 수 없습니다';
}

// Path: permission
class _Translations$permission$ko implements Translations$permission$en {
	_Translations$permission$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get camera => '카메라';
	@override String get screen => '화면 녹화';
	@override String get appQuery => '애플리케이션 목록 가져오기';
	@override String request({required Object p}) => '[${p}] 권한 켜기';
	@override String requestNeed({required Object p}) => '[${p}] 권한을 켜주십시오';
}

// Path: tls
class _Translations$tls$ko implements Translations$tls$en {
	_Translations$tls$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get insecure => '인증서 검증 건너뛰기';
	@override String get certificate => '인증서';
	@override String get privateKey => '개인 키';
	@override String get customTrustCert => '사용자 정의 인증서';
}

// Path: tun
class _Translations$tun$ko implements Translations$tun$en {
	_Translations$tun$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get stack => '네트워크 스택';
	@override String get inet4Address => 'IPv4 주소 범위';
	@override String get inet6Address => 'IPv6 주소 범위';
	@override String get dnsHijack => 'DNS 하이제킹';
	@override String get strictRoute => '엄격한 경로';
	@override String get tunDefaultRoute => '기본 경로';
	@override String get icmpForward => 'ICMP 전달';
	@override String get allowBypass => '앱이 VPN을 우회하도록 허용';
	@override String get appendHttpProxy => 'VPN에 HTTP 프록시 추가';
	@override String get bypassHttpProxyDomain => 'HTTP 프록시를 우회하도록 허용된 도메인';
}

// Path: dns
class _Translations$dns$ko implements Translations$dns$en {
	_Translations$dns$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get listen => '청취 연설';
	@override String get fakeIp => 'fake-ip';
	@override String get fallback => '폴백(Fallback)';
	@override String get preferH3 => 'DoH H3 우선';
	@override String get useHosts => 'Hosts 사용';
	@override String get useSystemHosts => '시스템 Hosts 사용';
	@override String get enhancedMode => '향상된 모드';
	@override String get fakeIPFilterMode => '${_root.dns.fakeIp} 필터 모드';
	@override String get fakeIPFilter => '${_root.dns.fakeIp} 필터';
	@override String get respectRules => '규칙 준수';
	@override String get nameServer => '네임 서버';
	@override String get defaultNameServer => '${_root.meta.byDefault} ${_root.dns.nameServer}';
	@override String get proxyNameServer => '${_root.meta.proxy} ${_root.dns.nameServer}';
	@override String get directNameServer => '${_root.meta.direct} ${_root.dns.nameServer}';
	@override String get fallbackNameServer => '${_root.dns.fallback} ${_root.dns.nameServer}';
	@override String get fallbackGeoIp => '${_root.dns.fallback} GeoIp';
	@override String get fallbackGeoIpCode => '${_root.dns.fallback} GeoIpCode';
}

// Path: sniffer
class _Translations$sniffer$ko implements Translations$sniffer$en {
	_Translations$sniffer$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get overrideDest => '덮어쓰기';
}

// Path: profilePatchMode
class _Translations$profilePatchMode$ko implements Translations$profilePatchMode$en {
	_Translations$profilePatchMode$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get currentSelected => '현재 선택됨';
	@override String get overwrite => '내장 - 덮어쓰기';
	@override String get noOverwrite => '내장 - 덮어쓰지 않음';
}

// Path: main.tray
class _Translations$main$tray$ko implements Translations$main$tray$en {
	_Translations$main$tray$ko._(this._root);

	final TranslationsKo _root; // ignore: unused_field

	// Translations
	@override String get menuOpen => '열기';
	@override String get menuExit => '종료';
}

/// The flat map containing all translations for locale <ko>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsKo {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'BackupAndSyncWebdavScreen.webdavServerUrl' => '서버 URL',
			'BackupAndSyncWebdavScreen.webdavRequired' => '비워둘 수 없습니다',
			'BackupAndSyncWebdavScreen.webdavLoginFailed' => '로그인 실패:',
			'BackupAndSyncWebdavScreen.webdavListFailed' => '파일 목록을 가져오지 못했습니다:',
			'LaunchFailedScreen.invalidProcess' => '앱 시작 실패 [유효하지 않은 프로세스 이름], 앱을 별도의 디렉토리에 다시 설치하십시오',
			'LaunchFailedScreen.invalidProfile' => '앱 시작 실패 [프로필 액세스 실패], 앱을 다시 설치하십시오',
			'LaunchFailedScreen.invalidVersion' => '앱 시작 실패 [유효하지 않은 버전], 앱을 다시 설치하십시오',
			'LaunchFailedScreen.systemVersionLow' => '앱 시작 실패 [시스템 버전이 너무 낮음]',
			'LaunchFailedScreen.invalidInstallPath' => '설치 경로가 유효하지 않습니다. 유효한 경로에 다시 설치하십시오',
			'PerAppAndroidScreen.title' => '앱별 프록시',
			'PerAppAndroidScreen.whiteListMode' => '화이트리스트 모드',
			'PerAppAndroidScreen.whiteListModeTip' => '활성화 시: 체크된 앱만 프록시됩니다. 비활성화 시: 체크되지 않은 앱만 프록시됩니다',
			'UserAgreementScreen.privacyFirst' => '개인 정보 보호 우선',
			'UserAgreementScreen.agreeAndContinue' => '동의 및 계속',
			'NetCheckScreen.enterDomain' => '도메인 이름을 입력하세요',
			'NetCheckScreen.checking' => '점검 중...',
			'NetCheckScreen.aQueryFailed' => ({required Object p}) => 'A 쿼리 실패: ${p}',
			'NetCheckScreen.aaaaQueryFailed' => ({required Object p}) => 'AAAA 쿼리 실패: ${p}',
			'NetCheckScreen.success' => '성공',
			'NetCheckScreen.failed' => '실패',
			'NetCheckScreen.suspectedPollution' => 'DNS 오염 의심',
			'NetCheckScreen.domainLabel' => '도메인',
			'NetCheckScreen.checkButton' => '점검',
			'NetCheckScreen.dnsSection' => '1. DNS 조회',
			'NetCheckScreen.directHttpSection' => '2. HTTP (TUN 경유, TUN 먼저 활성화 필요)',
			'NetCheckScreen.proxyHttpSection' => ({required Object p}) => '3. HTTP (프록시 경유, 포트: ${p})',
			'NetCheckScreen.tunNotEnabled' => 'TUN이 활성화되지 않았습니다',
			'NetCheckScreen.routeTableSection' => '4. 라우팅 테이블',
			'VersionUpdateScreen.versionReady' => ({required Object p}) => '새 버전 [${p}]이 준비되었습니다',
			'VersionUpdateScreen.update' => '업데이트를 위해 재시작',
			'VersionUpdateScreen.cancel' => '나중에',
			'loginScreen.login' => '로그인',
			'loginScreen.register' => '계정 가입',
			'loginScreen.forgotPassword' => '비밀번호 찾기',
			'loginScreen.provider' => '서비스 제공자',
			'loginScreen.providerName' => '${_root.loginScreen.provider} 코드/별칭/URL',
			'loginScreen.providerNameRequired' => '${_root.loginScreen.provider} 코드/별칭/URL을 입력하세요',
			'loginScreen.account' => '계정',
			'loginScreen.accountRequired' => '계정을 입력하세요',
			'loginScreen.email' => '이메일',
			'loginScreen.emailRequired' => '이메일 주소를 입력하세요',
			'loginScreen.password' => '비밀번호',
			'loginScreen.passwordRequired' => '비밀번호를 입력하세요',
			'loginScreen.validEmailRequired' => '유효한 이메일 주소를 입력하세요',
			'loginScreen.passwordMinLength' => ({required Object minLength}) => '비밀번호 길이는 최소 ${minLength}자 이상이어야 합니다',
			'loginScreen.unsupportedProvider' => '지원되지 않는 ${_root.loginScreen.provider}',
			'loginScreen.unsupportedProviderType' => '지원되지 않는 ${_root.loginScreen.provider} 유형',
			'loginScreen.unActivedProvider' => '로그인 기능이 활성화되어 있지 않습니다',
			'loginScreen.providerLoginSupportRequired' => ({required Object p}) => '공급자 코드/별칭은 ${_root.loginScreen.provider}에 문의해 주세요.\n${_root.loginScreen.provider} 연동은 다음을 참고하세요: ${p}',
			'loginScreen.providerDisclaimer' => '면책 조항: ${_root.loginScreen.provider}는 제3자 서비스이며, 본 앱과는 무관합니다',
			'main.tray.menuOpen' => '열기',
			'main.tray.menuExit' => '종료',
			'meta.enable' => '활성화',
			'meta.disable' => '비활성화',
			'meta.open' => '열기',
			'meta.close' => '닫기',
			'meta.quit' => '종료',
			'meta.add' => '추가',
			'meta.addSuccess' => '성공적으로 추가되었습니다',
			'meta.addFailed' => ({required Object p}) => '추가 실패: ${p}',
			'meta.remove' => '제거',
			'meta.removeConfirm' => '정말로 삭제하시겠습니까?',
			'meta.edit' => '편집',
			'meta.view' => '보기',
			'meta.remark' => '메모',
			'meta.byDefault' => '기본값',
			'meta.editRemark' => '메모 편집',
			'meta.more' => '더 보기',
			'meta.tips' => '정보',
			'meta.selectAll' => '전체 선택',
			'meta.copy' => '복사',
			'meta.paste' => '반죽',
			'meta.cut' => '자르다',
			'meta.save' => '저장',
			'meta.ok' => '확인',
			'meta.cancel' => '취소',
			'meta.faq' => '자주 묻는 질문',
			'meta.doc' => '문서',
			'meta.htmlTools' => 'HTML 툴셋',
			'meta.download' => '다운로드',
			'meta.loading' => '로드 중...',
			'meta.days' => '일',
			'meta.hours' => '시간',
			'meta.minutes' => '분',
			'meta.seconds' => '초',
			'meta.milliseconds' => '밀리초',
			'meta.protocol' => '프로토콜',
			'meta.search' => '검색',
			'meta.custom' => '사용자 정의',
			'meta.connect' => '연결',
			'meta.disconnect' => '연결 해제',
			'meta.connected' => '연결됨',
			'meta.disconnected' => '연결 해제됨',
			'meta.connecting' => '연결 중',
			'meta.connectTimeout' => '연결 시간 초과',
			'meta.timeout' => '시간 초과',
			'meta.timeoutDuration' => '시간 초과 기간',
			'meta.latency' => '지연 시간',
			'meta.latencyTest' => '지연 시간 확인',
			'meta.networkCheck' => '네트워크 점검',
			'meta.language' => '언어',
			'meta.next' => '다음',
			'meta.done' => '완료',
			'meta.apply' => '적용',
			'meta.refresh' => '새로고침',
			'meta.retry' => '다시 시도하시겠습니까?',
			'meta.update' => '업데이트',
			'meta.updateInterval' => '업데이트 간격',
			'meta.updateFailed' => ({required Object p}) => '업데이트 실패: ${p}',
			'meta.updateInterval5mTips' => '최소: 5분',
			'meta.updateIntervalPreferByProfile' => '공급자 설정 우선',
			'meta.none' => '없음',
			'meta.reset' => '초기화',
			'meta.authentication' => '인증',
			'meta.submit' => '제출',
			'meta.user' => '사용자',
			'meta.account' => '계정',
			'meta.password' => '비밀번호',
			'meta.decryptPassword' => '복호화 비밀번호',
			'meta.required' => '필수',
			'meta.go' => '계속',
			'meta.sudoPassword' => 'sudo 비밀번호 (TUN 모드에 필요)',
			'meta.other' => '기타',
			'meta.dns' => 'DNS',
			'meta.url' => 'URL',
			'meta.urlInvalid' => '유효하지 않은 URL',
			'meta.urlCannotEmpty' => '링크는 비워둘 수 없습니다',
			'meta.urlTooLong' => 'URL이 너무 깁니다 (>8182)',
			'meta.copyUrl' => '링크 복사',
			'meta.openUrl' => '링크 열기',
			'meta.shareUrl' => '링크 공유',
			'meta.coreSettingTips' => '참고: 설정을 수정한 후 적용하려면 다시 연결해야 합니다',
			'meta.overwrite' => '덮어쓰기',
			'meta.overwriteCustom' => '사용자 정의 덮어쓰기',
			'meta.overwriteAppend' => '추가 덮어쓰기',
			'meta.overwriteTips' => '원본 프로필 <- 사용자 정의 덮어쓰기 <- 앱 덮어쓰기',
			'meta.noOverwrite' => '덮어쓰지 않음',
			'meta.overwriteSettings' => '덮어쓰기 설정',
			'meta.diversionTemplates' => '전환 템플릿',
			'meta.ruleProviders' => '규칙 공급자',
			'meta.ruleTemplates' => '규칙 템플릿',
			'meta.proxyGroupsTemplates' => '프록시 그룹 템플릿',
			'meta.proxyGroups' => '프록시 그룹',
			'meta.proxyNodeList' => '프록시 노드 목록',
			'meta.proxyNodeFailure' => ({required Object p}) => '다음 프록시 노드가 만료되어 자동으로 제거되었습니다: ${p}',
			'meta.externalController' => '외부 컨트롤러',
			'meta.secret' => '비밀번호(Secret)',
			'meta.tcpConcurrent' => 'TCP 동시 핸드셰이크',
			'meta.globalClientFingerprint' => 'TLS 글로벌 핑거프린트',
			'meta.allowLanAccess' => 'LAN 장치 액세스',
			'meta.mixedPort' => '혼합 프록시 포트',
			'meta.logLevel' => '로그 레벨',
			'meta.findProcessMode' => '프로세스 매칭 모드',
			'meta.tcpkeepAliveInterval' => 'TCP Keep-alive 간격',
			'meta.delayTestUrl' => '지연 테스트 URL',
			'meta.delayTestTimeout' => '지연 테스트 시간 초과(ms)',
			'meta.tun' => 'TUN',
			'meta.ntp' => 'NTP',
			'meta.tls' => 'TLS',
			'meta.geo' => 'GEO',
			'meta.geoDownloadByProxy' => '프록시를 통해 Geo RuleSet 다운로드',
			'meta.geoRulesetTips' => 'Geosite/Geoip는 해당 RuleSet으로 변환됩니다',
			'meta.asnNotSupportInIosTips' => 'iOS 시스템 메모리 제한으로 인해 IP-ASN 및 SRC-IP-ASN 규칙은 iOS에서 무시됩니다.',
			'meta.sniffer' => '스니퍼',
			'meta.userAgent' => 'UserAgent',
			'meta.launchAtStartup' => '시작 시 실행',
			'meta.launchAtStartupRunAsAdmin' => 'Clash Mi를 관리자 권한으로 다시 시작하십시오',
			'meta.tunModeRunAsAdmin' => 'TUN 모드는 시스템 관리자 권한이 필요합니다. 앱을 관리자 권한으로 다시 시작하십시오',
			'meta.portableMode' => '포터블 모드',
			'meta.portableModeDisableTips' => '포터블 모드를 종료해야 하는 경우 [clashmi]를 종료하고 [clashmi.exe]와 동일한 디렉토리에 있는 [portable] 폴더를 수동으로 삭제하십시오',
			'meta.systemProxy' => '시스템 프록시',
			'meta.autoConnectAfterLaunch' => '실행 후 자동 연결',
			'meta.autoConnectAtBoot' => '시스템 시작 후 자동 연결',
			'meta.autoConnectAtBootTips' => '시스템 지원이 필요합니다. 일부 시스템에서는 [자동 시작]을 활성화해야 할 수도 있습니다.',
			'meta.hideAfterLaunch' => '실행 후 창 숨기기',
			'meta.autoSetSystemProxy' => '연결 시 시스템 프록시 자동 설정',
			'meta.bypassSystemProxy' => '시스템 프록시를 우회하도록 허용된 도메인 이름',
			'meta.excludeFromRecent' => '[최근 작업]에서 숨기기',
			'meta.wakeLock' => '절전 모드 방지',
			'meta.hideVpn' => 'VPN 아이콘 숨기기',
			'meta.hideVpnTips' => 'IPv6를 활성화하면 이 기능이 작동하지 않습니다',
			'meta.hideDockIcon' => 'Dock 아이콘 숨기기',
			'meta.showTrayTraffic' => '트레이에 트래픽 정보 표시',
			'meta.website' => '웹사이트',
			'meta.homePage' => '홈페이지',
			'meta.rule' => '규칙',
			'meta.global' => '글로벌',
			'meta.direct' => '직접 연결',
			'meta.block' => '차단',
			'meta.qrcode' => 'QR 코드',
			'meta.qrcodeTooLong' => '텍스트가 너무 길어 표시할 수 없습니다',
			'meta.qrcodeShare' => 'QR 코드 공유',
			'meta.textToQrcode' => '텍스트를 QR 코드로 변환',
			'meta.qrcodeScan' => 'QR 코드 스캔',
			'meta.qrcodeScanResult' => '스캔 결과',
			'meta.qrcodeScanFromImage' => '이미지에서 스캔',
			'meta.qrcodeScanResultFailed' => '이미지 분석 실패. 스크린샷이 유효한 QR 코드인지 확인하십시오',
			'meta.qrcodeScanResultEmpty' => '스캔 결과가 비어 있습니다',
			'meta.screenshot' => '스크린샷',
			'meta.backupAndSync' => '백업 및 동기화',
			'meta.importSuccess' => '가져오기 성공',
			'meta.rewriteConfirm' => '이 파일은 기존 로컬 설정을 덮어씁니다. 계속하시겠습니까?',
			'meta.importAndExport' => '가져오기 및 내보내기',
			'meta.import' => '가져오기',
			'meta.importFromUrl' => 'URL에서 가져오기',
			'meta.export' => '내보내기',
			'meta.send' => '보내기',
			'meta.receive' => '받기',
			'meta.sendConfirm' => '보내기를 확인하시겠습니까?',
			'meta.continueConnectConfirm' => '계속 연결하시겠습니까?',
			'meta.termOfUse' => '서비스 약관',
			'meta.privacyPolicy' => '개인정보 보호정책',
			'meta.log' => '로그',
			'meta.coreLog' => '코어 로그',
			'meta.core' => '코어',
			'meta.help' => '도움말',
			'meta.tutorial' => '튜토리얼',
			'meta.board' => '보드',
			'meta.boardOnline' => '온라인 보드 사용',
			'meta.boardOnlineUrl' => '온라인 보드 URL',
			'meta.boardLocalPort' => '로컬 보드 포트',
			'meta.alwayOnVPN' => '상시 연결',
			'meta.disableFontScaler' => '글꼴 크기 조정 비활성화 (재시작 후 적용)',
			'meta.autoOrientation' => '화면 방향에 따라 회전',
			'meta.restartTakesEffect' => '재시작 후 적용',
			'meta.reconnectTakesEffect' => '다시 연결 후 적용',
			'meta.runtimeProfile' => '런타임 프로필',
			'meta.willCompleteAfterRebootInstall' => '시스템 확장 설치를 완료하려면 장치를 재시작하십시오',
			'meta.willCompleteAfterRebootUninstall' => '시스템 확장 제거를 완료하려면 장치를 재시작하십시오',
			'meta.requestNeedsUserApproval' => '1. [시스템 설정]-[개인정보 보호 및 보안]에서 Clash Mi의 시스템 확장 설치를 [허용]하십시오\n2. [시스템 설정]-[일반]-[로그인 항목 및 확장 프로그램]-[네트워크 확장 프로그램]에서 [clashmiServiceSE]를 활성화하십시오\n완료 후 다시 연결하십시오',
			'meta.FullDiskAccessPermissionRequired' => '[시스템 설정]-[개인정보 보호 및 보안]-[전체 디스크 액세스]에서 clashmiServiceSE 권한을 활성화하고 다시 연결하십시오.',
			'meta.proxy' => '프록시',
			'meta.theme' => '테마',
			'meta.tvMode' => 'TV 모드',
			'meta.autoUpdate' => '자동 업데이트',
			'meta.updateChannel' => '자동 업데이트 채널',
			'meta.onlineCustomerService' => '온라인 고객센터',
			'meta.subscriptionChannel' => '구독 채널',
			'meta.hasNewVersion' => ({required Object p}) => '버전 ${p}로 업데이트',
			'meta.autoDownloadPkg' => '업데이트 패키지 자동 다운로드',
			'meta.devOptions' => '개발자 옵션',
			'meta.about' => '정보',
			'meta.name' => '이름',
			'meta.version' => '버전',
			'meta.notice' => '공지사항',
			'meta.sort' => '정렬',
			'meta.recommended' => '추천',
			'meta.innerError' => ({required Object p}) => '내부 오류: ${p}',
			'meta.share' => '공유',
			'meta.importFromClipboard' => '클립보드에서 가져오기',
			'meta.exportToClipboard' => '클립보드로 내보내기',
			'meta.server' => '서버',
			'meta.port' => '포트',
			'meta.donate' => '후원',
			'meta.setting' => '설정',
			'meta.settingCore' => '코어 설정',
			'meta.settingApp' => '앱 설정',
			'meta.coreOverwrite' => '코어 덮어쓰기',
			'meta.iCloud' => 'iCloud',
			'meta.webdav' => 'Webdav',
			'meta.lanSync' => 'LAN 동기화',
			'meta.lanSyncNotQuitTips' => '동기화가 완료될 때까지 이 화면을 종료하지 마십시오',
			'meta.deviceNoSpace' => '디스크 공간 부족',
			'meta.hideSystemApp' => '시스템 앱 숨기기',
			'meta.hideAppIcon' => '앱 아이콘 숨기기',
			'meta.openDir' => '파일 디렉토리 열기',
			'meta.type' => '유형',
			'meta.fileChoose' => '파일 선택',
			'meta.filePathCannotEmpty' => '파일 경로는 비워둘 수 없습니다',
			'meta.fileNotExist' => ({required Object p}) => '파일이 존재하지 않습니다: ${p}',
			'meta.fileTypeInvalid' => ({required Object p}) => '유효하지 않은 파일 형식: ${p}',
			'meta.uwpExemption' => 'UWP 네트워크 격리 면제',
			'meta.getProfile' => '프로필 가져오기',
			'meta.buyProfile' => '프로필 구매',
			'meta.addProfile' => '프로필 추가',
			'meta.myProfiles' => '내 프로필',
			'meta.profileEdit' => '프로필 편집',
			'meta.profileNeedActive' => '먼저 이 프로필을 현재 프로필로 설정한 뒤 연결/재연결하세요',
			'meta.profileDownloadBackupChannel' => '백업 다운로드 채널 사용',
			'meta.profileDownloadBackupChannelTips' => 'Clash Mi에서 제공하는 프록시 다운로드 채널(어떤 정보도 저장하지 않음)',
			'meta.profileEditReloadAfterProfileUpdate' => '프로필 업데이트 후 다시 로드',
			'meta.profileRulesAppendApplePush' => 'Apple 푸시 알림 규칙 추가',
			'meta.profileRulesAppendProxyTips' => '규칙은 원본 설정의 [proxy-groups]에서 [url-test] 또는 [select] 유형의 첫 번째 프록시로 자동 설정됩니다',
			'meta.profileImport' => '프로필 파일 가져오기',
			'meta.profileAddUrlOrContent' => '프로필 링크 추가',
			'meta.profileUrlOrContent' => 'Clash 설정 링크',
			'meta.profileUrlOrContentHit' => 'Clash 설정 링크 [필수]',
			'meta.profileUrlOrContentCannotEmpty' => '프로필 링크는 비워둘 수 없습니다',
			'permission.camera' => '카메라',
			'permission.screen' => '화면 녹화',
			'permission.appQuery' => '애플리케이션 목록 가져오기',
			'permission.request' => ({required Object p}) => '[${p}] 권한 켜기',
			'permission.requestNeed' => ({required Object p}) => '[${p}] 권한을 켜주십시오',
			'tls.insecure' => '인증서 검증 건너뛰기',
			'tls.certificate' => '인증서',
			'tls.privateKey' => '개인 키',
			'tls.customTrustCert' => '사용자 정의 인증서',
			'tun.stack' => '네트워크 스택',
			'tun.inet4Address' => 'IPv4 주소 범위',
			'tun.inet6Address' => 'IPv6 주소 범위',
			'tun.dnsHijack' => 'DNS 하이제킹',
			'tun.strictRoute' => '엄격한 경로',
			'tun.tunDefaultRoute' => '기본 경로',
			'tun.icmpForward' => 'ICMP 전달',
			'tun.allowBypass' => '앱이 VPN을 우회하도록 허용',
			'tun.appendHttpProxy' => 'VPN에 HTTP 프록시 추가',
			'tun.bypassHttpProxyDomain' => 'HTTP 프록시를 우회하도록 허용된 도메인',
			'dns.listen' => '청취 연설',
			'dns.fakeIp' => 'fake-ip',
			'dns.fallback' => '폴백(Fallback)',
			'dns.preferH3' => 'DoH H3 우선',
			'dns.useHosts' => 'Hosts 사용',
			'dns.useSystemHosts' => '시스템 Hosts 사용',
			'dns.enhancedMode' => '향상된 모드',
			'dns.fakeIPFilterMode' => '${_root.dns.fakeIp} 필터 모드',
			'dns.fakeIPFilter' => '${_root.dns.fakeIp} 필터',
			'dns.respectRules' => '규칙 준수',
			'dns.nameServer' => '네임 서버',
			'dns.defaultNameServer' => '${_root.meta.byDefault} ${_root.dns.nameServer}',
			'dns.proxyNameServer' => '${_root.meta.proxy} ${_root.dns.nameServer}',
			'dns.directNameServer' => '${_root.meta.direct} ${_root.dns.nameServer}',
			'dns.fallbackNameServer' => '${_root.dns.fallback} ${_root.dns.nameServer}',
			'dns.fallbackGeoIp' => '${_root.dns.fallback} GeoIp',
			'dns.fallbackGeoIpCode' => '${_root.dns.fallback} GeoIpCode',
			'sniffer.overrideDest' => '덮어쓰기',
			'profilePatchMode.currentSelected' => '현재 선택됨',
			'profilePatchMode.overwrite' => '내장 - 덮어쓰기',
			'profilePatchMode.noOverwrite' => '내장 - 덮어쓰지 않음',
			'protocolSniff' => '프로토콜 스니핑',
			'protocolSniffOverrideDestination' => '스니핑된 도메인 이름으로 연결 대상 주소 덮어쓰기',
			'edgeRuntimeNotInstalled' => '현재 장치에 Edge WebView2 런타임이 설치되어 있지 않아 페이지를 표시할 수 없습니다. Edge WebView2 런타임(x64)을 다운로드하여 설치하고 앱을 다시 시작한 후 다시 시도하십시오。',
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
