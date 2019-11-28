import 'package:json_annotation/json_annotation.dart';
part 'hot_key_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/28 0028
/// email: maoqitian068@163.com
/// des:  搜索热词
@JsonSerializable()
class HotKeyData{

  int id;
  String link;
  String name;
  int order;
  int visible;

  HotKeyData(this.id, this.link, this.name, this.order, this.visible);


  factory HotKeyData.fromJson(Map<String, dynamic> json){
    return _$HotKeyDataFromJson(json);
  }
}
