import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CreatePage extends StatelessWidget {
  const CreatePage({super.key});

  @override
  Widget build(BuildContext context) {
    // TextField의 값을 가져올 때 사용합니다.
    TextEditingController textController = TextEditingController();

    // 경고 메시지
    final error = ValueNotifier<String?>(null);

    return Scaffold(
      appBar: AppBar(
        // 뒤로가기 버튼
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          '버킷리스트 작성',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ValueListenableBuilder(
              valueListenable: error,
              builder: (context, error, _) {
                return TextField(
                  controller: textController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: '하고 싶은 일을 입력하세요',
                    errorText: error,
                  ),
                );
              },
            ),
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
                  String job = textController.text; // 값 가져오기

                  if (job.isEmpty) {
                    error.value = '내용을 입력해주세요.'; // 내용이 없는 경우 에러 메시지
                  } else {
                    error.value = null; // 내용이 있는 경우 에러 메시지 숨기기
                    Navigator.pop(context, job); // job 변수를 반환하며 화면을 종료합니다.
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
            )
          ],
        ),
      ),
    );
  }
}
