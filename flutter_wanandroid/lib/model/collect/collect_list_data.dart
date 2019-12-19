/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/7 0007
/// email: maoqitian068@163.com
/// des:  收藏 文章 数据 集合 data

import 'package:flutter_wanandroid/model/collect/collect_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'collect_list_data.g.dart';

@JsonSerializable()
class CollectListData{
  int curPage;
  List<CollectData> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;

  CollectListData(this.curPage, this.datas, this.offset, this.over,
      this.pageCount, this.size, this.total);



 factory CollectListData.fromJson(Map<String, dynamic> json){
    return _$CollectListDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$CollectListDataToJson(this);
}