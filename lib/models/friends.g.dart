// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friends.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Friends _$FriendsFromJson(Map<String, dynamic> json) => Friends()
  ..friends = (json['friends'] as List<dynamic>)
      .map((e) => Friend.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$FriendsToJson(Friends instance) => <String, dynamic>{
      'friends': instance.friends,
    };
