/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/24 0024
/// email: maoqitian068@163.com
/// des:  收藏网站 view item
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/MyIcons.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/common/event/cancel_event.dart';
import 'package:flutter_wanandroid/components/simple_input_dialog_layout.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/collect/collect_web_data.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/model/route_page_data.dart';
class CollectWebViewItem extends StatefulWidget {

  final CollectWebData collectWebData;

  CollectWebViewItem({Key key,this.collectWebData}):super(key : key);

  @override
  _CollectWebViewItemState createState() => _CollectWebViewItemState();
}

class _CollectWebViewItemState extends State<CollectWebViewItem> {


  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0,vertical: 6.0),
      child: ListTile(
        onTap: (){ //link 跳转  webview
          //routePageJson=${ToolUtils.object2string(routePageData)
          RoutePageData routePageData = new RoutePageData(widget.collectWebData.id, widget.collectWebData.name, widget.collectWebData.link,Constants.NOT_COLLECT_PAGE_TYPE , false);
          Application.router.navigateTo(context, '${Routes.webViewPage}??routePageJson=${ToolUtils.object2string(routePageData)}');
        },
        title: Padding( //文章标题
          padding: EdgeInsets.only(top: 10.0,bottom: 10.0),
          child: Text(
              ToolUtils.signToStr(widget.collectWebData.name),
              style: TextStyle(color: Colors.black, fontSize: 15.0),
              maxLines: 1, // title 只显示一行
              overflow: TextOverflow.ellipsis //超出一行 显示 ...
          )
        ),
        subtitle: Row(
          children: <Widget>[
              Expanded(
                child: IconButton(icon: Icon(Icons.edit,size: 20.0),onPressed: (){
                   //编辑 收藏网站
                  showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return SimpleInputDialogLayout(
                          isCollectArticle: false,
                          collectTitle: widget.collectWebData.name,
                          collectUrl: widget.collectWebData.link,
                          confirmCallback2: (collectTitle,collectUrl)async{
                          //编辑收藏网站
                          await dataUtils.getUpdateCollectWebData(widget.collectWebData.id ,collectTitle, collectUrl, context);
                          ToolUtils.showToast(msg: "修改成功");
                          Application.eventBus.fire(new CollectEvent());
                        },
                        );
                      }
                  );
                },),
              ),
              Expanded( //占位
                flex: 2,
                child: Container(),
              ),
              Expanded(
                child: IconButton(icon: Icon(MyIcons.delete,size: 20.0),onPressed: (){
                  ToolUtils.showAlertDialog(context, "确定删除收藏网站"+widget.collectWebData.name+"?",
                      confirmCallback: ()async{
                        // 删除收藏网站
                        await dataUtils.getDeleteCollectWeb(widget.collectWebData.id);
                        Application.eventBus.fire(new CollectEvent());
                        ToolUtils.showToast(msg: "删除收藏网站成功");
                  },confirmText: "确定");
                },),
              ),

          ],
        ),
      ),
    );
  }
}
