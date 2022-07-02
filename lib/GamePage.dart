import 'package:flutter/material.dart';
import 'package:rps_game_tflite/utils/Game.dart';

import 'core/Configuration.dart';

class GamePage extends StatefulWidget {
  GamePage(this.gameChoice, {Key? key}) : super(key: key);
  Choice gameChoice;
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    String PlayerChoice = widget.gameChoice.type.toString();
    String? Choice;
    switch (PlayerChoice) {
      case "Taş":
        Choice = "";
        break;
      case "Kağıt":
        Choice = "";
        break;
      case "Makas":
        Choice = "";
        break;
    }
    return Scaffold(
      backgroundColor: scaffoldBlack,
      body: SafeArea(
        child: Center(
          child: Text(
            PlayerChoice,
            style: TextStyle(
              color: Colors.white,
              fontSize: 65,
            ),
          ),
        ),
      ),
    );
  }
}
