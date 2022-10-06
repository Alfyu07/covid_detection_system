import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covidia/models/models.dart';
import 'package:covidia/services/saran_service.dart';
import 'package:flutter/material.dart';

class SaranProvider with ChangeNotifier {
  final SaranService saranService;
  SaranProvider(this.saranService);

  Stream<QuerySnapshot> readDiagnoses() => saranService.readSaran();

  Future<String?> addSaran(Saran saran) => saranService.createSaran(saran);
}
