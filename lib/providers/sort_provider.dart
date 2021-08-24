import 'package:flutter/material.dart';

class SortProvider with ChangeNotifier {
  int _index = 0;
  final List<String> _sortBy = ['Terbaru', 'Covid 19', 'Pneumonia', 'Normal'];

  int get index => _index;
  List<String> get sortBy => _sortBy;

  void setIndex(int newValue) {
    _index = newValue;
    notifyListeners();
  }
}
