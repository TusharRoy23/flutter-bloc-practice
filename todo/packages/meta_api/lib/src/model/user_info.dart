import 'package:json_annotation/json_annotation.dart';

part 'user_info.g.dart';

@JsonSerializable()
class UserInfo {
  final int? userId;
  final String petName;
  final String photo;
  final String address;

  UserInfo({
    this.userId,
    this.petName = '',
    this.photo = '',
    this.address = '',
  });

  factory UserInfo.fromJson(Map<String, dynamic> userInfoMap) =>
      _$UserInfoFromJson(userInfoMap);

  Map<String, dynamic> toJson() => _$UserInfoToJson(this);
}
