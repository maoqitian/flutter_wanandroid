/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/10/31 0031
/// email: maoqitian068@163.com
/// des:  导航 page
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/components/tag_item_view.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:flutter_wanandroid/model/navigation/navigation_data.dart';
import 'package:flutter_wanandroid/model/route_page_data.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';


class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> with AutomaticKeepAliveClientMixin{

  //一级导航
  List<NavigationData>  navListData = [];
  //二级导航列表
  List<ArticleData>  navSecondListData = [];
  //二级导航 index
  int index;

  bool loadSuccess = true;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    getNavListData(true);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
      return (navListData.length == 0) ? Container(
        child: loadSuccess ? null :
        ToolUtils.getErrorWidget(context,
            onPressCallBack: (){
              getNavListData(true);
        })
      ):RefreshIndicator(
          onRefresh: _handleRefreshPage,
          color: Theme.of(context).primaryColor,
          child: Row(
            //水平布局排放 两个 ListView 展示导航数据
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              getLeftRowWidget(),
              getRowRowWidget(),
            ],

          ));
    }


  void getNavListData(bool isRefresh) async{
    await dataUtils.getNavigationData(context,isRefresh).then((List<NavigationData> list){
       setState(() {
         //数据请求成功
         navListData.addAll(list);
         loadSuccess = false;
         index = 0;
       });
    },onError: (e){
      setState(() {
        loadSuccess = false;
        navListData.clear();
      });
    });

  }

  //左边一级导航
  getLeftRowWidget() {
    return Expanded(
      flex: 2,
      child: Container(
        color: Colors.white70,
        child: ListView.builder(
            itemCount: navListData.length,
            itemBuilder: (BuildContext context, int index){
                return getRowItem(index);
            }),
      ),
    );
  }

  //右边二级导航
  getRowRowWidget() {
    return Expanded(
      flex: 5,
      child: ListView(
        children: <Widget>[
          Container(
            //height: double.infinity,
            alignment: Alignment.topLeft,
            padding: const EdgeInsets.all(10),
            child: getRightListWidget(index), //传入一级分类下标
          )
        ],
      ),
    );
  }

  getRowItem(int i) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        decoration: BoxDecoration(
          color: index == i ? Colors.white70 : Colors.white,
          border: Border(
            left: BorderSide(
                width: 5,
                color:
                index == i ? Theme.of(context).primaryColor : Colors.white),
          ),
        ),
        child: Text(
          navListData[i].name,
          style: TextStyle(
            color: index == i ? Theme.of(context).primaryColor : Colors.grey,
            fontWeight: index == i ? FontWeight.w600 : FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
      onTap: (){
          setState(() {
            index = i; //记录选中的下标
          });
      },
    );
  }

  //页面刷新
  Future<Null> _handleRefreshPage() async{
    await getNavListData(false);
    return null;
  }
  
  //tag 展示 二级分类 标题
  getRightListWidget(int index) {
    getSecondListData(index);
    return Wrap(
      spacing: 3, //主轴上子控件的间距
      runSpacing: 3, //交叉轴上子控件之间的间距
      // 扩展方式，横向堆砌
      direction: Axis.horizontal,
      // 对齐方式
      alignment: WrapAlignment.start,
      // run的对齐方式 开始位置
      runAlignment: WrapAlignment.start,
      // 交叉轴对齐方式
      crossAxisAlignment: WrapCrossAlignment.end,
      // 文本对齐方向
      textDirection: TextDirection.ltr,
      // 确定垂直放置子元素的顺序，以及如何在垂直方向上解释开始和结束。 默认down
      verticalDirection: VerticalDirection.down,
      //mainAxisAlignment: MainAxisAlignment.spaceAround,
      //mainAxisSize: MainAxisSize.max,//表示尽可能多的占用水平方向的空间，此时无论子widgets实际占用多少水平空间，Row的宽度始终等于水平方向的最大宽度
      children: navSecondListData.map((ArticleData articleData){
        return TagItemView(
            pressCallback: (){
              RoutePageData routePageData = new RoutePageData(articleData.id, articleData.title, articleData.link,Constants.COLLECT_PAGE_TYPE , articleData.collect);
              Application.router.navigateTo(context, '${Routes.webViewPage}?routePageJson=${ToolUtils.object2string(routePageData)}');
            },
            textTitle: articleData.title,
            textColor: Colors.white,
            backgroundColor: ToolUtils.getRandomColor(),
        );
      }).toList(),
    );
  }

  void getSecondListData(int index) {
    setState(() {
      if(navListData.length>0)
      navSecondListData = navListData[index].articles;
    });
  }
}
