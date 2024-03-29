// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables, non_constant_identifier_names

import 'package:calculator/google_map/location.dart';
import 'package:calculator/google_map/map_page.dart';
import 'package:calculator/screens/tic_tac_toe.dart';
import 'package:calculator/snake_game/homescreen.dart';
import 'package:flutter/material.dart';

class ScoreScreen extends StatefulWidget {
  final VoidCallback resetScores;
  final int initialPlayerXScore;
  final int initialPlayerOScore;

  ScoreScreen({
    required this.resetScores,
    required this.initialPlayerXScore,
    required this.initialPlayerOScore,
  });

  @override
  State<ScoreScreen> createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  late int playerXScore;
  late int playerOScore;

  @override
  void initState() {
    super.initState();
    playerXScore = widget.initialPlayerXScore;
    playerOScore = widget.initialPlayerOScore;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App_Bar(),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
              Color.fromARGB(255, 92, 142, 230),
              Color.fromARGB(117, 117, 211, 245),
              Color.fromARGB(255, 63, 232, 151)
            ])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 1.4,
                decoration: BoxDecoration(
                    border: Border.all(
                        width: 4, color: Color.fromARGB(255, 255, 255, 255)),
                    borderRadius: BorderRadius.circular(16)),
                child: Column(
                  children: [
                    Text(
                      'Player X Score: $playerXScore',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 60, 164)),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Player O Score: $playerOScore',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 60, 164)),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    playerXScore = 0;
                    playerOScore = 0;
                  });
                  widget.resetScores();
                  // Navigator.of(context).push(MaterialPageRoute(builder: (context) => TicTacToeScreen()));
                },
                child: Text('Reset Game and Scores'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop(MaterialPageRoute(
                      builder: (context) => TicTacToeScreen()));
                },
                child: Text('Back to game'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MyLocation()));
                },
                child: Text('Get current location'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MapPage()));
                },
                child: Text('Map Page'),
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => HomeScreen()));
                },
                child: Text('Snake game'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar App_Bar() {
    return AppBar(
      centerTitle: true,
      automaticallyImplyLeading: false,
      title: Text(
        'Game Scores',
        style: TextStyle(
            color: Color.fromARGB(255, 0, 60, 164),
            fontWeight: FontWeight.w600),
      ),
      backgroundColor:
          Color.fromARGB(0, 255, 255, 255), // Make the AppBar transparent
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 92, 142, 230),
              Color.fromARGB(117, 117, 211, 245),
            ], // Customize the gradient colors
          ),
        ),
      ),
    );
  }
}
