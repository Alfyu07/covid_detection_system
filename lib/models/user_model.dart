part of 'models.dart';

@JsonSerializable()
class UserModel {
  final String? id;
  final String? fullName;
  final String? imgUrl;

  const UserModel({required this.id, this.fullName, this.imgUrl});
}
