/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-01-28
/// email: maoqitian068@163.com
/// des:  用户分享 page 个人 或者用户

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/common/event/coin_user_Info_event.dart';
import 'package:flutter_wanandroid/common/event/share_article_event.dart';
import 'package:flutter_wanandroid/data/data_utils.dart';
import 'package:flutter_wanandroid/model/usershare/user_share_data.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/share/item/user_share_article_item.dart';


class UserSharePage extends StatefulWidget {

  final String type;
  final String authorId;

  UserSharePage({this.type , this.authorId});

  @override
  _UserSharePageState createState() => _UserSharePageState();
}

class _UserSharePageState extends State<UserSharePage> with AutomaticKeepAliveClientMixin{

  List list = [];
  var pageIndex =  1;

  bool isFirstLoad = false;

  @override
  bool get wantKeepAlive => true;

  EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();
    _controller = EasyRefreshController();
    getUserShareListData(pageIndex);
    //分享成功 删除分享 等监听刷新页面
    Application.eventBus.on<ShareArticleEvent>().listen((event){
      print("刷新 个人 或者用户page");
      //接收到 收藏事件操作 刷新列表
      pageIndex = 1;
      getUserShareListData(pageIndex);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return EasyRefresh(
      topBouncing: false,
      enableControlFinishLoad: true,
      enableControlFinishRefresh: true,
      controller: _controller,
      child: ListView.builder(
        padding: EdgeInsets.all(0.0),
        itemBuilder: (context, index) {
          return makeShareCard(index, list[index]);
        },
        itemCount: list.length,
      ),
      onLoad: () async{
        _controller.callLoad();
        getUserShareListData(pageIndex);
      },
    );
  }

  Widget makeShareCard(index,item){
    return UserShareArticleItem(articleData: item,isUserCenter: (Constants.USER_CENTER_PAGE_TYPE == widget.type));
  }

  void getUserShareListData(int pageIndex) async{
    if(pageIndex == 1){
      list.clear();
    }
    if(Constants.USER_CENTER_PAGE_TYPE == widget.type){
      //获取个人分享数据
      await dataUtils.getPrivateUserShareArticleData(pageIndex).then((UserShareData userShareData){
        if(this.mounted){
          handShareData(userShareData);
        }
      },onError: (e){
        ToolUtils.showToast(msg: "获取分享文章数据失败");
      });
    }else{
      //获取用户分享数据分享数据
      await dataUtils.getUserShareArticleData(int.parse(widget.authorId),pageIndex).then((UserShareData userShareData){
        if(this.mounted){
          handShareData(userShareData);
        }
      },onError: (e){
        ToolUtils.showToast(msg: "获取分享文章数据失败");
      });
    }
  }

  void handShareData(UserShareData userShareData) {
    setState(() {
      if(userShareData.shareArticles.datas.length!=0){
        list.addAll(userShareData.shareArticles.datas);
        pageIndex= userShareData.shareArticles.curPage+1;
        if(!isFirstLoad){
          Application.eventBus.fire(new CoinUserInfoEvent(userShareData.coinInfo));
          isFirstLoad = true;
        }
        _controller.finishLoad(success: true);
      }else{
        ToolUtils.showToast(msg: "哥，这回真没了！！");
        _controller.finishLoad(noMore: true);
      }
    });
  }
}
