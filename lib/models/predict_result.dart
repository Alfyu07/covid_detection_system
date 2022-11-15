part of 'models.dart';

class PredictResult {
  PredictResult({
    required this.confidence,
    required this.index,
    required this.prediction,
  });

  List<double> confidence;
  int index;
  String prediction;

  factory PredictResult.fromJson(Map<String, dynamic> json) => PredictResult(
        confidence: (json['confidence'] as List<dynamic>)
            .map((e) => (e as num).toDouble())
            .toList(),
        index: json["index"] as int,
        prediction: json["prediction"] as String,
      );

  Map<String, dynamic> toJson() => {
        "confidence": List<dynamic>.from(confidence.map((x) => x)),
        "index": index,
        "prediction": prediction,
      };
}
