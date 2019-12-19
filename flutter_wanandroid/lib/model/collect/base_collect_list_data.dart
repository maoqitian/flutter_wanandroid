import 'package:flutter_wanandroid/model/base_response.dart';
import 'package:flutter_wanandroid/model/collect/collect_data.dart';
import 'package:json_annotation/json_annotation.dart';
import 'collect_list_data.dart';
part 'base_collect_list_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/19 0019
/// email: maoqitian068@163.com
/// des:


@JsonSerializable()
class BaseCollectListData extends BaseResponseBody<CollectListData>{

  BaseCollectListData(CollectListData data, int errorCode, String errorMsg):super(data, errorCode, errorMsg);

  factory BaseCollectListData.fromJson(Map<String, dynamic> json){
    return _$BaseCollectListDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$BaseCollectListDataToJson(this);

}