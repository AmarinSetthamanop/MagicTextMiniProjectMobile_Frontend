import 'package:json_annotation/json_annotation.dart';

part 'friend.g.dart';

@JsonSerializable()
class Friend {
  Friend();

  late num FID;
  late num friendID;
  late String name;
  late String photo;
  
  factory Friend.fromJson(Map<String,dynamic> json) => _$FriendFromJson(json);
  Map<String, dynamic> toJson() => _$FriendToJson(this);
}
