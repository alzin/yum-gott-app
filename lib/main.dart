import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

void main() {
  runApp(const YumGottApp());
}

class YumGottApp extends StatelessWidget {
  const YumGottApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yum Gott',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        primaryColor: Colors.orange[800],
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.orange[800]!,
          primary: Colors.orange[800]!,
          secondary: Colors.orange[600]!,
          tertiary: Colors.brown[600]!,
        ),
        textTheme: Theme.of(context).textTheme.apply(
          fontFamily: 'Roboto',
          displayColor: Colors.white,
          bodyColor: Colors.white,
        ),
      ),
      home: const OnboardingScreen(),
    );
  }
}
