import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_workspace/calculator/component/cal_notifier.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({
    super.key,
    required this.keyboard,
    required this.color,
  });

  final String keyboard; // 키보드 값
  final Color color; // 키보드 색상

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 한 번 탭할시
      onTap: () => CalNotifier.instance.process(keyboard),
      child: Container(
        color: Colors.black,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: AutoSizeText(
              keyboard,
              style: TextStyle(
                // 주어진 공간에 맞게 텍스트 크기를 자동으로 지정
                color: color,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
              minFontSize: 12.roundToDouble(), // 글자의 최소크기, 정수를 가장 가까운 실수로 변환
            ),
          ),
        ),
      ),
    );
  }
}
