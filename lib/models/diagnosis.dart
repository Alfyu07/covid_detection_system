part of 'models.dart';

class DiagnosisField {
  static const createdTime = 'createdTime';
}

@JsonSerializable()
class Diagnosis {
  String? id;
  String? imgUrl;
  String? label;
  double? confidence;
  bool? isCorrected;
  DateTime? date;

  Diagnosis({
    this.id,
    this.imgUrl,
    this.label,
    this.confidence,
    this.date,
    this.isCorrected = false,
  });

  Diagnosis copyWith({
    String? id,
    String? imgUrl,
    String? label,
    bool? isCorrected,
    DateTime? date,
  }) =>
      Diagnosis(
        id: id ?? this.id,
        imgUrl: imgUrl ?? this.imgUrl,
        label: label ?? this.label,
        isCorrected: isCorrected ?? this.isCorrected,
        date: date ?? this.date,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'imgUrl': imgUrl,
        'createdTime': Utils.fromDateTimeToJson(date),
        'label': label,
        'confidence': confidence,
        'isCorrected': isCorrected,
      };

  static Diagnosis fromJson(Map<String, dynamic> data) => Diagnosis(
        id: data['id'] as String,
        imgUrl: data['imgUrl'] as String,
        label: data['label'] as String,
        confidence: data['confidence'] as double,
        isCorrected: data['isCorrected'] as bool,
        date: Utils.toDateTime(
          data['createdTime'] as Timestamp,
        ),
      );
}

final List<Diagnosis> diagnoses = [
  Diagnosis(
    id: "1xdeafdxaa",
    confidence: 0.92,
    label: 'Covid 19',
    imgUrl:
        'https://prod-images-static.radiopaedia.org/images/157288/4c1383482027c97c445f418c9b74b3_big_gallery.jpg',
    date: DateTime.now(),
    isCorrected: true,
  ),
  Diagnosis(
    id: "2xjalkdhcd",
    confidence: 0.22,
    label: 'Pneumonia',
    imgUrl:
        'https://prod-images-static.radiopaedia.org/images/157288/4c1383482027c97c445f418c9b74b3_big_gallery.jpg',
    date: DateTime.now(),
    isCorrected: true,
  ),
  Diagnosis(
    id: "3fadkjfiekllad",
    confidence: 0.72,
    label: 'Normal',
    imgUrl:
        'https://prod-images-static.radiopaedia.org/images/157288/4c1383482027c97c445f418c9b74b3_big_gallery.jpg',
    date: DateTime.now(),
  ),
  Diagnosis(
    id: "2xjalkdhcd",
    confidence: 0.82,
    label: 'Pneumonia',
    imgUrl:
        'https://prod-images-static.radiopaedia.org/images/157288/4c1383482027c97c445f418c9b74b3_big_gallery.jpg',
    date: DateTime.now(),
  ),
  Diagnosis(
    id: "2xjalkdhcd",
    confidence: 0.32,
    label: 'Pneumonia',
    imgUrl:
        'https://prod-images-static.radiopaedia.org/images/157288/4c1383482027c97c445f418c9b74b3_big_gallery.jpg',
    date: DateTime.now(),
  ),
  Diagnosis(
    id: "2xjalkdhcd",
    confidence: 0.72,
    label: 'Pneumonia',
    imgUrl:
        'https://prod-images-static.radiopaedia.org/images/157288/4c1383482027c97c445f418c9b74b3_big_gallery.jpg',
    date: DateTime.now(),
  ),
];
