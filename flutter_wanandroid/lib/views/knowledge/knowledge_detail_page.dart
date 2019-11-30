/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-11-30
/// email: maoqitian068@163.com
/// des:  知识体系详情 文章列表打开  知识体系模块打开

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/model/knowledge/knowledgehierarchydata.dart';
import 'package:flutter_wanandroid/views/knowledge/knowledge_view.dart';


List <KnowledgeHierarchyData>_items=[];
TabController _tabController;

class KnowledegDetailPage extends StatefulWidget {


  KnowledegDetailPage();

  @override
  _KnowledegDetailPageState createState() => _KnowledegDetailPageState();
}

class _KnowledegDetailPageState extends State<KnowledegDetailPage> with SingleTickerProviderStateMixin{

  //用于控制/监听Tab菜单切换
  //TabBar和TabBarView正是通过同一个controller来实现菜单切换和滑动状态同步的。


  @override
  void initState() {
    super.initState();
    _tabController = new TabController(length: _items.length,vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){
              Navigator.of(context).pop(this);
            }),
        title: Text("知识体系"),
        centerTitle: true,
        //设置title 形式嵌入 tabbar 也可以 通过“bottom”属性在AppBar下方来添加一个导航栏底部tab按钮组
        bottom: buildTabBar(),
      ),
      body: KnowledgeTabBarViewLayout(),
    );
  }


  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  buildTabBar() {

  }

}


// TabBarView Widget
class KnowledgeTabBarViewLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("TabBarViewLayout build.......");
    return TabBarView(
      controller: _tabController,
      children: _items.map((KnowledgeHierarchyData hierarchyData){
        return KnowledgeView();
      }).toList(),
    );
  }
}
