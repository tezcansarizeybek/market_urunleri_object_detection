import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:deeplearning/database_helper.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

import 'bndbox.dart';
import 'camera.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomePage(this.cameras);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  @override
  void initState() {
    loadModel();
    super.initState();
  }

  loadModel() async {
    String res = await Tflite.loadModel(model: "assets/model.tflite", labels: "assets/label.txt");
    print(res);
  }

  setRecognitions(recognitions, imageHeight, imageWidth) async {
    setState(() {
      print(recognitions);
      recognitions.forEach((e) {
        veritabaniAc().then((db) {
          var detectedClass = e["detectedClass"];
          db.query('Urunler', where: "KODU = ?", whereArgs: [detectedClass]).then((sonuc) {
            if (sonuc.length > 0) {
              var so = discountCalc(sonuc.first);
              e["detectedClass"] = "$so";
              print("asdad");
            }
          });
        });
      });
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  discountCalc(query) {
    var price = double.tryParse(query["FIYAT1"].toString()) ?? 0.0;
    var dis1 = double.tryParse(query["IND1"].toString()) ?? 0.0;
    var dis2 = double.tryParse(query["IND2"].toString()) ?? 0.0;
    var s = price - (price * dis1 / 100);
    s = s - (s * dis2 / 100);
    return "${query["ADI"]} - ${s.toStringAsFixed(2)} TL";
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(""),
      ),
      body: Stack(
        children: [
          Camera(
            widget.cameras,
            _model,
            setRecognitions,
          ),
          BndBox(_recognitions == null ? [] : _recognitions, math.max(_imageHeight, _imageWidth), math.min(_imageHeight, _imageWidth), screen.height, screen.width, _model),
        ],
      ),
    );
  }
}
