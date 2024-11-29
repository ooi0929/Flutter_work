import 'package:flutter/material.dart';

class TodoAdd extends StatefulWidget {
  const TodoAdd({super.key});

  @override
  State<TodoAdd> createState() => _TodoAddState();
}

class _TodoAddState extends State<TodoAdd> {
  // TextField의 값을 가져오기 위한 컨트롤러
  late TextEditingController controller;

  // 에러 메시지를 관리할 valueNotifier
  final error = ValueNotifier<String?>(null);

  @override
  void initState() {
    super.initState();
    // TextEditController 초기화
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 제목
      appBar: AppBar(
        title: Text(
          'ToDo Add',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber[300],
        foregroundColor: Colors.white,
      ),
      // Todo 추가 영역
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // TextField의 에러메시지 관리
            ValueListenableBuilder(
              valueListenable: error,
              builder: (context, value, child) {
                return TextField(
                  controller: controller,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: '하고 싶은 일을 입력하세요',
                    errorText: value,
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            // 추가하기 버튼
            SizedBox(
              width: double.infinity,
              height: 32.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Colors.amber[300],
                ),
                onPressed: () {
                  // 값 가져오기
                  String todo = controller.text;

                  if (todo.isEmpty) {
                    // 내용이 없는 경우 에러 메시지
                    error.value = '내용을 입력해주세요.';
                  } else {
                    // 내용이 있는 경우 에러 메시지 숨기기
                    error.value = null;

                    // 내용이 있을 경우 추가할 todo 데이터를 반환
                    Navigator.pop(context, todo);
                  }
                },
                child: Text(
                  '추가하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 메모리 누수 방지
  @override
  void dispose() {
    controller.dispose(); // TextEditController 해제
    error.dispose(); // ValueNotifier 해제
    super.dispose(); // 항상 dispose는 마지막에 호출한다.
  }
}
