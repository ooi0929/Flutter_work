import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/custom_elevated_button.dart';
import '../layout/default_layout.dart';

// 1) GoRoute - 선언형
// 2) Push - 빌드형
class PushScreen extends StatelessWidget {
  const PushScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: ListView(
        children: [
          CustomElevatedButton(
            onPressed: () {
              // 현재 라우트가 형성이 되어있는 상태에서
              // 바로 라우트 스택을 쌓고 싶을 때에
              // push()를 활용한다.
              context.push('/basic');
            },
            data: 'Push Basic',
          ),
          // Nesting이 중요한 이유.
          // goRoute는 Route Stack을 쌓지 않음.
          // 뒤로 가기를 누르면 '/'화면으로 돌아감.

          // 현재 위치에서 Route Stack이 추가가 되는것이 아닌
          // 선언된 위치에서 Route Stack이 추가가 된다.

          // 즉, Nesting으로 쌓은 순서대로 Route Stack이 쌓이게 된다.
          CustomElevatedButton(
            onPressed: () {
              context.go('/basic');
            },
            data: 'Go Basic',
          ),
        ],
      ),
    );
  }
}
