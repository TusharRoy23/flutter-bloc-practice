import 'package:json_annotation/json_annotation.dart';
import 'token.dart';
import 'user_info.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true)
class User {
  final String? username;
  final UserInfo? userInfo;
  final Token? token;

  User({
    this.username,
    this.userInfo,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
