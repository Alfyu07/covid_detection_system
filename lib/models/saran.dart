part of 'models.dart';

class Saran {
  String? id;
  String? idUser;
  String? text;

  Saran({
    this.id,
    this.idUser,
    this.text,
  });

  Saran copyWith({
    String? id,
    String? idUser,
    String? text,
  }) =>
      Saran(
        id: id ?? this.id,
        idUser: idUser ?? this.idUser,
        text: text ?? this.text,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_user': idUser,
        'text': text,
      };

  factory Saran.fromJson(Map<String, dynamic> data) => Saran(
        id: data['id'] as String,
        idUser: data['id_user'] as String,
        text: data['text'] as String,
      );
}
