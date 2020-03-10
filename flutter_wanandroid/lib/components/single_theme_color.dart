/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/13 0013
/// email: maoqitian068@163.com
/// des:  主题颜色 圆形 + 文字 widget
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/common/provider/profile_change_notifier.dart';
import 'package:flutter_wanandroid/common/shared_preferences.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:provider/provider.dart';

class SingleThemeColor extends StatelessWidget {
  final int themeColor;
  final String colorName;

  const SingleThemeColor({Key key, this.themeColor, this.colorName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        ToolUtils.showToast(msg: "改变主题颜色为" + colorName);
        Provider.of<ThemeModel>(context, listen: false)
            .changeTheme(this.themeColor, false);
        dataUtils.setPrimaryColor(themeColor);
        dataUtils.setIsDarkMode(false);
        Navigator.pop(context);
      },
      child: Column(
        // 竖直布局
        children: <Widget>[
          Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                width: 50,
                height: 50,
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                    //圆形背景装饰
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    color: Color(this.themeColor)),
              ),
              //标识选中的主题颜色
              Offstage(
                offstage: dataUtils.getIsDarkMode() || dataUtils.getPrimaryColor() != themeColor,
                child: Icon(
                  Icons.done,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            colorName,
            style: TextStyle(color: Color(this.themeColor), fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
