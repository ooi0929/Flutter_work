// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:tomo_smartedu/page/teacher/digital/data/digital_data.dart';

// class SaveManager {
//   static final SaveManager _instance = SaveManager._internal();

//   factory SaveManager() {
//     return _instance;
//   }

//   SaveManager._internal();

//   SharedPreferences? _preferences;

//   final ValueNotifier<bool> autoScreenPermissionNotifier = ValueNotifier(true);

//   Future initialize() async {
//     _preferences = await SharedPreferences.getInstance();
//     autoScreenPermissionNotifier.value = autoScreenPermission;
//   }

//   Future setAutoScreenPermission(bool value) async {
//     autoScreenPermissionNotifier.value = value;
//     await setPref(SaveConstants.autoScreenPermission, value);
//   }

//   Future reset() async {
//     await _preferences?.remove(SaveConstants.newsPush);
//     await _preferences?.remove(SaveConstants.useTime);
//   }

//   Future setPref(String key, dynamic value) async {
//     if (value is int) {
//       await _preferences!.setInt(key, value);
//     } else if (value is String) {
//       await _preferences!.setString(key, value);
//     } else if (value is bool) {
//       await _preferences!.setBool(key, value);
//     } else if (value is double) {
//       await _preferences!.setDouble(key, value);
//     } else {
//       throw ArgumentError(
//           'does not supported pref key::: $key, value::: $value');
//     }
//   }

//   getPref(String key) => _preferences!.get(key);

//   getInt(String key, [int defaultValue = 0]) =>
//       _preferences!.getInt(key) ?? defaultValue;
//   getString(String key, [String defaultValue = '']) =>
//       _preferences!.getString(key) ?? defaultValue;
//   getBool(String key, [bool defaultValue = false]) =>
//       _preferences!.getBool(key) ?? defaultValue;
//   getDouble(String key, [double defaultValue = 0.0]) =>
//       _preferences!.getDouble(key) ?? defaultValue;
//   getObject(String key, [Object? defaultValue]) =>
//       _preferences!.get(key) ?? defaultValue;

//   //
//   bool get isFirstEntry => getBool(SaveConstants.firstEntry);
//   int get lastLoginDateTime => getInt(SaveConstants.lastLoginDateTime);
//   String get userId => getString(SaveConstants.userId);
//   String get userPwd => getString(SaveConstants.userPwd);
//   String get authToken => getString(SaveConstants.authToken);
//   String get pushToken => getString(SaveConstants.pushToken);
//   String get userName => getString(SaveConstants.userName);
//   bool get tutorial => getBool(SaveConstants.tutorial);
//   bool get autoLogin => getBool(SaveConstants.autoLogin, true);

//   //
//   bool get newsPush => getBool(SaveConstants.newsPush, true);
//   int get useTime => getInt(SaveConstants.useTime, 0);
//   bool get loggedOut => getBool(SaveConstants.loggedOut);

//   String get deviceNickname => getString(SaveConstants.deviceNickname);
//   bool get playgroundEnable => getBool(SaveConstants.playgroundEnable, true);
//   //
//   bool get screenPermission => getBool(SaveConstants.screenPermission, true);
//   bool get autoScreenPermission =>
//       getBool(SaveConstants.autoScreenPermission, true);

//   //
//   String get toolTeamChild => getString(SaveConstants.toolTeamChild);
//   int get toolTeamTeam => getInt(SaveConstants.toolTeamTeam);
//   String get toolLadderChild => getString(SaveConstants.toolLadderChild);
//   String get toolLadderItem => getString(SaveConstants.toolLadderItem);

//   // 디지털 액자
//   int get digitalTermInt =>
//       getInt(SaveConstants.digitalTerm, DigitalTerm.sec_10.millis);
//   bool get digitalIsShuffle => getBool(SaveConstants.digitalIsShuffle, false);
//   String get digitalEffect => getString(SaveConstants.digitalEffect);
//   String get digitalAutoEnd => getString(SaveConstants.digitalAutoEnd);
//   String get digitalFrame => getString(SaveConstants.digitalFrame);
//   int get digitalAlbumKey => getInt(SaveConstants.digitalAlbumKey);

//   int get noticeLastId => getInt(SaveConstants.noticeLastId, -1);
//   int get screenSplitCount => getInt(SaveConstants.screenSplitCount, 9);

//   int get apiServerType => getInt(SaveConstants.apiServerType, 0);

//   bool get submitProcess => getBool(SaveConstants.submitProcess, false);
//   String get selectedStudent => getString(SaveConstants.selectedStudent);

//   bool get autoDisableWakeLock =>
//       getBool(SaveConstants.autoDisableWakeLock, true);

