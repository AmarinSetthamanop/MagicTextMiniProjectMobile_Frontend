import 'package:json_annotation/json_annotation.dart';
import "notFriend.dart";
part 'notFriends.g.dart';

@JsonSerializable()
class NotFriends {
  NotFriends();

  late List<NotFriend> notFriends;
  
  factory NotFriends.fromJson(Map<String,dynamic> json) => _$NotFriendsFromJson(json);
  Map<String, dynamic> toJson() => _$NotFriendsToJson(this);
}
