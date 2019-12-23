import 'package:flutter_wanandroid/model/coin/coin_sign_in_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'coin_sign_in_list_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des:  积分记录列表数据

@JsonSerializable()
class CoinSignInListData{

  int curPage;
  List<CoinSignInData> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  CoinSignInListData(this.curPage, this.datas, this.offset, this.over,
      this.pageCount, this.size, this.total);

  factory CoinSignInListData.fromJson(Map<String, dynamic> json){
    return _$CoinSignInListDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$CoinSignInListDataToJson(this);
}

