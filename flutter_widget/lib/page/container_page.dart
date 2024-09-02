import 'package:flutter/material.dart';

// 요구사항
// 1. Flutter 라는 글자를 가진 원을 가진다.
// 2. 약 25도의 각도로 기울어진 박스형태의 위젯이 원을 둘러 싼다.
// 3. 박스 위젯은 하위 위젯에 제약을 줄 수 있다.
// 4. style, 크기, 제약은 개발자 마음.
class ContainerPage extends StatelessWidget {
  const ContainerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Container(
          color: Colors.amber,
          constraints: BoxConstraints(
            maxHeight: 200,
            maxWidth: 200,
            minHeight: 50,
            minWidth: 50,
          ),
          transform: Matrix4.rotationZ(0.25),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            alignment: Alignment.center,
            width: 200,
            height: 200,
            child: Text(
              'Flutter',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
