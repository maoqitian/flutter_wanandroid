/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/20 0020
/// email: maoqitian068@163.com
/// des:  用户中心 CustomScrollView 实现滑动隐藏效果
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_wanandroid/common/Page.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/common/event/coin_user_Info_event.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/collect/page/collect_item_page.dart';
import 'package:flutter_wanandroid/views/collect/page/collect_web_item_page.dart';
import 'package:flutter_wanandroid/views/share/page/user_share_page.dart';
import 'package:flutter_wanandroid/views/user/delegate/sticky_tabBar_delegate.dart';
import 'package:flutter_wanandroid/widget/stroke_widget.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart'
    as extended;

TabController _tabController;

class UserCenterPage extends StatefulWidget {
  final String type;
  final String authorId;
  final String authorName;

  UserCenterPage(
      {this.type = Constants.USER_CENTER_PAGE_TYPE,
      this.authorId,
      this.authorName});

  @override
  _UserCenterPageState createState() => _UserCenterPageState();
}

class _UserCenterPageState extends State<UserCenterPage>
    with SingleTickerProviderStateMixin {
  // 滚动控制器
  ScrollController _scrollController;

  //积分 等级
  int coin = 0;
  int level = 0;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(
        length: Constants.USER_CENTER_PAGE_TYPE == widget.type
            ? Constants.userPages.length
            : Constants.userSharePages.length,
        vsync: this);
    _scrollController = ScrollController();

    Application.eventBus.on<CoinUserInfoEvent>().listen((event) {
      print("刷新 个人 或者用户等级信息");
      //event.coinUserInfo.rank;
      if (this.mounted) {
        setState(() {
          coin = event.coinUserInfo.coinCount;
          level = event.coinUserInfo.level;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return /*Material(
      child: RefreshIndicator(
        child: CustomScrollView(
          slivers: <Widget>[
            //AppBar，包含一个导航栏
            SliverAppBar(
              iconTheme: IconThemeData(color: Colors.white), //设置 icon 颜色
              pinned: true,
              expandedHeight: 150.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text(dataUtils.getUserName(),style:TextStyle(color: Colors.white,
                    fontWeight: FontWeight.bold )),
                background: Image.asset(
                    ToolUtils.getImage("ic_zone_background",format: "webp"), fit: BoxFit.cover),
              ),
              //bottom: buildUserIconAndNickName(),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                  color: Colors.white,
                  child: buildTabBar(context)
              ),
            ),

            SliverFillRemaining(
              child: TabBarView(
                controller: _tabController,
                children: Constants.userPages.map((Page page){
                  return buildTabView(context, page);
                }).toList(),
              ),
            )

          ],
        ),
        onRefresh: _pageRefresh,
        color: ToolUtils.getPrimaryColor(context), //指示器颜色
      )
    );*/
        Scaffold(
      body: extended.NestedScrollView(
        //使用扩展 extended.NestedScrollView 处理 联动问题
        innerScrollPositionKeyBuilder: () {
          return Key(getKey(_tabController.index));
        },
        headerSliverBuilder: (context, bool) {
          return [
            SliverAppBar(
                iconTheme: IconThemeData(color: Colors.white), //设置 icon 颜色
                pinned: true,
                expandedHeight: 150.0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Container(
                    child: Row(
                      children: <Widget>[
                        Text(
                            Constants.USER_CENTER_PAGE_TYPE == widget.type
                                ? dataUtils.getUserName()
                                : widget.authorName,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                        Padding(
                          child: StrokeWidget(
                              strokeWidth: 2,
                              edgeInsets: EdgeInsets.symmetric(
                                  horizontal: 2.0, vertical: 0.0),
                              color: Colors.white,
                              childWidget: Text("lv " + level.toString(),
                                  style: TextStyle(
                                      fontSize: 11.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))),
                          padding: EdgeInsets.only(left: 10.0),
                        ),
                        Expanded(
                          child: Padding(
                            child: Text("积分：" + coin.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                                maxLines: 1, // title 只显示一行
                                overflow: TextOverflow.ellipsis),
                            padding: EdgeInsets.only(left: 10.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  background: Image.asset(
                      ToolUtils.getImage("ic_zone_background", format: "webp"),
                      fit: BoxFit.cover),
                )),
            SliverPersistentHeader(
              pinned: true,
              delegate: StickyTabBarDelegate(
                  color: Colors.white, child: buildTabBar(context)),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: Constants.USER_CENTER_PAGE_TYPE == widget.type
              ? Constants.userPages.map((Page page) {
                  return buildTabView(context, page);
                }).toList()
              : Constants.userSharePages.map((Page page) {
                  return buildTabView(context, page);
                }).toList(),
        ),
      ),
    );
  }

  Widget buildTabView(BuildContext context, Page page) {
    int labelIndex = page.labelIndex;
    switch (labelIndex) {
      case 1:
        //收藏文章
        return extended.NestedScrollViewInnerScrollPositionKeyWidget(
            //使用扩展 extended.NestedScrollView 处理 联动问题
            Key(getKey(labelIndex)),
            CollectItemPage(false));
        break;
      case 0:
        //分享文章
        return extended.NestedScrollViewInnerScrollPositionKeyWidget(
            //使用扩展 extended.NestedScrollView 处理 联动问题
            Key(getKey(labelIndex)),
            UserSharePage(type: widget.type, authorId: widget.authorId));
        break;
      case 2:
        //收藏网站
        return CollectWebItemPage(false);
        break;
      default:
        return Container(
          child: new Center(
            child: new Text("暂未实现 Page"),
          ),
        );
        break;
    }
  }

  String getKey(int index) {
    if (Constants.USER_CENTER_PAGE_TYPE == widget.type) {
      return Constants.userPages[index].labelId + index.toString();
    } else {
      return Constants.userSharePages[index].labelId + index.toString();
    }
  }

  buildUserIconAndNickName() {
    return /*Column(
      children: <Widget>[
        CircleAvatar(
          backgroundColor: Colors.white,//显示头像
          backgroundImage: AssetImage(ToolUtils.getImage("ic_default_avatar",format: "webp")),
        ),
        Text(dataUtils.getUserName(),
            style:TextStyle(color: Colors.white,
                fontWeight: FontWeight.bold )),*/
        Row(
      children: <Widget>[
        Padding(
          child: StrokeWidget(
              strokeWidth: 2,
              edgeInsets: EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
              color: Colors.white,
              childWidget: Text("lv 666",
                  style: TextStyle(
                      fontSize: 11.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold))),
          padding: EdgeInsets.only(right: 10.0),
        ),
        Text(
          "积分：66666",
          style: TextStyle(color: Colors.white, fontSize: 15.0),
        )
      ],
    );
    //],
    //);
  }

  //页面刷新
  Future<Null> _pageRefresh() async {
    print("下拉刷新 ");

    return null;
  }

  //构造 TabBar
  buildTabBar(BuildContext context) {
    return new TabBar(
      //构造Tab集合
      tabs: Constants.USER_CENTER_PAGE_TYPE == widget.type
          ? Constants.userPages.map((Page page) {
              return Tab(
                text: page.labelId,
              );
            }).toList()
          : Constants.userSharePages.map((Page page) {
              return Tab(
                text: page.labelId,
              );
            }).toList(),
      //设置tab文字得类型
      labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      labelPadding: EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),

      ///指示器大小计算方式，TabBarIndicatorSize.label跟文字等宽,TabBarIndicatorSize.tab跟每个tab等宽
      indicatorSize: TabBarIndicatorSize.label,
      //设置tab选中得颜色
      labelColor: Theme.of(context).primaryColor,
      //设置tab未选中得颜色
      unselectedLabelColor: Colors.grey,
      indicatorColor: Theme.of(context).primaryColor,
      //设置自定义tab的指示器，CustomUnderlineTabIndicator
      //若不需要自定义，可直接通过
      //indicatorColor 设置指示器颜色
      //indicatorWight 设置指示器厚度
      //indicatorPadding
      //indicatorSize  设置指示器大小计算方式
      controller: _tabController,
      //构造Tab集合
    );
  }
}
