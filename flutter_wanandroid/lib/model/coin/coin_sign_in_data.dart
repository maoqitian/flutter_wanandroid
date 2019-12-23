import 'package:json_annotation/json_annotation.dart';
part 'coin_sign_in_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des:  积分签到 bean
@JsonSerializable()
class CoinSignInData{

  int coinCount;
  int date;
  String desc;
  int id;
  String reason;
  int type;
  int userId;
  String userName;

  CoinSignInData(this.coinCount, this.date, this.desc, this.id, this.reason,
      this.type, this.userId, this.userName);

  factory CoinSignInData.fromJson(Map<String, dynamic> json){
    return _$CoinSignInDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$CoinSignInDataToJson(this);

}

