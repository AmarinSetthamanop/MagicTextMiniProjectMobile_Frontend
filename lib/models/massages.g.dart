// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'massages.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Massages _$MassagesFromJson(Map<String, dynamic> json) => Massages()
  ..massages = (json['massages'] as List<dynamic>)
      .map((e) => Massage.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MassagesToJson(Massages instance) => <String, dynamic>{
      'massages': instance.massages,
    };
