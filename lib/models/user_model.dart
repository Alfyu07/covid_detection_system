part of 'models.dart';

class UserField {
  static const createdTime = 'createdTime';
}

class UserModel {
  String? uid;
  String? name;
  String? email;
  String? imgUrl;
  int? role;
  DateTime? date;

  UserModel({
    required this.uid,
    this.name,
    this.imgUrl,
    this.email,
    this.role,
    this.date,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        'role': role,
        'createdTime': Utils.fromDateTimeToJson(date),
        'email': email,
        'nameToLowerCase': name?.toLowerCase(),
      };

  factory UserModel.fromJson(Map<String, dynamic> data) => UserModel(
        uid: data['uid'] as String,
        name: data['name'] as String,
        imgUrl: data['imgUrl'] as String,
        email: data['email'] as String,
        role: data['role'] as int,
        date: Utils.toDateTime(
          data['createdTime'] as Timestamp,
        ),
      );
}
