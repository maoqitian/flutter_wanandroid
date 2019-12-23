import 'package:flutter_wanandroid/model/base_response.dart';
import 'package:flutter_wanandroid/model/coin/rank_list_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_rank_list_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des:  

@JsonSerializable()
class BaseRankListData extends BaseResponseBody<RankListData>{

  BaseRankListData(RankListData data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);


  factory BaseRankListData.fromJson(Map<String, dynamic> json){
    return _$BaseRankListDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$BaseRankListDataToJson(this);

}