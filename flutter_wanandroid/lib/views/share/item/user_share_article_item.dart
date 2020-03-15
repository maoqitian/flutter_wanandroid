/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-01-28
/// email: maoqitian068@163.com
/// des:  分享文章 item

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/MyIcons.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/common/event/share_article_event.dart';
import 'package:flutter_wanandroid/data/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:flutter_wanandroid/model/route_page_data.dart';
import 'package:flutter_wanandroid/res/colours.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';


class UserShareArticleItem extends StatefulWidget {

  final ArticleData articleData;
  final bool isUserCenter; // 是否显示删除按钮 用户中心才显示删除

  const UserShareArticleItem({Key key, this.articleData,this.isUserCenter})
      :super(key:key);

  @override
  _UserShareArticleItemState createState() => _UserShareArticleItemState();
}

class _UserShareArticleItemState extends State<UserShareArticleItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: dataUtils.getIsDarkMode() ? Colours.dark_material_bg : Colors.white,
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
      child: ListTile(
        onTap: (){ //link 跳转  webview
          //routePageJson=${ToolUtils.object2string(routePageData)
          RoutePageData routePageData = new RoutePageData(widget.articleData.id, widget.articleData.title, widget.articleData.link,Constants.COLLECT_PAGE_TYPE , widget.articleData.collect);
          Application.router.navigateTo(context, '${Routes.webViewPage}?routePageJson=${ToolUtils.object2string(routePageData)}');
        },
        title: Padding( //文章标题
            padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
            child: Text(
                ToolUtils.signToStr(widget.articleData.title),
                style: TextStyle(color: Colors.black, fontSize: 15.0),
                maxLines: 1, // title 只显示一行
                overflow: TextOverflow.ellipsis //超出一行 显示 ...
            )
        ),
        subtitle: Row(
          children: <Widget>[
            Expanded(
              flex: 4,
              child: Text('时间：'+widget.articleData.niceDate ,
                  style: TextStyle(color: Colors.black54, fontSize: 10.0,),
                  maxLines: 1, // title 只显示一行
                  overflow: TextOverflow.ellipsis //超出一行 显示 ...
              ),
            ),
            Expanded( //占位
              flex: 2,
              child: Container(),
            ),
            Expanded(
              child: widget.isUserCenter ? IconButton(icon: Icon(MyIcons.delete,size: 20.0),onPressed: (){
                ToolUtils.showAlertDialog(context, "确定删除分享文章"+widget.articleData.title+"?",
                    confirmCallback: ()async{
                      // 删除收藏网站
                      await dataUtils.getDeleteUserShareArticle(widget.articleData.id,context);
                      Application.eventBus.fire(new ShareArticleEvent());
                      ToolUtils.showToast(msg: "删除分享文章成功");
                    },confirmText: "确定");
              },): Container(),
            ),
          ],
        ),
      ),
    );;
  }
}
