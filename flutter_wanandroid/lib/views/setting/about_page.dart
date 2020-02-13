/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-01-31
/// email: maoqitian068@163.com
/// des:  关于我们 page

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/route_page_data.dart';
import 'package:flutter_wanandroid/res/colours.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:package_info/package_info.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {

  String appVersion="";

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
        backgroundColor: dataUtils.getIsDarkMode() ? Colours.dark_unselected_item_color : Color(0xFFEEEEEE),
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
            SizedBox(height: 15.0),
            Html(
              data: """
                  <h2>应用内容</h2>
            <p>\t\t首先感谢鸿洋大佬，本应用内容全部来自于玩Android网站开放API。</p>
            <h2>源码位置</h2>
            <p>\t\t本应用已经开源，如果你发现任何错误，马上点击
            <a href="https://github.com/maoqitian/flutter_wanandroid" target="_blank">https://github.com/maoqitian/flutter_wanandroid</a>，在上面发起<b>issue</b>或者提交<b>pull request</b>。</p>
            """,
              padding: EdgeInsets.all(8.0),
              onLinkTap: (url) {
                RoutePageData routePageData = new RoutePageData(0, "项目源码", url,Constants.NOT_COLLECT_PAGE_TYPE , false);
                Application.router.navigateTo(context, '${Routes.webViewPage}?routePageJson=${ToolUtils.object2string(routePageData)}');
              },
            ),
          ],
        ),
    );
  }
}
