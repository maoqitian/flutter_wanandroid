/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/5 0005
/// email: maoqitian068@163.com
/// des:   web view 页面 flutter_webview_plugin

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class WebViewPage extends StatefulWidget {

  final String url;
  final String title;

  WebViewPage(this.url,this.title);

  @override
  State<WebViewPage> createState(){
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {

  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // widget 初始化
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: _pushBack),
        title: Text(widget.title,
         style: TextStyle(color: Colors.white),
        ),

      ),
      body: WebviewScaffold(
        url: widget.url,
        withZoom: false,
        withJavascript: true,
        withLocalStorage: true,
      ),
    );
  }

  void _pushBack() {
    Navigator.of(context).pop(this);
  }
}
