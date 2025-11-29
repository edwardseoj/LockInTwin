import 'package:flutter/material.dart';
import 'package:lock_in_twin/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Made Easy',
      home: const SplashScreen(),
    );
  }
  
}

