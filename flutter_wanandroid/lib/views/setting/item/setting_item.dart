/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-01-31
/// email: maoqitian068@163.com
/// des:  设置 item

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/provider/profile_change_notifier.dart';
import 'package:flutter_wanandroid/data/data_utils.dart';
import 'package:flutter_wanandroid/res/colours.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:package_info/package_info.dart';
import 'package:provider/provider.dart';


class SettingItem extends StatefulWidget {

  final String settingText;

  SettingItem(this.settingText);

  @override
  _SettingItemState createState() => _SettingItemState();
}

class _SettingItemState extends State<SettingItem> {

  bool isBlackMode =false;

  @override
  void initState() {
    super.initState();
    if("夜间模式" == widget.settingText){
      isBlackMode = dataUtils.getIsDarkMode();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.white,
      child: ListTile(
        title: Text(
          widget.settingText,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
        ),
        onTap: () {
          switch(widget.settingText){
            case "夜间模式":
              if(this.mounted){
                setState(() {
                  isBlackMode = !isBlackMode;
                });
                Provider.of<ThemeModel>(context,listen: false).changeTheme(dataUtils.getPrimaryColor(),isBlackMode);
                dataUtils.setIsDarkMode(isBlackMode);
              }
              break;
            case "清除缓存":
              ToolUtils.showAlertDialog(context, "确定清除缓存么么？",confirmText: "确定",
                  confirmCallback: () {
                    //清除缓存
                    ToolUtils.clearCache();
                  });
              break;
            case "关于我们":
              Application.router.navigateTo(context,Routes.aboutPage);
              break;
            default:
              ToolUtils.showToast(msg:"暂未实现");
              break;
          }
        },
        trailing: (widget.settingText == "夜间模式") ? Switch(
          activeColor: Theme.of(context).primaryColor,
          value: isBlackMode,
          onChanged: (bool val){
            if(this.mounted){
              setState(() {
                isBlackMode = !isBlackMode;
              });
              Provider.of<ThemeModel>(context,listen: false).changeTheme(dataUtils.getPrimaryColor(),isBlackMode);
              dataUtils.setIsDarkMode(isBlackMode);
            }
          },
        ): Icon(Icons.arrow_forward_ios,size: 15),
      ),
      decoration: BoxDecoration(
          color: dataUtils.getIsDarkMode() ? Colours.dark_material_bg : Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Color(0xffe5e5e5)))
      ),
    );
  }
}

