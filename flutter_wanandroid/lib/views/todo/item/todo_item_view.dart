/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/3/2 0002
/// email: maoqitian068@163.com
/// des:  
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/model/todo/todo_data.dart';
import 'package:expandable/expandable.dart';


class TodoItemView extends StatefulWidget {

  final TodoData todoData;

  TodoItemView(this.todoData);

  @override
  _TodoItemViewState createState() => _TodoItemViewState();
}

class _TodoItemViewState extends State<TodoItemView> {
  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(10),
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
                collapsed: Text(
                  widget.todoData.title,
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                expanded: Text(widget.todoData.content),
                builder: (_, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
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
        ));;
  }
}

