import 'package:flutter/material.dart';

import 'landscape_bottom.dart';
import 'landscape_top.dart';

class LandscapeScreen extends StatelessWidget {
  const LandscapeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: LandscapeTop(),
        ),
        Expanded(
          flex: 7,
          child: LandscapeBottom(),
        ),
      ],
    );
  }
}
