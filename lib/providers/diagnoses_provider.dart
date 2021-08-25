import 'dart:io';

import 'package:covid_detection_system/api/api.dart';
import 'package:covid_detection_system/models/models.dart';
import 'package:flutter/widgets.dart';

class DiagnoseProvider with ChangeNotifier {
  List<Diagnosis> _diagnoses = [];

  List<Diagnosis> get diagnoses => _diagnoses;
  List<Diagnosis> get covidDiagnoses =>
      _diagnoses.where((element) => element.result == "Covid 19").toList();
  List<Diagnosis> get pneumoniaDiagnoses =>
      _diagnoses.where((element) => element.result == "Pneumonia").toList();
  List<Diagnosis> get normalDiagnoses =>
      _diagnoses.where((element) => element.result == "Normal").toList();

  void setDiagnoses(List<Diagnosis> diagnoses) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _diagnoses = diagnoses;
      notifyListeners();
    });
  }

  void addDiagnose(Diagnosis diagnose) => Api.createDiagnose(diagnose);
}
