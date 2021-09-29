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

    final docref = await docDiagnosis.add(diagnosis.toJson());

    diagnosis.id = docref.id;

    updateDiagnoses(diagnosis);
    return diagnosis.id;
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

  static Future<String?> uploadFile(String destination, File file) async {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      final result = await ref.putFile(file);
      final imgUrl = await result.ref.getDownloadURL();
      return imgUrl;
    } on FirebaseException {
      return "null";
    }
  }

  static Future updateUserData(
    String? uid,
    String? unitKerja,
  ) async {
    final userCollection = FirebaseFirestore.instance.collection('users');
    return await userCollection.doc(uid).set({'unitKerja': unitKerja});
  }

  static Future<String?> updateDiagnoses(Diagnosis diagnosis) async {
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
}
