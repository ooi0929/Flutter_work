import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'environment.dart';
import 'my_app.dart';

Future<void> mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations(Environment.supportedOrientation);
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);

  runApp(const MyApp());
}
