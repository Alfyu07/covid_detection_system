part of 'models.dart';

@JsonSerializable()
class Diagnosis {
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

  Diagnosis copyWith({
    String? id,
    String? imgUrl,
    String? result,
    double? covid,
    double? pneumonia,
    double? normal,
    bool? isCorrected,
    DateTime? date,
  }) =>
      Diagnosis(
        id: id ?? this.id,
        imgUrl: imgUrl ?? this.imgUrl,
        result: result ?? this.result,
        covid: covid ?? this.covid,
        pneumonia: pneumonia ?? this.pneumonia,
        isCorrected: isCorrected ?? this.isCorrected,
        date: date ?? this.date,
      );

  factory Diagnosis.fromJson(Map<String, dynamic> json) =>
      _$DiagnosisFromJson(json);

  Map<String, dynamic> toJson() => _$DiagnosisToJson(this);
}

final List<Diagnosis> diagnoses = [
  Diagnosis(
    id: "1xdeafdxaa",
    covid: 0.92,
    pneumonia: 0.04,
    normal: 0.04,
    result: 'Covid 19',
    imgUrl:
        'https://prod-images-static.radiopaedia.org/images/157288/4c1383482027c97c445f418c9b74b3_big_gallery.jpg',
    date: DateTime.now(),
    isCorrected: true,
  ),
  Diagnosis(
    id: "2xjalkdhcd",
    covid: 0.02,
    pneumonia: 0.92,
    normal: 0.06,
    result: 'Pneumonia',
    imgUrl:
        'https://prod-images-static.radiopaedia.org/images/157288/4c1383482027c97c445f418c9b74b3_big_gallery.jpg',
    date: DateTime.now(),
    isCorrected: true,
  ),
  Diagnosis(
    id: "3fadkjfiekllad",
    covid: 0.07,
    pneumonia: 0.01,
    normal: 0.92,
    result: 'Normal',
    imgUrl:
        'https://prod-images-static.radiopaedia.org/images/157288/4c1383482027c97c445f418c9b74b3_big_gallery.jpg',
    date: DateTime.now(),
  ),
  Diagnosis(
    id: "2xjalkdhcd",
    covid: 0.02,
    pneumonia: 0.92,
    normal: 0.06,
    result: 'Pneumonia',
    imgUrl:
        'https://prod-images-static.radiopaedia.org/images/157288/4c1383482027c97c445f418c9b74b3_big_gallery.jpg',
    date: DateTime.now(),
  ),
  Diagnosis(
    id: "2xjalkdhcd",
    covid: 0.02,
    pneumonia: 0.92,
    normal: 0.06,
    result: 'Pneumonia',
    imgUrl:
        'https://prod-images-static.radiopaedia.org/images/157288/4c1383482027c97c445f418c9b74b3_big_gallery.jpg',
    date: DateTime.now(),
  ),
  Diagnosis(
    id: "2xjalkdhcd",
    covid: 0.02,
    pneumonia: 0.92,
    normal: 0.06,
    result: 'Pneumonia',
    imgUrl:
        'https://prod-images-static.radiopaedia.org/images/157288/4c1383482027c97c445f418c9b74b3_big_gallery.jpg',
    date: DateTime.now(),
  ),
];
