// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User()
  ..UID = json['UID'] as num
  ..name = json['name'] as String
  ..email = json['email'] as String
  ..password = json['password'] as String
  ..photo = json['photo'] as String
  ..friend_count = json['friend_count'] as num;

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'UID': instance.UID,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'photo': instance.photo,
      'friend_count': instance.friend_count,
    };
