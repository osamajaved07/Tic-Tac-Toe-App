// ignore_for_file: prefer_const_constructors, unused_import

import 'package:calculator/screens/splash_screen.dart';
import 'package:calculator/screens/tic_tac_toe.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tic-Tac-Toe',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF3A83B7)),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
