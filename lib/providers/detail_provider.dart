import 'package:covid_detection_system/models/models.dart';
import 'package:flutter/widgets.dart';

class DetailProvider with ChangeNotifier {
  Diagnosis? _diagnosis;

  Diagnosis? get diagnosis => _diagnosis;
  set diagnosis(Diagnosis? newValue) {
    _diagnosis = newValue;
    notifyListeners();
  }

  bool _isImgVisible = false;

  bool get isImgVisible => _isImgVisible;

  void setImgVisibility(bool value) {
    _isImgVisible = value;
    notifyListeners();
  }
}
