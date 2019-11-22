import 'package:flutter_wanandroid/model/article/article_list_data.dart';
import 'package:flutter_wanandroid/model/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
part 'article_base_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/7 0007
/// email: maoqitian068@163.com
/// des:  文章 base 数据

@JsonSerializable()
class ArticleBaseData {
  ArticleListData data;
  int errorCode;
  String errorMsg;

  ArticleBaseData(this.data, this. errorCode, this. errorMsg) ;

  factory ArticleBaseData.fromJson(Map<String, dynamic> json){
    return _$ArticleBaseDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$ArticleBaseDataToJson(this);

}