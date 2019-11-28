import 'package:json_annotation/json_annotation.dart';
part 'friend_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/28 0028
/// email: maoqitian068@163.com
/// des:  常用网站

@JsonSerializable()
class FriendData{

  String icon;
  int id;
  String link;
  String name;
  int order;
  int visible;

  FriendData(this.icon, this.id, this.link, this.name, this.order,
      this.visible);

  factory FriendData.fromJson(Map<String, dynamic> json){
    return _$FriendDataFromJson(json);
  }


}
