// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'score_screen.dart'; // Import the ScoreScreen

class TicTacToeScreen extends StatefulWidget {
  @override
  _TicTacToeScreenState createState() => _TicTacToeScreenState();
}

class _TicTacToeScreenState extends State<TicTacToeScreen> {
  late List<List<String>> board;
  String? currentPlayer;
  String? winner;
  int playerXScore = 0;
  int playerOScore = 0;

  @override
  void initState() {
    super.initState();
    initializeBoard();
  }

  void initializeBoard() {
    board = List.generate(3, (i) => List.generate(3, (j) => ''));
    currentPlayer = 'X';
    winner = null;
  }

  void makeMove(int row, int col) {
    if (board[row][col] == '' && winner == null) {
      setState(() {
        board[row][col] = currentPlayer!;
        checkWinner(row, col);
        currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';
      });
    }
  }

  void checkWinner(int row, int col) {
    // Check rows
    for (int i = 0; i < 3; i++) {
      if (board[i][0] == board[i][1] &&
          board[i][1] == board[i][2] &&
          board[i][0] != '') {
        winner = board[i][0];
        updateScores();
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (board[0][i] == board[1][i] &&
          board[1][i] == board[2][i] &&
          board[0][i] != '') {
        winner = board[0][i];
        updateScores();
        return;
      }
    }

    // Check diagonals
    if ((board[0][0] == board[1][1] &&
            board[1][1] == board[2][2] &&
            board[0][0] != '') ||
        (board[0][2] == board[1][1] &&
            board[1][1] == board[2][0] &&
            board[0][2] != '')) {
      winner = board[1][1];
      updateScores();
    }
  }

  void updateScores() {
    if (winner == 'X') {
      playerXScore++;
    } else if (winner == 'O') {
      playerOScore++;
    }
  }

  Widget buildTile(int row, int col) {
    return GestureDetector(
      onTap: () => makeMove(row, col),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          border: Border.all(color: Color.fromARGB(255, 0, 0, 0)),
        ),
        child: Center(
          child: Text(
            board[row][col],
            style: TextStyle(fontSize: 48),
          ),
        ),
      ),
    );
  }

  Widget buildGameBoard() {
    List<Widget> rows = [];
    for (int i = 0; i < 3; i++) {
      List<Widget> cols = [];
      for (int j = 0; j < 3; j++) {
        cols.add(buildTile(i, j));
      }
      rows.add(Row(children: cols));
    }
    return Column(children: rows);
  }

  void resetGame() {
    setState(() {
      initializeBoard();
    });
  }

  void resetScores() {
    playerXScore = 0;
    playerOScore = 0;
  }

  void navigateToScoreScreen() {
    Navigator.push(
      context,
      PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 500),
        pageBuilder: (_, __, ___) => ScoreScreen(
          initialPlayerXScore: playerXScore,
          initialPlayerOScore: playerOScore,
          resetScores: resetScores,
        ),
        transitionsBuilder: (_, animation, __, child) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: animation.drive(
                Tween(begin: 0.5, end: 1.0).chain(
                  CurveTween(curve: Curves.easeInOut),
                ),
              ),
              child: child,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: App_Bar(),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                Color.fromARGB(255, 92, 142, 230),
                Color.fromARGB(117, 117, 211, 245),
                Color.fromARGB(255, 63, 232, 151)
              ])),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),

              AnimatedOpacity(
                opacity: (winner != null) ? 1.0 : 0.0,
                duration: Duration(milliseconds: 500),
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.4,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4, color: Color.fromARGB(255, 2, 255, 200)),
                      borderRadius: BorderRadius.circular(16)),
                  child: Center(
                    child: Text(
                      (winner == null) ? '' : 'Player $winner wins!',
                      style: TextStyle(
                          fontSize: 34,
                          fontWeight: FontWeight.w500,
                          color: Color.fromARGB(255, 0, 0, 0)),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 28),
              Text(
                'Player $currentPlayer\'s turn',
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 0, 60, 164)),
              ),
              SizedBox(height: 16),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildGameBoard(),
                ],
              ),

              SizedBox(height: 40),
              ElevatedButton(
                onPressed: resetGame,
                child: Text('Restart Game'),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                // Add this button for navigating to the ScoreScreen
                onPressed: navigateToScoreScreen,
                child: Text('View Scores'),
              ),
              SizedBox(height: 20),

              //
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
        'Tic Tac Toe',
        style: TextStyle(
            color: Color.fromARGB(255, 0, 60, 164),
            fontWeight: FontWeight.w600),
      ),
      // backgroundColor:
      //     Color.fromARGB(0, 255, 255, 255), // Make the AppBar transparent
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 92, 142, 230),
              Color.fromARGB(117, 117, 211, 245),
              // Color.fromARGB(134, 63, 232, 150)
            ], // Customize the gradient colors
          ),
        ),
      ),
    );
  }
}
