/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-12-04
/// email: maoqitian068@163.com
/// des:  项目 listview item

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';


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
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               Expanded(
                 flex: 2,
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.start,
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                      Padding(
                       padding: EdgeInsets.all(5.0),
                       child:Row(
                         children: <Widget>[
                           Icon(Icons.person,size: 20.0),
                          Padding(
                           child: Text(widget.articleData.author == ""? widget.articleData.shareUser :widget.articleData.author,
                           style: TextStyle(color: Colors.black54, fontSize: 10.0)),
                           padding: EdgeInsets.only(top: 10.0, bottom: 10.0,left: 5.0),
                          )
                         ],
                       ),),
                       Padding(
                         padding: EdgeInsets.all(5.0),
                         child: Text(widget.articleData.title,
                             style: TextStyle(color: Colors.black, fontSize: 15.0,fontWeight: FontWeight.bold),
                             maxLines: 2, // title 显示2行
                             overflow: TextOverflow.ellipsis //超出2行 显示 ...
                         ),
                       ),
                       Padding(
                         padding: EdgeInsets.all(5.0),
                         child: Text(widget.articleData.desc,
                             style: TextStyle(color: Colors.grey, fontSize: 13.0),
                             maxLines: 2, // title 显示2行
                             overflow: TextOverflow.ellipsis //超出2行 显示 ...
                         ),
                       ),
                     ],
                   )
               ),
              Expanded(
               flex: 1,
                child:
                ClipRRect(
                  child: Image.network(
                    widget.articleData.envelopePic,
                    fit: BoxFit.fill,
                    height:240,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft:Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                )
              )

             ],
           ),
           subtitle: Row(
             children: <Widget>[
               IconButton(icon: Icon(widget.articleData.collect ?Icons.favorite:Icons.favorite_border,
                   color: widget.articleData.collect ? Colors.deepOrange : Colors.grey, size: 25.0),onPressed:_clickCollection,),
               Text("时间："+widget.articleData.niceDate,
                   style: TextStyle(color: Colors.grey, fontSize: 10.0),
                   maxLines: 1, // title 显示2行
                   overflow: TextOverflow.ellipsis //超出2行 显示 ...
               ),
               Expanded(
                   child: Padding(
                       padding: EdgeInsets.only(left: 5.0),
                       child: InkWell( //点击水波纹效果
                         child: Text(widget.isHomeShow ? "查看同类型文章":"",
                           maxLines: 1,
                           style: TextStyle(color: Colors.blue, fontSize: 10.0,decoration: TextDecoration.none),
                           overflow: TextOverflow.ellipsis,
                         ),
                         onTap: (){
                           if(this.widget.isHomeShow){
                             print("跳转 知识体系下文章 ");
                             Application.router.navigateTo(context, '${Routes.knowledgedetail}?type=${Uri.encodeComponent(Constants.RESULT_CODE_LATEST_PROJECT_PAGE)}&articleJson=${ToolUtils.object2string(widget.articleData)}');
                           }
                         },
                       )
                   ))
             ],
           ),
         )
    );
  }

  void _clickCollection() async {
    if(!dataUtils.hasLogin()){
      Application.router.navigateTo(context,Routes.login);
      ToolUtils.ShowToast(msg:"请先登录");
      return;
    }
    if(widget.articleData.collect){
      //取消收藏
      await dataUtils.getCancelCollectInnerArticle(widget.articleData.id);
      setState(() {
        widget.articleData.collect = false;
      });
      ToolUtils.ShowToast(msg:"取消收藏成功");
    }else{
      //添加收藏
      await dataUtils.getCollectInnerArticle(widget.articleData.id);
      setState(() {
        widget.articleData.collect = true;
      });
      ToolUtils.ShowToast(msg:"收藏成功");
    }
  }
}
