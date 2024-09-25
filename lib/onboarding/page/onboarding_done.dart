import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingDone extends StatefulWidget {
  const OnboardingDone({super.key});

  @override
  State<OnboardingDone> createState() => _OnboardingDoneState();
}

class _OnboardingDoneState extends State<OnboardingDone> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HomePage"),
        actions: [
          // 삭제 버튼
          IconButton(
            onPressed: () {
              // SharedPreferences에 저장된 모든 데이터 삭제
              prefs.clear();
            },
            icon: Icon(Icons.delete),
          )
        ],
      ),
      body: Center(
        child: Text(
          "환영합니다.",
          style: TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}
