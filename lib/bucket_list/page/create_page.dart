import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TextField의 값을 가져오기 위해 사용
    final TextEditingController textController = TextEditingController();

    // 경고 메시지
    final error = ValueNotifier<String?>(null);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '버킷리스트 작성',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        // 뒤로가기 버튼 색상 변경
        // iconTheme: IconThemeData(color: Colors.white),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 텍스트 입력창
            ValueListenableBuilder(
                valueListenable: error,
                builder: (context, value, child) {
                  return TextField(
                    autofocus: true,
                    controller: textController, // 컨트롤러 등록
                    decoration: InputDecoration(
                      hintText: '하고 싶은 일을 입력하세요.',
                      errorText: value,
                    ),
                  );
                }),
            SizedBox(height: 32.0),
            // 추가하기 버튼
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: LinearBorder(),
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  // 추가하기 버튼 클릭시
                  String job = textController.text; // TextField 값 가져오기

                  if (job.isEmpty) {
                    // 내용이 없는 경우 에러 메시지
                    error.value = '내용을 입력해주세요.';
                  } else {
                    // 내용이 있는 경우 에러 메시지 숨기기
                    error.value = null;
                    Navigator.pop(context, job);
                  }
                },
                child: Text(
                  '추가하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
