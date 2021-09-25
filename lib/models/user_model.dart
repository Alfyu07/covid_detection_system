part of 'models.dart';

@JsonSerializable()
class UserModel {
  final int id;
  final String? name;
  final String? imgUrl;

  const UserModel({required this.id, this.name, this.imgUrl});
}
