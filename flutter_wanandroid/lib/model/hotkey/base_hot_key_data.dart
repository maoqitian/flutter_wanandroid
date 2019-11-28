import 'package:flutter_wanandroid/model/base_response.dart';
import 'package:flutter_wanandroid/model/hotkey/hot_key_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_hot_key_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/28 0028
/// email: maoqitian068@163.com
/// des:  

@JsonSerializable()
class BaseHotKeyData extends BaseResponseBody<List<HotKeyData>>{


  BaseHotKeyData(List<HotKeyData> data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);

  factory BaseHotKeyData.fromJson(Map<String, dynamic> json){
    return _$BaseHotKeyDataFromJson(json);
  }
}