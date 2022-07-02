import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rps_game_tflite/Core/Configuration.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    bool isWorking = false;
    Size size = MediaQuery.of(context).size;
    CameraController? cameraController;
    CameraImage? imgCamera;

    loadModel()
    return Scaffold(
      backgroundColor: ScaffoldBlack,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 34, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              color: Colors.red,
            )
          ],
        ),
      )),
    );
  }
}
