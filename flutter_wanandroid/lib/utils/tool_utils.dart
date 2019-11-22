/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/8 0008
/// email: maoqitian068@163.com
/// des:  工具类
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


class ToolUtils{

  //判断 字符串 是否为空
  static bool isNullOrEmpty(String str) {
    return str == null || str.length <= 0;
  }

  //标题符号转换
  static String signToStr(String str) {
    return str
        .replaceAll(RegExp("(<em[^>]*>)|(</em>)"), "")
        .replaceAll(RegExp("\n{2,}"), "\n")
        .replaceAll(RegExp("\s{2,}"), " ")
        .replaceAll("&ndash;", "–")
        .replaceAll("&mdash;", "—")
        .replaceAll("&lsquo;", "‘")
        .replaceAll("&rsquo;", "’")
        .replaceAll("&sbquo;", "‚")
        .replaceAll("&ldquo;", "“")
        .replaceAll("&rdquo;", "”")
        .replaceAll("&bdquo;", "„")
        .replaceAll("&permil;", "‰")
        .replaceAll("&lsaquo;", "‹")
        .replaceAll("&rsaquo;", "›")
        .replaceAll("&euro;", "€")
        .replaceAll("&quot;","'")
        .replaceAll("<p>", "")
        .replaceAll("</p>", "")
        .replaceAll("</br>", "\n")
        .replaceAll("<br>", "\n")
    ;
  }


  static void ShowToast({String msg}){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }

}