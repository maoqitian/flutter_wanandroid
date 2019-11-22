/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/7 0007
/// email: maoqitian068@163.com
/// des:  文章 标签 对象

import 'package:json_annotation/json_annotation.dart';
part 'article_tag_data.g.dart';

@JsonSerializable()
class ArticleTagData{


  String name;
  String url;


  ArticleTagData(this.name, this.url);

  factory ArticleTagData.fromJson(Map<String, dynamic> json) => _$ArticleTagDataFromJson(json);

  Map<String,dynamic> toJson() => _$ArticleTagDataToJson(this);
}