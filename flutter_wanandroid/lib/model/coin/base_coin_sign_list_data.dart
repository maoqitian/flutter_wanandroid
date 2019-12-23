import 'package:flutter_wanandroid/model/coin/coin_sign_in_list_data.dart';
import 'package:json_annotation/json_annotation.dart';
import '../base_response.dart';
part 'base_coin_sign_list_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des:  
@JsonSerializable()
class BaseCoinSignListData extends BaseResponseBody<CoinSignInListData>{

  BaseCoinSignListData(CoinSignInListData data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);




  factory BaseCoinSignListData.fromJson(Map<String, dynamic> json){
    return _$BaseCoinSignListDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$BaseCoinSignListDataToJson(this);

}
