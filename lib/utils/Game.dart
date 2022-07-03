import 'dart:math';

class Game {
  static int score = 0;
  static List<String> choices = ["Taş", "Kağıt", "Makas"];
  static String? randomChoice() {
    Random random = new Random();
    int robotChoice = random.nextInt(3);
    return choices[robotChoice];
  }
}

class Choice {
  String? type = "";
  static var gameRule = {
    "Taş": {"Taş": "Berabere", "Kağıt": "Kaybettin", "Makas": "Kazandın"},
    "Kağıt": {"Taş": "Kazandın", "Kağıt": "Berabere", "Makas": "Kaybettin"},
    "Makas": {"Taş": "Kaybettin", "Kağıt": "Kazandın", "Makas": "Berabere"},
  };
  Choice(this.type);
}
