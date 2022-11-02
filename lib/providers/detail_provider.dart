import 'package:covidia/models/models.dart';
import 'package:flutter/widgets.dart';

class DetailProvider with ChangeNotifier {
  List<String?> correctionOptions = ["Covid 19", "Normal", "Pneumonia"];

  Diagnosis? _diagnosis;
  bool _isImgVisible = true;
  int? _selectedOption;

  String? _selectedCorrection;

  Diagnosis? get diagnosis => _diagnosis;
  bool get isImgVisible => _isImgVisible;
  int? get selectedOption => _selectedOption;
  String? get selectedCorrection => _selectedCorrection;

  set selectedOption(int? value) {
    _selectedOption = value;
    notifyListeners();
  }

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
