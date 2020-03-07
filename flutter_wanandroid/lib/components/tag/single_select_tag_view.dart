/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/3/5 0005
/// email: maoqitian068@163.com
/// des:  单选 tag view
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';

class SingleSelectTagView extends StatelessWidget {

  final int index; //为标识选中的
  final parent; //父控件
  final String choiceText;


  const SingleSelectTagView(
      {@required this.index,
        @required this.parent,
        @required this.choiceText})
      : super();

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: ChoiceChip(
          label: Text(choiceText,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold)),
          //选定的时候背景
          selectedColor: ToolUtils.getPrimaryColor(context),
          //未选用得时候背景
          disabledColor: Colors.grey[300],
          labelStyle: TextStyle(fontWeight: FontWeight.w200, fontSize: 15.0),
          labelPadding: EdgeInsets.only(left: 8.0, right: 8.0),
          materialTapTargetSize: MaterialTapTargetSize.padded,
          onSelected: (bool value) {
            parent.onSelectedChanged(index);
          },
          selected: parent.selectedType == index),
    );
  }
}
