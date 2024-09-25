import 'package:flutter/material.dart';

import 'portrait_bottom.dart';
import 'portrait_top.dart';

class PortraitScreen extends StatelessWidget {
  const PortraitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: PortraitTop(),
        ),
        Expanded(
          flex: 7,
          child: PortraitBottom(),
        ),
      ],
    );
  }
}
