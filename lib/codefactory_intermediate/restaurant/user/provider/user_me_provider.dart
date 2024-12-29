import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../common/const/data.dart';
import '../../common/secure_storage/secure_storage.dart';
import '../model/user_model.dart';
import '../repository/auth_repository.dart';
import '../repository/user_me_repository.dart';

final userMeProvider =
    StateNotifierProvider<UserMeStateNotifier, UserModelBase?>(
  (ref) {
    final authRepository = ref.watch(authRepositoryProvider);
    final userMeRepository = ref.watch(userMeRepositoryProvider);
    final storage = ref.watch(secureStorageProvider);

    return UserMeStateNotifier(
      authRepository: authRepository,
      repository: userMeRepository,
      storage: storage,
    );
  },
);

class UserMeStateNotifier extends StateNotifier<UserModelBase?> {
  final AuthRepository authRepository;
  final UserMeRepository repository;
  final FlutterSecureStorage storage;

  // 인스턴스화 하면
  // getMe 함수를 실행하여 사용자의 정보를 먼저 가져올 것.
  UserMeStateNotifier({
    required this.authRepository,
    required this.repository,
    required this.storage,
  }) : super(UserModelLoading()) {
    // 내 정보 가져오기
    getMe();
  }

  Future<void> getMe() async {
    final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    // 왜 토큰을 가져왔냐?
    // API 요청할 때 이미 헤더가 존재하니까 의미없지 않냐?
    //
    // 토큰이 존재하지 않다면 애초에 API 요청을 보낼 필요가 없으니까..
    if (refreshToken == null || accessToken == null) {
      state = null;

      return;
    }

    final resp = await repository.getMe();

    state = resp;
  }

  // 어떤 값이 들어올지 모르기 때문에
  // UserModelBase로 받기
  // 로그인 시도했는데 안될 수도 있는 상황을 대비해서.
  Future<UserModelBase> login({
    required String username,
    required String password,
  }) async {
    try {
      state = UserModelLoading();

      final resp = await authRepository.login(
        username: username,
        password: password,
      );

      await storage.write(key: ACCESS_TOKEN_KEY, value: resp.accessToken);
      await storage.write(key: REFRESH_TOKEN_KEY, value: resp.refreshToken);

      final userResp = await repository.getMe();

      state = userResp;

      return userResp;
    } catch (e) {
      // 메시지는 사실상 더 자세히 작성해야함.
      state = UserModelError(message: '로그인에 실패했습니다.');

      return Future.value(state);
    }
  }

  Future<void> logout() async {
    // state를 null로 만들어서 바로 로그인 페이지로 이동할 수 있게!
    state = null;

    // Future를 동시에 실행하고 둘 다 끝난 후 다음 코드를 실행하고 싶다면.
    await Future.wait([
      storage.delete(key: ACCESS_TOKEN_KEY),
      storage.delete(key: REFRESH_TOKEN_KEY),
    ]);
  }
}
