import 'package:flutter_wanandroid/model/base_response.dart';
import 'package:flutter_wanandroid/model/usershare/user_share_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_user_share_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/24 0024
/// email: maoqitian068@163.com
/// des:  base 分享人对应列表数据

@JsonSerializable()
class BaseUserShareData extends BaseResponseBody<UserShareData>{

  BaseUserShareData(UserShareData data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);


  factory BaseUserShareData.fromJson(Map<String, dynamic> json){
    return _$BaseUserShareDataFromJson(json);
  }


}
