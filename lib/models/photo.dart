import 'package:json_annotation/json_annotation.dart';

part 'photo.g.dart';

@JsonSerializable()
class Photo {
  Photo();

  late num MID;
  late String name;
  late String base64;
  late num UID;
  
  factory Photo.fromJson(Map<String,dynamic> json) => _$PhotoFromJson(json);
  Map<String, dynamic> toJson() => _$PhotoToJson(this);
}
