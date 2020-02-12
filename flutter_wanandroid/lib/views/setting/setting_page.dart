/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-01-31
/// email: maoqitian068@163.com
/// des:  设置 page

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/common/event/login_out_event.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/res/colours.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/setting/item/setting_item.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    isLogin = dataUtils.hasLogin();
    Application.eventBus.on<LoginOutEvent>().listen((event){
      if(this.mounted){
        setState(() {
          isLogin = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dataUtils.getIsDarkMode() ? Colours.dark_material_bg : Color(0xFFEEEEEE),
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pop(this);
            }),
        title: Text("设置",
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.white)),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          ListView(
            shrinkWrap: true,
            children: Constants.settingItems.map((String text){
              return SettingItem(text);
            }).toList(),
          ),
          SizedBox(
            height: 5,
          ),
          buildLoginOut()
        ],
      )
    );
  }

  buildLoginOut() {
    return isLogin? Container(
       color: dataUtils.getIsDarkMode() ? Colours.dark_unselected_item_color : Colors.white,
        child: ListTile(
          title: Center(
              child: Text(
            '退出登录',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
          )),
          onTap: () {
            //pushPage(context, SearchPage(), pageName: "SearchPage");
            //showAlertDialog(context);
            ToolUtils.showAlertDialog(context, "乃确定不是手滑了么？",
                confirmCallback: () {
              //退出登录
              doLoginOut();
            });
          },
        ),
      ):Container();
    }


  void doLoginOut() async {
    //退出登录
    await dataUtils.getLoginOut();
    //发出 登录成功事件
    Application.eventBus.fire(new LoginOutEvent());
    dataUtils.setUserName("");
    dataUtils.setLoginState(false);
    ToolUtils.showToast(msg: "退出登录成功");
  }
}
