/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/20 0020
/// email: maoqitian068@163.com
/// des:  用户中心 CustomScrollView 实现滑动隐藏效果
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_wanandroid/common/Page.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/user/delegate/sticky_tabBar_delegate.dart';
import 'package:flutter_wanandroid/widget/stroke_widget.dart';

TabController _tabController;

class UserCenterPage extends StatefulWidget {
  @override
  _UserCenterPageState createState() => _UserCenterPageState();
}

class _UserCenterPageState extends State<UserCenterPage> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: Constants.userPages.length,vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
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
    );
  }

  Widget buildTabView(BuildContext context, Page page) {
    int labelIndex = page.labelIndex;
    switch(labelIndex){
      case 1:
      //最新博文
        return Container(
          child: new Center(
            child: new Text(page.labelId+"Page"),
          ),
        );
        break;
      case 2:
      //最新项目
        return Container(
          child: new Center(
            child: new Text(page.labelId+"Page"),
          ),
        );
        break;
      default:
        return  Container(
          child: new Center(
            child: new Text("暂未实现 Page"),
          ),
        );
        break;
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
                  childWidget: Text( "lv 666", style: TextStyle(fontSize: 11.0, color: Colors.white, fontWeight: FontWeight.bold))
              ),
              padding: EdgeInsets.only(right: 10.0),
            ),
            Text(
               "积分：66666",
              style: TextStyle(color: Colors.white,fontSize: 15.0),
            )

          ],
        );
      //],
    //);
  }

  //页面刷新
  Future<Null> _pageRefresh() async{
    print("下拉刷新 ");

    return null;
  }
}
//构造 TabBar
buildTabBar(BuildContext context) {
  return new TabBar(
    //构造Tab集合
    tabs: Constants.userPages.map((Page page ){
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