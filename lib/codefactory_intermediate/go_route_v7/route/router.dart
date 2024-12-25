import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../screen/basic_screen.dart';
import '../screen/error_screen.dart';
import '../screen/login_screen.dart';
import '../screen/named_screen.dart';
import '../screen/nested_child_screen.dart';
import '../screen/nested_screen.dart';
import '../screen/path_param_screen.dart';
import '../screen/pop_base_screen.dart';
import '../screen/pop_return_screen.dart';
import '../screen/private_screen.dart';
import '../screen/push_screen.dart';
import '../screen/query_parameter_screen.dart';
import '../screen/root_screen.dart';
import '../screen/transition_screen.dart';
import '../screen/transition_screen_1.dart';

// 로그인이 됐는지 안됐는지
// true - Login OK / false - Login NO
bool authState = false;

// https://blog.codefactory.ai/ -> '/' 와 같음 (도메인을 제외했을 때) path라고 부름
// https://blog.codefactory.ai/flutter -> path: /flutter

// GoRoute 패키지로 라우트를 설정할 때에는 GoRouter로 정의.
// path를 지정할 때에는 GoRoute로 정의.

// / -> root screen
// /basic -> basic screen
// /basic/named
//
// named는 따로 옮길 거.
// /named
final router = GoRouter(
  // state -> GoRouteState
  // 여기서의 리다이렉트는 GoRoute 전역에 사용됨.
  redirect: (context, state) {
    // return string (path) -> 해당 라우트로 이동한다. (path)
    // return null -> 원래 이동하려던 라우트로 이동한다.
    if (state.matchedLocation == '/login/private' && !authState) {
      return '/login';
    }

    return null;
  },
  routes: [
    // 홈
    GoRoute(
      path: '/',
      builder: (context, state) => const RootScreen(),
      // GoRoute에 routes 속성이 있어서
      // 안에 경로를 쌓을 수 있다.
      routes: [
        GoRoute(
          path: 'basic',
          builder: (context, state) => const BasicScreen(),
        ),
        GoRoute(
          path: 'named',
          // named 기능을 사용할 때에는 name 파라미터를 사용하면 됨.
          // 직접 지정한 이름을 가지고 사용
          // 언제 유용하냐?
          // 라우트가 굉장히 길어졌을 때 유용함.
          // ex)
          // /123/456/789/10/11/12/32/241/ -> /long_screen으로 묶을 수 있음.
          name: 'named_screen',
          builder: (context, state) => const NamedScreen(),
        ),
        GoRoute(
          path: 'push',
          builder: (context, state) => const PushScreen(),
        ),
        GoRoute(
          path: 'pop',
          // /pop
          builder: (context, state) => const PopBaseScreen(),
          routes: [
            // /pop/return
            GoRoute(
              path: 'return',
              builder: (context, state) => const PopReturnScreen(),
            ),
          ],
        ),
        GoRoute(
          // :을 넣게 되면
          // 뒤에 오는 값을 변수로 칭할 수 있음.

          // /path_param/123
          // id = 123
          path: 'path_param/:id',
          builder: (context, state) => const PathParamScreen(),
          routes: [
            GoRoute(
              // /path_param/:id/:name
              path: ':name',
              // 편견 깨기.
              // PathParamScreen이 공유가 되는 것이 아닌
              // 서로 독립적인 위젯이다.
              builder: (context, state) => const PathParamScreen(),
            ),
          ],
        ),
        GoRoute(
          path: 'query_param',
          builder: (context, state) => const QueryParameterScreen(),
        ),
        // BottomNavigation의 화면만 움직이도록
        ShellRoute(
          // builder 속성 안에는
          // routes 속성에 있는 위젯들을 전부 감쌀 수 있는 위젯을 넣을 수 있다.

          // child: routes 속성에 있는 GoRoute가 반환해주는 값들을 child에서 사용이 가능하다.
          // child = GoRoute(
          //   path: 'nested/a',
          //   builder: (context, state) => const NestedChildScreen(
          //     routeName: '/nested/a',
          //   ),
          // ),
          builder: (context, state, child) {
            return NestedScreen(
              child: child,
            );
          },
          routes: [
            // /nested/a
            GoRoute(
              path: 'nested/a',
              builder: (context, state) => const NestedChildScreen(
                routeName: '/nested/a',
              ),
            ),
            // /nested/b
            GoRoute(
              path: 'nested/b',
              builder: (context, state) => const NestedChildScreen(
                routeName: '/nested/b',
              ),
            ),
            // /nested/c
            GoRoute(
              path: 'nested/c',
              builder: (context, state) => const NestedChildScreen(
                routeName: '/nested/c',
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'login',
          builder: (context, state) => const LoginScreen(),
          routes: [
            GoRoute(
              path: 'private',
              builder: (context, state) => const PrivateScreen(),
            ),
          ],
        ),
        // redirect 2번째 방법
        GoRoute(
          path: 'login2',
          builder: (context, state) => const LoginScreen(),
          routes: [
            // 현재 라우트에서만 리다이렉트 적용
            GoRoute(
              path: 'private',
              builder: (context, state) => const PrivateScreen(),
              redirect: (context, state) {
                if (!authState) {
                  return '/login2';
                }

                return null;
              },
            ),
          ],
        ),
        GoRoute(
          path: 'transition',
          builder: (context, state) => const TransitionScreen(),
          routes: [
            GoRoute(
              path: 'detail',
              pageBuilder: (context, state) => CustomTransitionPage(
                // transitionDuration - animation 시간 제어
                transitionDuration: Duration(seconds: 3),
                // Transition 애니메이션 관련 코드
                transitionsBuilder:
                    // animation: 0~1 값이 점점 늘어남.
                    // 화면이 전환될 때
                    // 화면이 전환되는 순간이 0, 화면이 전환되고 난 끝나는 순간이 1

                    // secondaryAnimation: 거꾸로

                    // push -> animation
                    // pop -> secondaryAnimation

                    // child는 pageBuilder가 받고 있는 child와 같음.
                    (context, animation, secondaryAnimation, child) {
                  // FadeTranstion - 투명도 효과 -> opacity 속성
                  // ScaleTransition - 확대, 축소 효과 -> scale 속성
                  // RotationTransition - 회전 효과 -> truns 속성

                  return FadeTransition(
                    opacity: animation,
                    child: child,
                  );
                },

                child: const TransitionScreen1(),
              ),
            ),
          ],
        ),
      ],
    ),
  ],
  // 에러 스크린 빌더하는 방법
  // state -> GoRoute의 상태정보를 나타냄
  errorBuilder: (context, state) => ErrorScreen(
    error: state.error.toString(),
  ),

  // GoRoute 로그 보는 방법
  // 기본값은 false
  debugLogDiagnostics: true,
);
