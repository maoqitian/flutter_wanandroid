import 'dart:io';

import 'package:event_bus/event_bus.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/10/30 0030
/// email: maoqitian068@163.com
/// des:  入口函数

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_wanandroid/common/provider/profile_change_notifier.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/common/shared_preferences.dart';
import 'package:flutter_wanandroid/views/app_page.dart';
import 'package:provider/provider.dart';

import 'common/constants.dart';

SpUtil sp;

void main() async{

  Application.sp = await SpUtil.getInstance();
  runApp(MyApp());

  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，
    // 是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatefulWidget {

  MyApp(){
    // 注册 fluro routes
    final Router router = Router();
    Routes.configureRoutes(router);
    // 设置环境变量 router
    Application.router = router;
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  int themeColor ;


  @override
  void initState() {
    Application.eventBus = new EventBus();
    themeColor = Application.sp.getInt(SharedPreferencesKeys.THEME_COLOR_KEY);
    super.initState();
    if(themeColor == null ){
      themeColor = 0xFFFFC800;//默认黄色
    }
  }

  @override
  void dispose() {
    super.dispose();
    Application.eventBus.destroy();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(builder: (_){  //Provider 主题颜色数据共享
          return ThemeModel(this.themeColor);
        },)
      ],
      child: Consumer<ThemeModel>(
        builder: (context,themeModel,_){
          return MaterialApp(
            title: 'titles',
            theme: new ThemeData(
              primaryColor: Color(themeModel.settingThemeColor),
              backgroundColor: Color(0xFFEFEFEF),
              accentColor: Color(0xFF888888),
              textTheme: TextTheme(
                //设置Material的默认字体样式
                body1: TextStyle(color: Color(0xFF888888), fontSize: 16.0),
              ),
              iconTheme: IconThemeData(
                color: Color(themeModel.settingThemeColor),
                size: 35.0,
              ),
            ),
            home: new Scaffold(
              body: AppPage(),
            ),
            /// 生成路由
            onGenerateRoute: Application.router.generator,
          );
        },
      ),
    );


  }
}

