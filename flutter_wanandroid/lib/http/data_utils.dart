import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-11-03
/// email: maoqitian068@163.com
/// des:  数据获取帮助类

import 'package:flutter_wanandroid/http/http_utils.dart';
import 'package:flutter_wanandroid/model/article/article_base_data.dart';
import 'package:flutter_wanandroid/model/article/article_top_base_data.dart';
import 'package:flutter_wanandroid/model/banner/banner_base_data.dart';
import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:flutter_wanandroid/model/article/article_list_data.dart';
import 'package:flutter_wanandroid/model/banner/banner_data.dart';
import 'package:flutter_wanandroid/model/coin/base_coin_info.dart';
import 'package:flutter_wanandroid/model/coin/coin_user_info.dart';
import 'package:flutter_wanandroid/model/friend/base_friend_data.dart';
import 'package:flutter_wanandroid/model/friend/friend_data.dart';
import 'package:flutter_wanandroid/model/hotkey/base_hot_key_data.dart';
import 'package:flutter_wanandroid/model/hotkey/hot_key_data.dart';
import 'package:flutter_wanandroid/model/login/base_login_data.dart';
import 'package:flutter_wanandroid/model/login/login_data.dart';
import 'api/Api.dart';

DataUtils dataUtils = new DataUtils();

class DataUtils{

  //私有构造函数
  DataUtils._internal();

  //保存单例
  static DataUtils _singleton = new DataUtils._internal();

  //工厂构造函数
  factory DataUtils()=> _singleton;



  /// 首页数据模块
  //获取首页banner 数据
  Future<List<BannerData>> getBannerData() async{
    Response response = await httpUtils.get(Api.BANNER_JSON);
    return BannerBaseData.fromJson(response.data).data;
  }

  // 首页文章列表
  //方法：GET
  //参数：页码，拼接在连接中，从0开始。
  Future<ArticleListData> getArticleData(int pageNum) async{
    String path = '/article/list/$pageNum/json';
    Response response = await httpUtils.get(path);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }

  // 首页 最新项目 列表数据
  //方法：GET
  //参数：页码，拼接在连接中，从0开始。
  Future<ArticleListData> getLatestProjectData(int pageNum) async{
    String path = '/article/listproject/$pageNum/json';
    Response response = await httpUtils.get(path);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }

  //常用网站
  Future<List<FriendData>> getFriendListData() async{
    Response response = await HttpUtils().get(Api.FRIEND_JSON);
    BaseFriendData baseFriendData = BaseFriendData.fromJson(response.data);
    return baseFriendData.data;
  }

  //搜索热词
  Future<List<HotKeyData>> getHotKeyListData() async{
    Response response = await httpUtils.get(Api.HOT_KEY_JSON);
    BaseHotKeyData baseHotKeyData = BaseHotKeyData.fromJson(response.data);
    return baseHotKeyData.data;
  }

  //置顶文章
  Future<List<ArticleData>> getArticleTopData() async{
    Response response = await httpUtils.get(Api.ARTICLE_TOP);
    return ArticleTopBaseData.fromJson(response.data).data;
  }


  /// 知识体系


  //知识体系下的文章
  Future<ArticleListData> getKnowledgeArticleData(int cid,int pageNum) async{
    String path = '/article/list/$pageNum/json';
    Map<String, dynamic> params={"cid": cid};
    Response response = await httpUtils.get(path,params: params);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }


  /// 登录注册
  //登录
  Future<LoginData> getLoginData(String username,String password,BuildContext context) async{
    FormData formData = FormData.fromMap({"username": username, "password": password});
    Response response = await httpUtils.post(Api.LOGIN_JSON,formData: formData,isAddLoading:true,context: context,loadingText: "正在登陆...");
    return BaseLoginData.fromJson(response.data).data;
  }

  //注册
  Future<LoginData> getRegisterData(String username,String password,String repassword,BuildContext context) async{
    FormData formData =FormData.fromMap({"username": username, "password": password,"repassword": repassword});
    Response response = await httpUtils.post(Api.REGISTER_JSON,formData: formData,isAddLoading:true,context: context,loadingText: "正在登陆...");
    return BaseLoginData.fromJson(response.data).data;
  }
  //退出登录
  Future<String> getLoginOut() async{
    Response response = await httpUtils.get(Api.LOGIN_OUT_JSON);
    return response.data["data"];
  }


  /// 收藏模块


  // 站内文章收藏 （文章列表）
  //方法：POST
  //参数： 文章id，拼接在链接中。
  Future<String> getCollectInnerArticle(int id) async{
    String path = '/lg/collect/$id/json';
    Response response = await httpUtils.post(path);
    return response.data["data"];
  }


  //取消收藏 文章列表
  //方法：POST
  //参数：
  //id:拼接在链接上
  Future<String> getCancelCollectInnerArticle(int id) async{
    String path = '/lg/uncollect_originId/$id/json';
    Response response = await httpUtils.post(path);
    return response.data["data"];
  }


  /// 积分


  //个人积分
  Future<CoinUserInfo> getCoinUserInfo() async{
    Response response = await httpUtils.get(Api.COIN_USER_INFO_JSON);
    return BaseCoinInfo.fromJson(response.data).data;
  }


  /// SharedPreferences 存储 用户名 是否登录等状态
  void setUserName(String username){
     Application.sp.putString(SharedPreferencesKeys.USER_NAME_KEY,username);
  }

  String getUserName() {
    return Application.sp.getString(SharedPreferencesKeys.USER_NAME_KEY);
  }

  void setPassWord(String password) {
     Application.sp.putString(SharedPreferencesKeys.PASSWORD_KEY,password);
  }

  String getPassword() {
    return Application.sp.getString(SharedPreferencesKeys.PASSWORD_KEY);
  }

  void setLoginState(bool loginState) {
     Application.sp.putBool(SharedPreferencesKeys.LOGIN_STATE_KEY,loginState);
  }

  bool getLoginState() {
    return Application.sp.getBool(SharedPreferencesKeys.LOGIN_STATE_KEY);
  }
  //是否登录
  bool hasLogin(){
    //是否存在登录的 key
    if(!Application.sp.hasKey(SharedPreferencesKeys.LOGIN_STATE_KEY)) return false;
    return getLoginState();
  }

}
