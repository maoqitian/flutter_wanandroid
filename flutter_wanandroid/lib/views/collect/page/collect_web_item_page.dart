/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des: 收藏 模块对应 page  收藏文章
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/refresh/refresh_page.dart';
import 'package:flutter_wanandroid/data/data_utils.dart';
import 'package:flutter_wanandroid/model/collect/collect_web_data.dart';
import 'package:flutter_wanandroid/views/collect/item/collect_web_view_item.dart';

class CollectWebItemPage extends StatefulWidget {

  //设置当前页面是否可以下拉刷新，个人中心页面不能下拉刷新
  bool notUserCenter;
  CollectWebItemPage(this.notUserCenter);

  @override
  _CollectWebItemPageState createState() => _CollectWebItemPageState();
}

class _CollectWebItemPageState extends State<CollectWebItemPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  //  ListViewItem
  Widget makeCollectCard(index,item){
    return CollectWebViewItem(collectWebData: item);
  }

  Future<Map> getCollectWebListData([Map<String, dynamic> params]) async {
    Map<String, dynamic> result;
      //收藏网站数据
      await dataUtils.getCollectWebListData().then((List<CollectWebData> list){
        result = {"list":list, 'total':0, 'pageIndex':1};
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
            child: RefreshPage(requestApi: getCollectWebListData,
                renderItem: makeCollectCard,
                isCanLoadMore: false,
                isCanRefresh: widget.notUserCenter,
                isNeedController: widget.notUserCenter)
        )
      ],
    );
  }
}

