/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/24 0024
/// email: maoqitian068@163.com
/// des:  收藏文章 view item
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/model/collect/collect_data.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';

class CollectViewItem extends StatefulWidget {

  final CollectData collectData;

  CollectViewItem({Key key,this.collectData}):super(key : key);

  @override
  _CollectViewItemState createState() => _CollectViewItemState();
}

class _CollectViewItemState extends State<CollectViewItem> {


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
      child: ListTile(
        onTap: (){ //link 跳转  webview
          Application.router.navigateTo(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(widget.collectData.title)}&url=${Uri.encodeComponent(widget.collectData.link)}');
        },
        title: Padding( //文章标题
          padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
          child: Text(
              ToolUtils.signToStr(widget.collectData.title),
              style: TextStyle(color: Colors.black, fontSize: 15.0),
              maxLines: 1, // title 只显示一行
              overflow: TextOverflow.ellipsis //超出一行 显示 ...
          )
        ),
        subtitle: Row(
          children: <Widget>[

          ],
        ),
      ),
    );
  }
}
