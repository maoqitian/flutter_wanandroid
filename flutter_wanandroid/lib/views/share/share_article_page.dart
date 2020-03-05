/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-01-28
/// email: maoqitian068@163.com
/// des:  广场 page

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/event/share_article_event.dart';
import 'package:flutter_wanandroid/components/refresh/refresh_page.dart';
import 'package:flutter_wanandroid/components/dialog/simple_input_dialog_layout.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_list_data.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/home/item/list_view_item.dart';


class ShareArticlePage extends StatefulWidget {

  @override
  _ShareArticlePageState createState() => _ShareArticlePageState();
}

class _ShareArticlePageState extends State<ShareArticlePage> {

  @override
  void initState() {
    super.initState();
  }

  Widget makeShareCard(index,item){
    return ListViewItem(articleData: item,isHomeShow: false,isClickUser: true);
  }

  Future<Map> getShareArticleListData([Map<String, dynamic> params]) async {
    //收藏文章
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    Map<String, dynamic> result;
    //收藏网站数据
    await dataUtils.getShareArticleData(pageIndex).then((ArticleListData list){
      result = {"list":list.datas, 'total':list.pageCount, 'pageIndex':list.curPage};
    },onError: (e){
      print("onError 发生错误");
      result = {"list":[], 'total':0, 'pageIndex':0};
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: _inAddShare,
          backgroundColor: Theme.of(context).primaryColor,
          child: Icon(Icons.add)),
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){
              Navigator.of(context).pop(this);
            }),
        title: Text("广场",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
      ),
      body: buildShareArticlePage(),
    );
  }


  //构建页面
  buildShareArticlePage() {
    return Column(
      children: <Widget>[
        new Expanded(
            child: RefreshPage(requestApi: getShareArticleListData, renderItem: makeShareCard,)
        )
      ],
    );
  }

  //分享文章
  void _inAddShare() {
    if(dataUtils.hasLogin()){
      showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return SimpleInputDialogLayout(
              isCollectArticle: false,
              isDIYText: true,
              themeText: "分享",
              dialogTitleText: "分享文章",
              confirmCallback2: (collectTitle,collectUrl) async{
                //收藏文章
                await dataUtils.getShareArticle(collectTitle,collectUrl,context);
                ToolUtils.showToast(msg: "分享文章成功");
                Application.eventBus.fire(new ShareArticleEvent());
              },
            );
          }
      );
    }else{
      Application.router.navigateTo(context,Routes.login);
    }
  }
}
