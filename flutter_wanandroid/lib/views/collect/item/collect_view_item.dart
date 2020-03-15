/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/24 0024
/// email: maoqitian068@163.com
/// des:  收藏文章 view item
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/MyIcons.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/common/event/collect_event.dart';
import 'package:flutter_wanandroid/data/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:flutter_wanandroid/model/collect/collect_data.dart';
import 'package:flutter_wanandroid/model/route_page_data.dart';
import 'package:flutter_wanandroid/res/colours.dart';
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
      color: dataUtils.getIsDarkMode() ? Colours.dark_material_bg : Colors.white,
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
      child: ListTile(
        onTap: (){ //link 跳转  webview
          RoutePageData routePageData = new RoutePageData(widget.collectData.id, widget.collectData.title, widget.collectData.link,Constants.NOT_COLLECT_PAGE_TYPE , false);
          Application.router.navigateTo(context, '${Routes.webViewPage}?routePageJson=${ToolUtils.object2string(routePageData)}');
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
          children: setCollectWidget(widget.collectData),
        ),
      ),
    );
  }

  List<Widget> setCollectWidget(CollectData collectData){
    List<Widget> list = [];
    if(collectData.author!= ""){
      list.add(new Icon(Icons.person,size: 20.0));
      list.add( Padding(
        child: InkWell(
          child: Text(collectData.author,
              style: TextStyle(color: Colors.blue, fontSize: 10.0)),
          onTap: (){
              //作者不为空，说明可以更加作者昵称查看文章 否则查看 分享人 个人信息主页
              Application.router.navigateTo(context, '${Routes.knowledgedetail}?type=${Uri.encodeComponent(Constants.RESULT_CODE_AUTHOR_ARTICLE_PAGE)}&author=${Uri.encodeComponent(collectData.author)}');
          },
        ),
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0,left: 5.0,right: 5.0),
      ));
    }
    list.add(Padding(
      padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
      child: Text("分类：",
        maxLines: 1,
        style: TextStyle(color: Colors.black54, fontSize: 10.0,decoration: TextDecoration.none),
        overflow: TextOverflow.ellipsis,
      ),
    ));
    list.add(Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: InkWell( //点击水波纹效果
          child: Text(collectData.chapterName,
            maxLines: 1,
            style: TextStyle(color: Colors.blue, fontSize: 10.0,decoration: TextDecoration.none),
            overflow: TextOverflow.ellipsis,
          ),
          onTap: (){
              print("跳转 知识体系下文章 ");
              ArticleData articleData =new ArticleData("", "", 0, collectData.chapterName, false, 0, "", "", false, 0, "", "", "", "", "", 0, collectData.chapterId, "", "", 0, 0, 0, 0, 0, null, "", 0, 0, "");
              Application.router.navigateTo(context,'${Routes.knowledgedetail}?type=${Uri.encodeComponent(Constants.RESULT_CODE_HOME_PAGE)}&articleJson=${ToolUtils.object2string(articleData)}');
          },
        )
    ));
    list.add(Expanded(  //使用Expanded 占用剩余空间 ，保证 more_vert icon 按钮竖直方向对齐
         child:  Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0,left: 5.0),
          child: Text("收藏时间："+collectData.niceDate,
          maxLines: 1,
          style: TextStyle(color: Colors.black54, fontSize: 10.0,decoration: TextDecoration.none),
          overflow: TextOverflow.ellipsis,
      ),
    )));
    list.add(
       InkWell(
        child: Icon(Icons.more_vert,size: 18.0),
        onTap: (){
          showModalBottomSheet( //使用showModalBottomSheet 模仿 底部弹出 dialog
              backgroundColor: dataUtils.getIsDarkMode() ? Colours.dark_material_bg : Colors.white,
              context: context,
              builder: (BuildContext context){
                return new Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: new Icon(MyIcons.collection,color: Theme.of(context).primaryColor),
                      title: new Text("取消收藏"),
                      onTap: () async {
                        //取消收藏
                        await dataUtils.getCancelCollect(widget.collectData.id, widget.collectData.originId,context);
                        Application.eventBus.fire(new CollectEvent());
                        ToolUtils.showToast(msg:"取消收藏成功");
                        Navigator.pop(context);
                      },
                    ),
                    Container(
                      color: Colors.grey,
                      width: MediaQuery.of(context).size.width,
                      height: 3,
                    ),
                    ListTile(
                      title: Center(child: new Text("取消"),),
                      onTap: () async {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                );
              }
          );
        },
      ),
    );
    return list;
  }
}
