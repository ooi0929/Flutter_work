import 'package:flutter/material.dart';
import 'package:flutter_workspace/onboarding/page/home_page.dart';
import 'package:flutter_workspace/onboarding/page/onboarding.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyAppOnboarding extends StatefulWidget {
  const MyAppOnboarding({super.key});

  @override
  State<MyAppOnboarding> createState() => _MyAppOnboardingState();
}

class _MyAppOnboardingState extends State<MyAppOnboarding> {
  @override
  Widget build(BuildContext context) {
    late SharedPreferences prefs;

    initState() async {
      super.context;
      prefs = await SharedPreferences.getInstance();
    }

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
