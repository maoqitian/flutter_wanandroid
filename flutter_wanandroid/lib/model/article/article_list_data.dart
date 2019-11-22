/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/7 0007
/// email: maoqitian068@163.com
/// des:  文章 数据 集合 data
import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:json_annotation/json_annotation.dart';

part 'article_list_data.g.dart';

@JsonSerializable()
class ArticleListData{
  int curPage;
  List<ArticleData> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;


  ArticleListData(this.curPage, this.datas, this.offset, this.over,
      this.pageCount, this.size, this.total);

  factory ArticleListData.fromJson(Map<String, dynamic> json){
    return _$ArticleListDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$ArticleListDataToJson(this);
}