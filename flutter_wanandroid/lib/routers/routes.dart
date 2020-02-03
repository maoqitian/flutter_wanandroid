
//定义跳转路径
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/routers/router_handler.dart';

class Routes {

  static String root = "/";
  static String home = "/home_page";
  static String knowledgedetail = "/knowledge_detail_page";
  static String login = "/login_page";
  static String register = "/register_page";
  static String webViewPage = '/web_view_page';
  static String userCenterPage = '/user_center_page';
  static String collectItemPage = '/collect_page';
  static String commonWebPage = '/common_web_page';
  static String shareArticlePage = '/share_article_page';
  static String coinRankPage = '/coin_rank_page';
  static String userCoinPage = '/user_coin_page';
  static String settingPage = '/setting_page';
  static String aboutPage = '/about_page';
  static String searchPage = '/search_page';

  static void configureRoutes(Router router){

    router.notFoundHandler = new Handler(handlerFunc: (BuildContext context, Map<String, List<String>> params){
      print("ROUTE WAS NOT FOUND !!!");
    });

    /// 第一个参数是路由地址，第二个参数是页面跳转和传参，第三个参数是默认的转场动画
    router.define(root, handler: homeHandler);
    router.define(login, handler: loginHandler);
    router.define(register, handler: registerHandler);
    router.define(webViewPage, handler: webViewPageHand);
    router.define(knowledgedetail, handler: knowledgeDetailHandler);
    router.define(userCenterPage, handler: userCenterHandler);
    router.define(collectItemPage, handler: collectPageHandler);
    router.define(commonWebPage, handler: commonWebPageHandler);
    router.define(shareArticlePage, handler: shareArticlePageHandler);
    router.define(coinRankPage, handler: coinRankPageHandler);
    router.define(userCoinPage, handler: userCoinPageHandler);
    router.define(settingPage, handler: settingPageHandler);
    router.define(aboutPage, handler: aboutPageHandler);
    router.define(searchPage, handler: searchPageHandler);
  }


}