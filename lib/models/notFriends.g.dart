// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notFriends.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotFriends _$NotFriendsFromJson(Map<String, dynamic> json) => NotFriends()
  ..notFriends = (json['notFriends'] as List<dynamic>)
      .map((e) => NotFriend.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$NotFriendsToJson(NotFriends instance) =>
    <String, dynamic>{
      'notFriends': instance.notFriends,
    };
