import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/models/models.dart';

class SaranService {
  Future<String?> createSaran(Saran saran) async {
    final docSaran = FirebaseFirestore.instance.collection('saran');

    final docref = await docSaran.add(saran.toJson());

    saran.id = docref.id;

    updateSaran(saran);

    return saran.id;
  }

  Future<String?> updateSaran(Saran saran) async {
    try {
      final docDiagnosis =
          FirebaseFirestore.instance.collection('saran').doc(saran.id);

      await docDiagnosis.update(saran.toJson());

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

  Stream<QuerySnapshot> readSaran() => FirebaseFirestore.instance
      .collection('saran')
      .orderBy(DiagnosisField.createdTime, descending: true)
      .snapshots();
}
