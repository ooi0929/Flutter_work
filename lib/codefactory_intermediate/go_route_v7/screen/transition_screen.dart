import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/custom_elevated_button.dart';
import '../layout/default_layout.dart';

// Transition은 애니메이션과 비슷한 영역.
class TransitionScreen extends StatelessWidget {
  const TransitionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Container(
        color: Colors.red,
        child: ListView(
          children: [
            CustomElevatedButton(
              onPressed: () {
                context.go('/transition/detail');
              },
              data: 'Go to Detail',
            ),
          ],
        ),
      ),
    );
  }
}
