/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/2/18 0018
/// email: maoqitian068@163.com
/// des:  问答页面
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/refresh_page.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_list_data.dart';
import 'package:flutter_wanandroid/views/home/item/list_view_item.dart';


class QuestionAnswerPage extends StatefulWidget {
  @override
  _QuestionAnswerPageState createState() => _QuestionAnswerPageState();
}

class _QuestionAnswerPageState extends State<QuestionAnswerPage> {

  Widget makeCard(index,item){

    return new ListViewItem(articleData: item,isHomeShow: false,isClickUser: false);
  }

  //获取问答数据
  Future<Map> getQuestionListData([Map<String, dynamic> params]) async {
    var pageIndex = (params is Map) ? params['pageIndex'] : 1;
    Map<String, dynamic> result;
      //正常列表数据 加载更多
      await dataUtils.getQuestionListData(pageIndex).then((ArticleListData articleListData){
        pageIndex = articleListData.curPage+1;
        result = {"list":articleListData.datas, 'total':articleListData.pageCount, 'pageIndex':pageIndex};
      },onError: (e){
        result = {"list":[], 'total':0, 'pageIndex':0};
      });
      return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop(this);
            }),
        title: Text("问答",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: RefreshPage(requestApi: getQuestionListData, renderItem: makeCard,startIndex: 1),
    );
  }
}
