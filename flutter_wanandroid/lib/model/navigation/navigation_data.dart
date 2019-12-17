import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'navigation_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/17 0017
/// email: maoqitian068@163.com
/// des:  导航数据

@JsonSerializable()
class NavigationData{

  List<ArticleData> articles;
  int cid;
  String name;

  NavigationData(this.articles, this.cid, this.name);

  factory NavigationData.fromJson(Map<String, dynamic> json){
    return _$NavigationDataFromJson(json);
  }
}