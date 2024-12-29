// 스플래쉬 스크린
// 앱에 처음 진입했을 때 잠깐 동안의 여러 정보들을 긁어오면서
// 어떤 페이지로 라우팅할지 정하는 페이지이다.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../const/colors.dart';
import '../layout/default_layout.dart';

// 이제는 authProvider에 리다이렉트 로직을 구성하였고, 이 로직을 통해 라우팅이 되고 있기 때문에 
// UI관련 로직을 제외한 모든 로직을 지우고
// Stateful -> Stateless로 변경
// class SplashScreen extends ConsumerStatefulWidget {
//   static String get routeName => 'splash';

//   const SplashScreen({super.key});

//   @override
//   ConsumerState<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends ConsumerState<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     checkToken();
//     // deleteToken();
//   }

//   void checkToken() async {
//     // 2초 기다리기.
//     await Future.delayed(Duration(seconds: 2));

//     final storage = ref.read(secureStorageProvider);

//     // 내부 스토리지에서 토큰 읽어오기.
//     // final accessToken = await storage.read(key: ACCESS_TOKEN_KEY);
//     final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

//     // API 요청을 위한 클래스.
//     final dio = Dio();

//     // 토큰이 유효 검사
//     try {
//       // refresh 토큰을 이용해 재발급하는 요청.
//       final resp = await dio.post(
//         'http://$ip/auth/token',
//         options: Options(
//           headers: {
//             'Authorization': 'Bearer $refreshToken',
//           },
//         ),
//       );

//       // access 토큰 만료시 refresh 토큰으로 재발급한 것을 디스크 스토리지에 덮어씌우기
//       await storage.write(
//           key: ACCESS_TOKEN_KEY, value: resp.data['accessToken']);

//       // 에러 발생하지 않을 시
//       // RootTab 페이지로 이동
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => RootTab(),
//         ),
//         (route) => false, // true: 경로 유지, false: 경로 제거
//       );
//     } catch (e) {
//       // try 블록에서 실행 중 에러발생시
//       // 로그인 페이지로 이동
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(
//           builder: (context) => LoginScreen(),
//         ),
//         (route) => false, // true: 경로 유지, false: 경로 제거
//       );
//     }
//   }

//   // 디스크에서 토큰을 비워내는 로직
//   void deleteToken() async {
//     final storage = ref.read(secureStorageProvider);
//     await storage.deleteAll();
//   }
class SplashScreen extends ConsumerWidget {
  static String get routeName => 'splash';

  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return DefaultLayout(
      backgroundColor: PRIMARY_COLOR,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/img/logo/logo.png',
              width: MediaQuery.of(context).size.width / 2,
            ),
            const SizedBox(height: 16.0),
            CircularProgressIndicator(
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
