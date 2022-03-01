import 'package:flutter/material.dart';

class ZoomProvider extends ChangeNotifier {
  late TransformationController _controller;

  ZoomProvider() {
    _controller = TransformationController();

    _controller.addListener(() {
      if (_controller.value.getMaxScaleOnAxis() >= 1.3) {
        print("scale > 1.3");
      }
    });
  }

  TransformationController get controller => _controller;
}
