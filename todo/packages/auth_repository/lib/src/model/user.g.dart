// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
    username: json['username'] as String,
    userId: json['userId'] as int,
    petName: json['petName'] as String,
    photo: json['photo'] as String,
    address: json['address'] as String,
    accessToken: json['accessToken'] as String,
    refreshToken: json['refreshToken'] as String,
  );
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'username': instance.username,
      'userId': instance.userId,
      'petName': instance.petName,
      'photo': instance.photo,
      'address': instance.address,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
    };
