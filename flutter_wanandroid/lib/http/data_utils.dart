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



class DataUtils{

  /// 首页数据模块
  //获取首页banner 数据
  static Future<List<BannerData>> getBannerData() async{
    Response response = await HttpUtils.get(Api.BANNER_JSON);
    return BannerBaseData.fromJson(response.data).data;
  }

  // 首页文章列表
  //方法：GET
  //参数：页码，拼接在连接中，从0开始。
  static Future<ArticleListData> getArticleData(int pageNum) async{
    String path = '/article/list/$pageNum/json';
    Response response = await HttpUtils.get(Api.BASE_URL+path);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }

  // 首页 最新项目 列表数据
  //方法：GET
  //参数：页码，拼接在连接中，从0开始。
  static Future<ArticleListData> getListProjectData(int pageNum) async{
    String path = '/article/listproject/$pageNum/json';
    Response response = await HttpUtils.get(Api.BASE_URL+path);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }

  //常用网站
  static Future<List<FriendData>> getFriendListData() async{
    Response response = await HttpUtils.get(Api.FRIEND_JSON);
    BaseFriendData baseFriendData = BaseFriendData.fromJson(response.data);
    return baseFriendData.data;
  }

  //搜索热词
  static Future<List<HotKeyData>> getHotKeyListData() async{
    Response response = await HttpUtils.get(Api.HOT_KEY_JSON);
    BaseHotKeyData baseHotKeyData = BaseHotKeyData.fromJson(response.data);
    return baseHotKeyData.data;
  }

  //置顶文章
  static Future<List<ArticleData>> getArticleTopData() async{
    Response response = await HttpUtils.get(Api.ARTICLE_TOP);
    return ArticleTopBaseData.fromJson(response.data).data;
  }


  /// 登录注册
  //登录
  static Future<LoginData> getLoginData(String username,String password,BuildContext context) async{
    FormData formData = FormData.fromMap({"username": username, "password": password});
    Response response = await HttpUtils.post(Api.LOGIN_JSON,formData,isAddLoading:true,context: context,loadingText: "正在登陆...");
    return BaseLoginData.fromJson(response.data).data;
  }

  //注册
  static Future<LoginData> getRegisterData(String username,String password,String repassword,BuildContext context) async{
    FormData formData =FormData.fromMap({"username": username, "password": password,"repassword": repassword});
    Response response = await HttpUtils.post(Api.REGISTER_JSON,formData,isAddLoading:true,context: context,loadingText: "正在登陆...");
    return BaseLoginData.fromJson(response.data).data;
  }
  //退出登录
  static Future<String> getLoginOut() async{
    Response response = await HttpUtils.get(Api.LOGIN_OUT_JSON);
    return response.data["data"];
  }


  /// 收藏模块



  /// 积分


  //个人积分
  static Future<CoinUserInfo> getCoinUserInfo() async{
    Response response = await HttpUtils.get(Api.COIN_USER_INFO_JSON);
    return BaseCoinInfo.fromJson(response.data).data;
  }


  /// SharedPreferences 存储 用户名 是否登录等状态
  static void setUserName(String username){
     Application.sp.putString(SharedPreferencesKeys.USER_NAME_KEY,username);
  }

  static String getUserName() {
    return Application.sp.getString(SharedPreferencesKeys.USER_NAME_KEY);
  }

  static void setPassWord(String password) {
     Application.sp.putString(SharedPreferencesKeys.PASSWORD_KEY,password);
  }

  static String getPassword() {
    return Application.sp.getString(SharedPreferencesKeys.PASSWORD_KEY);
  }

  static void setLoginState(bool loginState) {
     Application.sp.putBool(SharedPreferencesKeys.LOGIN_STATE_KEY,loginState);
  }

  static bool getLoginState() {
    return Application.sp.getBool(SharedPreferencesKeys.LOGIN_STATE_KEY);
  }
  //是否登录
  static bool hasLogin(){
    //是否存在登录的 key
    if(!Application.sp.hasKey(SharedPreferencesKeys.LOGIN_STATE_KEY)) return false;
    return getLoginState();
  }

}
