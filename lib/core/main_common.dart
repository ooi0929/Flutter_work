import 'package:firebase_core/firebase_core.dart';
// 위에는 firebase 사용을 위한 임포트

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_workspace/firebase_options.dart';
import 'package:provider/provider.dart';

import '../bucket_list_with_firebase/auth_service.dart';
import '../bucket_list_with_firebase/bucket_list_with_firebase_app.dart';
import '../bucket_list_with_firebase/bucket_service_with_firebase.dart';
import '../bucket_list_with_provider/bucket_service.dart';
import '../homepage/homepage_app.dart';
import '../onboarding/onboarding_app.dart';
import '../random_cat/cat_service.dart';
import 'environment.dart';
import 'my_app.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(Environment.supportedOrientation);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  // firebase 등록해주기
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); // firebase 앱 시작

  // BuildType에 따른 분기 처리
  // return 대신 break를 쓴 이유: runApp()은 앱 실행 함수로, 실행 후 더 이상의 코드가 실행되지 않기 때문에 return이 불필요하다.
  switch (Environment.instance.buildType) {
    // 여기부터는 DevStory 입문
    case BuildType.hello:
    case BuildType.instagram:
    case BuildType.bucketList:
    case BuildType.numberQuiz:
    case BuildType.onboarding:
      runApp(const OnboardingApp());
      break;

    case BuildType.bucketListWithProvider:
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => BucketService()),
          ],
          child: const MyApp(),
        ),
      );
      break;

    case BuildType.randomCat:
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => CatService()),
          ],
          child: const MyApp(),
        ),
      );
      break;

    case BuildType.bucketListWithFirebase:
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (context) => AuthService()),
            ChangeNotifierProvider(
                create: (context) => BucketServiceWithFirebase()),
          ],
          child: const BucketListWithFirebaseApp(),
        ),
      );
      break;
    // 여기부터는 DevStory 실전
    case BuildType.appleStoreWithStatefulWidget:
      runApp(const MyApp());
      break;

    // 여기부터는 삼촌과의 과제
    case BuildType.calculator:
    case BuildType.todo:
      runApp(const MyApp());
      break;

    // 삼촌과의 과제 라우팅으로 연결하는 곳
    case BuildType.homepage:
      runApp(const HomepageApp());

    default:
      runApp(Container()); // 기본값: 빈 화면
      break;
  }
}
