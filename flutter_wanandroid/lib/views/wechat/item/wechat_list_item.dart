/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-01-26
/// email: maoqitian068@163.com
/// des:  公众号 Item

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/knowledge/knowledge_hierarchy_data.dart';
import 'package:flutter_wanandroid/res/colours.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';

class WechatListItem extends StatefulWidget {

  KnowledgeHierarchyData wechatData;

  WechatListItem(this.wechatData);

  @override
  _WechatListItemState createState() => _WechatListItemState();
}

class _WechatListItemState extends State<WechatListItem> {


  @override
  Widget build(BuildContext context) {
    return new Card(
      color: dataUtils.getIsDarkMode() ? Colours.dark_material_bg : Colors.white,
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
      child: ListTile(
        onTap: (){ //link 跳转  webview
          Application.router.navigateTo(context,'${Routes.knowledgedetail}?type=${Uri.encodeComponent(Constants.RESULT_CODE_WECHAT_PAGE)}&knowledgeJson=${ToolUtils.object2string(widget.wechatData)}');
        },
        leading: CircleAvatar(
          backgroundColor: Colors.white,//显示头像
          backgroundImage: AssetImage(ToolUtils.getImage("ic_launcher_foreground")),
        ),
        title: Padding( //文章标题
          padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
          child: Text(
              ToolUtils.signToStr(widget.wechatData.name),
              style: TextStyle(color: Colors.black, fontSize: 15.0,fontWeight: FontWeight.bold),
              maxLines: 1, // title 只显示一行
              overflow: TextOverflow.ellipsis //超出一行 显示 ...
          ),
        ),
      ),
    );
  }
}
