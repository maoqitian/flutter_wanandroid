import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/refresh/refresh_grid_page.dart';
import 'package:flutter_wanandroid/data/data_utils.dart';
import 'package:flutter_wanandroid/model/knowledge/knowledge_hierarchy_data.dart';
import 'package:flutter_wanandroid/views/knowledge/item/knowledge_grid_item.dart';

/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/10/31 0031
/// email: maoqitian068@163.com
/// des:  知识体系 widget


class KnowledgePage extends StatefulWidget {
  @override
  _KnowledgePageState createState() => _KnowledgePageState();
}

class _KnowledgePageState extends State<KnowledgePage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  Future<Map> getKnowLedgeListData([Map<String, dynamic> params]) async {
    //收藏文章
    Map<String, dynamic> result;
    await dataUtils.getKnowledgeTreeData().then((List<KnowledgeHierarchyData> list){
      result = {"list":list, 'total':0, 'pageIndex':0};
    },onError: (e){
      print("onError 发生错误");
      result = {"list":[], 'total':0, 'pageIndex':0};
    });
    return result;
  }


  //  GridViewItem
  Widget makeItem(item){
    return KnowledgeGridItem(item) ;
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshGridPage(requestApi:getKnowLedgeListData, renderItem: makeItem,isCanLoadMore: false);
  }
}
