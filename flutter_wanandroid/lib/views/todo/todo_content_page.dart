/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/3/2 0002
/// email: maoqitian068@163.com
/// des:  todo内容page
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/Page.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/components/tag/single_select_tag_view.dart';


class TodoContentPage extends StatefulWidget {
  //页面显示 状态 0 待办 1 完成
  final int state;
  const TodoContentPage({Key key, this.state = 0}) : super(key: key);

  @override
  _TodoContentPageState createState() => _TodoContentPageState();
}

class _TodoContentPageState extends State<TodoContentPage> {

  //初始选择
  int selected = 0;

  ValueChanged<int> onSelectedChanged(int _index) {
    print("当前选择的tag位置"+_index.toString());
    setState(() {
      selected = _index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Wrap(
          // 使用迭代器的方法生成list
          children: Constants.todoTypes.map((Page page){
            return SingleSelectTagView(index: page.labelIndex,choiceText: page.labelId,parent: this);
          }).toList(),
        ),
      ],
    );
  }
}
