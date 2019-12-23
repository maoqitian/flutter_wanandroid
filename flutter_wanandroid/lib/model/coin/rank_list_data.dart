import 'package:flutter_wanandroid/model/coin/coin_user_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'rank_list_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des:  积分排行榜 数据 bean

@JsonSerializable()
class RankListData{
  int curPage;
  List<CoinUserInfo> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;


  RankListData(this.curPage, this.datas, this.offset, this.over,
      this.pageCount, this.size, this.total);

  factory RankListData.fromJson(Map<String, dynamic> json){
    return _$RankListDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$RankListDataToJson(this);
}

