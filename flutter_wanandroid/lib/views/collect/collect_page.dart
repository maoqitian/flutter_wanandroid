/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/23 0023
/// email: maoqitian068@163.com
/// des:  收藏 页面 展示收藏数据 收藏文章 收藏网站  发布文章
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/Page.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/common/event/collect_event.dart';
import 'package:flutter_wanandroid/components/dialog/simple_input_dialog_layout.dart';
import 'package:flutter_wanandroid/data/data_utils.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/collect/page/collect_item_page.dart';
import 'package:flutter_wanandroid/views/collect/page/collect_web_item_page.dart';


TabController _tabController;
class CollectPage extends StatefulWidget {

  @override
  _CollectPageState createState() => _CollectPageState();
}

class _CollectPageState extends State<CollectPage> with SingleTickerProviderStateMixin {

  //是否为收藏文章
  bool collectType = true;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: Constants.collectPages.length,vsync: this);
    _tabController.addListener((){
      //监听当前tabController 索引
      var index =  _tabController.index;
      print("当前索引"+index.toString());
      switch(index){
        case 0:
          setState(() {
            collectType = true;
          });
          break;
        case 1:
          setState(() {
            collectType = false;
          });
          break;
      }
    });
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
      floatingActionButton: FloatingActionButton(
          onPressed: _inAddCollect,
        tooltip: 'Increment',
        backgroundColor: Theme.of(context).primaryColor,
        child: Icon(Icons.add)),
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
      isScrollable: true,
      //设置tab选中得颜色
      labelColor: Colors.white,
      //设置tab未选中得颜色
      unselectedLabelColor: Colors.white54,
      indicatorColor: Colors.white,
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
           return CollectItemPage(true);
           break;
         case 2:
           //收藏网站
           return CollectWebItemPage(true);
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


  void _inAddCollect() {
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return SimpleInputDialogLayout(
              isCollectArticle: collectType,
              confirmCallback1: (collectTitle,collectAuthor,collectUrl) async{
                //收藏文章
                await dataUtils.getCollectOutsideArticle(collectTitle, collectAuthor, collectUrl,context);
                ToolUtils.showToast(msg: "收藏文章成功");
                Application.eventBus.fire(new CollectEvent());
              },confirmCallback2: (collectTitle,collectUrl)async{
                //收藏网站
                await dataUtils.getCollectWebData(collectTitle, collectUrl, context);
                ToolUtils.showToast(msg: "收藏网站成功");
                Application.eventBus.fire(new CollectEvent());
              },
          );
        }
    );
  }
}

