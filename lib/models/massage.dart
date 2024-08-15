import 'package:json_annotation/json_annotation.dart';

part 'massage.g.dart';

@JsonSerializable()
class Massage {
  Massage();

  late num MID;
  late String name;
  late String massage;
  late String time;
  
  factory Massage.fromJson(Map<String,dynamic> json) => _$MassageFromJson(json);
  Map<String, dynamic> toJson() => _$MassageToJson(this);
}
