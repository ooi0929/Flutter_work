import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/custom_elevated_button.dart';
import '../layout/default_layout.dart';

class PopReturnScreen extends StatelessWidget {
  const PopReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          CustomElevatedButton(
            onPressed: () {
              // GoRoute를 불러와줘야 한다.
              // 딱 하나의 값만 반환이 가능하다.

              // 여러 개의 값을 반환하고 싶으면 어떻게 하지?
              // List를 반환하거나 Class를 반환하게끔해서 가져오면 된다.
              context.pop('code factory');
            },
            data: 'Pop',
          ),
        ],
      ),
    );
  }
}
