/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/1/21 0021
/// email: maoqitian068@163.com
/// des:  
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';

class TagItemView extends StatelessWidget {

  final Function pressCallback;
  final String textTitle;

  TagItemView({this.pressCallback, this.textTitle});


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(pressCallback != null){
          pressCallback();
        }
      },
      child: Chip(
        label: Text(
          textTitle,
          style: TextStyle(
              fontSize: 12.0,
              color: ToolUtils.getRandomColor(),
              fontStyle: FontStyle.normal),
        ),
        labelPadding: EdgeInsets.only(left: 3.0, right: 3.0),
        // backgroundColor: Color(0xfff1f1f1),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0)),
        materialTapTargetSize: MaterialTapTargetSize.padded,
      ),
    );
  }
}
