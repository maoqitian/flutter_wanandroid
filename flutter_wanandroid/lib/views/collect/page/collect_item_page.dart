/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des: 收藏 模块对应 page  收藏文章
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/event/cancel_event.dart';
import 'package:flutter_wanandroid/components/refresh_page.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/collect/collect_list_data.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/collect/item/collect_view_item.dart';

class CollectItemPage extends StatefulWidget {

  //设置当前页面是否可以下拉刷新，个人中心页面不能下拉刷新
  bool notUserCenter;

  CollectItemPage(this.notUserCenter);

  @override
  _CollectItemPageState createState() => _CollectItemPageState();
}

class _CollectItemPageState extends State<CollectItemPage> with AutomaticKeepAliveClientMixin{


  List list = [];
  var pageIndex =  0;

  @override
  bool get wantKeepAlive => true;

  EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    if(!widget.notUserCenter){
      getUserCollectListData(pageIndex);
      _controller = EasyRefreshController();
      Application.eventBus.on<CollectEvent>().listen((event){
        //接收到 收藏事件操作 刷新列表
        getUserCollectListData(0);
      });
    }
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

  //个人中心获取数据
  getUserCollectListData(int pageNum) async {
    if(pageNum == 0){
      list.clear();
    }
    await dataUtils.getCollectArticleListData(pageNum).then((CollectListData collectListData){
      //result = {"list":collectListData.datas, 'total':collectListData.pageCount, 'pageIndex':collectListData.curPage};
      if(this.mounted){
        setState(() {
          if(collectListData.datas.length!=0){
            list.addAll(collectListData.datas);
            pageIndex= collectListData.curPage;
            _controller.finishLoad(success: true);
          }else{
            ToolUtils.showToast(msg: "哥，这回真没了！！");
            _controller.finishLoad(noMore: true);
          }
        });
      }
    },onError: (e){
      print("onError 发生错误");
      //result = {"list":[], 'total':0, 'pageIndex':0};
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        new Expanded(
          // 收藏网站没有加载更多
            child: widget.notUserCenter ?  RefreshPage(requestApi: getCollectListData,
                renderItem: makeCollectCard,
                isCanRefresh: widget.notUserCenter,
                isNeedController: widget.notUserCenter,
            ):EasyRefresh(
              topBouncing: false,
              enableControlFinishLoad: true,
              enableControlFinishRefresh: true,
              controller: _controller,
              child: ListView.builder(
                padding: EdgeInsets.all(0.0),
                itemBuilder: (context, index) {
                  return makeCollectCard(index, list[index]);
                },
                itemCount: list.length,
              ),
              onLoad: () async{
                _controller.callLoad();
                getUserCollectListData(pageIndex);
              },
           )
        )
      ],
    );
  }
}

