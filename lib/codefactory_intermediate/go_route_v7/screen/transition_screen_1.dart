import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../component/custom_elevated_button.dart';
import '../layout/default_layout.dart';

class TransitionScreen1 extends StatelessWidget {
  const TransitionScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      body: Container(
        color: Colors.blue,
        child: ListView(
          children: [
            CustomElevatedButton(
              onPressed: () {
                context.pop();
              },
              data: 'POP',
            ),
          ],
        ),
      ),
    );
  }
}
