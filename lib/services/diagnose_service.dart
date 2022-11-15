import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/models/models.dart';
import 'package:http/http.dart' as http;

class DiagnoseService {
  final FirebaseFirestore firestore;

  DiagnoseService(this.firestore);

  Future<String?> createDiagnosis(Diagnosis diagnosis) async {
    final docDiagnosis = firestore.collection('diagnosis');

    final docref = await docDiagnosis.add(diagnosis.toJson());

    diagnosis.id = docref.id;

    updateDiagnoses(diagnosis);

    return diagnosis.id;
  }

  Future<String?> updateDiagnoses(Diagnosis diagnosis) async {
    try {
      final docDiagnosis = firestore.collection('diagnosis').doc(diagnosis.id);

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

  Stream<QuerySnapshot<Map<String, dynamic>>> readDiagnoses() => firestore
      .collection('diagnosis')
      .orderBy(DiagnosisField.createdTime, descending: true)
      .snapshots();

  Stream<QuerySnapshot> readNormalDiagnoses() => firestore
      .collection('diagnosis')
      .where('label', isEqualTo: 'Normal')
      .orderBy(DiagnosisField.createdTime, descending: true)
      .snapshots();

  Stream<QuerySnapshot> readPneumoniaDiagnoses() => firestore
      .collection('diagnosis')
      .where('label', isEqualTo: 'Pneumonia')
      .orderBy(DiagnosisField.createdTime, descending: true)
      .snapshots();

  Stream<QuerySnapshot> readCovidDiagnoses() => firestore
      .collection('diagnosis')
      .where('label', isEqualTo: 'Covid 19')
      .orderBy(DiagnosisField.createdTime, descending: true)
      .snapshots();

  Future<QuerySnapshot<Map<String, dynamic>>> queryData(String query) async {
    return firestore
        .collection('diagnosis')
        .where('id', isGreaterThanOrEqualTo: query)
        .where('id', isLessThan: '${query}z')
        .get();
  }

  Future<ApiReturnValue<PredictResult>> classifyImage(
    File imageFile, {
    http.MultipartRequest? request,
  }) async {
    const String url = 'https://covidia-be.azurewebsites.net/predict';
    final uri = Uri.parse(url);
    request ??= http.MultipartRequest(
      "POST",
      uri,
    )..headers["Content-Type"] = "application/json";

    final multipartFile =
        await http.MultipartFile.fromPath('file', imageFile.path);
    request.files.add(multipartFile);

    final response = await request.send();

    if (response.statusCode != 200) {
      return const ApiReturnValue(message: "Add item failed, please try again");
    }

    final String responseBody = await response.stream.bytesToString();

    final data = jsonDecode(responseBody) as Map<String, dynamic>;

    final PredictResult result = PredictResult.fromJson(data);

    return ApiReturnValue(value: result, message: "success");
  }
}
