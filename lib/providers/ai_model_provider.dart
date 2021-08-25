import 'package:flutter/material.dart';

class AiModelProvider with ChangeNotifier {
  String? _selectedValue = "CNN";
  String? _tempValue = "CNN";
  String? get selectedValue => _selectedValue;
  String? get tempValue => _tempValue;

  void setValue() {
    _selectedValue = _tempValue;
    notifyListeners();
  }

  void setTempValue(String? newValue) {
    _tempValue = newValue;
    notifyListeners();
  }
}
