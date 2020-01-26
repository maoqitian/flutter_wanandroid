/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/10/31 0031
/// email: maoqitian068@163.com
/// des:  公众号 widget
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/refresh_page.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/knowledge/knowledge_hierarchy_data.dart';
import 'package:flutter_wanandroid/views/wechat/item/wechat_list_item.dart';


class WechatChaptersPage extends StatefulWidget {
  @override
  _WechatChaptersPageState createState() => _WechatChaptersPageState();
}

class _WechatChaptersPageState extends State<WechatChaptersPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();

  }

  Future<Map> getWechatListData([Map<String, dynamic> params]) async {
    //收藏文章
    Map<String, dynamic> result;
    await dataUtils.getWXArticleChaptersData().then((List<KnowledgeHierarchyData> list){
      result = {"list":list, 'total':0, 'pageIndex':0};
    },onError: (e){
      print("onError 发生错误");
      result = {"list":[], 'total':0, 'pageIndex':0};
    });
    return result;
  }


  //  GridViewItem
  Widget makeWechatCard(index,item){
    return WechatListItem(item) ;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        new Expanded(
            child: RefreshPage(requestApi: getWechatListData,
                renderItem: makeWechatCard,isCanLoadMore: false,)
        )
      ],
    );
  }
}
