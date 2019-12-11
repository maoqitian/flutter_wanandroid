/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/10/31 0031
/// email: maoqitian068@163.com
/// des:  项目 widget
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/knowledge/knowledge_hierarchy_data.dart';
import 'package:flutter_wanandroid/views/home/page/latest_project_page.dart';

List <KnowledgeHierarchyData>_items=[];
TabController  _tabController;

class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with SingleTickerProviderStateMixin{


  @override
  void initState() async {
    super.initState();
    List<KnowledgeHierarchyData> list= await dataUtils.getProjectClassifyData(context);
    _items.addAll(list);
    _tabController = new TabController(length: _items.length,vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: _items.map((KnowledgeHierarchyData hierarchyData){
          return  LatestProjectPage(id: hierarchyData.id,type: Constants.RESULT_CODE_LATEST_PROJECT_PAGE);
        }).toList(),
      ),
    );

  }

  Widget buildAppBar() {
    return AppBar(
      //嵌入 appbar
      title: buildTabBar(),
    );
  }

  buildTabBar() {
    return TabBar(
      //构造Tab集合
      tabs: _items.map((KnowledgeHierarchyData hierarchyData){
        return Tab(
          text: hierarchyData.name,
        );
      }).toList(),
      //tabs 的长度超出屏幕宽度后，TabBar，是否可滚动
      //设置为false tab 将平分宽度，为true tab 将会自适应宽度
      isScrollable: true,
      //设置tab文字得类型
      labelStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
      labelPadding: EdgeInsets.only(top: 12.0, left: 12.0, right: 12.0),
      ///指示器大小计算方式，TabBarIndicatorSize.label跟文字等宽,TabBarIndicatorSize.tab跟每个tab等宽
      indicatorSize: TabBarIndicatorSize.label,
      //设置tab选中得颜色
      labelColor: Colors.white,
      //设置tab未选中得颜色
      unselectedLabelColor: Colors.white54,
      indicatorColor: Colors.white,
      //indicator: (isKnowledgeCome()) ? const BoxDecoration():null, //如果是首页进入 取消下划线，伪装成 app bar title
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
