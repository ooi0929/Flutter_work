import 'package:flutter/material.dart';

import 'environment.dart';

// 기본 MyApp Buid
// Enviroment에 있는 BuildType Enum 값에 따라 해당 build()를 실행.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Environment.instance.buildType.build(context),
    );
  }
}
