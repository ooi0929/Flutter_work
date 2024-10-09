import 'package:flutter/material.dart';

import '../component/cal_notifier.dart';

class LandscapeTop extends StatelessWidget {
  const LandscapeTop({super.key});

  @override
  Widget build(BuildContext context) {
    // Singleton Instance
    final displayNotifier = CalNotifier.instance.displayNotifier;
    final resultNotifier = CalNotifier.instance.resultNotifier;

    return SizedBox.expand(
      child: ColoredBox(
        color: Colors.black,
        child: Column(
          // 계산식과 계산결과를 보일 위치를 조정
          mainAxisAlignment: MainAxisAlignment.end, // 주축(세로) 끝에 위치
          crossAxisAlignment: CrossAxisAlignment.end, // 반대축(가로) 끝에 위치
          children: [
            // 식
            ValueListenableBuilder(
              valueListenable: displayNotifier,
              builder: (context, value, child) {
                return Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.normal,
                  ),
                );
              },
            ),
            // 결과
            ValueListenableBuilder(
              valueListenable: resultNotifier,
              builder: (context, value, child) {
                return Text(
                  value,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
