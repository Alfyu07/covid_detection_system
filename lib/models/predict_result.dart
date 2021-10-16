part of 'models.dart';

@JsonSerializable()
class PredictResult {
  final List<double> confidence;
  final String prediction;
  final int index;

  PredictResult(this.confidence, this.prediction, this.index);
  factory PredictResult.fromJson(Map<String, dynamic> json) =>
      _$PredictResultFromJson(json);
  Map<String, dynamic> toJson() => _$PredictResultToJson(this);
}
