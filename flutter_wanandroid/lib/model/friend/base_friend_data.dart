import 'package:flutter_wanandroid/model/base_response.dart';
import 'package:flutter_wanandroid/model/friend/friend_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_friend_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/28 0028
/// email: maoqitian068@163.com
/// des:  
@JsonSerializable()
class BaseFriendData extends BaseResponseBody<List<FriendData>>{

  BaseFriendData(List<FriendData> data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);

  factory BaseFriendData.fromJson(Map<String, dynamic> json){
    return _$BaseFriendDataFromJson(json);
  }

}