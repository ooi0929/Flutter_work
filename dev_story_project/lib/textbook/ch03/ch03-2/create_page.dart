// 버킷 생성 페이지
import 'package:flutter/material.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // TextField의 값을 가져올 때 사용
  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '버킷리스트 작성',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white, // 뒤로가기 버튼 색상
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 텍스트 입력창
            TextField(
              controller: textEditingController, // 컨트롤러 연결
              autofocus: true, // 자동적으로 focus 되도록 설정
              decoration: InputDecoration(
                hintText: '하고 싶은 일을 입력하세요',
                focusColor: Colors.blue,
              ),
            ),
            SizedBox(height: 32.0),
            // 추가하기 버튼
            SizedBox(
              width: double.infinity,
              height: 48.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: LinearBorder(),
                ),
                onPressed: () {
                  // 추가하기 버튼 클릭 시
                },
                child: Text(
                  '추가하기',
                  style: TextStyle(
                    color: Colors.white,
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
