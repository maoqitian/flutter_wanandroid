/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/3/2 0002
/// email: maoqitian068@163.com
/// des:  
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/MyIcons.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/event/todo_change_event.dart';
import 'package:flutter_wanandroid/components/dialog/simple_input_dialog_layout.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/todo/todo_data.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';


class TodoItemView extends StatefulWidget {

  final TodoData todoData;

  TodoItemView(this.todoData);

  @override
  _TodoItemViewState createState() => _TodoItemViewState();
}

class _TodoItemViewState extends State<TodoItemView> {

  //todo是否 结束
  bool isDone ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDone = (widget.todoData.status == 1);
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.only(left: 5,right: 5),
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      widget.todoData.dateStr,
                      style: Theme.of(context).textTheme.body2,
                    )),
                collapsed: buildCollapsed(widget.todoData),
                expanded: buildExpanded(widget.todoData),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ),
        ));
  }



  Widget buildExpanded(TodoData tododata) {
    return ListTile(
      trailing: Checkbox(
        activeColor: ToolUtils.getPrimaryColor(context),
        value: isDone,
        onChanged:(isCheck) async {
          await dataUtils.getUpdateDoneTodo(tododata.id,{"status":isCheck ? 1 : 0}).then((TodoData todoData){
            setState(() {
            });
            Application.eventBus.fire(new TodoChangeEvent());
          });
        },
      ),
      title: Padding( //文章标题
          padding: EdgeInsets.only(top: 10.0,bottom: 20.0),
          child: Text(
              ToolUtils.signToStr(tododata.content),
              style: TextStyle(color: Colors.black, fontSize: 15.0),
              maxLines: 3, // title 只显示一行
              overflow: TextOverflow.ellipsis //超出一行 显示 ...
          )
      ),
      subtitle: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: IconButton(icon: Icon(Icons.edit,size: 20.0),onPressed: (){
              //编辑todo
              showDialog<void>(
                  context: context,
                  barrierDismissible: false, // user must tap button!
                  builder: (BuildContext context) {
                    return SimpleInputDialogLayout(
                      isTodoDialog: true,
                      isCollectArticle: false,
                      dialogTitleText: "编辑",
                      themeText: "清单",
                      isDIYText: true,
                      todoData: tododata,
                      confirmCallback3: (params)async{
                        //编辑收藏网站
                        await dataUtils.getUpdateTodoData(tododata.id,params).then((TodoData todoData){
                          ToolUtils.showToast(msg: "修改成功");
                          Application.eventBus.fire(new TodoChangeEvent());
                        });

                      },
                    );
                  }
              );
            },),
          ),
          Expanded( //占位
            flex: 4,
            child: Container(),
          ),
          Expanded(
            child: IconButton(icon: Icon(MyIcons.delete,size: 20.0),onPressed: (){
              ToolUtils.showAlertDialog(context, "确定删除清单"+widget.todoData.title+"?",
                  confirmCallback: ()async{
                    // 删除收藏网站
                    await dataUtils.getDeleteTodoData(widget.todoData.id).then((String s){
                      Application.eventBus.fire(new TodoChangeEvent());
                      ToolUtils.showToast(msg: "删除成功");
                    });
                  },confirmText: "确定");
            },),
          ),

        ],
      ),
    );
  }

  //副标题
  Widget buildCollapsed(TodoData todoData) {
    List<Widget> list = List();
    if(todoData.priority == 1){
      list.add(ToolUtils.buildStrokeWidget("重要", Colors.red));
    }else{
      list.add(ToolUtils.buildStrokeWidget("一般", Colors.greenAccent));
    }
    switch(todoData.type){
      case 1:
        list.add(ToolUtils.buildStrokeWidget("工作", Colors.deepOrange));
        break;
      case 2:
        list.add(ToolUtils.buildStrokeWidget("学习",Colors.redAccent));
        break;
      case 3:
        list.add(ToolUtils.buildStrokeWidget("生活", Colors.lightBlue));
        break;
    }
    list.add(Text(
      todoData.title,
      softWrap: true,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    ),);
    return Row(
      children: list
    );
  }
}

