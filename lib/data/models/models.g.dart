// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Diagnosis _$DiagnosisFromJson(Map<String, dynamic> json) {
  return Diagnosis(
    id: json['id'] as int,
    imgUrl: json['imgUrl'] as String?,
    result: json['result'] as String?,
    covid: (json['covid'] as num?)?.toDouble(),
    pneumonia: (json['pneumonia'] as num?)?.toDouble(),
    normal: (json['normal'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$DiagnosisToJson(Diagnosis instance) => <String, dynamic>{
      'id': instance.id,
      'imgUrl': instance.imgUrl,
      'result': instance.result,
      'covid': instance.covid,
      'pneumonia': instance.pneumonia,
      'normal': instance.normal,
    };

//!User
User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    id: json['id'] as int,
    name: json['name'] as String?,
    imgUrl: json['imgUrl'] as String?,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'imgUrl': instance.imgUrl,
    };
