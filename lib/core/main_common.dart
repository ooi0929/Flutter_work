import 'package:firebase_core/firebase_core.dart';
// 위에는 firebase 사용을 위한 임포트

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide Provider, ChangeNotifierProvider;
import 'package:provider/provider.dart';

import '../codefactory_intermediate/go_route_v7/go_route_v7.dart';
import '../codefactory_intermediate/restaurant/restaurant.dart';
import '../codefactory_intermediate/state_management/state_management.dart';
import '../devstory_beginner/bucket_list_with_firebase/auth_service.dart';
import '../devstory_beginner/bucket_list_with_firebase/bucket_list_with_firebase_app.dart';
import '../devstory_beginner/bucket_list_with_firebase/bucket_service_with_firebase.dart';
import '../devstory_beginner/bucket_list_with_provider/bucket_service.dart';
import '../devstory_beginner/onboarding/onboarding_app.dart';
import '../devstory_beginner/random_cat/cat_service.dart';
import '../devstory_intermediate/house_of_tomorrow/house_of_tomorrow.dart';
import '../devstory_intermediate/house_of_tomorrow/src/service/cart_service.dart'
    as house_of_tomorrow;
import '../devstory_intermediate/house_of_tomorrow/src/service/lang_service.dart'
    as house_of_tomorrow;
import '../devstory_intermediate/house_of_tomorrow/src/service/theme_service.dart'
    as house_of_tomorrow;
import '../devstory_intermediate/house_of_tomorrow_mvvm/house_of_tomorrow_mvvm.dart';
import '../devstory_intermediate/house_of_tomorrow_mvvm/src/repository/product_repository.dart';
import '../devstory_intermediate/house_of_tomorrow_mvvm/src/service/cart_service.dart'
    as house_of_tomorrow_mvvm;
import '../devstory_intermediate/house_of_tomorrow_mvvm/src/service/lang_service.dart'
    as house_of_tomorrow_mvvm;
import '../devstory_intermediate/house_of_tomorrow_mvvm/src/service/theme_service.dart'
    as house_of_tomorrow_mvvm;
import '../firebase_options.dart';
import '../uncle/homepage/homepage_app.dart';
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
      runApp(const MyApp());

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

    // 여기부터는 DevStory 중급
    case BuildType.appleStoreWithStatefulWidget:
    case BuildType.appleStoreWithInheritedWidget:
    case BuildType.appleStoreWithProvider:
    case BuildType.appleStoreWithRiverpod:
    case BuildType.appleStoreWithCubit:
    case BuildType.appleStoreWithBloc:
      runApp(const MyApp());
      break;

    case BuildType.houseOfTomorrow:
      runApp(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (context) => house_of_tomorrow.ThemeService(),
            ),
            ChangeNotifierProvider(
              create: (context) => house_of_tomorrow.LangService(),
            ),
            ChangeNotifierProvider(
              create: (context) => house_of_tomorrow.CartService(),
            )
          ],
          child: const HouseOfTomorrow(),
        ),
      );
      break;

    case BuildType.houseOfTomorrowMVVM:
      runApp(
        MultiProvider(
          providers: [
            Provider(
              create: (context) => ProductRepository(),
            ),
            ChangeNotifierProvider(
              create: (context) => house_of_tomorrow_mvvm.ThemeService(),
            ),
            ChangeNotifierProvider(
              create: (context) => house_of_tomorrow_mvvm.LangService(),
            ),
            ChangeNotifierProvider(
              create: (context) => house_of_tomorrow_mvvm.CartService(),
            )
          ],
          child: const HouseOfTomorrowMvvm(),
        ),
      );

    // 여기부터는 CodeFactory 입문

    // 여기부터는 CodeFactory 중급
    case BuildType.restaurant:
      runApp(
        ProviderScope(
          child: const Restaurant(),
        ),
      );
      break;

    case BuildType.stateManagement:
      runApp(const StateManagement());

    case BuildType.goRouteV7:
      runApp(const GoRouteV7());

    // 여기부터는 삼촌과의 과제
    case BuildType.calculator:
    case BuildType.todo:
      runApp(const MyApp());
      break;

    // 삼촌과의 과제 라우팅으로 연결하는 곳
    case BuildType.homepage:
      runApp(const HomepageApp());

    // ignore: unreachable_switch_default
    default:
      runApp(Container()); // 기본값: 빈 화면
      break;
  }
}
