import 'package:flutter/material.dart';

import 'landscape_screen.dart';
import 'portrait_screen.dart';

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OrientationBuilder(
        builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            // 세로 모드
            return PortraitScreen();
          } else {
            // 가로 모드
            return LandscapeScreen();
          }
        },
      ),
    );
  }
}