//   Future updatePush(bool receive) async {
//     await setPref(SaveConstants.newsPush, receive);
//     if (receive) {
//       // await FirebaseManager().subscribeToTopic(ApplicationConstants.topicAll);
//       // bool testAccount = HiveManager().getUser()?.isTest ?? false;
//       // if (testAccount) {
//       //   await FirebaseManager()
//       //       .subscribeToTopic(ApplicationConstants.topicAllTest);
//       // }
//     } else {
//       // await FirebaseManager()
//       //     .unsubscribeFromTopic(ApplicationConstants.topicAll);
//       // await FirebaseManager()
//       //     .unsubscribeFromTopic(ApplicationConstants.topicAllTest);
//     }
//   }

//   Future initPush() async => await updatePush(newsPush);

//   //
//   Future login(String userId, String userPwd, String authToken) async {
//     await setPref(SaveConstants.userId, userId);
//     await setPref(SaveConstants.userPwd, userPwd);
//     await setPref(SaveConstants.authToken, authToken);
//     await setPref(
//         SaveConstants.lastLoginDateTime, DateTime.now().millisecondsSinceEpoch);
//     await setPref(SaveConstants.loggedOut, false);
//   }

//   Future logout() async {
//     // await _preferences!.remove(SaveConstants.userId);
//     await _preferences!.remove(SaveConstants.userPwd);
//     await _preferences!.remove(SaveConstants.authToken);
//     await _preferences!.remove(SaveConstants.lastLoginDateTime);
//     await setPref(SaveConstants.loggedOut, true);
//   }
// }

// // SaveManager의 sharedPreference 키로 사용
// abstract class SaveConstants {
//   static const firstEntry = "firstEntry"; // 오프라인 지원을 위해서 최초 메인 진입 체크
//   static const userId = "userId"; // 로그인 아이디
//   static const userPwd = "userPwd"; // 로그인 패스워드
//   static const lastLoginDateTime = "lastLoginDateTime"; // 최종 로그인 시간
//   static const authToken = "authToken"; // 로그인 토큰
//   static const autoLogin = "autoLogin";

//   static const pushToken = "pushToken";
//   static const deviceId = "deviceId";
//   static const loggedOut = "loggedOut";
//   static const notifyNewBook = "notifyNewBook"; // 새로운 책(권)이 추가되었을 때의 알림 발생(1회)
//   static const deviceNickname = "deviceNickname"; // [원아용] 설정에서 사용
//   static const playgroundEnable = "playgroundEnable"; // [원아용] 설정에서 사용
//   static const newsPush = "newPush"; //소식 알림 설정

//   static const screenPermission = "screenPermission";
//   static const autoScreenPermission = 'autoScreenPermission'; // 설정 자동 집중 모드

//   // 앱 사용시 이용시간에 따른 알림 처리
//   static const useTime = "useTime"; // 이용 시간 설정

//   // 튜토리얼 진입 여부
//   static const tutorial = "tutorial";

//   static const userName = "userName";
//   static const hostIp = "hostIp";
//   static const lastDummyChildCount = "lastDummyChildCount";

//   //
//   static const cooperationType = 'cooperationType';
//   static const cooperationHorizontal = 'cooperationHorizontal';
//   static const cooperationVertical = 'cooperationVertical';

//   // 수업도구(팀나누기, 사다리타기) 저장 정보
//   static const toolTeamChild = 'toolTeamChild';
//   static const toolTeamTeam = 'toolTeamTeam';
//   static const toolLadderChild = 'toolLadderChild';
//   static const toolLadderItem = 'toolLadderItem'; // 당첨 내역

//   // 디지털 액자 사용자 저장 데이터
//   static const digitalTerm = 'digitalTerm';
//   static const digitalIsShuffle = 'digitalIsShuffle';
//   static const digitalEffect = 'digitalEffect';
//   static const digitalAutoEnd = 'digitalAutoEnd';
//   static const digitalFrame = 'digitalFrame';
//   static const digitalAlbumKey = 'digitalAlbumKey';

//   // 마지막 받은 공지사항 ID
//   static const noticeLastId = 'noticeLastId';
//   // 모아보기시 화면 분할 개수
//   static const screenSplitCount = 'shareSplitCount';

//   // 개발용(스플레쉬 화면에서 서버를 선택하도록)
//   static const apiServerType = 'apiServerType';

//   // 결과물 제출 처리중??
//   static const submitProcess = 'submitProcess';

//   // 원아쪽에서 원아 선택 API를 서버에 보냈는지 확인.
//   // 해제를 수행하기 위한 용도
//   // classId,studentId
//   static const selectedStudent = 'selectedStudent';

//   // 원아 화면 잠김 자동 해제 관련
//   static const autoDisableWakeLock = 'autoDisableWakeLock';
// }
