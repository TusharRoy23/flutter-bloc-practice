// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfo _$UserInfoFromJson(Map<String, dynamic> json) {
  return UserInfo(
    userId: json['userId'] as int?,
    petName: json['petName'] as String,
    photo: json['photo'] as String,
    address: json['address'] as String,
  );
}

Map<String, dynamic> _$UserInfoToJson(UserInfo instance) => <String, dynamic>{
      'userId': instance.userId,
      'petName': instance.petName,
      'photo': instance.photo,
      'address': instance.address,
    };
