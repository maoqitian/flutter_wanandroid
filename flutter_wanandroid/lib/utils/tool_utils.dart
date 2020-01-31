import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cookie_jar/cookie_jar.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/8 0008
/// email: maoqitian068@163.com
/// des:  工具类
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';


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
        .replaceAll("&amp;", "&")
        .replaceAll("&permil;", "‰")
        .replaceAll("&lsaquo;", "‹")
        .replaceAll("&rsaquo;", "›")
        .replaceAll("&euro;", "€")
        .replaceAll("&quot;","'")
        .replaceAll("<p>", "")
        .replaceAll("&middot;","·")
        .replaceAll("&hellip;", "...")
        .replaceAll("</p>", "")
        .replaceAll("</br>", "\n")
        .replaceAll("<br>", "\n")
    ;
  }


  // 显示 Toast
  static void showToast({String msg}){
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

  //获取本地资源图片
  static String getImage(String imageName,{String format:'png'}){
    return "images/$imageName.$format";
  }

  //清除 cookie 缓存
  static void clearCookie() async{
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String documentsPath = documentsDir.path;
    var dir = new Directory("$documentsPath/cookies");
    await dir.create();
    PersistCookieJar(dir: dir.path).deleteAll();
  }

  //获取主题颜色
  static Color getPrimaryColor(BuildContext context){
    return Theme.of(context).primaryColor;
  }



  /// object 转为 string json
  static String object2string<T>(T t) {
    return fluroCnParamsEncode(jsonEncode(t));
  }

  static String fluroCnParamsEncode(String originalCn) {
    return jsonEncode(Utf8Encoder().convert(originalCn));
  }

  /// string json 转为 map
  static Map<String, dynamic> string2map(String str) {
    return json.decode(fluroCnParamsDecode(str));
  }

  /// fluro 传递后取出参数，解析
  static String fluroCnParamsDecode(String encodeCn) {
    var list = List<int>();

    ///字符串解码
    jsonDecode(encodeCn).forEach(list.add);
    String value = Utf8Decoder().convert(list);
    return value;
  }

  //Dialog 封装
  static void showAlertDialog(BuildContext context,
      String contentText,{Function confirmCallback,
        Function dismissCallback,String confirmText = ""}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(contentText),
          actions: <Widget>[
            FlatButton(
              child: Text('我手滑了'),
              onPressed: () {
                if(dismissCallback!=null){
                  dismissCallback();
                }
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(confirmText == "" ? '注销':confirmText),
              onPressed: () {
                if(confirmCallback != null){
                  confirmCallback();
                }
                Navigator.of(context).pop();
              },
            )
          ],
          elevation: 20, //阴影
        );
      },
    );
  }


  static Color getRandomColor() {
    Random random = Random();
    var temp = random.nextInt(6);
    List<Color> colors = [
      Colors.blueAccent,
      Colors.yellowAccent ,
      Colors.redAccent,
      Colors.purpleAccent,
      Colors.lightGreenAccent,
      Colors.deepOrangeAccent,
    ];
    /*int r = 0;
    int g = 0;
    int b = 0;
    bool dark = ThemeUtils.dark; // 是否是夜间模式
    if (!dark) {
      // 0-190, 如果颜色值过大,就越接近白色,就看不清了,所以需要限定范围
      r = random.nextInt(190);
      g = random.nextInt(190);
      b = random.nextInt(190);
    } else {
      // 150-255
      r = random.nextInt(105) + 150;
      g = random.nextInt(105) + 150;
      b = random.nextInt(105) + 150;
    }*/
    return colors[temp];
  }


  static Widget getErrorWidget(BuildContext context,{Function onPressCallBack}){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text("页面出错了！！"),
        RaisedButton(
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          child: Text("重新加载"),
          onPressed: () {
            if(onPressCallBack !=null){
              onPressCallBack();
            }
          },
        )
      ],
    );
  }

  //清除缓存
  static void clearCache() async {
    Directory tempDir = await getTemporaryDirectory();
    //删除缓存目录
    await delDir(tempDir);
    //清除图片缓存
    PaintingBinding.instance.imageCache.clear();
    //await loadCache();
    showToast(msg: '清除缓存成功');
  }

  ///递归方式删除目录
  static Future<Null> delDir(FileSystemEntity file) async {
    if (file is Directory) {
      final List<FileSystemEntity> children = file.listSync();
      for (final FileSystemEntity child in children) {
        await delDir(child);
      }
    }
    await file.delete();
  }

}