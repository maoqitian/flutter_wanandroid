/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/1 0001
/// email: maoqitian068@163.com
/// des:  首页最新博文 page 轮播图 + 文章列表
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/views/home/item/list_view_item.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:flutter_wanandroid/components/list_refresh.dart' as listComp;
import 'package:flutter_wanandroid/components/refresh_page.dart' as listComp;
import 'package:flutter_wanandroid/model/article/article_list_data.dart';
import 'package:flutter_wanandroid/views/home/page/banner_page.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {


  @override
  void initState() {
    super.initState();
  }

  //  ListViewItem
  Widget makeCard(index,item){

    return new ListViewItem(articleData: item);
  }


  headerView (){
    return Column(
      children: <Widget>[
           Stack(
             children: <Widget>[
               //轮播图 page
               new BannerPage(),
             ],),
        SizedBox(height: 1, child:Container(color: Theme.of(context).primaryColor)),
        SizedBox(height: 10),
      ],
    );
  }

  //获取 文章 列表数据
  Future<Map> getIndexListData([Map<String, dynamic> params]) async {
   var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    /*var  pageTotal = 0;
    String path = '/article/list/$pageIndex/json';
    try{
    var response = await HttpUtils.get(Api.BASE_URL+path);
    if(response != null && response['errorCode'] == 0){
      pageTotal = response['data']['pageCount'];
      if (!(pageTotal is int) || pageTotal <= 0) {
        pageTotal = 0;
      }
      for (int i = 0; i < response['data']['datas'].length; i++) {
        Map<String, dynamic> json = response['data']['datas'][i];
        articleList.add(ArticleData.fromJson(json));
       }
      }
     }catch(e){
    }*/
    if(pageIndex == 0){ //置顶 数据 正常列表数据 同时请求 第一次请求
      List<ArticleData> articleAllList = [];
      Map<String, dynamic> result;
       await Future.wait([DataUtils.getArticleTopData(),DataUtils.getArticleData(pageIndex)])
          .then((List articleList){
        articleAllList.addAll(articleList[0]);
        ArticleListData articleListData = articleList[1];
        articleAllList.addAll(articleListData.datas);
        pageIndex += 1;
        result = {"list":articleAllList, 'total':articleListData.pageCount, 'pageIndex':pageIndex};
      });
      return result;
    }else{
      //正常列表数据 加载更多
      ArticleListData articleListData = await DataUtils.getArticleData(pageIndex);
      Map<String, dynamic> result = {"list":articleListData.datas, 'total':articleListData.pageCount, 'pageIndex':articleListData.curPage};
      return result;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Expanded(
            //child: listComp.ListRefresh(getIndexListData,makeCard,headerView)
            child: listComp.RefreshPage(getIndexListData,makeCard,headerView,true)
        )
      ],
    );
  }
}

