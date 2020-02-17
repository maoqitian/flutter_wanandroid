import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/route_page_data.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/views/web_page/controller/navigation_control.dart';
import 'package:flutter_wanandroid/views/web_page/controller/web_page_menu.dart';
import 'package:webview_flutter/webview_flutter.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/5 0005
/// email: maoqitian068@163.com
/// des:   web view 页面


class WebViewPage extends StatefulWidget {


  final String routePageData;


  WebViewPage({this.routePageData});


  @override
  State<WebViewPage> createState() {
    return _WebViewPageState();
  }
}

class _WebViewPageState extends State<WebViewPage> {
  //final flutterWebviewPlugin = new FlutterWebviewPlugin();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  RoutePageData routePageData;

  //webview 是否正在加载
  bool isLoading = true;

  @override
  void initState() {
    // widget 初始化
    super.initState();
    routePageData= RoutePageData.fromJson(ToolUtils.string2map(widget.routePageData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        //icon 颜色
        iconTheme: !dataUtils.getIsDarkMode() ? IconThemeData(
          color: Colors.white,
        ) : null,
        leading: webArrowBack(),
        title: Text(
          routePageData.title,
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
           NavigationControls(_controller.future,routePageData),
           WebPageMenu(_controller.future)
        ],
      ),
      body: Stack(children: <Widget>[
        WebView(
          initialUrl: routePageData.url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          javascriptChannels: <JavascriptChannel>[
            _toasterJavascriptChannel(context),
          ].toSet(),
          navigationDelegate: (NavigationRequest request) {
            if(this.mounted){
              setState(() {
                isLoading = true;
              });
            }
            if (request.url.startsWith('https://www.baidu.com/')) {
              print('blocking navigation to $request}');
              return NavigationDecision.prevent;
            }
            print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            print('Page started loading: $url');
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
            if(this.mounted){
              setState(() {
                isLoading = false;
              });
            }
          },
          gestureNavigationEnabled: true,
        ),
        isLoading ? Container(
          child: Center(
            child: SpinKitWanderingCubes(color: ToolUtils.getPrimaryColor(context),shape: BoxShape.circle,
            duration: Duration(milliseconds: 1200),),
          ),
        ) : Container(),
      ],)
    );
  }

  JavascriptChannel _toasterJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'Toaster',
        onMessageReceived: (JavascriptMessage message) {
          Scaffold.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        });
  }


  webArrowBack() {
    return FutureBuilder<WebViewController>(
        future: _controller.future,
        builder: (BuildContext context,
            AsyncSnapshot<WebViewController> snapshot) {
          final bool webViewReady = snapshot.connectionState == ConnectionState.done;
          final WebViewController controller = snapshot.data;
            return IconButton(
              icon: const Icon(Icons.arrow_back_ios,color: Colors.white),
              onPressed: !webViewReady
                  ? (){
                  Navigator.of(context).pop(this);
                  return;
                  }: () async {
                if (await controller.canGoBack()) {
                  await controller.goBack();
                } else {
                  //关闭 webview page
                  Navigator.of(context).pop(this);
                  return;
                }
              },
            );
        });
  }
}
