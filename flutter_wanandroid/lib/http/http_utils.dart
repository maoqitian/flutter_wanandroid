import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/widget/loading_widget.dart';
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
  static Future get(String url, {Map<String, dynamic> params,bool isAddLoading = false ,BuildContext context,String loadingText}) async {
    Response response ;

    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();

    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));

    //显示 加载中的 loading
    if(isAddLoading){
      showLoading(context,loadingText);
    }

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
    if(isAddLoading){
      dismissLoading(context);
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
  static Future post(String url, FormData formData,{bool isAddLoading = false ,BuildContext context,String loadingText}) async {
    Response response ;

    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();

    dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));

    //显示 加载中的 loading
    if(isAddLoading){
      showLoading(context,loadingText);
    }

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
      dismissLoading(context);
    }
    if(isAddLoading){
      dismissLoading(context);
    }
    if(response.data["errorCode"] == 0 ){
      return response;
    }else{
      String data = response.data["errorMsg"];
      ToolUtils.ShowToast(msg: data);
    }
  }



  /// 显示Loading
  static void showLoading(BuildContext context,String loadText) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          return new LoadingWidget(
            outsideDismiss: false,
            loadingText: loadText,
          );
        });
  }
  /// 隐藏Loading
  static void dismissLoading(BuildContext context) {
    Navigator.of(context).pop();
  }

}