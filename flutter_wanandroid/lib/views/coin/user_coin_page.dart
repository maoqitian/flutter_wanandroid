/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-01-29
/// email: maoqitian068@163.com
/// des:  我的积分 page

import 'package:flutter/material.dart';


class UserCoinPage extends StatefulWidget {
  @override
  _UserCoinPageState createState() => _UserCoinPageState();
}

class _UserCoinPageState extends State<UserCoinPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){
              Navigator.of(context).pop(this);
            }),
        title: Text("我的积分",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
      ),
      body: buildCPage(),
    );
  }

  buildCPage() {
    return Column(
      children: <Widget>[

      ],
    );
  }
}
