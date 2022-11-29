part of 'models.dart';

class EngineModel {
  EngineModel({
    required this.accuracy,
    required this.createdDate,
    required this.index,
    required this.modelPath,
    required this.name,
  });

  final String accuracy;
  final String createdDate;
  final int index;
  final String modelPath;
  final String name;

  EngineModel copyWith({
    String? accuracy,
    String? createdDate,
    int? index,
    String? modelPath,
    String? name,
  }) =>
      EngineModel(
        accuracy: accuracy ?? this.accuracy,
        createdDate: createdDate ?? this.createdDate,
        index: index ?? this.index,
        modelPath: modelPath ?? this.modelPath,
        name: name ?? this.name,
      );

  factory EngineModel.fromJson(Map<String, dynamic> json) => EngineModel(
        accuracy: json["accuracy"] as String,
        createdDate: json["createdDate"] as String,
        index: json["index"] as int,
        modelPath: json["model_path"] as String,
        name: json["name"] as String,
      );

  Map<String, dynamic> toJson() => {
        "accuracy": accuracy,
        "createdDate": createdDate,
        "index": index.toString(),
        "model_path": modelPath,
        "name": name,
      };
}
