import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bucket_service.dart';

/// 버킷 생성 페이지
class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  // TextField의 값을 가져올 때 사용합니다.
  TextEditingController textController = TextEditingController();

  // 경고 메세지
  final error = ValueNotifier<String?>(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "버킷리스트 작성",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        // 뒤로가기 버튼
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.chevron_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // 텍스트 입력창
            ValueListenableBuilder(
              valueListenable: error,
              builder: (context, error, _) {
                return TextField(
                  controller: textController,
                  autofocus: true,
                  decoration: InputDecoration(
                    hintText: "하고 싶은 일을 입력하세요",
                    errorText: error,
                  ),
                );
              },
            ),
            SizedBox(height: 32),
            // 추가하기 버튼
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: LinearBorder(),
                  backgroundColor: Colors.blue,
                ),
                child: Text(
                  "추가하기",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  // 추가하기 버튼 클릭시
                  String job = textController.text;
                  if (job.isEmpty) {
                    error.value = "내용을 입력해주세요."; // 내용이 없는 경우 에러 메세지
                  } else {
                    error.value = null;

                    // BucketService 가져오기
                    BucketService bucketService = context.read<BucketService>();
                    bucketService.createBucket(job);

                    Navigator.pop(context); // 화면을 종료합니다.
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
