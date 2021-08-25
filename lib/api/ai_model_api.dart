import 'package:flutter/widgets.dart';

class AiModelApi {
  static Future<String> predict(Image image) async {
    await Future.delayed(const Duration(seconds: 2));

    return "covid";
  }
}
