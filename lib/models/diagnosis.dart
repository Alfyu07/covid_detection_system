part of 'models.dart';

class DiagnosisField {
  static const createdTime = 'createdTime';
}

class Diagnosis extends Equatable {
  String? id;
  String? imgUrl;
  String? label;
  List<double>? confidence;
  bool? isCorrected;
  DateTime? date;
  int? index;

  Diagnosis({
    this.id,
    this.imgUrl,
    this.label,
    this.confidence,
    this.date,
    this.isCorrected = false,
    this.index,
  });

  Diagnosis copyWith({
    String? id,
    String? imgUrl,
    String? label,
    List<double>? confidence,
    bool? isCorrected,
    DateTime? date,
    int? index,
  }) =>
      Diagnosis(
        id: id ?? this.id,
        imgUrl: imgUrl ?? this.imgUrl,
        label: label ?? this.label,
        confidence: confidence ?? this.confidence,
        isCorrected: isCorrected ?? this.isCorrected,
        date: date ?? this.date,
        index: index ?? this.index,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'imgUrl': imgUrl,
        'createdTime': Utils.fromDateTimeToJson(date),
        'label': label,
        'confidence': confidence,
        'isCorrected': isCorrected,
        'index': index,
      };

  factory Diagnosis.fromJson(Map<String, dynamic> data) => Diagnosis(
        id: data['id'] as String,
        imgUrl: data['imgUrl'] as String,
        label: data['label'] as String,
        confidence: (data['confidence'] as List<dynamic>)
            .map((e) => (e as num).toDouble())
            .toList(),
        isCorrected: data['isCorrected'] as bool,
        date: Utils.toDateTime(
          data['createdTime'] as Timestamp,
        ),
        index: data['index'] as int,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        imgUrl,
        label,
        confidence,
        isCorrected,
        date,
        index,
      ];
}
