/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/1 0001
/// email: maoqitian068@163.com
/// des:  首页最新博文 page 轮播图 + 文章列表
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/refresh_page.dart';
import 'package:flutter_wanandroid/views/home/item/list_view_item.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:flutter_wanandroid/model/article/article_list_data.dart';
import 'package:flutter_wanandroid/views/home/page/banner_page.dart';

class FirstPage extends StatefulWidget {
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> with AutomaticKeepAliveClientMixin {

  //  防止页面重绘 三个步骤 扩展AutomaticKeepAliveClientMixin 重写wantKeepAlive 返回 true , build 方法加入super.build(context);
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  //  ListViewItem
  Widget makeCard(index,item){

    return new ListViewItem(articleData: item,isHomeShow: true);
  }


  headerView (){
    return Column(
          children: <Widget>[
            Stack(
              children: <Widget>[
                //轮播图 page
                new BannerPage(),
              ],),
            //SizedBox(height: 1, child:Container(color: Theme.of(context).primaryColor)),
            SizedBox(height: 10),
          ],
        );

  }

  //获取 文章 列表数据
  Future<Map> getIndexListData([Map<String, dynamic> params]) async {
   var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    Map<String, dynamic> result;
    if(pageIndex == 0){ //置顶 数据 正常列表数据 同时请求 第一次请求
      List<ArticleData> articleAllList = [];
       await Future.wait([dataUtils.getArticleTopData(),dataUtils.getArticleData(pageIndex)])
          .then((List articleList){
        if(articleList == null){
          result = {"list":articleAllList, 'total':0, 'pageIndex':pageIndex};
        }else{
          articleAllList.addAll(articleList[0]);
          ArticleListData articleListData = articleList[1];
          articleAllList.addAll(articleListData.datas);
          pageIndex += 1;
          result = {"list":articleAllList, 'total':articleListData.pageCount, 'pageIndex':pageIndex};
        }
      },onError: (e){
            print("发生错误"+e.toString());
            result = {"list":[], 'total':0, 'pageIndex':0};
       }
      );
      return result;
    }else{
      //正常列表数据 加载更多
       await dataUtils.getArticleData(pageIndex).then((ArticleListData articleListData){
         result = {"list":articleListData.datas, 'total':articleListData.pageCount, 'pageIndex':articleListData.curPage};
      },onError: (e){
         result = {"list":[], 'total':0, 'pageIndex':0};
       });
      return result;
    }
  }



  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        new Expanded(
            //child: listComp.ListRefresh(getIndexListData,makeCard,headerView)
            child: RefreshPage(requestApi:getIndexListData,
                               renderItem: makeCard,
                               headerView : headerView,
                               isHaveHeader:true)
        )
      ],
    );
  }
}

