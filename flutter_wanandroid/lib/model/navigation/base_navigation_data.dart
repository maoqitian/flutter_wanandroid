import 'package:flutter_wanandroid/model/base_response.dart';
import 'package:flutter_wanandroid/model/navigation/navigation_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_navigation_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/17 0017
/// email: maoqitian068@163.com
/// des:  

@JsonSerializable()
class BaseNavigationData extends BaseResponseBody<List<NavigationData>>{

  BaseNavigationData(List<NavigationData> data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);


  factory BaseNavigationData.fromJson(Map<String, dynamic> json){
    return _$BaseNavigationDataFromJson(json);
  }
}
