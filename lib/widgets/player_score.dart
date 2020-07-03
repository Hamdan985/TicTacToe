import 'package:flutter/material.dart';

class PlayerScore extends StatelessWidget {
  final int playerWins;
  final String player;

  const PlayerScore({this.playerWins, this.player});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Player  $player',
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
          ),
        ),
        Text(
          '$playerWins',
          style: TextStyle(
            color: Colors.white,
            fontSize: 34,
          ),
        ),
      ],
    );
  }
}
