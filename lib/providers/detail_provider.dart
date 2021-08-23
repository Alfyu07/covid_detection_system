import 'package:flutter/widgets.dart';

class DetailProvider with ChangeNotifier {
  bool _isImgVisible = false;

  bool get isImgVisible => _isImgVisible;

  void setImgVisibility(bool value) {
    _isImgVisible = value;
    notifyListeners();
  }
}
