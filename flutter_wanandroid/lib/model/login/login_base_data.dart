import 'package:json_annotation/json_annotation.dart';
import 'login_data.dart';
part 'login_base_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-11-24
/// email: maoqitian068@163.com
/// des:  



@JsonSerializable()
class LoginBaseData{


  LoginData data;
  int errorCode;
  String errorMsg;

  LoginBaseData(this.data, this.errorCode, this.errorMsg);


  factory LoginBaseData.fromJson(Map<String, dynamic> json){
    return _$LoginBaseDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$LoginBaseDataToJson(this);

}
