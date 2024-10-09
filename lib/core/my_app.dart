// import 'package:calculator/core/environment.dart';
import 'package:flutter/material.dart';

import 'environment.dart';

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
