// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photo _$PhotoFromJson(Map<String, dynamic> json) => Photo()
  ..MID = json['MID'] as num
  ..name = json['name'] as String
  ..base64 = json['base64'] as String
  ..UID = json['UID'] as num;

Map<String, dynamic> _$PhotoToJson(Photo instance) => <String, dynamic>{
      'MID': instance.MID,
      'name': instance.name,
      'base64': instance.base64,
      'UID': instance.UID,
    };
