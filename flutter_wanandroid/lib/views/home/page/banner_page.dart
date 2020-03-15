/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/5 0005
/// email: maoqitian068@163.com
/// des:  轮播图 widget
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/components/banner/home_banner.dart';
import 'package:flutter_wanandroid/data/data_utils.dart';
import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:flutter_wanandroid/model/banner/banner_data.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/model/route_page_data.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';


class BannerPage extends StatefulWidget {
  @override
  _BannerPageState createState() => _BannerPageState();
}

class _BannerPageState extends State<BannerPage> {

  //轮播图数据
  List <BannerData> _bannerList = [];
  //存放每个 banner
  List<Widget> _list = [];

  @override
  void initState() {
    super.initState();
    loadData();
  }

  // banner 跳转 webViewPage
  void _launchURL(BannerData bannerData)  {
    RoutePageData routePageData = new RoutePageData(bannerData.id, bannerData.title, bannerData.url,Constants.NOT_COLLECT_PAGE_TYPE , false);
    Application.router.navigateTo(context,
        '${Routes.webViewPage}?routePageJson=${ToolUtils.object2string(routePageData)}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key('__header__'),
      children: _list,
    );
  }

  void loadData() async{
    var list = await dataUtils.getBannerData();
      if(mounted){
        setState(() {
          _bannerList = list;
          if(_bannerList.length > 0 ){
            _list.add(HomeBanner(_bannerList,(bannerData){
              _launchURL(bannerData);
            }));
          }
        });
      }
    }

}


