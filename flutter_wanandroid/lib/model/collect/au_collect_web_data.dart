import 'package:flutter_wanandroid/model/base_response.dart';
import 'package:flutter_wanandroid/model/collect/collect_web_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'au_collect_web_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des:  收藏 网站 编辑 完整 返回 bean

@JsonSerializable()
class AuCollectWebData extends BaseResponseBody<CollectWebData>{

  AuCollectWebData(CollectWebData data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);

  factory AuCollectWebData.fromJson(Map<String, dynamic> json){
    return _$AuCollectWebDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$AuCollectWebDataToJson(this);
}
