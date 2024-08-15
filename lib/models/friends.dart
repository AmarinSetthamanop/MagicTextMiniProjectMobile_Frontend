import 'package:json_annotation/json_annotation.dart';
import "friend.dart";
part 'friends.g.dart';

@JsonSerializable()
class Friends {
  Friends();

  late List<Friend> friends;
  
  factory Friends.fromJson(Map<String,dynamic> json) => _$FriendsFromJson(json);
  Map<String, dynamic> toJson() => _$FriendsToJson(this);
}
