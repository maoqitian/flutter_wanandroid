/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des:  收藏网站 bean
import 'package:json_annotation/json_annotation.dart';
part 'collect_web_data.g.dart';
@JsonSerializable()
class CollectWebData{

  ///    "desc": "",
  //    "icon": "",
  //    "id": 2350,
  //    "link": "http://www.maoqitian.com",
  //    "name": "maoqitian",
  //    "order": 0,
  //    "userId": 863,
  //    "visible": 1

  String desc;
  int id;
  String icon ;
  int visible ;
  int order ;
  String name;
  int userId;
  String link ;

  CollectWebData(this.desc, this.id, this.icon, this.visible, this.order,
      this.name, this.userId, this.link);

  factory CollectWebData.fromJson(Map<String, dynamic> json){
    return _$CollectWebDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$CollectWebDataToJson(this);

}
