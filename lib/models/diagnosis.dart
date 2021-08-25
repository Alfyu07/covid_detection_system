part of 'models.dart';

@JsonSerializable()
class Diagnosis extends Equatable {
  final String id;
  final String? imgUrl;
  final String? result;
  final double? covid;
  final double? pneumonia;
  final double? normal;
  final bool? isCorrected;
  final DateTime? date;

  const Diagnosis({
    required this.id,
    this.imgUrl,
    this.result,
    this.covid,
    this.pneumonia,
    this.normal,
    this.date,
    this.isCorrected = false,
  });

  factory Diagnosis.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisToJson(this);
  @override
  List<Object?> get props => [id, imgUrl, result, covid, pneumonia, normal];
}

final List<Diagnosis> diagnoses = [
  Diagnosis(
    id: "1xdeafdxaa",
    covid: 0.92,
    pneumonia: 0.04,
    normal: 0.04,
    result: 'Covid 19',
    imgUrl:
        'https://www.researchgate.net/publication/325559051/figure/fig3/AS:634061244596226@1528183389605/A-CT-scan-of-a-normal-lung-in-a-transverse-plane.png',
    date: DateTime.now(),
  ),
  Diagnosis(
    id: "2xjalkdhcd",
    covid: 0.02,
    pneumonia: 0.92,
    normal: 0.06,
    result: 'Pneumonia',
    imgUrl:
        'https://www.researchgate.net/publication/325559051/figure/fig3/AS:634061244596226@1528183389605/A-CT-scan-of-a-normal-lung-in-a-transverse-plane.png',
    date: DateTime.now(),
  ),
  Diagnosis(
    id: "3fadkjfiekllad",
    covid: 0.07,
    pneumonia: 0.01,
    normal: 0.92,
    result: 'Normal',
    imgUrl:
        'https://www.researchgate.net/publication/325559051/figure/fig3/AS:634061244596226@1528183389605/A-CT-scan-of-a-normal-lung-in-a-transverse-plane.png',
    date: DateTime.now(),
  ),
  Diagnosis(
    id: "2xjalkdhcd",
    covid: 0.02,
    pneumonia: 0.92,
    normal: 0.06,
    result: 'Pneumonia',
    imgUrl:
        'https://www.researchgate.net/publication/325559051/figure/fig3/AS:634061244596226@1528183389605/A-CT-scan-of-a-normal-lung-in-a-transverse-plane.png',
    date: DateTime.now(),
  ),
  Diagnosis(
    id: "2xjalkdhcd",
    covid: 0.02,
    pneumonia: 0.92,
    normal: 0.06,
    result: 'Pneumonia',
    imgUrl:
        'https://www.researchgate.net/publication/325559051/figure/fig3/AS:634061244596226@1528183389605/A-CT-scan-of-a-normal-lung-in-a-transverse-plane.png',
    date: DateTime.now(),
  ),
  Diagnosis(
    id: "2xjalkdhcd",
    covid: 0.02,
    pneumonia: 0.92,
    normal: 0.06,
    result: 'Pneumonia',
    imgUrl:
        'https://www.researchgate.net/publication/325559051/figure/fig3/AS:634061244596226@1528183389605/A-CT-scan-of-a-normal-lung-in-a-transverse-plane.png',
    date: DateTime.now(),
  ),
];
