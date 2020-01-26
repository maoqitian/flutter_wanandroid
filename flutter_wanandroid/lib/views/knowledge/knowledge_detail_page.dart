import 'dart:math';

/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-11-30
/// email: maoqitian068@163.com
/// des:  知识体系详情 文章列表打开  最新项目查看同类型项目 知识体系模块打开

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:flutter_wanandroid/model/knowledge/knowledge_hierarchy_data.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/home/page/latest_project_page.dart';
import 'package:flutter_wanandroid/views/knowledge/knowledge_view.dart';

List <KnowledgeHierarchyData>_items=[];
TabController   _tabController;

class KnowledegDetailPage extends StatefulWidget {

  String type; //页面跳转类型 首页跳转 还是知识体系跳转
  String author;//作者名称
  final String articleJson;
  final String knowledgeJson;

  KnowledegDetailPage({this.type,this.author,this.articleJson,this.knowledgeJson});

  @override
  _KnowledegDetailPageState createState() => _KnowledegDetailPageState();
}

class _KnowledegDetailPageState extends State<KnowledegDetailPage> with SingleTickerProviderStateMixin{

  //用于控制/监听Tab菜单切换
  //TabBar和TabBarView正是通过同一个controller来实现菜单切换和滑动状态同步的。

  ArticleData articleData;
  KnowledgeHierarchyData knowledgeHierarchyData;
  String _title;
  @override
  void initState() {
    _items.clear();
    super.initState();
    if(Constants.RESULT_CODE_HOME_PAGE == widget.type){
      //首页最新博文进入
      articleData= ArticleData.fromJson(ToolUtils.string2map(widget.articleJson));
      _title = articleData.superChapterName;
      _items.add(new KnowledgeHierarchyData(articleData.courseId,articleData.superChapterId,articleData.chapterName,0,0,false,1,null));
    }else if(Constants.RESULT_CODE_LATEST_PROJECT_PAGE == widget.type){
      //首页最新项目 进入 id 选择 chapterId
      articleData= ArticleData.fromJson(ToolUtils.string2map(widget.articleJson));
      _title = articleData.superChapterName;
      _items.add(new KnowledgeHierarchyData(articleData.courseId,articleData.chapterId,articleData.chapterName,0,0,false,1,null));
    } else if(Constants.RESULT_CODE_AUTHOR_ARTICLE_PAGE == widget.type){
      //约定 author 作者文章页面 id = -1 来标识 作者文章页面
      _title = widget.author;
      _items.add(new KnowledgeHierarchyData(0,-1,widget.author,0,0,false,1,null));
    }else if(Constants.RESULT_CODE_WECHAT_PAGE == widget.type){
      //微信公众号
      knowledgeHierarchyData = KnowledgeHierarchyData.fromJson(ToolUtils.string2map(widget.knowledgeJson));
      _title = knowledgeHierarchyData.name;
      _items.add(knowledgeHierarchyData);
    }else{
      //知识体系模块进入
      knowledgeHierarchyData = KnowledgeHierarchyData.fromJson(ToolUtils.string2map(widget.knowledgeJson));
      _title = knowledgeHierarchyData.name;
      _items.addAll(knowledgeHierarchyData.children);
    }
    _tabController = new TabController(length: _items.length,vsync: this);
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(),
      body: TabBarView(
        controller: _tabController,
        children: _items.map((KnowledgeHierarchyData hierarchyData){
          return (Constants.RESULT_CODE_LATEST_PROJECT_PAGE == widget.type)
              ? LatestProjectPage(id: hierarchyData.id,type: widget.type):
          KnowledgeView(id: hierarchyData.id,author: hierarchyData.name,);
        }).toList(),
      ),
    );
  }


  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
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
        indicator: (isKnowledgeCome()) ? const BoxDecoration():null, //如果是首页进入 取消下划线，伪装成 app bar title
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

  Widget buildAppBar() {
    return AppBar(
      leading: new IconButton(
          icon: new Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: (){
            Navigator.of(context).pop(this);
          }),
      //如果是首页进入知识体系 标题 之前嵌入 appbar
      title: (isKnowledgeCome())? buildTabBar():
      Text(_title,style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white)),
      centerTitle: true,
      //设置title 形式嵌入 tabbar 也可以 通过“bottom”属性在AppBar下方来添加一个导航栏底部tab按钮组
      bottom: (isKnowledgeCome())? null : buildTabBar(),
    );
  }

  //判断是否为 知识体系模块跳转 控制 tabBar 显示位置
  bool isKnowledgeCome(){
    if(Constants.RESULT_CODE_HOME_PAGE == widget.type
        || Constants.RESULT_CODE_LATEST_PROJECT_PAGE == widget.type
        || Constants.RESULT_CODE_AUTHOR_ARTICLE_PAGE == widget.type
        || Constants.RESULT_CODE_WECHAT_PAGE == widget.type){
      return true;
    }else{
      return false;
    }
  }

}
