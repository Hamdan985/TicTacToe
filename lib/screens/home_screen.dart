import 'package:flutter/material.dart';
import 'dart:core';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int no_of_ex_wins = 0;
  int no_of_oh_wins = 0;
  bool exTurn = true;
  List<String> exOh = ['', '', '', '', '', '', '', '', ''];
  List<int> playedTiles = [];
  List scoreBoard = ['Player 1', 'Player 2', '0', '0'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Text(
                      'Scoreboard',
                      style: TextStyle(
                        fontSize: 32.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        'Player - X : $no_of_ex_wins',
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                      Text(
                        'Player - X : $no_of_ex_wins',
                        style: TextStyle(color: Colors.white, fontSize: 22.0),
                      ),
                    ],
                  )
                ],
              )),
          Expanded(
            flex: 5,
            child: GridView.builder(
              itemCount: 9,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.09,
              ),
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => _buttonPressed(index),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        exOh[index],
                        style: TextStyle(
                          fontSize: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.redAccent[400],
            ),
          ),
        ],
      ),
    );
  }

  void _buttonPressed(int index) {
    setState(() {
      if (!playedTiles.contains(index)) {
        if (exTurn) {
          exOh[index] = 'X';
          exTurn = !exTurn;
        } else {
          exOh[index] = 'O';
          exTurn = !exTurn;
        }
      } else {
        print('tile already played');
      }

      playedTiles.add(index);
      _checkForWinner();
    });
  }

  void _checkForWinner() {
    if (_winnerContitions()) {
      print('Check for winner condition');
      showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              elevation: 4.0,
              title: Text('Congrats player X or O'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text('How about another match!!!'),
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text('Replay?'),
                  onPressed: _matchReset,
                ),
              ],
            );
          });
    } else {
      return;
    }
  }

  bool _winnerContitions() {
    //first row
    if (exOh[0] == exOh[1] && exOh[0] == exOh[2] && exOh[0] != '') {
      return true;
    }
    //second row
    if (exOh[3] == exOh[4] && exOh[3] == exOh[5] && exOh[3] != '') {
      return true;
    }
    //third row
    if (exOh[6] == exOh[7] && exOh[6] == exOh[8] && exOh[6] != '') {
      return true;
    }
    //first column
    if (exOh[0] == exOh[3] && exOh[0] == exOh[6] && exOh[0] != '') {
      return true;
    }
    //second column
    if (exOh[1] == exOh[4] && exOh[1] == exOh[7] && exOh[1] != '') {
      return true;
    }
    //third column
    if (exOh[2] == exOh[5] && exOh[2] == exOh[8] && exOh[2] != '') {
      return true;
    }
    // L to R diagonal
    if (exOh[0] == exOh[4] && exOh[0] == exOh[8] && exOh[0] != '') {
      return true;
    }
    // R to L diagonal
    if (exOh[2] == exOh[4] && exOh[2] == exOh[6] && exOh[2] != '') {
      return true;
    } else {
      return false;
    }
  }

  void _matchReset() {
    setState(() {
      exOh = ['', '', '', '', '', '', '', '', ''];
    });
    Navigator.of(context).pop();
  }
}
