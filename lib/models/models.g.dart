// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PredictResult _$PredictResultFromJson(Map<String, dynamic> json) {
  return PredictResult(
    (json['confidence'] as List<dynamic>)
        .map((e) => (e as num).toDouble())
        .toList(),
    json['prediction'] as String,
    json['index'] as int,
  );
}

Map<String, dynamic> _$PredictResultToJson(PredictResult instance) =>
    <String, dynamic>{
      'confidence': instance.confidence,
      'prediction': instance.prediction,
      'index': instance.index,
    };
