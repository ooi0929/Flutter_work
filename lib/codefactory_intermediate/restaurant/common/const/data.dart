// 앱 전역적으로 공통으로 쓰이는 상수들을 모아두는 파일

// 토큰 정보
import 'dart:io';

const ACCESS_TOKEN_KEY = 'ACCESS_TOKEN';
const REFRESH_TOKEN_KEY = 'REFRESH_TOKEN';

// 프로바이더를 사용할거기 때문에 주석처리
// 디스크 스토리지를 사용하기 위한 클래스
// final storage = FlutterSecureStorage();

// localhost
// 시뮬레이터 + port
const simulatorIp = '127.0.0.1:3000';

// 에뮬레이터 + port
const emulatorIp = '10.0.2.2:3000';

// Platform을 통해 플랫폼을 구분가능 (dart:io 패키지이어야 함)
// 웹 환경
// final ip = kIsWeb ? simulatorIp : emulatorIp;
// 모바일 환경
final ip = Platform.isIOS ? simulatorIp : emulatorIp;
