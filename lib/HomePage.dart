import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:rps_game_tflite/core/Configuration.dart';
import 'package:rps_game_tflite/utils/Game.dart';
import 'package:tflite/tflite.dart';

import 'GamePage.dart';
import 'main.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String choice = "";
  CameraController? cameraController;
  CameraImage? imgCamera;

  bool isWorking = false;
  List<dynamic> _currentRecognition = [];

  //sayaç
  int timeLeft = 3;
  void _startCounterDown() {
    Timer.periodic(const Duration(milliseconds: 600), (timer) {
      if (timeLeft > 0) {
        setState(() {
          timeLeft--;
        });
      } else {
        timer.cancel();
        showGeneralDialog(
          context: context,
          barrierDismissible: true,
          barrierLabel:
              MaterialLocalizations.of(context).modalBarrierDismissLabel,
          transitionDuration: Duration(microseconds: 200),
          pageBuilder: (
            BuildContext context,
            Animation first,
            Animation second,
          ) {
            return GamePage(Choice(choice));
          },
        );
        timeLeft = 3;
      }
    });
  }

  // Model Yüklendi
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/tflite/rps.tflite",
      labels: "assets/tflite/labels.txt",
      numThreads: 1,
    );
  }

  initCamera() {
    cameraController =
        CameraController(cameras![1], ResolutionPreset.low, enableAudio: false);
    cameraController!.initialize().then((value) {
      if (!mounted) {
        return;
      }
      setState(() {
        cameraController!.startImageStream((imageFromStream) => {
              if (!isWorking)
                {
                  isWorking = true,
                  imgCamera = imageFromStream,
                  runModelOnStreamFrames(),
                }
            });
      });
    });
  }

// tflite run
  runModelOnStreamFrames() async {
    if (imgCamera != null) {
      var recognitions = await Tflite.runModelOnFrame(
        bytesList: imgCamera!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: imgCamera!.height,
        imageWidth: imgCamera!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        numResults: 1,
        threshold: 0.1,
        asynch: true,
      );

      setState(() {
        _currentRecognition = recognitions!;
        choice = _currentRecognition[0]['label'];
      });
      isWorking = false;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initCamera();
    loadModel();
  }

  @override
  void dispose() async {
    // TODO: implement dispose
    super.dispose();
    await Tflite.close();
    cameraController?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return imgCamera == null
        ? Center(
            child: CircularProgressIndicator(color: primaryOrange),
          )
        : Scaffold(
            backgroundColor: scaffoldBlack,
            body: SafeArea(
                child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "SKOR: " + Game.score.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "YÜKSEK SKOR: " + Game.highScore.toString(),
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * .05),
                  Camera(size),
                  TextGelenSonuc(),
                  SizedBox(height: size.height * .05),
                  Text(
                    timeLeft.toString(),
                    style: TextStyle(
                      fontSize: 55,
                      color: primaryOrange,
                    ),
                  ),
                  MaterialButton(
                    onPressed: _startCounterDown,
                    child: Text(
                      "START",
                      style: TextStyle(
                          fontSize: 55, color: Colors.white, letterSpacing: 3),
                    ),
                  ),
                ],
              ),
            )),
          );
  }

  Text TextGelenSonuc() {
    return Text(
      _currentRecognition[0]['label'],
      style: TextStyle(color: primaryOrange, fontSize: 25),
    );
  }

  Container Camera(Size size) {
    return Container(
      height: size.height * 0.5,
      child: AspectRatio(
        aspectRatio: cameraController!.value.aspectRatio,
        child: CameraPreview(cameraController!),
      ),
    );
  }
}
