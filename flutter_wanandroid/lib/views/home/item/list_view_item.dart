/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/5 0005
/// email: maoqitian068@163.com
/// des:  首页 文章 list view item
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/model/route_page_data.dart';
import 'package:flutter_wanandroid/res/colours.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/widget/stroke_widget.dart';


class ListViewItem extends StatefulWidget {


  final ArticleData articleData;
  final bool isHomeShow; // 是否首页展示 控制 是否还能点击 进入知识体系
  final bool isClickUser; // 是可以点击作者 跳转对应页面

  const ListViewItem({Key key, this.articleData,this.isHomeShow = true, this.isClickUser=true})
      :super(key:key);

  @override
  _ListViewItemState createState() => _ListViewItemState();
}

class _ListViewItemState extends State<ListViewItem> {



  @override
  Widget build(BuildContext context) {
    return new Card(
      color: dataUtils.getIsDarkMode() ? Colours.dark_material_bg : Colors.white,
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
      child: ListTile(
        onTap: (){ //link 跳转  webview
          RoutePageData routePageData = new RoutePageData(widget.articleData.id, widget.articleData.title, widget.articleData.link,Constants.COLLECT_PAGE_TYPE , widget.articleData.collect);
          Application.router.navigateTo(context, '${Routes.webViewPage}?routePageJson=${ToolUtils.object2string(routePageData)}');
        },
        leading: IconButton(icon: new Icon(widget.articleData.collect ? Icons.favorite : Icons.favorite_border,
            color: widget.articleData.collect ? Colors.deepOrange : Colors.grey, size: 25.0),
            onPressed: _clickCollection),
        title: Padding( //文章标题
          padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
          child: Text(
            ToolUtils.signToStr(widget.articleData.title),
            style: TextStyle(color: Colors.black, fontSize: 15.0,fontWeight: FontWeight.bold),
            maxLines: 1, // title 只显示一行
            overflow: TextOverflow.ellipsis //超出一行 显示 ...
          ),
        ),
        subtitle: Row(
            children: _setArticleWidget(widget.articleData)
        ),
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
    widget.add(new Icon(articleData.author == ""?Icons.folder_shared:Icons.person,size: 20.0));
    widget.add( Padding(
      child: InkWell(
        child: Text(articleData.author == ""? articleData.shareUser :articleData.author,
            style: TextStyle(color: this.widget.isClickUser? Colors.blue:Colors.black54, fontSize: 10.0)),
        onTap: (){
          if(this.widget.isClickUser){
            if(!(articleData.author == "")){ //如果作者不为空，说明可以更加作者昵称查看文章 否则查看 分享人 个人信息主页
              Application.router.navigateTo(context, '${Routes.knowledgedetail}?type=${Uri.encodeComponent(Constants.RESULT_CODE_AUTHOR_ARTICLE_PAGE)}&author=${Uri.encodeComponent(articleData.author)}');
            }else{
              print("跳转分享人个人中心");
              Application.router.navigateTo(context, '${Routes.userCenterPage}?type=${Uri.encodeComponent(Constants.USER_SHARE_CENTER_PAGE_TYPE)}&authorId=${Uri.encodeComponent(articleData.userId.toString())}&authorName=${Uri.encodeComponent(articleData.shareUser)}');
            }
          }
        },
      ),
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0,left: 5.0),
    ));
    widget.add(Padding(
      child: Text('时间：'+articleData.niceDate ,
          style: TextStyle(color: Colors.black54, fontSize: 10.0,),
          maxLines: 1, // title 只显示一行
          overflow: TextOverflow.ellipsis //超出一行 显示 ...
      ),
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0,left: 5.0),
    ));
    widget.add(Expanded(
        child: Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0,left: 10.0),
          child: InkWell( //点击水波纹效果
            child: Text(articleData.superChapterName+" / "+ articleData.chapterName,
            maxLines: 1,
            style: TextStyle(color:this.widget.isHomeShow? Colors.blue:Colors.black54, fontSize: 10.0,decoration: TextDecoration.none),
            overflow: TextOverflow.ellipsis,
          ),
          onTap: (){
            if(this.widget.isHomeShow){
              print("跳转 知识体系下文章 ");
              Application.router.navigateTo(context,'${Routes.knowledgedetail}?type=${Uri.encodeComponent(Constants.RESULT_CODE_HOME_PAGE)}&articleJson=${ToolUtils.object2string(articleData)}');
            }
          },
          )
        )));
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
      padding: EdgeInsets.only(right: 5.0),
    );
  }

  void _clickCollection() async {
    if(!dataUtils.hasLogin()){
      Application.router.navigateTo(context,Routes.login);
      ToolUtils.showToast(msg:"请先登录");
      return;
    }
    if(widget.articleData.collect){
      //取消收藏
      await dataUtils.getCancelCollectInnerArticle(widget.articleData.id);
      setState(() {
        widget.articleData.collect = false;
      });
      ToolUtils.showToast(msg:"取消收藏成功");
    }else{
      //添加收藏
      await dataUtils.getCollectInnerArticle(widget.articleData.id);
      setState(() {
        widget.articleData.collect = true;
      });
      ToolUtils.showToast(msg:"收藏成功");
    }
  }

}


