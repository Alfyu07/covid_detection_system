import 'dart:io';

import 'package:flutter/material.dart';

class ImgProvider with ChangeNotifier {
  File? _image;

  File? get image => _image;

  set image(File? newImage) {
    _image = newImage;
    notifyListeners();
  }

  void destroyImage() {
    _image = null;
    notifyListeners();
  }
}
