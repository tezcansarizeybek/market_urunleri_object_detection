import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import 'home.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Permission.camera.request();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Hata: ${e.code}\n${e.description}');
  }
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Market Ürünleri Tanıma',
      theme: ThemeData(primaryColor: Colors.blue),
      darkTheme: ThemeData.dark(),
      home: HomePage(cameras),
    );
  }
}
