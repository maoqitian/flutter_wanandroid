/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/2/26 0026
/// email: maoqitian068@163.com
/// des:  todo页面
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/views/todo/todo_content_page.dart';

class TodoPage extends StatefulWidget {

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {


  //存放 底部导航栏 对应的每个 widget
  List<Widget> _list = List();
  //当前 tab
  int _currentIndex = 0;
  final pageController = PageController();
  List tabData = [
    {'text': '待办', 'icon': Icon(Icons.calendar_today)},
    {'text': '完成', 'icon': Icon(Icons.done_all)},
  ];
  //BottomNavigationBar 数据
  List<BottomNavigationBarItem> _myTabs = [];

  @override
  void initState() {
    super.initState();
    for(int i = 0; i < tabData.length; i++){
      _myTabs.add(new BottomNavigationBarItem(
        icon: tabData[i]['icon'],
        title: new Text(tabData[i]['text']),
      ));
    }

    _list
      ..add(TodoContentPage(state: 0))
      ..add(TodoContentPage(state: 1));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop(this);
            }),
        title: Text("TODO",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: PageView( //使用PageView 切换 优化界面全部加载问题
        controller: pageController,
        children: _list,
        onPageChanged: _itemTapped,
        physics: NeverScrollableScrollPhysics(),// 禁止滑动
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _myTabs,
        //高亮  被点击高亮
        currentIndex: _currentIndex,
        //修改 页面
        onTap: _onTap,
        //shifting :按钮点击移动效果
        //fixed：固定
        type: BottomNavigationBarType.fixed,
        fixedColor: Theme.of(context).primaryColor,
      ),
    );
  }

  // BottomNavigationBar 点击执行方法
  void _itemTapped(int index) {
    if(this.mounted){
      setState(() {
        _currentIndex = index;
        //appBarTitle = tabData[index]['text'];
      });
    }
  }
  // 底部tab 切换
  void _onTap(int index) {
    pageController.jumpToPage(index);
  }
}
