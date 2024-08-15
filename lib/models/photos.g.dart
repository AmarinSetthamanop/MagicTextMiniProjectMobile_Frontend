// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'photos.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Photos _$PhotosFromJson(Map<String, dynamic> json) => Photos()
  ..photos = (json['photos'] as List<dynamic>)
      .map((e) => Photo.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$PhotosToJson(Photos instance) => <String, dynamic>{
      'photos': instance.photos,
    };
