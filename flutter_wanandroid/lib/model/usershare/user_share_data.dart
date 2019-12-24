import 'package:flutter_wanandroid/model/article/article_list_data.dart';
import 'package:flutter_wanandroid/model/coin/coin_user_info.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_share_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/24 0024
/// email: maoqitian068@163.com
/// des:  广场 分享人 分享数据

@JsonSerializable()
class UserShareData{

  CoinUserInfo coinInfo;
  ArticleListData shareArticles;

  UserShareData(this.coinInfo, this.shareArticles);


  factory UserShareData.fromJson(Map<String, dynamic> json){
    return _$UserShareDataFromJson(json);
  }

}
