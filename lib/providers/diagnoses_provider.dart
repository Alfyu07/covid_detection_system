import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/models/models.dart';
import 'package:covidia/services/diagnose_service.dart';
import 'package:covidia/services/storage_service.dart';
import 'package:flutter/widgets.dart';

class DiagnoseProvider with ChangeNotifier {
  final DiagnoseService diagnoseService;
  final StorageService storageService;
  File? _image;
  bool _isLoading = false;

  DiagnoseProvider(this.diagnoseService, this.storageService);

  Stream<QuerySnapshot> readDiagnoses() => diagnoseService.readDiagnoses();

  Stream<QuerySnapshot> readNormalDiagnoses() =>
      diagnoseService.readNormalDiagnoses();

  Stream<QuerySnapshot> readPneumoniaDiagnoses() =>
      diagnoseService.readPneumoniaDiagnoses();

  Stream<QuerySnapshot> readCovidDiagnoses() =>
      diagnoseService.readCovidDiagnoses();

  Future<ApiReturnValue<PredictResult>> classifyImage(File imageFile) async {
    final output = await diagnoseService.classifyImage(imageFile);
    return output;
  }

  Future<String?> updateDiagnoses({
    required Diagnosis diagnosis,
    String? label,
    bool? isCorrected,
  }) async {
    diagnosis.label = label;
    diagnosis.isCorrected = isCorrected;

    return diagnoseService.updateDiagnoses(diagnosis);
  }

  Future<String?> uploadImage(String destination, File file) async {
    final result = await storageService.uploadImage(destination, file);
    return result;
  }

  Future<String?> addDiagnoses(Diagnosis diagnosis) =>
      diagnoseService.createDiagnosis(diagnosis);

  File? get image => _image;
  bool get isLoading => _isLoading;

  set image(File? newImage) {
    _image = newImage;
    notifyListeners();
  }

  set isLoading(bool newValue) {
    _isLoading = !_isLoading;
    notifyListeners();
  }
}
