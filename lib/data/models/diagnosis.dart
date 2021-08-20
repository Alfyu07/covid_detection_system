part of 'models.dart';

@JsonSerializable()
class Diagnosis extends Equatable {
  final int id;
  final String? imgUrl;
  final String? result;
  final double? covid;
  final double? pneumonia;
  final double? normal;

  const Diagnosis({
    required this.id,
    this.imgUrl,
    this.result,
    this.covid,
    this.pneumonia,
    this.normal,
  });

  factory Diagnosis.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisToJson(this);
  @override
  // TODO: implement props
  List<Object?> get props => [id, imgUrl, result, covid, pneumonia, normal];
}
