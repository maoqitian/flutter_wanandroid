import 'package:flutter_wanandroid/model/base_response.dart';
import 'package:flutter_wanandroid/model/collect/collect_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_collect_article_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des:  收藏站外文章

@JsonSerializable()
class BaseCollectArticleData extends BaseResponseBody<CollectData>{


  BaseCollectArticleData(CollectData data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);

  factory BaseCollectArticleData.fromJson(Map<String, dynamic> json){
    return _$BaseCollectArticleDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$BaseCollectArticleDataToJson(this);

}

