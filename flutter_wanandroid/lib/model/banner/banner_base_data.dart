import 'package:flutter_wanandroid/model/banner/bannerdata.dart';
import 'package:json_annotation/json_annotation.dart';
part 'banner_base_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/7 0007
/// email: maoqitian068@163.com
/// des:  文章 bass 数据

@JsonSerializable()
class BannerBaseData {
  List<BannerData> data;
  int errorCode;
  String errorMsg;


  BannerBaseData(this.data, this.errorCode, this.errorMsg);

  factory BannerBaseData.fromJson(Map<String, dynamic> json){
    return _$BannerBaseDataFromJson(json);
  }

}