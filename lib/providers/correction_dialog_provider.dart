import 'package:flutter/material.dart';

class CorrectionDialogProvider with ChangeNotifier {
  String? _selectedValue;
  String? _tempValue;
  String? get selectedValue => _selectedValue;
  String? get tempValue => _tempValue;

  void setValue() {
    _selectedValue = _tempValue;
    notifyListeners();
  }

  set selectedValue(String? newValue) {
    _selectedValue = newValue;
    notifyListeners();
  }

  set tempValue(String? newValue) {
    _tempValue = newValue;
    notifyListeners();
  }
}
