/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-11-03
/// email: maoqitian068@163.com
/// des:  首页 banner model

import 'package:json_annotation/json_annotation.dart';
part 'bannerdata.g.dart';
/**
 * {
    "desc": "Android高级进阶直播课免费学习",
    "id": 23,
    "imagePath": "https://wanandroid.com/blogimgs/d9a6f718-5011-429c-8dd5-273f02f3bf25.jpeg",
    "isVisible": 1,
    "order": 0,
    "title": "Android高级进阶直播课免费学习",
    "type": 0,
    "url": "https://url.163.com/4bj"
    },
 */

@JsonSerializable()
class BannerData {
  String desc;
  int id;
  String imagePath ;
  int isVisible ;
  int order ;
  String title;
  int type;
  String url ;


  BannerData(this.desc, this.id, this.imagePath, this.isVisible, this.order,
      this.title, this.type, this.url);

  factory BannerData.fromJson(Map<String, dynamic> json){
    return _$BannerDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$BannerDataToJson(this);
}