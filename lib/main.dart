import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rps_game_tflite/core/simple_preferences.dart';
import 'package:rps_game_tflite/utils/Game.dart';

import 'HomePage.dart';

List<CameraDescription>? cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  final firstcamera = cameras!.first;
  await SimplePreferences.init();
  Game.highScore = SimplePreferences.getHighScore() ?? 0;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Taş Kağıt Makas',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
