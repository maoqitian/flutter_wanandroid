/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-01-31
/// email: maoqitian068@163.com
/// des:  关于我们 page

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  String appVersion;

  @override
  void initState() {
    super.initState();
    PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      //String appName = packageInfo.appName;
      //String packageName = packageInfo.packageName;
      if(this.mounted){
        setState(() {
          appVersion = packageInfo.version;
        });
      }
      //String buildNumber = packageInfo.buildNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFEEEEEE),
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop(this);
              }),
          title: Text("关于我们",
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white)),
          centerTitle: true,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20.0),//能强制子控件具有特定宽高
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(ToolUtils.getImage("ic_launcher"),
                    fit: BoxFit.contain,
                    width: 60.0,
                    height: 60.0
                )
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(appVersion,style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: Colors.lightBlue),)
              ],
            ),
          ],
        ),
    );
  }
}
