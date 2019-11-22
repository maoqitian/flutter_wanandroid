/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/5 0005
/// email: maoqitian068@163.com
/// des:  轮播图 widget
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/home_banner.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/banner/bannerdata.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/routers/routes.dart';


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
    Application.router.navigateTo(context,
        '${Routes.webViewPage}?title=${Uri.encodeComponent(bannerData.title)}&url=${Uri.encodeComponent(bannerData.url)}');

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      key: Key('__header__'),
      children: _list,
    );
  }

  void loadData() async{
    var list = await DataUtils.getBannerData();
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


