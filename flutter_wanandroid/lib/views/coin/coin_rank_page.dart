/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-01-29
/// email: maoqitian068@163.com
/// des:  积分排行榜 page

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/refresh/refresh_page.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/coin/rank_list_data.dart';
import 'package:flutter_wanandroid/views/coin/item/coin_rank_item.dart';


class CoinRankPage extends StatefulWidget {
  @override
  _CoinRankPageState createState() => _CoinRankPageState();
}

class _CoinRankPageState extends State<CoinRankPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){
              Navigator.of(context).pop(this);
            }),
        title: Text("积分排行榜",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
      ),
      body: buildCoinRankPage(),
    );
  }


  Widget makeRankCard(index,item){
    return CoinRankItem(coinUserInfo: item);
  }

  Future<Map> getCoinRankListData([Map<String, dynamic> params]) async {
    //收藏文章
    var pageIndex = (params is Map) ? params['pageIndex'] : 1;
    Map<String, dynamic> result;
    //收藏网站数据
    await dataUtils.getCoinRankListData(pageIndex).then((RankListData rankListData){
      pageIndex = rankListData.curPage+1;
      result = {"list":rankListData.datas, 'total':rankListData.pageCount, 'pageIndex':pageIndex};
    },onError: (e){
      print("onError 发生错误");
      result = {"list":[], 'total':0, 'pageIndex':0};
    });
    return result;
  }


  buildCoinRankPage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: RefreshPage(
            requestApi: getCoinRankListData, renderItem: makeRankCard,startIndex: 1,
          ),
        )
      ],
    );
  }
}
