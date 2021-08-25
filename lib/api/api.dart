import 'package:covid_detection_system/models/models.dart';

class Api {
  static Future<List<Diagnosis>> readDiagnoses() async {
    await Future.delayed(const Duration(seconds: 2));

    return diagnoses;
  }

  static Future<String> createDiagnose(Diagnosis diagnose) async {
    await Future.delayed(const Duration(seconds: 1));

    return "index";
  }
}
