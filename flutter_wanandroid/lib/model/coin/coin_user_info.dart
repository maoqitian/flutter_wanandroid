/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/26 0026
/// email: maoqitian068@163.com
/// des:  积分数据
import 'package:json_annotation/json_annotation.dart';
part 'coin_user_info.g.dart';
@JsonSerializable()
class CoinUserInfo{

  int coinCount;
  int rank;
  int level;
  int userId;
  String username;

  CoinUserInfo(this.coinCount, this.rank, this.level, this.userId,
      this.username);


  factory CoinUserInfo.fromJson(Map<String, dynamic> json){
    return _$CoinUserInfoFromJson(json);
  }
}
