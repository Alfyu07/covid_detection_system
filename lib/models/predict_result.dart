part of 'models.dart';

@JsonSerializable()
class PredictResult extends Equatable {
  final List<double> confidence;
  final String prediction;
  final int index;

  const PredictResult(this.confidence, this.prediction, this.index);

  factory PredictResult.fromJson(Map<String, dynamic> json) =>
      _$PredictResultFromJson(json);
  Map<String, dynamic> toJson() => _$PredictResultToJson(this);

  @override
  String toString() {
    return 'PredictResult(confidence: $confidence, predictio: $prediction, index: $index)';
  }

  @override
  // TODO: implement props
  List<Object?> get props => [confidence, prediction, index];
}
