part of 'models.dart';

class Saran {
  String? id;
  String? idUser;
  String? text;
  UserModel? user;
  DateTime? date;

  Saran({
    this.id,
    this.idUser,
    this.user,
    this.text,
    this.date,
  });

  Saran copyWith({
    String? id,
    String? idUser,
    String? text,
    DateTime? date,
    UserModel? user,
  }) =>
      Saran(
        id: id ?? this.id,
        idUser: idUser ?? this.idUser,
        text: text ?? this.text,
        date: date ?? this.date,
        user: user ?? this.user,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'id_user': idUser,
        'text': text,
        'createdTime': Utils.fromDateTimeToJson(date),
      };

  factory Saran.fromJson(Map<String, dynamic> data) => Saran(
        id: data['id'] as String,
        idUser: data['id_user'] as String,
        text: data['text'] as String,
        date: Utils.toDateTime(
          data['createdTime'] as Timestamp,
        ),
      );
}
