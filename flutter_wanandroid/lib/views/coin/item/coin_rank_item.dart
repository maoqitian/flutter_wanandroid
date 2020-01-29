/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-01-29
/// email: maoqitian068@163.com
/// des:  

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/MyIcons.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/coin/coin_user_info.dart';
import 'package:flutter_wanandroid/widget/stroke_widget.dart';


class CoinRankItem extends StatelessWidget {

  final CoinUserInfo coinUserInfo;

  CoinRankItem({this.coinUserInfo});

  String userName;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: buildItem(coinUserInfo),
        ),
      ),
    );
  }

  buildItem(CoinUserInfo data) {
    List<Widget> list = [];
    if(dataUtils.hasLogin()){
      userName = dataUtils.getUserName();
      userName = userName.replaceRange(1, 3,"**");
    }
    if(data.rank == 1 || data.rank == 2 || data.rank == 3){
      switch (data.rank){
        case 1:
          list.add(Icon(MyIcons.first,color:Colors.yellow));
          break;
        case 2:
          list.add(Icon(MyIcons.second,color: Colors.blueGrey));
          break;
        case 3:
          list.add(Icon(MyIcons.third,color: Colors.orangeAccent));
          break;
      }
      list.add(Padding(
        padding: EdgeInsets.only(left: 10.0),
        child:Text(
          (data.username),
          style: TextStyle(color: Colors.black, fontSize: 15.0,fontWeight: FontWeight.bold),
          maxLines: 1, // title 只显示一行
          overflow: TextOverflow.ellipsis //超出一行 显示 ...
      )));
    }else{
      list.add(Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: Text(
          (data.rank.toString()+".  "+data.username),
          style: TextStyle(color: data.username == userName ? Colors.blue:Colors.black, fontSize: 15.0,fontWeight: FontWeight.bold),
          maxLines: 1, // title 只显示一行
          overflow: TextOverflow.ellipsis //超出一行 显示 ...
      )));
    }
    list.add(Padding(
      child: StrokeWidget(
          strokeWidth: 2,
          edgeInsets: EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
          color: data.username == userName ? Colors.blue : Colors.black,
          childWidget: Text( "lv "+data.level.toString(),
              style: TextStyle(fontSize: 11.0, color: data.username == userName ? Colors.blue: Colors.black, fontWeight: FontWeight.bold))
      ),
      padding: EdgeInsets.only(left: 10.0),
    ));
    return list;
  }
}
