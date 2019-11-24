/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-11-24
/// email: maoqitian068@163.com
/// des:  登录数据
/// {
//        "admin": false,
//        "chapterTops": [],
//        "collectIds": [
//            9016,
//            9002,
//            9014,
//            9013,
//            9012,
//            9011,
//            9866
//        ],
//        "email": "",
//        "icon": "",
//        "id": 863,
//        "nickname": "maoqitian",
//        "password": "",
//        "publicName": "maoqitian",
//        "token": "",
//        "type": 0,
//        "username": "maoqitian"
//    }

import 'package:json_annotation/json_annotation.dart';

part 'login_data.g.dart';

@JsonSerializable()
class LoginData{

  String email;
  String icon;
  int id;
  String password;
  String token;
  int type;
  String username;
  String nickname;
  String publicName;
  List<int> collectIds;
  List<String> chapterTops;
  bool admin;

  LoginData(this.email, this.icon, this.id, this.password, this.token,
      this.type, this.username, this.nickname, this.publicName, this.collectIds,
      this.chapterTops, this.admin);



  factory LoginData.fromJson(Map<String, dynamic> json){
    return _$LoginDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$LoginDataToJson(this);


}