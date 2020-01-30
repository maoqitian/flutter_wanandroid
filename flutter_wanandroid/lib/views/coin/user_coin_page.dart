/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-01-29
/// email: maoqitian068@163.com
/// des:  我的积分 page

import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/coin/coin_sign_in_list_data.dart';
import 'package:flutter_wanandroid/model/coin/coin_user_info.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/coin/item/user_coin_record_item.dart';

import 'header/circle_header.dart';


class UserCoinPage extends StatefulWidget {
  @override
  _UserCoinPageState createState() => _UserCoinPageState();
}

class _UserCoinPageState extends State<UserCoinPage> {

  // 连接通知器
  LinkHeaderNotifier _headerNotifier;

  List list = [];
  var pageIndex =  1;

  int coin =0;

  @override
  void initState() {
    super.initState();
    _headerNotifier = LinkHeaderNotifier();
    getInfo(pageIndex);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: EasyRefresh.custom(
        header: LinkHeader(
          _headerNotifier,
          extent: 70.0,
          triggerDistance: 70.0,
          completeDuration: Duration(milliseconds: 500),
        ),
        slivers: <Widget>[
          SliverAppBar(
            iconTheme: IconThemeData(color: Colors.white), //设置 icon 颜色
            expandedHeight: 180.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,
              title: Text("我的积分: "+coin.toString(),
                  style:TextStyle(color: Colors.white,
                  fontWeight: FontWeight.bold )),
            ),
            actions: <Widget>[
              CircleHeader(
                _headerNotifier,
              ),
            ],
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                return UserCoinRecordItem(coinSignInData: list[index]);
              },
              childCount: list.length,
            ),
          ),
        ],
        onRefresh: () async {
          await getInfo(1);
        },
        onLoad: () async {
          await getInfo(pageIndex);
        },
      ),
    );
  }


  getInfo(int pageNum) async{
    if(pageNum == 1){
      list.clear();
      pageIndex = pageNum;
      //组合获取数据 积分 积分记录
      await Future.wait([dataUtils.getCoinUserInfo(),dataUtils.getCoinSignListData(pageNum)]).then((List datas){
        CoinUserInfo coinUserInfo = datas[0];
        CoinSignInListData coinSignInListData = datas[1];
        if(this.mounted){
          setState(() {
            coin = coinUserInfo.coinCount;
            if(coinSignInListData.datas.length!=0){
              pageIndex = coinSignInListData.curPage+1;
              list.addAll(coinSignInListData.datas);
            }else{
              ToolUtils.showToast(msg: "哥，这回真没了！！");
            }
          });
        }
      },onError: (e){
        ToolUtils.showToast(msg:"获取数据错误");
      });
    }else{
      //积分记录 加载更多
      await dataUtils.getCoinSignListData(pageNum).then((CoinSignInListData coinSignInListData){
        if(this.mounted){
          setState(() {
            if(coinSignInListData.datas.length!=0){
              pageIndex = coinSignInListData.curPage+1;
              list.addAll(coinSignInListData.datas);
            }else{
              ToolUtils.showToast(msg: "哥，这回真没了！！");
            }
          });
        }
      },onError: (e){
        ToolUtils.showToast(msg:"获取数据发生错误");
      });
    }
  }

}
