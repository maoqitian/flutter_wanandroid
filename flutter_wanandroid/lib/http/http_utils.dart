import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/widget/loading_widget.dart';
import 'package:path_provider/path_provider.dart';

import 'api/Api.dart';

/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-11-03
/// email: maoqitian068@163.com
/// des:  网络请求工具类  单例模式


Map<String, dynamic> optHeader = {
  'accept-language': 'zh-cn',
  'content-type': 'application/json'
};

HttpUtils httpUtils = new HttpUtils();

class HttpUtils {

  //保存单例
  static HttpUtils _singleton = new HttpUtils._internal();

  //工厂构造函数
  factory HttpUtils()=> _singleton;

  //单例模式

  Dio _dio;

  HttpUtils._internal() {
    if (null == _dio) {
      _dio = new Dio();
      _dio.options.baseUrl = Api.BASE_URL;
      _dio.options.connectTimeout = 30 * 1000;
      _dio.options.sendTimeout = 30 * 1000;
      _dio.options.receiveTimeout = 30 * 1000;
    }
  }


  // url ：网络请求地址
  // parasm : 请求参数
  // get 请求
   Future get(String url, {Map<String, dynamic> params,bool isAddLoading = false ,BuildContext context,String loadingText}) async {
    Response response ;

    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();

    _dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path,ignoreExpires: true)));

    //显示 加载中的 loading
    if(isAddLoading){
      showLoading(context,loadingText);
    }

    try {
      if (params != null) {
        response = await _dio.get(url, queryParameters: params);
      } else {
        response = await _dio.get(url);
      }
      disMissLoadingDialog(isAddLoading, context);
      if(response.data["errorCode"] == 0 ){
        return response;
      }else{
        String data = response.data["errorMsg"];
        ToolUtils.showToast(msg: data);
      }
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response!= null) {
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
      }
      ToolUtils.showToast(msg: handleError(e));
      disMissLoadingDialog(isAddLoading, context);
      return null;
    }
  }



  // url ：网络请求地址
  // formData : 请求参数
  // post 请求
   Future post(String url, {FormData formData,Map<String, dynamic> queryParameters, bool isAddLoading = false ,BuildContext context,String loadingText}) async {
    Response response ;

    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();

    _dio.interceptors.add(CookieManager(PersistCookieJar(dir: dir.path)));

    //显示 加载中的 loading
    if(isAddLoading){
      showLoading(context,loadingText);
    }

    try {
      if(formData!=null){
        response = await _dio.post(url, data: formData);
      }else if(queryParameters != null){
        response = await _dio.post(url, queryParameters: queryParameters);
      }else{
        response = await _dio.post(url);
      }
      disMissLoadingDialog(isAddLoading, context);
      if(response.data["errorCode"] == 0 ){
        return response;
      }else{
        String data = response.data["errorMsg"];
        ToolUtils.showToast(msg: data);
      }
    } on DioError catch (e) {
      // The request was made and the server responded with a status code
      // that falls out of the range of 2xx and is also not 304.
      if (e.response!= null) {
        print(e.response.headers);
        print(e.response.request);
      } else {
        // Something happened in setting up or sending the request that triggered an Error
        print(e.request);
      }
      ToolUtils.showToast(msg: handleError(e));
      disMissLoadingDialog(isAddLoading, context);
      return null;
    }
  }


  void disMissLoadingDialog(bool isAddLoading,BuildContext context){
    if(isAddLoading){
      Navigator.of(context).pop();
    }
  }

  /// 显示Loading
  void showLoading(BuildContext context,String loadText) {
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


  static String handleError(error, {String defaultErrorStr = '未知错误!!!'}) {
    String errStr;
    if (error is DioError) {
      if (error.type == DioErrorType.CONNECT_TIMEOUT) {
        errStr = '连接超时!!!';
      } else if (error.type == DioErrorType.SEND_TIMEOUT) {
        errStr = '请求超时!!!';
      } else if (error.type == DioErrorType.RECEIVE_TIMEOUT) {
        errStr = '响应超时!!!';
      } else if (error.type == DioErrorType.CANCEL) {
        errStr = '请求取消!!!';
      } else if (error.type == DioErrorType.RESPONSE) {
        int statusCode = error.response.statusCode;
        String msg = error.response.statusMessage;

        /// 异常状态码的处理
        switch (statusCode) {
          case 500:
            errStr = '服务器异常!!!';
            break;
          case 404:
            errStr = '未找到资源!!!';
            break;
          default:
            errStr = '$msg[$statusCode]';
            break;
        }
      } else if (error.type == DioErrorType.DEFAULT) {
        errStr = '${error.message}';
        if (error.error is SocketException) {
          errStr = '网络连接超时!!!';
        }
      } else {
        errStr = '未知错误!!!';
      }
    }
    return errStr ?? defaultErrorStr;
  }

}