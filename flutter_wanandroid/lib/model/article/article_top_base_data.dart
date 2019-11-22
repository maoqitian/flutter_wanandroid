import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'article_top_base_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/7 0007
/// email: maoqitian068@163.com
/// des:  文章 置顶 base 数据

@JsonSerializable()
class ArticleTopBaseData {

  List<ArticleData> data;
  int errorCode;
  String errorMsg;


  ArticleTopBaseData(this.data, this.errorCode, this.errorMsg);

  factory ArticleTopBaseData.fromJson(Map<String, dynamic> json){
    return _$ArticleTopBaseDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$ArticleTopBaseDataToJson(this);
}