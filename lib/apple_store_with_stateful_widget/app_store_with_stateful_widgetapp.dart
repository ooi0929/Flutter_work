import 'package:flutter/material.dart';

import 'page/apple_store_with_stateful_widget.dart';

class AppStoreWithStatefulWidget extends StatelessWidget {
  const AppStoreWithStatefulWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AppleStoreWithStatefulWidget(),
    );
  }
}
