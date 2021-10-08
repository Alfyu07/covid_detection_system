part of 'models.dart';

@JsonSerializable()
class PredictResult {
  final List<double> confidence;
  final String prediction;

  PredictResult(this.confidence, this.prediction);
  factory PredictResult.fromJson(Map<String, dynamic> json) =>
      _$PredictResultFromJson(json);
  Map<String, dynamic> toJson() => _$PredictResultToJson(this);
}
