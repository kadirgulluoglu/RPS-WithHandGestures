import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import 'HomePage.dart';

List<CameraDescription>? cameras;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  final firstcamera = cameras!.first;
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
