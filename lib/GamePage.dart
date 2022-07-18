import 'package:flutter/material.dart';
import 'package:rps_game_tflite/HomePage.dart';
import 'package:rps_game_tflite/utils/Game.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'core/Configuration.dart';
import 'core/simple_preferences.dart';

class GamePage extends StatefulWidget {
  GamePage(this.gameChoice, {Key? key}) : super(key: key);
  Choice gameChoice;
  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late SharedPreferences _preferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getHighScore();
  }

  void getHighScore() async {
    _preferences = await SharedPreferences.getInstance();
  }

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
      if (Game.score > Game.highScore) {
        Game.highScore = Game.score;
        SimplePreferences.setHighScore(Game.highScore);
      }
    } else if (Choice.gameRule[widget.gameChoice.type]![RobotChoice] ==
        "Kaybettin") {
      Game.score = 0;
    }
    Color resultColor(String result) {
      if (result == "Kazandın")
        return Colors.green;
      else if (result == "Kaybettin")
        return Colors.redAccent;
      else
        return Colors.white;
    }

    String result =
        Choice.gameRule[widget.gameChoice.type]![RobotChoice].toString();
    return Scaffold(
      backgroundColor: scaffoldBlack,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          children: [
            Expanded(
              flex: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Image.asset(PlayerChoicePath!),
                          Text(
                            "Sen",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ],
                      )),
                  Expanded(
                      flex: 2,
                      child: Text("VS",
                          style:
                              TextStyle(color: primaryOrange, fontSize: 45))),
                  Expanded(
                      flex: 5,
                      child: Column(
                        children: [
                          Image.asset(RobotChoicePath!),
                          Text(
                            "Rakip",
                            style: TextStyle(color: Colors.white, fontSize: 30),
                          ),
                        ],
                      )),
                ],
              ),
            ),
            Spacer(flex: 1),
            Expanded(
              flex: 5,
              child: Text(
                result,
                style: TextStyle(
                    color: resultColor(result),
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
                  Navigator.pop(context);
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
