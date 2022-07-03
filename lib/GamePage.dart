import 'package:flutter/material.dart';
import 'package:rps_game_tflite/HomePage.dart';
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
    String? RobotChoice = Game.randomChoice();
    String? PlayerChoicePath;
    String? RobotChoicePath;

    switch (RobotChoice) {
      case "Taş":
        RobotChoicePath = "assets/images/rock.png";
        break;
      case "Kağıt":
        RobotChoicePath = "assets/images/paper.png";
        break;
      case "Makas":
        RobotChoicePath = "assets/images/scissors.png";
        break;
    }
    switch (widget.gameChoice.type) {
      case "Taş":
        PlayerChoicePath = "assets/images/rock.png";
        break;
      case "Kağıt":
        PlayerChoicePath = "assets/images/paper.png";
        break;
      case "Makas":
        PlayerChoicePath = "assets/images/scissors.png";
        break;
    }

    if (Choice.gameRule[widget.gameChoice.type]![RobotChoice] == "Kazandın") {
      setState(() {
        Game.score++;
      });
    }
    return Scaffold(
      backgroundColor: scaffoldBlack,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(flex: 5, child: Image.asset(PlayerChoicePath!)),
                  Expanded(
                      flex: 2,
                      child: Text("VS",
                          style: TextStyle(color: Colors.white, fontSize: 45))),
                  Expanded(flex: 5, child: Image.asset(RobotChoicePath!)),
                ],
              ),
            ),
            Spacer(flex: 1),
            Expanded(
              flex: 5,
              child: Text(
                Choice.gameRule[widget.gameChoice.type]![RobotChoice]
                    .toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                "SKOR: " + Game.score.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              flex: 2,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                },
                child: Text("Tekrar Oyna"),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
