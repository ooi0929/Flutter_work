import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/view/root_tab.dart';
import '../../common/view/splash_screen.dart';
import '../../restaurant/view/basket_screen.dart';
import '../../restaurant/view/order_done_screen.dart';
import '../../restaurant/view/restaurant_detail_screen.dart';
import '../model/user_model.dart';
import '../view/login_screen.dart';
import 'user_me_provider.dart';

final authProvider = ChangeNotifierProvider<AuthProvider>(
  (ref) {
    return AuthProvider(ref: ref);
  },
);

class AuthProvider extends ChangeNotifier {
  final Ref ref;

  AuthProvider({
    required this.ref,
  }) {
    ref.listen<UserModelBase?>(
      userMeProvider,
      (previous, next) {
        // 다른값이 들어올 때에만 실행
        if (previous != next) {
          notifyListeners();
        }
      },
    );
  }

  // 라우트 등록을 해당 스크린으로 가서 static으로 등록
  // 쓸 때에는 name이 절대로 겹치면 안됨.
  List<GoRoute> get routes => [
        GoRoute(
          path: '/',
          name: RootTab.routeName,
          builder: (context, state) => RootTab(),
          routes: [
            // 모바일에서는
            // 쿼리까진 안쓰는 것을 추천
            GoRoute(
              path: 'restaurant/:rid',
              name: RestaurantDetailScreen.routeName,
              builder: (context, state) => RestaurantDetailScreen(
                id: state.pathParameters['rid']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: '/splash',
          name: SplashScreen.routeName,
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          name: LoginScreen.routeName,
          builder: (context, state) => LoginScreen(),
        ),
        // 장바구니는 꼭 레스토랑 페이지를 통해서만 이동해야하는 것은 아니기 때문에
        // 따로 path를 구성
        GoRoute(
          path: '/basket',
          name: BasketScreen.routeName,
          builder: (context, state) => BasketScreen(),
        ),
        // 마지막 결제 창이기 때문에
        // 이 밑으로 라우팅을 더 넣을게 없기 때문에
        // 이것도 따로 path를 구성
        GoRoute(
          path: '/order_done',
          name: OrderDoneScreen.routeName,
          builder: (context, state) => OrderDoneScreen(),
        ),
      ];

  // SplashScreen
  // 앱을 처음 시작했을 때
  // 토큰이 존재하는지 확인하고
  // 로그인 스크린으로 보내줄지
  // 홈 스크린으로 보내줄지
  // 확인하는 과정이 필요하다.
  String? redirectLogic(BuildContext context, GoRouterState state) {
    final UserModelBase? user = ref.read(userMeProvider);

    // 로깅 -> 로그인중?
    final logginIn = state.matchedLocation == '/login';

    // 유저 정보가 없는데
    // 로그인 중이면 그대로 로그인 페이지에 두고
    // 만약에 로그인중이 아니라면 로그인 페이지로 이동
    if (user == null) {
      return logginIn ? null : '/login';
    }

    // user가 null이 아니면

    // UserModel 상태
    // 사용자 정보가 있는 상태라면 &&
    // 로그인 중이거나 현재 위치가 SplashScreen이면
    // 홈으로 이동
    if (user is UserModel) {
      return logginIn || state.matchedLocation == '/splash' ? '/' : null;
    }

    // UserModelError 상태
    if (user is UserModelError) {
      return !logginIn ? '/login' : null;
    }

    // 나머지 경우에는 null 처리
    // 가던 곳으로 가라.
    return null;
  }

  // 처음 실행될 때에만 실행
  void logout() {
    // read를 하게되면 함수가 실행되는 순간에만
    // 해당 프로바이더를 불러오기 때문에
    // 실제 이 클래스의 의존성은 아니다.

    // 만약
    // watch처럼 의존성을 넣게 되면
    // 빌드타임에 값을 알아야 하기 때문에

    // 동시에 서로를 의존하게 되면
    // circular dependencies가 된다.
    ref.read(userMeProvider.notifier).logout();
  }
}
