import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/views/app_page.dart';
import 'package:flutter_wanandroid/views/login/login_page.dart';
import 'package:flutter_wanandroid/views/web_page/web_view_page.dart';


// app的首页
var homeHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new AppPage();
  },
);

//登录页
var loginHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new LoginPage();
  },
);


// webview 页面
var webViewPageHand = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return new WebViewPage(url, title);
    });
