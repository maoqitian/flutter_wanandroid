/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/28 0028
/// email: maoqitian068@163.com
/// des:  最新项目 page
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/components/refresh_page.dart' as listComp;
import 'package:flutter_wanandroid/components/refresh_page.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_list_data.dart';
import 'package:flutter_wanandroid/views/home/item/project_list_item.dart';

class LatestProjectPage extends StatefulWidget {

  int id;
  String type;

  LatestProjectPage({this.id,this.type});

  @override
  _LatestProjectPageState createState() => _LatestProjectPageState();
}

class _LatestProjectPageState extends State<LatestProjectPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  Widget makeProjectCard(index,item){
    return new ProjectListItem(articleData: item,isHomeShow: !(Constants.RESULT_CODE_LATEST_PROJECT_PAGE == widget.type));
  }

  //获取 最新项目 列表数据
  Future<Map> getProjectListData([Map<String, dynamic> params]) async {
    Map<String, dynamic> result;
    if(Constants.RESULT_CODE_LATEST_PROJECT_PAGE == widget.type){
      //显示 同类型项目信息
      var pageIndex = (params is Map) ? params['pageIndex'] : 0;
      await dataUtils.getKnowledgeArticleData(widget.id, pageIndex).then((ArticleListData articleListData){
        result = {"list":articleListData.datas, 'total':articleListData.pageCount, 'pageIndex':articleListData.curPage};
      },onError: (e){
        print("onError 发生错误");
        result = {"list":[], 'total':0, 'pageIndex':0};
      });
    }else{
      //最新项目
      var pageIndex = (params is Map) ? params['pageIndex'] : 0;
      await dataUtils.getLatestProjectData(pageIndex).then((ArticleListData articleListData){
        result = {"list":articleListData.datas, 'total':articleListData.pageCount, 'pageIndex':articleListData.curPage};
      },onError: (e){
        print("onError 发生错误");
        result = {"list":[], 'total':0, 'pageIndex':0};
      });
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: <Widget>[
        new Expanded(
            child: RefreshPage(requestApi: getProjectListData,
                               renderItem: makeProjectCard)
        )
      ],
    );
  }
}
