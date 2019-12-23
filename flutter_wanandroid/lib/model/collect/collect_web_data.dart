/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des:  收藏网站 bean
import 'package:json_annotation/json_annotation.dart';
part 'collect_web_data.g.dart';
@JsonSerializable()
class CollectWebData{
  String desc;
  int id;
  String icon ;
  int isVisible ;
  int order ;
  String title;
  int type;
  String url ;

  CollectWebData(this.desc, this.id, this.icon, this.isVisible, this.order,
      this.title, this.type, this.url);

  factory CollectWebData.fromJson(Map<String, dynamic> json){
    return _$CollectWebDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$CollectWebDataToJson(this);

}
