import 'package:dio/dio.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-11-30
/// email: maoqitian068@163.com
/// des:  每个知识体系 内容对应的页面

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/refresh_page.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_list_data.dart';
import 'package:flutter_wanandroid/views/home/item/list_view_item.dart';

class KnowledgeView extends StatefulWidget {

  int id;
  String author;
  KnowledgeView({this.id,this.author});

  @override
  _KnowledgeViewState createState() => _KnowledgeViewState();
}

class _KnowledgeViewState extends State<KnowledgeView> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

  }

  //  ListViewItem
  Widget makeCard(index,item){

    return new ListViewItem(articleData: item,isHomeShow: false,isClickUser: false);
  }

  //获取 文章 列表数据
  Future<Map> getIndexListData([Map<String, dynamic> params]) async {
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    Map<String, dynamic> result;
      if(-1 == this.widget.id){
        await dataUtils.getAuthorArticleData(widget.author, pageIndex).then((ArticleListData articleListData){
          result = {"list":articleListData.datas, 'total':articleListData.pageCount, 'pageIndex':articleListData.curPage};
        },onError: (e){
          print("onError 发生错误");
          result = {"list":[], 'total':0, 'pageIndex':0};
        });
      }else{
        await dataUtils.getKnowledgeArticleData(widget.id, pageIndex).then((ArticleListData articleListData){
          result = {"list":articleListData.datas, 'total':articleListData.pageCount, 'pageIndex':articleListData.curPage};
        },onError: (e){
          print("onError 发生错误");
          result = {"list":[], 'total':0, 'pageIndex':0};
        });
      }
      return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        new Expanded(
            child: RefreshPage(requestApi: getIndexListData,
                               renderItem: makeCard)
        )
      ],
    );
  }
}
