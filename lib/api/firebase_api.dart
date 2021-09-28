import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/models/models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

// ignore: avoid_classes_with_only_static_members
class FirebaseApi {
  static Future<String?> createDiagnosis(Diagnosis diagnosis) async {
    final docDiagnosis = FirebaseFirestore.instance.collection('diagnosis');

    await docDiagnosis.add(diagnosis.toJson()).then((value) {
      FirebaseFirestore.instance
          .collection('diagnosis')
          .doc(value.id)
          .update({'id': value.id});
    });
  }

  static Stream<QuerySnapshot> readDiagnoses() => FirebaseFirestore.instance
      .collection('diagnosis')
      .orderBy(DiagnosisField.createdTime, descending: true)
      .snapshots();

  static Stream<QuerySnapshot> readNormalDiagnoses() =>
      FirebaseFirestore.instance
          .collection('diagnosis')
          .where('label', isEqualTo: 'Normal')
          .orderBy(DiagnosisField.createdTime, descending: true)
          .snapshots();

  static Stream<QuerySnapshot> readPneumoniaDiagnoses() =>
      FirebaseFirestore.instance
          .collection('diagnosis')
          .where('label', isEqualTo: 'Pneumonia')
          .orderBy(DiagnosisField.createdTime, descending: true)
          .snapshots();

  static Stream<QuerySnapshot> readCovidDiagnoses() =>
      FirebaseFirestore.instance
          .collection('diagnosis')
          .where('label', isEqualTo: 'Covid 19')
          .orderBy(DiagnosisField.createdTime, descending: true)
          .snapshots();

  static Future<QuerySnapshot> queryData(String query) async {
    return FirebaseFirestore.instance
        .collection('diagnosis')
        .where('id', isGreaterThanOrEqualTo: query)
        .where('id', isLessThan: '${query}z')
        .get();
  }

  static Future<String?>? uploadFile(String destination, File file) async {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      final upload = ref.putFile(file);
      String? url;
      await upload.whenComplete(() async {
        url = await ref.getDownloadURL();
      });
      return url;
    } on FirebaseException {
      return "null";
    }
  }

  static Future updateDiagnoses(Diagnosis diagnosis) async {
    final docDiagnosis =
        FirebaseFirestore.instance.collection('diagnosis').doc(diagnosis.id);

    await docDiagnosis.update(diagnosis.toJson());
  }
}
