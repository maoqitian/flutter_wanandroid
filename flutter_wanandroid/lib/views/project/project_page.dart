/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/10/31 0031
/// email: maoqitian068@163.com
/// des:  项目 widget
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/components/main_app_bar.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/knowledge/knowledge_hierarchy_data.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/drawer/drawer_page.dart';
import 'package:flutter_wanandroid/views/home/page/latest_project_page.dart';


class ProjectPage extends StatefulWidget {
  @override
  _ProjectPageState createState() => _ProjectPageState();
}

class _ProjectPageState extends State<ProjectPage> with SingleTickerProviderStateMixin{

  List <KnowledgeHierarchyData>_items=[];

  bool loadSuccess = true;

  @override
  void initState() {
    super.initState();
    print("project initState");
    loadProjectTreeData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //规避 没有获取 项目分类时 _items.length = 0 TabController 无法初始化的情况
    return (_items.length == 0)? Container(
      child: loadSuccess ? null :
      ToolUtils.getErrorWidget(context,
          onPressCallBack: (){
            loadProjectTreeData();
          })
    ):DefaultTabController(
      length: _items.length,
      child:  new Scaffold(
        appBar: buildAppBar(),
        body: TabBarView(
          children: _items.map((KnowledgeHierarchyData hierarchyData){
            return  LatestProjectPage(id: hierarchyData.id,type: Constants.RESULT_CODE_LATEST_PROJECT_PAGE);
          }).toList(),
        ),
        drawer: Drawer(
          child: DrawerPage(),
        ),
      ),
    );
  }
  Widget buildAppBar() {
    return MyAppBar(
      leading: Container(
        child: Icon(Icons.menu,color: Colors.white),
      ),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
            icon:  Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              ToolUtils.showToast(msg: '点击了搜索');
            })
      ],
      title: buildTabBar(),
    );
  }

  buildTabBar() {
    return TabBar(
      //构造Tab集合
      tabs: _items.map((KnowledgeHierarchyData hierarchyData){
        return Tab(
          text: ToolUtils.signToStr(hierarchyData.name),
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
      //若不需要自定义，可直接通过
      //indicatorColor 设置指示器颜色
      //indicatorWight 设置指示器厚度
      //indicatorSize  设置指示器大小计算方式
      //controller: _tabController,
      //构造Tab集合
    );

  }
  //获取项目分类
  void loadProjectTreeData() async{
    await dataUtils.getProjectClassifyData(context).then((List <KnowledgeHierarchyData> list){
      setState(() {
        _items.clear();
        _items.addAll(list);
        loadSuccess = true;
      });
    },onError: (e){
      setState(() {
        loadSuccess = false;
      });
      ToolUtils.showToast(msg:"获取项目分类错误" );
    });
  }
}
