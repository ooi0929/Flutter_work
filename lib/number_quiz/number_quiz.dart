import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NumberQuiz extends StatefulWidget {
  const NumberQuiz({super.key});

  @override
  State<NumberQuiz> createState() => _NumberQuizState();
}

class _NumberQuizState extends State<NumberQuiz> {
  // 보여줄 퀴즈 Notifier 생성
  final quiz = ValueNotifier('');

  // 위젯 생성 시 호출
  @override
  void initState() {
    super.initState();
    print('시작');
    getQuiz(); // 퀴즈 가져오기 호출
  }

  void getQuiz() async {
    String trivia = await getNumberTrivia();
    quiz.value = trivia;
  }

  // Numbers API 호출하기
  Future<String> getNumberTrivia() async {
    // get 메서드로 URL 호출
    Response result = await Dio().get('http://numbersapi.com/random/trivia');
    String trivia = result.data;
    print(trivia);
    return trivia;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // quiz
              Expanded(
                child: Center(
                  child: ValueListenableBuilder(
                      valueListenable: quiz,
                      builder: (context, quiz, _) {
                        return Text(
                          quiz,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28.0,
                          ),
                          textAlign: TextAlign.center,
                        );
                      }),
                ),
              ),
              // New Quiz 버튼
              SizedBox(
                height: 42.0,
                child: ElevatedButton(
                  onPressed: () {
                    // New Quiz 클릭시 퀴즈 가져오기
                    getQuiz();
                  },
                  style: ElevatedButton.styleFrom(
                    shape: LinearBorder(),
                    backgroundColor: Colors.white,
                  ),
                  child: Text(
                    'New Quiz',
                    style: TextStyle(
                      color: Colors.pinkAccent,
                      fontSize: 24.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 위젯 삭제시 호출
  @override
  void dispose() {
    // quiz Notifier 삭제 -> 메모리 누수 방지.
    quiz.dispose();
    super.dispose();
  }
}
