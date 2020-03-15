/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-02-03
/// email: maoqitian068@163.com
/// des:  搜索页面

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/MyIcons.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/components/refresh/refresh_page.dart';
import 'package:flutter_wanandroid/components/search/search_bar.dart';
import 'package:flutter_wanandroid/components/tag/tag_item_view.dart';
import 'package:flutter_wanandroid/data/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_list_data.dart';
import 'package:flutter_wanandroid/model/hotkey/hot_key_data.dart';
import 'package:flutter_wanandroid/model/route_page_data.dart';
import 'package:flutter_wanandroid/model/search/search_history.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/home/item/list_view_item.dart';

class SearchPage extends StatefulWidget {
  final String routePageData;

  SearchPage({this.routePageData});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  //页面跳转传递数据
  RoutePageData routePageData;

  SearchBar searchBar;
  //是否展示结果
  bool isResult = false;
  //搜索关键字
  String key = "";
  //搜索热词
  List<HotKeyData> hotList = [];

  bool _expend = true;

  //处理 键盘开启与关闭
  FocusNode searchFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    routePageData =
        RoutePageData.fromJson(ToolUtils.string2map(widget.routePageData));
    searchBar = new SearchBar(
        inBar: true,
        buildDefaultAppBar: buildAppBar,
        setState: this.setState,
        onSubmitted: onSubmitted,
        searchFocus: searchFocus,
        hintText:
            isWeChatSearch() ? "搜索" + routePageData.title + "公众号历史文章" : "搜索关键词",
        onClear: () {
          //清空搜索输入回调
          if (this.mounted) {
            if (isResult) {
              setState(() {
                isResult = false;
              });
            }
          }
        },
        onClosed: () {
          //页面关闭回调
          if (this.mounted) {
            if (isResult) {
              //获取键盘焦点
              FocusScope.of(context).requestFocus(searchFocus);
              setState(() {
                isResult = false;
              });
            } else {
              //退出搜索页面
              Navigator.maybePop(context);
            }
          }
        });
    getHotKeyListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: searchBar.buildSearchBar(context),
      body:  Container(
          child: isResult ? buildSearchResult() : SingleChildScrollView(child:buildHistoryAndHotKey())),
    );
  }

  //构建搜索框 appbar
  AppBar buildAppBar(BuildContext context) {
    return new AppBar(actions: [searchBar.getSearchAction(context)]);
  }

  //确认搜索文字
  void onSubmitted(String value) {
    print("onSubmitted" + value);
    if (ToolUtils.isNullOrEmpty(value)) {
      ToolUtils.showToast(msg: "请输入搜索关键字");
      return;
    }
    key = value;
    searchBar.controller.text = value;
    dataUtils.addSearchHistory(SearchHistory(name: value));
    gotoSearch();
  }

  //搜索历史 搜索热词
  buildHistoryAndHotKey() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: buildHistoryAndHotKeyPageList());
  }

  List<Widget> buildHistoryAndHotKeyPageList() {
    List<Widget> widgetList = [];
    if (hotList.length > 0) {
      widgetList.add(buildTagItem(
          hotList.map((HotKeyData hotKeyData) {
            return buildTagView(hotKeyData.name);
          }).toList(),
          isPanel: true,
          title: "大家都在搜"));
    } else {
      widgetList.add(Container());
    }

    if (dataUtils.getSearchHistoryListData().length > 0) {
      widgetList.add(Padding(
          child: Text(
            "搜索历史",
            style: TextStyle(color: Colors.black),
          ),
          padding: EdgeInsets.only(left: 15, top: 20, bottom: 3)));
      widgetList.add(Padding(
        child: buildTagItem(
            dataUtils
                .getSearchHistoryListData()
                .map((SearchHistory searchHistory) {
              return buildTagView(searchHistory.name);
            }).toList(),
            isPanel: false),
        padding: EdgeInsets.all(15.0),
      ));
      widgetList.add(SizedBox(height: 6));
      widgetList.add(GestureDetector(
          onTap: () {
            ToolUtils.showAlertDialog(context, "确认清除全部历史记录吗？",
                confirmText: "确认", confirmCallback: () {
              dataUtils.clearSearchHistoryListData();
              if (this.mounted) {
                setState(() {});
              }
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(MyIcons.delete, size: 20.0),
              SizedBox(width: 10),
              Text("清空搜索历史")
            ],
          )));
    }

    return widgetList;
  }

  //搜索结果
  buildSearchResult() {
    return RefreshPage(
        requestApi: isWeChatSearch()
            ? getSearchResultWechatListData
            : getSearchResultListData,
        renderItem: makeCard,
        startIndex: isWeChatSearch() ? 1 : 0,
        isCanRefresh: false);
  }

  //  ListViewItem
  Widget makeCard(index, item) {
    return ListViewItem(articleData: item, isHomeShow: false);
  }

  Widget buildTagItem(List<Widget> widgetList, {String title, bool isPanel}) {
    return isPanel
        ? ExpansionPanelList(
            animationDuration: kThemeAnimationDuration,
            expansionCallback: (panelIndex, isExpanded) {
              setState(() {
                _expend = !isExpanded;
              });
            },
            children: <ExpansionPanel>[
                ExpansionPanel(
                    //折叠布局
                    canTapOnHeader: true, //点击标题是否展开关闭
                    isExpanded: _expend,
                    headerBuilder: (context, isExpanded) {
                      return ListTile(
                        title: Text(title),
                      );
                    },
                    body: Wrap(
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
                        children: widgetList))
              ])
        : Wrap(
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
            children: widgetList);
  }

  Widget buildTagView(String text) {
    return TagItemView(
      textTitle: text,
      textColor: Colors.white,
      backgroundColor: ToolUtils.getRandomColor(),
      isShape: true,
      pressCallback: () {
        //print("pressCallback"+text);
        key = text;
        searchBar.controller.text = text;
        dataUtils.addSearchHistory(new SearchHistory(name: text));
        //关闭键盘
        //FocusScope.of(context).requestFocus(FocusNode());
        searchFocus.unfocus();
        gotoSearch();
      },
    );
  }

  //搜索热词
  void getHotKeyListData() async {
    await dataUtils.getHotKeyListData().then((List<HotKeyData> list) {
      if (this.mounted) {
        setState(() {
          hotList.clear();
          hotList.addAll(list);
        });
      }
    }, onError: (e) {
      ToolUtils.showToast(msg: "获取搜索热词数据失败");
    });
  }

  //搜索结果
  Future<Map> getSearchResultListData([Map<String, dynamic> params]) async {
    Map<String, dynamic> result;
    //最新项目
    var pageIndex = (params is Map) ? params['pageIndex'] : 0;
    await dataUtils.getSearchListData(pageIndex, key).then(
        (ArticleListData articleListData) {
      if (articleListData.datas.length == 0) {
        ToolUtils.showToast(msg: "没有找到相关文章");
      }
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

  //搜索公众号历史结果
  Future<Map> getSearchResultWechatListData(
      [Map<String, dynamic> params]) async {
    Map<String, dynamic> result;
    //最新项目
    var pageIndex = (params is Map) ? params['pageIndex'] : 1;
    await dataUtils
        .getSearchWXArticleData(key, routePageData.id, pageIndex)
        .then((ArticleListData articleListData) {
      if (articleListData.datas.length == 0) {
        ToolUtils.showToast(msg: "没有找到相关文章");
      }
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

  //执行搜索
  void gotoSearch() {
    if (this.mounted) {
      setState(() {
        isResult = true;
      });
    }
    getSearchResultListData();
  }

  //是否为公众号搜索
  bool isWeChatSearch() {
    return Constants.WECHAT_SEARCH_PAGE_TYPE == routePageData.type;
  }
}
