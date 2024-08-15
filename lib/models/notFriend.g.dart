// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notFriend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotFriend _$NotFriendFromJson(Map<String, dynamic> json) => NotFriend()
  ..UID = json['UID'] as num
  ..name = json['name'] as String
  ..email = json['email'] as String
  ..password = json['password'] as String
  ..photo = json['photo'] as String;

Map<String, dynamic> _$NotFriendToJson(NotFriend instance) => <String, dynamic>{
      'UID': instance.UID,
      'name': instance.name,
      'email': instance.email,
      'password': instance.password,
      'photo': instance.photo,
    };
