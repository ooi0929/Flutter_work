import 'package:flutter/material.dart';
import 'package:flutter_workspace/onboarding/page/onboarding_done.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  late SharedPreferences prefs;
  bool isOnboarded = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  // 비동기로 실행하기에 build() 내부에 isOnboarded를 작성하면 에러 발생
  // 완전히 초기화가 진행될때까지 기다리는 구문이 필요함.
  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      isOnboarded = prefs.getBool('isOnboarded') ?? false;
      isLoading = false; // 초기화 완료 후 로딩 상태를 false로 변경
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return isOnboarded
        ? OnboardingDone()
        : Scaffold(
            body: IntroductionScreen(
              pages: [
                // 첫 번째 페이지
                PageViewModel(
                  title: "빠른 개발",
                  body: "Flutter의 hot reload는 쉽고 UI 빌드를 도와줍니다.",
                  image: Padding(
                    padding: EdgeInsets.all(32),
                    child:
                        Image.network('https://i.ibb.co/2ZQW3Sb/flutter.png'),
                  ),
                  decoration: PageDecoration(
                    titleTextStyle: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    bodyTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
                // 두 번째 페이지
                PageViewModel(
                  title: "표현력 있고 유연한 UI",
                  body: "Flutter에 내장된 아름다운 위젯들로 사용자를 기쁘게 하세요.",
                  image: Image.network('https://i.ibb.co/LRpT3RQ/flutter2.png'),
                  decoration: PageDecoration(
                    titleTextStyle: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    bodyTextStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
              next: Text(
                'Next',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              done: Text(
                'Done',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onDone: () async {
                // Done 클릭시 isOnboarded = true로 저장
                await prefs.setBool("isOnboarded", true);

                // When done button is press
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => HomePage()),
                // );
                _navigatorOnboarding();
              },
            ),
          );
  }

  // Buildcontext 파라미터는 async가 있는 블록내에서 사용하지 않는 것이 좋다.
  void _navigatorOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => OnboardingDone(),
      ),
    );
  }
}
