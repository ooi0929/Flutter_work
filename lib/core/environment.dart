import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../codefactory_intermediate/restaurant/restaurant.dart';
import '../codefactory_intermediate/state_management/state_management.dart';
import '../devstory_beginner/bucket_list/bucket_list.dart';
import '../devstory_beginner/bucket_list_with_firebase/bucket_list_with_firebase.dart';
import '../devstory_beginner/bucket_list_with_provider/bucket_list_with_provider.dart';
import '../devstory_beginner/hello_flutter/hello.dart';
import '../devstory_beginner/instagram/instagram.dart';
import '../devstory_beginner/number_quiz/number_quiz.dart';
import '../devstory_beginner/onboarding/onboarding.dart';
import '../devstory_beginner/random_cat/random_cat.dart';
import '../devstory_intermediate/apple_store_with_bloc/page/apple_store_with_bloc.dart';
import '../devstory_intermediate/apple_store_with_cubit/page/apple_store_with_cubit.dart';
import '../devstory_intermediate/apple_store_with_inherited_widget/page/apple_store_with_inherited_widget.dart';
import '../devstory_intermediate/apple_store_with_provider.dart/page/apple_store_with_provider.dart';
import '../devstory_intermediate/apple_store_with_riverpod/page/apple_store_with_riverpod.dart';
import '../devstory_intermediate/apple_store_with_stateful_widget/page/apple_store_with_stateful_widget.dart';
import '../devstory_intermediate/house_of_tomorrow/house_of_tomorrow.dart';
import '../devstory_intermediate/house_of_tomorrow_mvvm/house_of_tomorrow_mvvm.dart';
import '../uncle/calculator/page/calculator.dart';
import '../uncle/homepage/page/home_page.dart';
import '../uncle/todo/page/todo.dart';
import 'main_common.dart';

enum BuildType {
  // 여기부터는 DevStory 입문
  hello,
  instagram,
  onboarding,
  bucketList,
  bucketListWithProvider,
  numberQuiz,
  randomCat,
  bucketListWithFirebase,

  // 여기부터는 DevStory 중급
  appleStoreWithStatefulWidget,
  appleStoreWithInheritedWidget,
  appleStoreWithProvider,
  appleStoreWithRiverpod,
  appleStoreWithCubit,
  appleStoreWithBloc,
  houseOfTomorrow,
  houseOfTomorrowMVVM,

  // 여기부터는 CodeFactory 입문

  // 여기부터는 CodeFactory 중급
  restaurant,
  stateManagement,

  // 여기부터는 삼촌과의 과제
  calculator,
  todo,
  homepage;

  const BuildType();

  Widget build(BuildContext context) {
    switch (this) {
      // 여기부터는 DevStory 입문
      case BuildType.hello:
        return Hello();
      case BuildType.instagram:
        return Instagram();
      case BuildType.onboarding:
        return Onboarding();
      case BuildType.bucketList:
        return BucketList();
      case BuildType.bucketListWithProvider:
        return BucketListWithProvider();
      case BuildType.numberQuiz:
        return NumberQuiz();
      case BuildType.randomCat:
        return RandomCat();
      case BuildType.bucketListWithFirebase:
        return BucketListWithFirebase();

      // 여기부터는 DevStory 실전
      case BuildType.appleStoreWithStatefulWidget:
        return AppleStoreWithStatefulWidget();
      case BuildType.appleStoreWithInheritedWidget:
        return AppleStoreWithInheritedWidget();
      case BuildType.appleStoreWithProvider:
        return AppleStoreWithProvider();
      case BuildType.appleStoreWithRiverpod:
        return AppleStoreWithRiverpod();
      case BuildType.appleStoreWithCubit:
        return AppleStoreWithCubit();
      case BuildType.appleStoreWithBloc:
        return AppleStoreWithBloc();
      case BuildType.houseOfTomorrow:
        return HouseOfTomorrow();
      case BuildType.houseOfTomorrowMVVM:
        return HouseOfTomorrowMvvm();

      // 여기부터는 CodeFactory 입문

      // 여기부터는 CodeFactory 중급
      case BuildType.restaurant:
        return Restaurant();
      case BuildType.stateManagement:
        return StateManagement();

      // 여기부터는 삼촌과의 과제
      case BuildType.calculator:
        return Calculator();
      case BuildType.todo:
        return Todo();
      case BuildType.homepage:
        return HomePage();
      default:
        return Container();
    }
  }
}

enum SupportOrientation {
  landscape,
  portrait,
  orientation,
}

class Environment {
  final BuildType _buildType;
  BuildType get buildType => _buildType;

  static Environment? _instance;
  static Environment get instance => _instance!;

  const Environment._internal(this._buildType);
  factory Environment.newInstance(BuildType buildType) {
    _instance ??= Environment._internal(buildType);
    return _instance!;
  }

  Future run() => mainCommon();

  // 앱에 따라서 설정을 한다.
  static SupportOrientation supportOrientation = SupportOrientation.orientation;

  static get supportedOrientation {
    if (supportOrientation == SupportOrientation.landscape) {
      if (kIsWeb || Platform.isWindows || Platform.isIOS) {
        // 저작툴 iOS 14 대응시까지...(저작툴로 인해서 한쪽 방향만 지원)
        return [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ];
      } else {
        return [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ];
      }
    } else if (supportOrientation == SupportOrientation.portrait) {
      return [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ];
    } else {
      return [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp,
      ];
    }
  }
}
