// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friend _$FriendFromJson(Map<String, dynamic> json) => Friend()
  ..FID = json['FID'] as num
  ..friendID = json['friendID'] as num
  ..name = json['name'] as String
  ..photo = json['photo'] as String;

Map<String, dynamic> _$FriendToJson(Friend instance) => <String, dynamic>{
      'FID': instance.FID,
      'friendID': instance.friendID,
      'name': instance.name,
      'photo': instance.photo,
    };
