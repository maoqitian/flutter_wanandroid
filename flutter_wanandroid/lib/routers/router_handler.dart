import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/views/app_page.dart';
import 'package:flutter_wanandroid/views/knowledge/knowledge_detail_page.dart';
import 'package:flutter_wanandroid/views/login/login_page.dart';
import 'package:flutter_wanandroid/views/login/register_page.dart';
import 'package:flutter_wanandroid/views/user/user_center_page.dart';
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
// 注册页
var registerHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new RegisterPage();
  },
);

// webview 页面
var webViewPageHand = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return new WebViewPage(url, title);
    });

//知识体系下的文章
var knowledgeDetailHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    String type = params['type']?.first; //页面跳转类型
    String author = params['author']?.first; //更加 作者名称显示作者文章
    String articleJson = params['articleJson']?.first;
    String knowledgeJson = params['knowledgeJson']?.first;
    return new KnowledegDetailPage(type:type,author:author,articleJson: articleJson,knowledgeJson: knowledgeJson,);
  },
);

//用户中心
var userCenterHandler = new Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return new UserCenterPage();
  },
);