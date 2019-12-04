/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/28 0028
/// email: maoqitian068@163.com
/// des:  最新项目 page
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/refresh_page.dart' as listComp;
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_list_data.dart';
import 'package:flutter_wanandroid/views/home/item/project_list_item.dart';

class LatestProjectPage extends StatefulWidget {

  @override
  _LatestProjectPageState createState() => _LatestProjectPageState();
}

class _LatestProjectPageState extends State<LatestProjectPage> {



  @override
  void initState() {
    super.initState();
  }

  Widget makeProjectCard(index,item){

    return new ProjectListItem(articleData: item,isHomeShow: true);
  }

  //获取 最新项目 列表数据
  Future<Map> getLatestProjectListData([Map<String, dynamic> params]) async {
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    Map<String, dynamic> result;
    await dataUtils.getLatestProjectData(pageIndex).then((ArticleListData articleListData){
      result = {"list":articleListData.datas, 'total':articleListData.pageCount, 'pageIndex':articleListData.curPage};
    },onError: (e){
      print("onError 发生错误");
      result = {"list":[], 'total':0, 'pageIndex':0};
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new Expanded(
            child: listComp.RefreshPage(getLatestProjectListData,makeProjectCard,null,false)
        )
      ],
    );
  }
}
