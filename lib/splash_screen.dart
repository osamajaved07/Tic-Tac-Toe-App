// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:calculator/tic_tac_toe.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 92, 142, 230),
              Color.fromARGB(117, 117, 211, 245),
              Color.fromARGB(255, 63, 232, 151)
            ])),
        child: Stack(
          children: [
            Center(
              child: LottieBuilder.asset("assets/Lottie/TicTacToe.json"),
            ),
            SizedBox(
              height: 120,
            ),
            Positioned(
                top: 700,
                left: 0,
                bottom: 0,
                right: 0,
                child: LottieBuilder.asset("assets/Lottie/loading dots.json"))
          ],
        ),
      ),
      nextScreen: TicTacToeScreen(),
      duration: 3200,
      splashIconSize: 800,
      backgroundColor: Colors.lightBlue.shade100,
    );
  }
}
