import 'package:flutter_wanandroid/model/collect/collect_web_data.dart';
import 'package:json_annotation/json_annotation.dart';
import '../base_response.dart';
part 'base_collect_web_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des:  


@JsonSerializable()
class BaseCollectWebData extends BaseResponseBody<List<CollectWebData>>{

  BaseCollectWebData(List<CollectWebData>data,int errorCode, String errorMsg):super(data, errorCode, errorMsg);

  factory BaseCollectWebData.fromJson(Map<String, dynamic> json){
    return _$BaseCollectWebDataFromJson(json);
  }

}
