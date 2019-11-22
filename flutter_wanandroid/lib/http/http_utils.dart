import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
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

    if (params != null) {
      response = await dio.get(url, queryParameters: params);
    } else {
      response = await dio.get(url);
    }
    return response;

  }



  // url ：网络请求地址
  // parasm : 请求参数
  // post 请求
  static Future post(String url, Map<String, dynamic> params) async {
    Response response ;

    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();

    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));

    response = await dio.get(url, queryParameters: params);

    return response;

  }



}