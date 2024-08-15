import 'package:json_annotation/json_annotation.dart';

part 'ocr.g.dart';

@JsonSerializable()
class Ocr {
  Ocr();

  late String ocr_text_delete_spaces;
  
  factory Ocr.fromJson(Map<String,dynamic> json) => _$OcrFromJson(json);
  Map<String, dynamic> toJson() => _$OcrToJson(this);
}
