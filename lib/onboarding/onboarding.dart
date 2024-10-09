import 'package:flutter/material.dart';
import 'package:flutter_workspace/onboarding/home_page.dart';
import 'package:flutter_workspace/onboarding/intro_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  // SharedPreferences에서 온보딩 상태를 불러오는 함수
  Future<bool> getOnboardingStatus() async {
    // shared_preferences 인스턴스 생성.
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isOnboarded') ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: getOnboardingStatus(), // 비동기 함수 호출
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터 로딩 중일 때
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // 에러가 발생했을 때
          return const Center(
            child: Text('Error loading onboarding status'),
          );
        } else if (snapshot.hasData) {
          // 로딩이 완료되었을 때
          bool isOnboarded = snapshot.data ?? false;
          return isOnboarded ? HomePage() : IntroPage();
        } else {
          // 데이터가 없는 경우 기본적으로 IntroPage로 이동
          return IntroPage();
        }
      },
    );
  }
}
