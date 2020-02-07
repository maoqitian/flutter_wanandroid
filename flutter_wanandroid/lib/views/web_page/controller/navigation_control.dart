/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/1/10 0010
/// email: maoqitian068@163.com
/// des:  web_view_page 页面 标题 控制模块
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/route_page_data.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';


class NavigationControls extends StatefulWidget {

  const NavigationControls(this._webViewControllerFuture, this.routePageData)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;
  //页面数据 收藏
  final RoutePageData routePageData;

  @override
  _NavigationControlsState createState() => _NavigationControlsState();
}

class _NavigationControlsState extends State<NavigationControls> {


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: widget._webViewControllerFuture,
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
    if(Constants.COLLECT_PAGE_TYPE == widget.routePageData.type){
      list.add(IconButton(
          icon: Icon(
              widget.routePageData.collect
                  ? Icons.favorite
                  : Icons.favorite_border,
              color: widget.routePageData.collect
                  ? Colors.deepOrange
                  : Colors.white,
              size: 25.0),
          onPressed:  () async{
          await clickCollection();
       },
      ));
  }
    return list;
  }

   clickCollection() async {
    if (!dataUtils.hasLogin()) {
      Application.router.navigateTo(context, Routes.login);
      ToolUtils.showToast(msg: "请先登录");
      return;
    }
    if (widget.routePageData.collect) {
      //取消收藏
      await dataUtils.getCancelCollectInnerArticle(widget.routePageData.id);
      setState(() {
        widget.routePageData.collect = false;
      });
      ToolUtils.showToast(msg: "取消收藏成功");
    } else {
      //添加收藏
      await dataUtils.getCollectInnerArticle(widget.routePageData.id);
      setState(() {
        widget.routePageData.collect = true;
      });
      ToolUtils.showToast(msg: "收藏成功");
    }
  }

}


