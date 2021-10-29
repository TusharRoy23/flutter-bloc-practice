import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User {
  final String username;
  final int userId;
  final String petName;
  final String photo;
  final String address;
  final String accessToken;
  final String refreshToken;

  const User({
    this.username = '',
    this.userId = 0,
    this.petName = '',
    this.photo = '',
    this.address = '',
    this.accessToken = '',
    this.refreshToken = '',
  });

  factory User.token({String accessToken = '', String refreshToken = ''}) {
    return User(accessToken: accessToken, refreshToken: refreshToken);
  }

  static const empty = User(
    username: '',
    userId: 0,
    petName: '',
    photo: '',
    address: '',
    accessToken: '',
    refreshToken: '',
  );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
