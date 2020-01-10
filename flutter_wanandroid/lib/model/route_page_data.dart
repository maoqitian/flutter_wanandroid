import 'package:json_annotation/json_annotation.dart';
part 'route_page_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/1/10 0010
/// email: maoqitian068@163.com
/// des:  页面跳转数据

@JsonSerializable()
class RoutePageData{

  //页面 id
  int id;
  //页面标题
  String title;
  //页面 链接
  String url;
  //页面类型
  String type;
  //是否收藏
  bool collect;


  RoutePageData(this.id, this.title, this.url, this.type, this.collect);

  factory RoutePageData.fromJson(Map<String, dynamic> json){
    return _$RoutePageDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$RoutePageDataToJson(this);
}