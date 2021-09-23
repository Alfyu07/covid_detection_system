import 'package:covid_detection_system/api/firebase_api.dart';
import 'package:covid_detection_system/models/models.dart';
import 'package:flutter/widgets.dart';

class DiagnoseProvider with ChangeNotifier {
  List<Diagnosis>? _diagnoses = [];

  List<Diagnosis> get diagnoses => _diagnoses ?? [];
  List<Diagnosis> get covidDiagnoses =>
      _diagnoses!.where((element) => element.label == "Covid 19").toList();
  List<Diagnosis> get pneumoniaDiagnoses =>
      _diagnoses!.where((element) => element.label == "Pneumonia").toList();
  List<Diagnosis> get normalDiagnoses =>
      _diagnoses!.where((element) => element.label == "Normal").toList();

  void setDiagnoses(List<Diagnosis>? diagnoses) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _diagnoses = diagnoses;
      notifyListeners();
    });
  }

  void updateDiagnoses(Diagnosis diagnosis, String? label, bool? isCorrected) {
    diagnosis.label = label;
    diagnosis.isCorrected = isCorrected;

    FirebaseApi.updateDiagnoses(diagnosis);
  }

  void addDiagnoses(Diagnosis diagnosis) =>
      FirebaseApi.createDiagnosis(diagnosis);
}
