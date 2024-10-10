import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class NumberQuiz extends StatefulWidget {
  const NumberQuiz({super.key});

  @override
  State<NumberQuiz> createState() => _NumberQuizState();
}

class _NumberQuizState extends State<NumberQuiz> {
  final quiz = ValueNotifier(''); // 보여줄 퀴즈

  @override
  void initState() {
    super.initState();
    getQuiz(); // 위젯이 빌드될 때 퀴즈 가져오기 호출
  }

  // 퀴즈 가져오기
  void getQuiz() async {
    String trivia = await getNumberTrivia();
    quiz.value = trivia;
  }

  // Number API 호출하기
  Future<String> getNumberTrivia() async {
    // get 메서드로 URL 호출
    Response result = await Dio().get('http://numbersapi.com/random/trivia');

    String trivia = result.data;
    return trivia;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pinkAccent,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Center(
                  child: ValueListenableBuilder(
                    valueListenable: quiz,
                    builder: (context, quiz, _) {
                      return Text(
                        quiz,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 42.0,
                child: ElevatedButton(
                  onPressed: () => getQuiz(), // New Quiz 클릭시 퀴즈 가져오기
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
}
