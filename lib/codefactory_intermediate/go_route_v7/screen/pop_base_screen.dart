import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/custom_elevated_button.dart';
import '../layout/default_layout.dart';

class PopBaseScreen extends StatelessWidget {
  const PopBaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          CustomElevatedButton(
            // 값을 받아오기를 기다려야 하니까
            // 비동기 작업
            onPressed: () async {
              final result = await context.push('/pop/return');

              print(result);
            },
            data: 'Push Pop Return Screen',
          ),
        ],
      ),
    );
  }
}
