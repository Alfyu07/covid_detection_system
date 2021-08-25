part of 'models.dart';

@JsonSerializable()
class User extends Equatable {
  final int id;
  final String? name;
  final String? imgUrl;

  const User({required this.id, this.name, this.imgUrl});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
  @override
  List<Object?> get props => [id, name, imgUrl];
}
