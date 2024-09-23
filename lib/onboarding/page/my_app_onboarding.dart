import 'package:flutter/material.dart';
import 'package:flutter_workspace/onboarding/page/home_page.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'onboarding.dart';

class MyAppOnboarding extends StatefulWidget {
  const MyAppOnboarding({super.key});

  @override
  State<MyAppOnboarding> createState() => _MyAppOnboardingState();
}

class _MyAppOnboardingState extends State<MyAppOnboarding> {
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    prefs = await SharedPreferences.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    bool onboard = prefs.getBool("onBoarded") ?? false;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.getTextTheme('Jua'),
      ),
      home: onboard ? HomePage() : Onboarding(),
    );
  }
}
