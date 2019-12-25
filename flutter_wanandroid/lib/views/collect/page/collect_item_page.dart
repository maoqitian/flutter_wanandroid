/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des: 收藏 模块对应 page  收藏文章
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/refresh_page.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/collect/collect_list_data.dart';
import 'package:flutter_wanandroid/views/collect/item/collect_view_item.dart';

class CollectItemPage extends StatefulWidget {


  CollectItemPage();

  @override
  _CollectItemPageState createState() => _CollectItemPageState();
}

class _CollectItemPageState extends State<CollectItemPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  //  ListViewItem
  Widget makeCollectCard(index,item){
    return CollectViewItem(collectData: item) ;
  }

  Future<Map> getCollectListData([Map<String, dynamic> params]) async {
      //收藏文章
      var pageIndex = (params is Map) ? params['pageIndex'] : 0;
      Map<String, dynamic> result;
      await dataUtils.getCollectArticleListData(pageIndex).then((CollectListData collectListData){
        result = {"list":collectListData.datas, 'total':collectListData.pageCount, 'pageIndex':collectListData.curPage};
      },onError: (e){
        print("onError 发生错误");
        result = {"list":[], 'total':0, 'pageIndex':0};
      });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        new Expanded(
          // 收藏网站没有加载更多
            child: RefreshPage(requestApi: getCollectListData, renderItem: makeCollectCard)
        )
      ],
    );
  }
}

