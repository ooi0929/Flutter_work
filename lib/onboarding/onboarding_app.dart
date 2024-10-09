import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'onboarding.dart';

class OnboardingApp extends StatelessWidget {
  const OnboardingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.getTextTheme('Jua'),
      ),
      home: Onboarding(),
    );
  }
}
