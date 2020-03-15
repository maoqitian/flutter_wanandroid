/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020-01-27
/// email: maoqitian068@163.com
/// des: 常用网站 page

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/components/tag/tag_item_view.dart';
import 'package:flutter_wanandroid/data/data_utils.dart';
import 'package:flutter_wanandroid/model/friend/friend_data.dart';
import 'package:flutter_wanandroid/model/route_page_data.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';


class CommonWebPage extends StatefulWidget {

  @override
  _CommonWebPageState createState() => _CommonWebPageState();
}

class _CommonWebPageState extends State<CommonWebPage> {

  List<FriendData> dataList = [];

  @override
  void initState() {
    super.initState();
    getCommonWebListData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: (){
              Navigator.of(context).pop(this);
            }),
        title: Text("常用网站",style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,color: Colors.white)),
        centerTitle: true,
      ),
      body: buildCommonWebPage(),
    );
  }

  buildCommonWebPage() {
     return  Wrap(
         spacing: 3, //主轴上子控件的间距
         runSpacing: 3, //交叉轴上子控件之间的间距
         // 扩展方式，横向堆砌
         direction: Axis.horizontal,
         // 对齐方式
         alignment: WrapAlignment.center,
         // run的对齐方式 开始位置
         runAlignment: WrapAlignment.center,
         // 交叉轴对齐方式
         crossAxisAlignment: WrapCrossAlignment.end,
         // 文本对齐方向
         textDirection: TextDirection.ltr,
         // 确定垂直放置子元素的顺序，以及如何在垂直方向上解释开始和结束。 默认down
         verticalDirection: VerticalDirection.down,
         //mainAxisAlignment: MainAxisAlignment.spaceAround,
         //mainAxisSize: MainAxisSize.max,//表示尽可能多的占用水平方向的空间，此时无论子widgets实际占用多少水平空间，Row的宽度始终等于水平方向的最大宽度
         children: dataList.map((FriendData friendData){
           return TagItemView(
             pressCallback: (){
               RoutePageData routePageData = new RoutePageData(friendData.id, friendData.name, friendData.link,Constants.NOT_COLLECT_PAGE_TYPE , false);
               Application.router.navigateTo(context, '${Routes.webViewPage}?routePageJson=${ToolUtils.object2string(routePageData)}');
             },
             textTitle: friendData.name,
             textColor: Colors.white,
             backgroundColor: ToolUtils.getRandomColor(),
           );
         }).toList(),
     );
  }

  void getCommonWebListData() async{
    await dataUtils.getFriendListData(context).then((List<FriendData> list){
      setState(() {
        dataList.clear();
        dataList.addAll(list);
      });
    },onError: (e){
        ToolUtils.showToast(msg: "获取数据常用网站数据失败");
    });
  }
}
