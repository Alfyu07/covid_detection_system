import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/models/models.dart';
import 'package:covidia/services/diagnose_service.dart';
import 'package:flutter/widgets.dart';

class DiagnoseProvider with ChangeNotifier {
  final DiagnoseService diagnoseService;
  DiagnoseProvider(this.diagnoseService);

  Stream<QuerySnapshot> readDiagnoses() => diagnoseService.readDiagnoses();

  Stream<QuerySnapshot> readNormalDiagnoses() =>
      diagnoseService.readNormalDiagnoses();

  Stream<QuerySnapshot> readPneumoniaDiagnoses() =>
      diagnoseService.readPneumoniaDiagnoses();

  Stream<QuerySnapshot> readCovidDiagnoses() =>
      diagnoseService.readCovidDiagnoses();

  Future<String?> updateDiagnoses(
      {required Diagnosis diagnosis, String? label, bool? isCorrected}) async {
    diagnosis.label = label;
    diagnosis.isCorrected = isCorrected;

    return diagnoseService.updateDiagnoses(diagnosis);
  }

  Future<String?> addDiagnoses(Diagnosis diagnosis) =>
      diagnoseService.createDiagnosis(diagnosis);
}
