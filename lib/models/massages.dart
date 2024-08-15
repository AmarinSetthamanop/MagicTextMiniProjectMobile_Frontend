import 'package:json_annotation/json_annotation.dart';
import "massage.dart";
part 'massages.g.dart';

@JsonSerializable()
class Massages {
  Massages();

  late List<Massage> massages;
  
  factory Massages.fromJson(Map<String,dynamic> json) => _$MassagesFromJson(json);
  Map<String, dynamic> toJson() => _$MassagesToJson(this);
}
