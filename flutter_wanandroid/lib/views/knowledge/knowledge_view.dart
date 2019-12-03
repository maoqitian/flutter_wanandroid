/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-11-30
/// email: maoqitian068@163.com
/// des:  每个知识体系 内容对应的页面

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/refresh_page.dart' as listComp;
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_list_data.dart';
import 'package:flutter_wanandroid/views/home/item/list_view_item.dart';

class KnowledgeView extends StatefulWidget {

  int id;

  KnowledgeView(this.id);

  @override
  _KnowledgeViewState createState() => _KnowledgeViewState();
}

class _KnowledgeViewState extends State<KnowledgeView> {


  @override
  void initState() {
    super.initState();

  }

  //  ListViewItem
  Widget makeCard(index,item){

    return new ListViewItem(articleData: item,isHomeShow: false);
  }

  //获取 文章 列表数据
  Future<Map> getIndexListData([Map<String, dynamic> params]) async {
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;

    if(pageIndex == 0){ //置顶 数据 正常列表数据 同时请求 第一次请求
      ArticleListData articleListData = await dataUtils.getKnowledgeArticleData(widget.id, pageIndex);
      pageIndex += 1;
      Map<String, dynamic> result = {"list":articleListData.datas, 'total':articleListData.pageCount, 'pageIndex':pageIndex};
      return result;
    }else{
      //正常列表数据 加载更多
      ArticleListData articleListData = await dataUtils.getKnowledgeArticleData(widget.id,pageIndex);
      Map<String, dynamic> result = {"list":articleListData.datas, 'total':articleListData.pageCount, 'pageIndex':articleListData.curPage};
      return result;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Expanded(
            child: listComp.RefreshPage(getIndexListData,makeCard,null,false)
        )
      ],
    );;
  }
}
