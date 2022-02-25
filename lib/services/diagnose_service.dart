import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:covidia/models/models.dart';

class DiagnoseService {
  Future<String?> createDiagnosis(Diagnosis diagnosis) async {
    final docDiagnosis = FirebaseFirestore.instance.collection('diagnosis');

    final docref = await docDiagnosis.add(diagnosis.toJson());

    diagnosis.id = docref.id;

    updateDiagnoses(diagnosis);

    return diagnosis.id;
  }

  Future<String?> updateDiagnoses(Diagnosis diagnosis) async {
    try {
      final docDiagnosis =
          FirebaseFirestore.instance.collection('diagnosis').doc(diagnosis.id);

      await docDiagnosis.update(diagnosis.toJson());

      return "Data successfully updated";
    } on FirebaseException catch (e) {
      switch (e.code) {
        case "object-not-found":
          return e.message;
        default:
          return "Update data failed : ${e.message}";
      }
    }
  }

  Stream<QuerySnapshot> readDiagnoses() => FirebaseFirestore.instance
      .collection('diagnosis')
      .orderBy(DiagnosisField.createdTime, descending: true)
      .snapshots();

  Stream<QuerySnapshot> readNormalDiagnoses() => FirebaseFirestore.instance
      .collection('diagnosis')
      .where('label', isEqualTo: 'Normal')
      .orderBy(DiagnosisField.createdTime, descending: true)
      .snapshots();

  Stream<QuerySnapshot> readPneumoniaDiagnoses() => FirebaseFirestore.instance
      .collection('diagnosis')
      .where('label', isEqualTo: 'Pneumonia')
      .orderBy(DiagnosisField.createdTime, descending: true)
      .snapshots();

  Stream<QuerySnapshot> readCovidDiagnoses() => FirebaseFirestore.instance
      .collection('diagnosis')
      .where('label', isEqualTo: 'Covid 19')
      .orderBy(DiagnosisField.createdTime, descending: true)
      .snapshots();

  Future<QuerySnapshot> queryData(String query) async {
    return FirebaseFirestore.instance
        .collection('diagnosis')
        .where('id', isGreaterThanOrEqualTo: query)
        .where('id', isLessThan: '${query}z')
        .get();
  }
}
