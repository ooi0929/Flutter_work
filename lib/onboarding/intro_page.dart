import 'package:flutter/material.dart';
import 'package:flutter_workspace/onboarding/home_page.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late SharedPreferences prefs;
  final isLoading = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    isLoading.value = false; // 로딩이 끝나면 화면 업데이트
  }

  @override
  Widget build(BuildContext context) {
    // SharedPreferences 초기화 전에는 로딩 화면 표시
    return ValueListenableBuilder(
      valueListenable: isLoading,
      builder: (context, isLoading, _) {
        if (isLoading) {
          // 로딩 중일 때 로딩 스피너 표시
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // 로딩이 끝나면 IntroductionScreen을 보여준다.
        return Scaffold(
          body: IntroductionScreen(
            pages: [
              // 첫 번째 페이지
              PageViewModel(
                title: '빠른 개발',
                body: 'Flutter의 hot reload는 쉽고 UI 빌드를 도와줍니다.',
                image: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Image.network('https://i.ibb.co/2ZQW3Sb/flutter.png'),
                ),
                decoration: PageDecoration(
                  titleTextStyle: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  bodyTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                  ),
                ),
              ),
              // 두 번째 페이지
              PageViewModel(
                title: '표현력 있고 유연한 UI',
                body: 'Flutter에 내장된 아름다운 위젯들로 사용자를 기쁘게 하세요.',
                image: Image.network('https://i.ibb.co/LRpT3RQ/flutter2.png'),
                decoration: PageDecoration(
                  titleTextStyle: TextStyle(
                    color: Colors.blueAccent,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                  bodyTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
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
            onDone: () {
              // Done 클릭 시 isOnboarding = true로 저장
              prefs.setBool('isOnboarded', true);

              // Done 클릭 시 페이지 이동
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomePage(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
