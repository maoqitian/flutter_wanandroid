/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-01-30
/// email: maoqitian068@163.com
/// des:  

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/model/coin/coin_sign_in_data.dart';


class UserCoinRecordItem extends StatelessWidget {

  CoinSignInData coinSignInData;

  UserCoinRecordItem({this.coinSignInData});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(coinSignInData.desc),
      subtitle: new Divider(),
    );
  }
}
