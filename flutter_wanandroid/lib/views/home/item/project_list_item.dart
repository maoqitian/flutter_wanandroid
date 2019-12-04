/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-12-04
/// email: maoqitian068@163.com
/// des:  项目 listview item

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:flutter_wanandroid/routers/routes.dart';


class ProjectListItem extends StatefulWidget {

  final ArticleData articleData;
  final bool isHomeShow; // 是否首页展示 控制 是否还能点击 进入知识体系

  ProjectListItem({this.articleData,this.isHomeShow});

  @override
  _ProjectListItemState createState() => _ProjectListItemState();
}

class _ProjectListItemState extends State<ProjectListItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
         child: ListTile(
           onTap: (){ //link 跳转  webview
             Application.router.navigateTo(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(widget.articleData.title)}&url=${Uri.encodeComponent(widget.articleData.link)}');
           },
           title: Row(
             children: <Widget>[
               Container(
                 width: 200,
                 height: 150,
                 child: Text(widget.articleData.title,
                     style: TextStyle(color: Colors.black, fontSize: 15.0),
                     maxLines: 2, // title 显示2行
                     overflow: TextOverflow.ellipsis //超出2行 显示 ...
                 ),
               ),
               ClipRRect(
                 child: Image.network(
                   widget.articleData.envelopePic,
                   fit: BoxFit.fill,
                   width: 120,
                   height:240,
                 ),
                 borderRadius: BorderRadius.only(
                   topLeft: Radius.circular(5),
                   topRight: Radius.circular(5),
                   bottomLeft:Radius.circular(5),
                   bottomRight: Radius.circular(5),
                 ),
               )
             ],
           ),
           subtitle: Row(
             children: <Widget>[

             ],
           ),
         )
    );
  }
}
