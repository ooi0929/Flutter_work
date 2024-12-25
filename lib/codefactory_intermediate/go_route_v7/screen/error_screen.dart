// 에러 스크린은 GoRoute상의 에러를 다루는 것.
import 'package:flutter/material.dart';

import '../component/custom_elevated_button.dart';

class ErrorScreen extends StatelessWidget {
  final String error;

  const ErrorScreen({
    super.key,
    required this.error,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('에러'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          Text('Error: $error'),
          CustomElevatedButton(
            onPressed: () {},
            data: '홈으로',
          ),
        ],
      ),
    );
  }
}
