/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-02-03
/// email: maoqitian068@163.com
/// des:  搜索页面

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/refresh_page.dart';
import 'package:flutter_wanandroid/components/search_bar.dart';
import 'package:flutter_wanandroid/components/tag_item_view.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_list_data.dart';
import 'package:flutter_wanandroid/model/hotkey/hot_key_data.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/home/item/list_view_item.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchBar searchBar;
  //是否展示结果
  bool isResult = false;
  String key;

  List<HotKeyData> hotList = [];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBar buildAppBar(BuildContext context) {
    return new AppBar(actions: [searchBar.getSearchAction(context)]);
  }

  //确认搜索文字
  void onSubmitted(String value) {
    print(value);
    key = value;
    gotoSearch();
  }

  @override
  void initState() {
    super.initState();
    searchBar = new SearchBar(
        inBar: true,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onClosed: () {
          print("closed");
        });
    getHotKeyListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.buildSearchBar(context),
      body: Container(
          child: isResult ? buildSearchResult() : buildHistoryAndHotKey()),
    );
  }

  //搜索历史 搜索热词
  buildHistoryAndHotKey() {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("搜索历史"),
          SizedBox(
            height: 10,
          ),
          buildHistory(),
          Text("大家都在搜"),
          buildHotKey(),
        ],
      ),
    );
  }

  //搜索结果
  buildSearchResult() {
    return RefreshPage(
        requestApi: getSearchResultListData,
        renderItem: makeCard,
        isCanRefresh: false);
  }

  //  ListViewItem
  Widget makeCard(index, item) {
    return ListViewItem(articleData: item, isHomeShow: false);
  }

  //获取 最新项目 列表数据
  Future<Map> getSearchResultListData([Map<String, dynamic> params]) async {
    Map<String, dynamic> result;
    //最新项目
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    await dataUtils.getSearchListData(pageIndex, key).then(
        (ArticleListData articleListData) {
      result = {
        "list": articleListData.datas,
        'total': articleListData.pageCount,
        'pageIndex': articleListData.curPage
      };
    }, onError: (e) {
      print("onError 发生错误");
      result = {"list": [], 'total': 0, 'pageIndex': 0};
    });
    return result;
  }

  //搜索历史 数据库
  buildHistory() {
    return Container();
  }

  //搜索热词
  buildHotKey() {
    return hotList.length > 0 ? buildTagItem(hotList) : Container();
  }

  buildTagItem(List<HotKeyData> list) {
    /*List<Widget> tiles = [];
    list.map(f)
    for (var item in list) {
      tiles.add(TagItemView(textTitle: item.name));
    }*/
    return Wrap(
      spacing: 3, //主轴上子控件的间距
      runSpacing: 3, //交叉轴上子控件之间的间距
      // 扩展方式，横向堆砌
      direction: Axis.horizontal,
      // 对齐方式
      alignment: WrapAlignment.start,
      // run的对齐方式 开始位置
      runAlignment: WrapAlignment.start,
      // 交叉轴对齐方式
      crossAxisAlignment: WrapCrossAlignment.end,
      // 文本对齐方向
      textDirection: TextDirection.ltr,
      // 确定垂直放置子元素的顺序，以及如何在垂直方向上解释开始和结束。 默认down
      verticalDirection: VerticalDirection.down,
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      //mainAxisSize: MainAxisSize.max,//表示尽可能多的占用水平方向的空间，此时无论子widgets实际占用多少水平空间，Row的宽度始终等于水平方向的最大宽度
      children: list.map((HotKeyData hotKeyData) {
        return TagItemView(
            textTitle: hotKeyData.name,
            textColor: Colors.white,
            backgroundColor: ToolUtils.getRandomColor(),
            isChip: true,
            pressCallback: (){
             key = hotKeyData.name;
             gotoSearch();

        },
        );
      }).toList(),
    );
  }

  void getHotKeyListData() async {
    await dataUtils.getHotKeyListData().then((List<HotKeyData> list) {
      if (this.mounted) {
        setState(() {
          hotList.addAll(list);
        });
      }
    }, onError: (e) {
      ToolUtils.showToast(msg: "获取搜索热词数据失败");
    });
  }

  //执行搜索
  void gotoSearch() {
    if (this.mounted) {
      setState(() {
        isResult = true;
      });
    }
    getSearchResultListData();
  }
}
