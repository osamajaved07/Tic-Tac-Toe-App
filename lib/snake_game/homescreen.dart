// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, constant_identifier_names

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int foodPosition = 200;
  SnakeDirection snakeDirection = SnakeDirection.Down;
  int score = 0;
  bool isGameRunning = false;
  late Timer timer;
  bool _isGameOver = false;

  List<int> snakePosition = [];

  @override
  void initState() {
    super.initState();
    initialiseSnake();
  }

  void initialiseSnake() {
    for (var i = 0; i < 3; i++) {
      snakePosition.add(i);
    }
  }

  void startGame() {
    isGameRunning = true;
    timer = Timer.periodic(Duration(milliseconds: 300), (timer) {
      moveSnake();
      isGameOver();
    });
  }

  void moveSnake() {
    if (snakeDirection == SnakeDirection.Right) {
      if (snakePosition.last % 15 == 14) {
        snakePosition.add(snakePosition.last + 1 - 15);
      } else {
        snakePosition.add(snakePosition.last + 1);
      }
    } else if (snakeDirection == SnakeDirection.Left) {
      if (snakePosition.last % 15 == 0) {
        snakePosition.add(snakePosition.last - 1 + 15);
      } else {
        snakePosition.add(snakePosition.last - 1);
      }
    } else if (snakeDirection == SnakeDirection.Up) {
      if (snakePosition.last < 15) {
        snakePosition.add(snakePosition.last - 15 + 330);
      } else {
        snakePosition.add(snakePosition.last - 15);
      }
    } else if (snakeDirection == SnakeDirection.Down) {
      if (snakePosition.last > 314) {
        snakePosition.add(snakePosition.last + 15 - 330);
      } else {
        snakePosition.add(snakePosition.last + 15);
      }
    }

    if (snakePosition.last == foodPosition) {
      onEatFood();
    } else {
      snakePosition.removeAt(0);
    }

    setState(() {});
  }

  void onEatFood() {
    score++;
    while (snakePosition.contains(foodPosition)) {
      foodPosition = Random().nextInt(329);
    }
  }

  void isGameOver() {
    List<int> duplicateSnakePosition = [];
    duplicateSnakePosition.addAll(snakePosition);
    duplicateSnakePosition.remove(snakePosition.last);
    if (duplicateSnakePosition.contains(snakePosition.last)) {
      timer.cancel();
      _isGameOver = true;
      setState(() {});
    }
  }

  void restartGame() {
    _isGameOver = false;
    score = 0;
    snakePosition = [];
    initialiseSnake();
    startGame();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: (dragUpdateDetais) {
        if (dragUpdateDetais.delta.dy > 0) {
          snakeDirection = SnakeDirection.Down;
        } else {
          snakeDirection = SnakeDirection.Up;
        }
        setState(() {});
      },
      onHorizontalDragUpdate: (drageUpdateDetails) {
        if (drageUpdateDetails.delta.dx > 0) {
          snakeDirection = SnakeDirection.Right;
        } else {
          snakeDirection = SnakeDirection.Left;
        }
        setState(() {});
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            'Snake Game',
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
        ),
        body: Column(
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: 330,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 15,
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 2,
                ),
                itemBuilder: (context, index) {
                  if (index == foodPosition) {
                    return Food();
                  } else if (snakePosition.contains(index)) {
                    return Snake();
                  } else {
                    return Box();
                  }
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Score: $score",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!_isGameOver && !isGameRunning)
                    ElevatedButton(
                      onPressed: startGame,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      child: Text(
                        "Start Game",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  if (_isGameOver)
                    ElevatedButton(
                      onPressed: restartGame,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      child: Text(
                        "Retry",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Box extends StatelessWidget {
  const Box({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class Food extends StatelessWidget {
  const Food({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class Snake extends StatelessWidget {
  const Snake({Key? key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

enum SnakeDirection { Up, Down, Left, Right }
