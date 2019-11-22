/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/5 0005
/// email: maoqitian068@163.com
/// des:  首页 文章 list view item
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/widget/stroke_widget.dart';

class ListViewItem extends StatelessWidget {

  final String itemUrl;
  final String itemTitle;
  final String data;
  final ArticleData articleData;

  const ListViewItem({Key key, this.itemUrl, this.itemTitle, this.data,this.articleData})
      :super(key:key);


  @override
  Widget build(BuildContext context) {
    return new Card(
      color: Colors.white,
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
      child: ListTile(
        onTap: (){ //link 跳转  webview
          Application.router.navigateTo(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(articleData.title)}&url=${Uri.encodeComponent(articleData.link)}');
        },
        title: Padding( //文章标题
          padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
          child: Text(
             ToolUtils.signToStr(articleData.title),
             style: TextStyle(color: Colors.black, fontSize: 15.0),
           ),
        ),
        subtitle: Row(
          children: _setArticleWidget(articleData)
        ),
        trailing:
        IconButton(icon: new Icon(Icons.favorite_border,color: Colors.grey, size: 25.0),onPressed: (){
          _clickCollection();
        }),
      ),
    );
  }
  //返回 list 集合 显示文章信息
  List<Widget> _setArticleWidget(ArticleData articleData) {
      List <Widget> widget = [];
      if(1 == articleData.type){
        // 加入 置顶标签
        widget.add(_buildStrokeWidget('置顶',Colors.redAccent));
      }
      if(articleData.fresh){
        //加入 新 标签
        widget.add( _buildStrokeWidget('新',Colors.redAccent));
      }
      if(articleData.tags.length > 0){
        //加入 tag 标签
        widget.add( _buildStrokeWidget(articleData.tags[0].name,Colors.green));
      }
      widget.add(new Icon(Icons.person,size: 20.0));
      widget.add( Padding(
        child: Text(articleData.author == ""? articleData.shareUser :articleData.author,
            style: TextStyle(color: Colors.black54, fontSize: 10.0)),
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0,left: 5.0),
      ));
      widget.add(Padding(
        child: Text('时间：'+articleData.niceDate ,
            style: TextStyle(color: Colors.black54, fontSize: 10.0)),
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0,left: 5.0),
      ));
    return widget;
  }

  // 创建 tag widget 方法
  Widget _buildStrokeWidget(String text , Color color) {
    return Padding(
      child: StrokeWidget(
          strokeWidth: 0.5,
          edgeInsets: EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
          color: color,
          childWidget: Text(
            text,
            style: TextStyle(
                fontSize: 11.0,
                color: color,
                fontWeight: FontWeight.w100),
          )
      ),
      padding: EdgeInsets.only(right: 10.0),
    );
  }

  void _clickCollection() {
    ToolUtils.ShowToast(msg:"点击了收藏按钮");
  }
}

