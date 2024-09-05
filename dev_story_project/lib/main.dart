import 'package:dev_story_project/textbook/ch03/ch03-1/home_page.dart';
import 'package:dev_story_project/textbook/ch03/ch03-1/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Shared_preferences 인스턴스 생성
// 앱이 시작되기 전에 인스턴스 불러오기.
// late 키워드를 통해 나중에 무조건 값을 할당해준다는 것을 명시
late SharedPreferences prefs;
void main() async {
  // main() 함수에서 async를 쓰려면 생성
  WidgetsFlutterBinding.ensureInitialized();

  prefs = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // SharedPreferences에서 온보딩 완료 여부 조회
    // isOnboarded에 해당하는 값에서 null을 반환하는 경우 false 할당
    bool isOnboarded = prefs.getBool("isOnboarded") ?? false;

    return MaterialApp(
      home: isOnboarded ? HomePage() : Onboarding(),
    );
  }
}
