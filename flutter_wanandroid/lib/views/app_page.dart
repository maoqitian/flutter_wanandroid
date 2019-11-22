/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/10/30 0030
/// email: maoqitian068@163.com
/// des: 底层基础页面 BottomNavigationBar

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/search_input.dart';
import '../common/MyIcons.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/home/home_page.dart';
import 'package:flutter_wanandroid/views/knowledge/knowledge_page.dart';
import 'package:flutter_wanandroid/views/navigation/navigation_page.dart';
import 'package:flutter_wanandroid/views/oa/oa_page.dart';
import 'package:flutter_wanandroid/views/project/project_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'drawer/drawer_page.dart';



class AppPage extends StatefulWidget {
  @override
  _AppPageState createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {


  //存放 底部导航栏 对应的每个 widget
  List<Widget> _list = List();

  String appBarTitle;

  //当前 tab
  int _currentIndex = 0;

  List tabData = [
    {'text': '首页', 'icon': Icon(Icons.home)},
    {'text': '知识体系', 'icon': Icon(MyIcons.knowledge)},
    {'text': '公众号', 'icon': Icon(MyIcons.wechat)},
    {'text': '导航', 'icon': Icon(Icons.navigation)},
    {'text': '项目', 'icon': Icon(Icons.android)},
  ];

  //BottomNavigationBar 数据
  List<BottomNavigationBarItem> _myTabs = [];

  ///遍历加入 tab widget 和 icon data


  @override
  void initState() {
    super.initState();
    appBarTitle = tabData[0]['text'];

    for(int i = 0; i < tabData.length; i++){
        _myTabs.add(new BottomNavigationBarItem(
            icon: tabData[i]['icon'],
            title: new Text(tabData[i]['text']),
        ));
    }

    _list
        ..add(new HomePage())
        ..add(new KnowledgePage())
        ..add(new OfficialAccountsPage())
        ..add(new NavigationPage())
        ..add(new ProjectPage());
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  DateTime _lastPressedAt; //上次点击时间

  @override
  Widget build(BuildContext context) {
    return WillPopScope( ///通过WillPopScope 嵌套，可以用于监听处理 Android 返回键的逻辑。 WillPopScope 并不是监听返回按键，只是当前页面将要被pop时触发的回调
        child: buildAppPage(),
        onWillPop: () async{
           return _doubleExitApp();
        }
    );
  }

  //双击返回 退出应用
  bool _doubleExitApp(){
    if (_lastPressedAt == null ||
        DateTime.now().difference(_lastPressedAt) > Duration(seconds: 1)) {
      ToolUtils.ShowToast(msg: "再点一次退出应用");
      //两次点击间隔超过1秒则重新计时
      _lastPressedAt = DateTime.now();
      return false;
    }
    //应用关闭直接取消 Toast
    Fluttertoast.cancel();
    return true;
}


  ///如果返回 return new Future.value(false); popped 就不会被处理
  ///如果返回 return new Future.value(true); popped 就会触发
  ///这里可以通过 showDialog 弹出确定框，在返回时通过 Navigator.of(context).pop(true);决定是否退出
  /// 单击提示退出
  Future<bool> _dialogExitApp(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          content: new Text("是否退出"),
          actions: <Widget>[
            new FlatButton(onPressed: () => Navigator.of(context).pop(false), child:  new Text("取消")),
            new FlatButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: new Text("确定"))
          ],
        ));
  }

  //是否显示 app bar 如为首页则不显示 app bar , app bar 由首页的 HomePage 创建
  renderAppBar(BuildContext context, Widget widget, int index) {
   if(index != 0 ){
      return AppBar(
        leading: Builder( builder: (context){
          return IconButton(
              icon: Container(
                  child:  ClipOval(
                    child: Image.network(
                      'https://hbimg.huabanimg.com/9bfa0fad3b1284d652d370fa0a8155e1222c62c0bf9d-YjG0Vt_fw658',
                      scale: 15.0,
                    ),
                  )
              ),
              onPressed: (){
                /// 打开侧边栏 使用 Builder( builder: (context) 保证获取到 Scaffold  context 可以正常打开侧边栏
                print("点击打开侧边栏");
                Scaffold.of(context).openDrawer();
              });
           },
        ),
        title: Text(appBarTitle,
            style: new TextStyle(
              color: Colors.white //设置字体颜色为白色
          )
      ),
        centerTitle: true, //title 居中显示
        actions: <Widget>[
          IconButton(
              icon:  Icon(Icons.search),
              color: Colors.white,
              onPressed: () {
                ToolUtils.ShowToast(msg: '点击了搜索');
              })
        ],);
    }
  }

  buildSearchInput(BuildContext context) {
      return new SearchInput((value) {}, (value) {}, () {});
  }
  // BottomNavigationBar 点击执行方法
  void _itemTapped(int index) {
     if(this.mounted){
       setState(() {
         _currentIndex = index;
         appBarTitle = tabData[index]['text'];
       });
      }
     }

  /// 创建 app page 页面
  Widget buildAppPage() {
    return Scaffold(
      appBar: renderAppBar(context, widget, _currentIndex),
      body: IndexedStack(
        index: _currentIndex,
        children: _list,
      ),
      /// 侧边栏 抽屉
      drawer: Drawer(
        child: DrawerPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _myTabs,
        //高亮  被点击高亮
        currentIndex: _currentIndex,
        //修改 页面
        onTap: _itemTapped,
        //shifting :按钮点击移动效果
        //fixed：固定
        type: BottomNavigationBarType.fixed,

        fixedColor: Theme.of(context).primaryColor,
      ),
    );
  }
}