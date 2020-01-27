/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/1/10 0010
/// email: maoqitian068@163.com
/// des:  web_view_page 页面 标题 控制模块
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/model/route_page_data.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';


class NavigationControls extends StatelessWidget {

  const NavigationControls(this._webViewControllerFuture, this.routePageData)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;
  //页面数据 收藏
  final RoutePageData routePageData;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _webViewControllerFuture,
      builder: (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady = snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return Row(
          children: buildIconButton()
        );
      },
    );
  }

  buildIconButton() {
    List<Widget> list =[];
    if(Constants.COLLECT_PAGE_TYPE == routePageData.type){
      list.add(IconButton(
        icon: const Icon(Icons.favorite),
        onPressed:  () async{
          ToolUtils.showToast(msg: "点击了收藏");
        },
      ));
    }
    return list;
  }
}


