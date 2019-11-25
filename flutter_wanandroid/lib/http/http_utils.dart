import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:path_provider/path_provider.dart';

/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-11-03
/// email: maoqitian068@163.com
/// des:  网络请求工具类


Map<String, dynamic> optHeader = {
  'accept-language': 'zh-cn',
  'content-type': 'application/json'
};


var dio = new Dio();


class HttpUtils {

  // url ：网络请求地址
  // parasm : 请求参数
  // get 请求
  static Future get(String url, [Map<String, dynamic> params]) async {
    Response response ;

    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();

    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));

    try {
      if (params != null) {
        response = await dio.get(url, queryParameters: params);
      } else {
        response = await dio.get(url);
      }
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response!= null) {
        ToolUtils.ShowToast(msg: "网络出现异常"+e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        ToolUtils.ShowToast(msg: "网络出现异常"+e.message);
      }
    }
    if(response.data["errorCode"] == 0 ){
       return response;
    }else{
       String data = response.data["errorMsg"];
       ToolUtils.ShowToast(msg: data);
    }
  }



  // url ：网络请求地址
  // formData : 请求参数
  // post 请求
  static Future post(String url, FormData formData) async {
    Response response ;

    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();

    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));

    try {
      response = await dio.post(url, data: formData);
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response!= null) {
        ToolUtils.ShowToast(msg: "网络出现异常"+e.response.data);
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
        ToolUtils.ShowToast(msg: "网络出现异常"+e.message);
      }
    }
    if(response.data["errorCode"] == 0 ){
      return response;
    }else{
      String data = response.data["errorMsg"];
      ToolUtils.ShowToast(msg: data);
    }
  }



}