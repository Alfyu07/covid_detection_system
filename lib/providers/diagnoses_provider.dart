import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_detection_system/api/firebase_api.dart';
import 'package:covid_detection_system/models/models.dart';
import 'package:flutter/widgets.dart';

class DiagnoseProvider with ChangeNotifier {
  Stream<QuerySnapshot> readDiagnoses() => FirebaseApi.readDiagnoses();

  Stream<QuerySnapshot> readNormalDiagnoses() =>
      FirebaseApi.readNormalDiagnoses();

  Stream<QuerySnapshot> readPneumoniaDiagnoses() =>
      FirebaseApi.readPneumoniaDiagnoses();

  Stream<QuerySnapshot> readCovidDiagnoses() =>
      FirebaseApi.readCovidDiagnoses();

  void updateDiagnoses(Diagnosis diagnosis, String? label, bool? isCorrected) {
    diagnosis.label = label;
    diagnosis.isCorrected = isCorrected;

    FirebaseApi.updateDiagnoses(diagnosis);
  }

  void addDiagnoses(Diagnosis diagnosis) =>
      FirebaseApi.createDiagnosis(diagnosis);
}
