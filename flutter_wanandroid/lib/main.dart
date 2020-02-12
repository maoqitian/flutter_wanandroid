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
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/res/colours.dart';
import 'package:flutter_wanandroid/res/styles.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/common/shared_preferences.dart';
import 'package:flutter_wanandroid/views/app_page.dart';
import 'package:provider/provider.dart';

import 'common/constants.dart';

SpUtil sp;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Application.sp = await SpUtil.getInstance();
  if (Platform.isAndroid) {
    // 以下两行 设置android状态栏为透明的沉浸。写在组件渲染之后，
    // 是为了在渲染后进行set赋值，覆盖状态栏，写在渲染之前MaterialApp组件会覆盖掉这个值。
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
  runApp(MyApp());
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
  bool isDarkMode;

  @override
  void initState() {
    Application.eventBus = new EventBus();
    themeColor = Application.sp.getInt(SharedPreferencesKeys.THEME_COLOR_KEY);
    isDarkMode = Application.sp.getBool(SharedPreferencesKeys.THEME_DARK_MODE_KEY);
    super.initState();
    if(themeColor == null ){
      themeColor = 0xFFFFC800;//默认黄色
      dataUtils.setPrimaryColor(themeColor);
    }
    if(isDarkMode == null){
      isDarkMode = false;
      dataUtils.setIsDarkMode(isDarkMode);
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
        ChangeNotifierProvider(
          create: (BuildContext context) {
          return ThemeModel(themeColor,isDarkMode);
        },)
      ],
      child: Consumer<ThemeModel>(
        builder: (context,themeModel,_){
          return MaterialApp(
            title: 'titles',
            theme: getThemeData(themeModel),
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


  ThemeData getThemeData(ThemeModel themeModel){
    return !themeModel.isDarkMode ?  ThemeData(
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
    ):ThemeData(
        errorColor: themeModel.isDarkMode ? Colours.dark_red : Colours.red,
        brightness: themeModel.isDarkMode ? Brightness.dark : Brightness.light,
        primaryColor: themeModel.isDarkMode ? Colours.dark_app_main : Colours.app_main,
        accentColor: themeModel.isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // Tab指示器颜色
        indicatorColor: themeModel.isDarkMode ? Colours.dark_app_main : Colours.app_main,
        // 页面背景色
        scaffoldBackgroundColor: themeModel.isDarkMode ? Colours.dark_bg_color : Colors.white,
        // 主要用于Material背景色
        canvasColor: themeModel.isDarkMode ? Colours.dark_material_bg : Colors.white,
        // 文字选择色（输入框复制粘贴菜单）
        textSelectionColor: Colours.app_main.withAlpha(70),
        textSelectionHandleColor: Colours.app_main,
        textTheme: TextTheme(
          // TextField输入文字颜色
          subhead: themeModel.isDarkMode ? TextStyles.textDark : TextStyles.text,
          // Text默认文字样式
          body1: themeModel.isDarkMode ? TextStyles.textDark : TextStyles.text,
          // 这里用于小文字样式
          subtitle: themeModel.isDarkMode ? TextStyles.textDarkGray12 : TextStyles.textGray12,
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: themeModel.isDarkMode ? TextStyles.textHint14 : TextStyles.textDarkGray14,
        ),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: themeModel.isDarkMode ? Colours.dark_bg_color : Colors.white,
          brightness: themeModel.isDarkMode ? Brightness.dark : Brightness.light,
        ),
        dividerTheme: DividerThemeData(
            color: themeModel.isDarkMode ? Colours.dark_line : Colours.line,
            space: 0.6,
            thickness: 0.6
        )
    );
  }
}

