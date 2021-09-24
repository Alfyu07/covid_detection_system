import 'package:covid_detection_system/models/models.dart';
import 'package:flutter/widgets.dart';

class DetailProvider with ChangeNotifier {
  Diagnosis? _diagnosis;
  bool _isImgVisible = true;

  String? _selectedCorrection;

  Diagnosis? get diagnosis => _diagnosis;
  bool get isImgVisible => _isImgVisible;
  String? get selectedCorrection => _selectedCorrection;

  set isImgVisible(bool value) {
    _isImgVisible = value;
    notifyListeners();
  }

  set diagnosis(Diagnosis? newValue) {
    _diagnosis = newValue;
    notifyListeners();
  }

  set selectedCorrection(String? newValue) {
    _selectedCorrection = newValue;
    notifyListeners();
  }
}
