import 'package:json_annotation/json_annotation.dart';
import "photo.dart";
part 'photos.g.dart';

@JsonSerializable()
class Photos {
  Photos();

  late List<Photo> photos;
  
  factory Photos.fromJson(Map<String,dynamic> json) => _$PhotosFromJson(json);
  Map<String, dynamic> toJson() => _$PhotosToJson(this);
}
