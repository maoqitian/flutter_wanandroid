import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/common/shared_preferences.dart';
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
import 'package:flutter_wanandroid/model/login/base_login_data.dart';
import 'package:flutter_wanandroid/model/login/login_data.dart';
import 'api/Api.dart';



class DataUtils{


  //获取首页banner 数据
  // 数据手动解析 没有使用 JsonSerializable
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

  //置顶文章
  static Future<List<ArticleData>> getArticleTopData() async{
    Response response = await HttpUtils.get(Api.ARTICLE_TOP);
    return ArticleTopBaseData.fromJson(response.data).data;
  }


  //登录
  static Future<LoginData> getLoginData(String username,String password) async{
    FormData formData = FormData.fromMap({"username": username, "password": password});
    Response response = await HttpUtils.post(Api.LOGIN_JSON,formData);
    return BaseLoginData.fromJson(response.data).data;
  }

  //注册
  static Future<LoginData> getRegisterData(String username,String password,String repassword) async{
    FormData formData =FormData.fromMap({"username": username, "password": password,"repassword": repassword});
    Response response = await HttpUtils.post(Api.REGISTER_JSON,formData);
    return BaseLoginData.fromJson(response.data).data;
  }


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
