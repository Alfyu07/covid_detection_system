import 'dart:io';
import 'package:tflite/tflite.dart';

// ignore: avoid_classes_with_only_static_members
class TfliteApi {
  Future<void> loadModel() async {
    await Tflite.loadModel(
        model: 'assets/lite_model.tflite', labels: 'assets/labels.txt');
  }

  Future classifyImage(File image) async {
    final output = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 3,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 125.5,
    );
    return output;
  }
}
