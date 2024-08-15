import 'package:json_annotation/json_annotation.dart';

part 'notFriend.g.dart';

@JsonSerializable()
class NotFriend {
  NotFriend();

  late num UID;
  late String name;
  late String email;
  late String password;
  late String photo;
  
  factory NotFriend.fromJson(Map<String,dynamic> json) => _$NotFriendFromJson(json);
  Map<String, dynamic> toJson() => _$NotFriendToJson(this);
}
