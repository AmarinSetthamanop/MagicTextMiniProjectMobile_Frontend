// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'massage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Massage _$MassageFromJson(Map<String, dynamic> json) => Massage()
  ..MID = json['MID'] as num
  ..name = json['name'] as String
  ..massage = json['massage'] as String
  ..time = json['time'] as String;

Map<String, dynamic> _$MassageToJson(Massage instance) => <String, dynamic>{
      'MID': instance.MID,
      'name': instance.name,
      'massage': instance.massage,
      'time': instance.time,
    };
