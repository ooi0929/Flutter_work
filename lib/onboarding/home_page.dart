import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 나중에 값을 넣겠다고 명시
  late SharedPreferences prefs;

  // 로딩 상태를 관리하는 Notifier
  final isLoading = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  // SharedPreferences 초기화 함수
  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    isLoading.value = false; // 로딩이 완료되면 ValueNotifier 값 변경
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
        actions: [
          // 삭제 버튼
          IconButton(
            onPressed: () {
              // SharedPreferences에 저장된 모든 데이터 삭제
              // 비동기 함수 없이 바로 clear() 사용
              prefs.clear();
              // 추가적으로 값을 지운 후 다른 작업을 할 경우 async/await가 필요할 수 있음.
            },
            icon: Icon(Icons.delete),
          ),
        ],
      ),
      body: Stack(
        children: [
          // 실제 화면
          Center(
            child: Text(
              '환영합니다.',
              style: TextStyle(fontSize: 28.0),
            ),
          ),
          // 로딩 상태 관리: isLoading 값이 true이면 로딩 화면 표시
          ValueListenableBuilder(
            valueListenable: isLoading,
            builder: (context, isLoading, _) {
              return isLoading
                  ? Container(
                      color: Colors.white.withOpacity(0.8), // 로딩 중일 때 배경을 살짝 덮음
                      child: Center(
                        child: CircularProgressIndicator(), // 로딩 스피너
                      ),
                    )
                  : SizedBox.shrink(); // 로딩이 완료되면 빈 공간
            },
          ),
        ],
      ),
    );
  }
}
