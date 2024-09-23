import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'environment.dart';
import 'my_app.dart';

Future<void> mainCommon() async {
  // main() 함수에서 async를 쓰려면 필요
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(Environment.supportedOrientation);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  runApp(const MyApp());
}
