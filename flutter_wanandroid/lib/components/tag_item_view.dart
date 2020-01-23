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
  final Color backgroundColor;
  final Color textColor;
  TagItemView({this.pressCallback, this.textTitle, this.backgroundColor, this.textColor});


  @override
  Widget build(BuildContext context) {
    return
      Padding(
        padding: EdgeInsets.only(left: 3.0),
        child: ActionChip(
          onPressed: (){
            if(pressCallback != null){
              pressCallback();
            }
          },
          label: Text(
            textTitle,
            maxLines: 1, // title 只显示一行
            overflow: TextOverflow.ellipsis ,//超出一行 显示 ...
            style: TextStyle(
                fontSize: 12.0,
                color: textColor == null ? null: textColor,
                fontStyle: FontStyle.normal),
          ),
          labelPadding: EdgeInsets.only(left: 2.0, right: 2.0),
          materialTapTargetSize: MaterialTapTargetSize.padded,
          /*shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0)),*/
          elevation: 1,
          backgroundColor: backgroundColor == null ? null : backgroundColor,
        )
      );

  }
}
