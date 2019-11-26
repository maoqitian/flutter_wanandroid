import 'package:flutter_wanandroid/model/coin/coin_user_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_coin_info.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/26 0026
/// email: maoqitian068@163.com
/// des:  
@JsonSerializable()
class BaseCoinInfo{

  CoinUserInfo data;
  int errorCode;
  String errorMsg;

  BaseCoinInfo(this.data, this.errorCode, this.errorMsg);

  factory BaseCoinInfo.fromJson(Map<String, dynamic> json){
    return _$BaseCoinInfoFromJson(json);
  }

}
