import 'package:flutter/material.dart';

import 'route/router.dart';

class GoRouteV7 extends StatelessWidget {
  const GoRouteV7({super.key});

  @override
  Widget build(BuildContext context) {
    // GoRouter를 쓸 때에는 MaterialApp 대신 .router를 붙여서 사용하면 된다.
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}
