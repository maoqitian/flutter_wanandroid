/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/1/21 0021
/// email: maoqitian068@163.com
/// des:   tag view
import 'package:flutter/material.dart';

class TagItemView extends StatelessWidget {

  final Function pressCallback;
  final String textTitle;
  final Color backgroundColor;
  final Color textColor;
  final bool isShape; //是否需要 shape 包围
  final bool isCanClick; //是否能被点击，默认可以被点击
  TagItemView({this.pressCallback, this.textTitle, this.backgroundColor, this.textColor, this.isShape=false, this.isCanClick=true});


  @override
  Widget build(BuildContext context) {
    return  InkWell(
        onTap: isCanClick ? () {
          if(pressCallback != null){
            pressCallback();
          }
        } : null,
        child: Chip(
          backgroundColor: backgroundColor == null ? null : backgroundColor,
          label: Text(
            textTitle,
            style: TextStyle(
                fontSize: 12.0,
                color: textColor == null ? null: textColor,
                fontStyle: isShape ? FontStyle.italic: FontStyle.normal),
          ),
          labelPadding: EdgeInsets.only(left: 5.0, right: 5.0),
          // backgroundColor: Color(0xfff1f1f1),
          shape: isShape ? RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0)) : null,
          materialTapTargetSize: MaterialTapTargetSize.padded,
        ),
      ) ;
  }
}
