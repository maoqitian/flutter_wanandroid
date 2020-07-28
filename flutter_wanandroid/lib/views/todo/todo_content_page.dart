/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/3/2 0002
/// email: maoqitian068@163.com
/// des:  todo内容page
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/Page.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/common/event/todo_change_event.dart';
import 'package:flutter_wanandroid/components/refresh/refresh_page.dart';
import 'package:flutter_wanandroid/components/tag/single_select_tag_view.dart';
import 'package:flutter_wanandroid/data/data_utils.dart';
import 'package:flutter_wanandroid/model/todo/todo_list_data.dart';
import 'package:flutter_wanandroid/views/todo/item/todo_item_view.dart';


class TodoContentPage extends StatefulWidget {
  //页面显示 状态 0 待办 1 完成
  final int status;
  const TodoContentPage({Key key, this.status = 0}) : super(key: key);

  @override
  _TodoContentPageState createState() => _TodoContentPageState();
}

class _TodoContentPageState extends State<TodoContentPage> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  //初始选择
  int selectedType = 0;

  ValueChanged<int> onSelectedChanged(int _index) {
    print("当前选择的tag位置"+_index.toString());
    setState(() {
      selectedType = _index;
      //刷新类别数据
      Application.eventBus.fire(new TodoChangeEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Wrap(
          // 对齐方式
          alignment: WrapAlignment.start,
          // run的对齐方式 开始位置
          runAlignment: WrapAlignment.start,
          // 使用迭代器的方法生成list
          children: Constants.todoTypes.map((PageData page){
            return SingleSelectTagView(index: page.labelIndex,choiceText: page.labelId,parent: this);
          }).toList(),
        ),
        Expanded(
            child: RefreshPage(requestApi: getTodoListData,
                renderItem: makeTodoItem,startIndex: 1,)
        )
      ],
    );
  }


  Future<Map> getTodoListData([Map<String, dynamic> params]) async {
    var pageIndex = (params is Map) ? params['pageIndex'] : 1;
    //获取todo list
    Map<String, dynamic> requestParams={"status":widget.status,"type":selectedType};
    Map<String, dynamic> result;
    await dataUtils.getTodoListData(pageIndex,params: requestParams).then((TodoListData todoListData){
      pageIndex = todoListData.curPage+1;
      result = {"list":todoListData.datas, 'total':todoListData.pageCount, 'pageIndex':pageIndex};
    },onError: (e){
      print("onError 发生错误");
      result = {"list":[], 'total':0, 'pageIndex':0};
    });
    return result;
  }


  //  GridViewItem
  Widget makeTodoItem(index,item){
    return TodoItemView(item) ;
  }
}
