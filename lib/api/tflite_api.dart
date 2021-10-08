import 'dart:io';
import 'package:tflite/tflite.dart';

class TfliteApi {
  static Future<void> loadModel() async {
    await Tflite.loadModel(
        model: 'assets/lite_model.tflite', labels: 'assets/labels.txt');
  }

  static Future classifyImage(File image) async {
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
