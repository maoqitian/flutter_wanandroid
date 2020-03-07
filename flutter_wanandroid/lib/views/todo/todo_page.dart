/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/2/26 0026
/// email: maoqitian068@163.com
/// des:  todo页面
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/Page.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/common/event/todo_change_event.dart';
import 'package:flutter_wanandroid/components/dialog/simple_input_dialog_layout.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/todo/todo_data.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/todo/todo_content_page.dart';

class TodoPage extends StatefulWidget {
  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: Constants.todoPages.length,
        child: Scaffold(
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
            bottom: buildTabBar(),
          ),
          body: TabBarView(
            children: Constants.todoPages.map((Page page) {
              return TodoContentPage(status: page.labelIndex);
            }).toList(),
          ),
          floatingActionButton: FloatingActionButton(
              onPressed: _inAddTodo,
              tooltip: 'Increment',
              backgroundColor: Theme.of(context).primaryColor,
              child: Icon(Icons.add)),
        ));
  }

  buildTabBar() {
    return new TabBar(
      //构造Tab集合
      tabs: Constants.todoPages.map((Page page) {
        return Tab(
          text: page.labelId,
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
    );
  }

  void _inAddTodo() {
    //新增todo
    showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return SimpleInputDialogLayout(
            isTodoDialog: true,
            isCollectArticle: false,
            dialogTitleText: "添加TODO",
            themeText: "清单",
            isDIYText: true,
            confirmCallback3: (params)async{
              //编辑收藏网站
              await dataUtils.getAddTodoData(params).then((TodoData todoData){
                ToolUtils.showToast(msg: "添加成功");
                Application.eventBus.fire(new TodoChangeEvent());
              });
            },
          );
        }
    );
  }
}
