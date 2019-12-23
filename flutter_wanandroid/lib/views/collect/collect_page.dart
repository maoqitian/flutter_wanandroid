/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des:  收藏 页面 展示收藏数据 收藏文章 收藏网站  发布文章
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/Page.dart';
import 'package:flutter_wanandroid/common/constants.dart';


TabController _tabController;
class CollectPage extends StatefulWidget {

  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: Constants.collectPages.length,vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: pushBack),
        title: Text("我的收藏",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        bottom: buildTabBar(context),
      ),
      body: TabBarView(
        controller: _tabController,
        children: Constants.collectPages.map((Page page){
          return buildTabView(context, page);
        }).toList(),
      ),
    );
  }

  buildTabBar(BuildContext context) {
    return new TabBar(
      //构造Tab集合
      tabs: Constants.collectPages.map((Page page ){
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
      controller: _tabController,
      //构造Tab集合
    );
  }

  pushBack() {
    Navigator.of(context).pop(this);
  }

  Widget buildTabView(BuildContext context, Page page) {
       int labelIndex = page.labelIndex;
       switch(labelIndex){
         case 1:
           //收藏文章
           
           break;
         case 2:
           //收藏网站

           break;
       }
  }
}

