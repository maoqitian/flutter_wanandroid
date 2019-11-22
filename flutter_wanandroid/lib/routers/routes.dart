
//定义跳转路径
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/routers/router_handler.dart';

class Routes {

  static String root = "/";
  static String home = "/home_page";
  static String login = "/login_page";

  static String webViewPage = '/web-view-page';


  static void configureRoutes(Router router){

    router.notFoundHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params){
      print("ROUTE WAS NOT FOUND !!!");
    });

    /// 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画
    router.define(root, handler: homeHandler);
    router.define(login, handler: loginHandler);
    router.define(webViewPage, handler: webViewPageHand);
  }


}