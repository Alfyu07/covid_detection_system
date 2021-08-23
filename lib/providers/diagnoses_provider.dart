import 'package:covid_detection_system/models/models.dart';
import 'package:flutter/widgets.dart';

class DiagnoseProvider with ChangeNotifier {
  List<Diagnosis> _diagnoses = [];

  List<Diagnosis> get diagnoses => _diagnoses;

  void setDiagnoses(List<Diagnosis> diagnoses) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _diagnoses = diagnoses;
      notifyListeners();
    });
  }
}
