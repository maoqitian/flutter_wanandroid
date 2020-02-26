/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/8 0008
/// email: maoqitian068@163.com
/// des:  侧边栏 抽屉
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/common/event/login_event.dart';
import 'package:flutter_wanandroid/common/event/login_out_event.dart';
import 'package:flutter_wanandroid/components/single_theme_color.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/coin/coin_user_info.dart';
import 'package:flutter_wanandroid/model/login/login_data.dart';
import 'package:flutter_wanandroid/res/colours.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';
import 'package:flutter_wanandroid/widget/stroke_widget.dart';
import '../../common/MyIcons.dart';


const List<Map<String, dynamic>> defalutThemeColor = [
  {'cnName': 'Flutter蓝', 'value': 0xFF3391EA},
  {'cnName': '姨妈红', 'value': 0xFFC91B3A},
  {'cnName': '橘子橙', 'value': 0xFFF7852A},
  {'cnName': '骚烈黄', 'value': 0xFFFFC800},
  {'cnName': '早苗绿', 'value': 0xFFC0FF3E},
  {'cnName': '基佬紫', 'value': 0xFFBF3EFF},
  {'cnName': '少女粉', 'value': 0xFFFF6EB4},
  {'cnName': '淡雅灰', 'value': 0xFF949494}
];

class DrawerPage extends StatefulWidget {
  @override
  _DrawerPageState createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {

  final TextStyle textStyle =
  TextStyle(fontSize: 16, fontWeight: FontWeight.w300);


  bool isLogin = false;

  LoginData loginData;
  String username;
  int coin =0;
  int level =0;
  @override
  void initState() {
    super.initState();
    isLogin = dataUtils.hasLogin();

    if(isLogin){
      //如果已经登陆  获取积分 等级 保持积分数据更新
      getCoinUserInfo();
    }
    Application.eventBus.on<LoginEvent>().listen((event) {
      if(this.mounted){
        setState((){
          isLogin = true;
          loginData = event.loginData;
        });
        //获取积分 等级
        getCoinUserInfo();
      }
    });

    Application.eventBus.on<LoginOutEvent>().listen((event){
      if(this.mounted){
        setState(() {
          isLogin = false;
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
           accountName: Text(isLogin ? dataUtils.getUserName():"点击头像登录",
                 style:TextStyle(color: Colors.white,
                     fontWeight: FontWeight.bold )),
           accountEmail: Container(
             padding: const EdgeInsets.only(bottom: 10.0),
             child: Row(
                 children: buildCoinWidget(isLogin)
               )
           ),
           currentAccountPicture:
           InkWell(
             borderRadius: BorderRadius.all(Radius.circular(10.0)),
             child: CircleAvatar(
               backgroundColor: Colors.white,//显示头像
               backgroundImage: AssetImage(isLogin ? ToolUtils.getImage("ic_launcher_foreground"):ToolUtils.getImage("ic_default_avatar",format: "webp")), //'https://hbimg.huabanimg.com/9bfa0fad3b1284d652d370fa0a8155e1222c62c0bf9d-YjG0Vt_fw658'
             ),
             onTap: (){
                 if(!isLogin){
                   // 没有登录 跳转登录页面
                   Application.router.navigateTo(context,Routes.login);
                 }else{
                   //登录则跳转用户中心
                   print("点击跳转用户中心");
                   Application.router.navigateTo(context,'${Routes.userCenterPage}?type=${Uri.encodeComponent(Constants.USER_CENTER_PAGE_TYPE)}');
                 }
              },
             ),
           decoration: BoxDecoration(
             color: dataUtils.getIsDarkMode() ? Colours.dark_unselected_item_color : ToolUtils.getPrimaryColor(context),
           ),
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            size: 27.0,
          ),
          title: Text(
            '首页',
            style: textStyle,
          ),
          onTap: () {
            ///关闭侧边栏
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.surround_sound,
            size: 27.0,
          ),
          title: Text(
            '广场',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(false,Routes.shareArticlePage);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.format_list_bulleted,
            size: 27.0,
          ),
          title: Text(
            '常用网站',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(false,Routes.commonWebPage);
          },
        ),
        ListTile(
          leading: Icon(
            MyIcons.collection,
            size: 27.0,
          ),
          title: Text(
            '我的收藏',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(true,Routes.collectItemPage);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.question_answer,
            size: 27.0,
          ),
          title: Text(
            '问答',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(false,Routes.questionAnswerPage);
          },
        ),
        ListTile(
          leading: Icon(
            MyIcons.todo,
            size: 27.0,
          ),
          title: Text(
            'TODO',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(true,Routes.todoPage);
          },
        ),
        new Divider(),
        ListTile(
          leading: Icon(
            MyIcons.rank,
            size: 27.0,
          ),
          title: Text(
            '积分排行榜',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(false,Routes.coinRankPage);
          },
        ),
        ListTile(
          leading: Icon(
            MyIcons.coin,
            size: 27.0,
          ),
          title: Text(
            '我的积分',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(true,Routes.userCoinPage);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.color_lens,
            size: 27.0,
          ),
          title: Text(
            '主题',
            style: textStyle,
          ),
          onTap: () {
            //pushPage(context, SearchPage(), pageName: "SearchPage");
            ///显示主题 dialog
            buildSimpleDialog(context);
          },
        ),
        ListTile(
          leading: Icon(
            Icons.settings,
            size: 27.0,
          ),
          title: Text(
            '设置',
            style: textStyle,
          ),
          onTap: () {
            checkLoginGoPage(false,Routes.settingPage);
          },
        ),
      ],
    );
  }

  // 主题切换 dialog
  Future<Dialog> buildSimpleDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            child: Container(
               //symmetric({ vertical, horizontal })：用于设置对称方向的填
               padding: const EdgeInsets.symmetric(vertical: 10.0),
               height: 300,
               child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                     Center(
                        heightFactor: 2.0,
                        child:Text("主题切换"),
                      ),
                    Wrap(
                      spacing: 10, //主轴上子控件的间距
                      runSpacing: 10, //交叉轴上子控件之间的间距
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
                      children: buildThemeColorChildren(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: RaisedButton(
                        textColor: Colors.white,
                        color: Theme.of(context).primaryColor,
                        child: Text(
                            "关闭"
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        padding: const EdgeInsets.all(5.0),
                      ),
                    ),
                  ],
               )
            ),
          );
        }
    );
  }

  List<Widget> buildThemeColorChildren() {
    List<Widget> colorChildList =  new List<Widget>();
    for(int i = 0; i< defalutThemeColor.length;i++){
        colorChildList.add(SingleThemeColor(
          colorName: defalutThemeColor[i]['cnName'],
          themeColor: defalutThemeColor[i]['value'],
        ));
    }
    return colorChildList;
  }

  void getCoinUserInfo() async{
    CoinUserInfo coinUserInfo = await dataUtils.getCoinUserInfo();
    setState(() {
      coin = coinUserInfo.coinCount;
      level = coinUserInfo.level;
    });
  }

  //显示 等级 和 积分信息
  List<Widget> buildCoinWidget(bool isLogin) {
    List<Widget> list = [];
    if(isLogin){
       list.add(Padding(
         child: StrokeWidget(
             strokeWidth: 2,
             edgeInsets: EdgeInsets.symmetric(horizontal: 2.0, vertical: 0.0),
             color: Colors.white,
             childWidget: Text( "lv "+level.toString(), style: TextStyle(fontSize: 11.0, color: Colors.white, fontWeight: FontWeight.bold))
         ),
         padding: EdgeInsets.only(right: 10.0),
       ));
       list.add(Text(
         isLogin ? "积分："+ coin.toString():'',
         style: TextStyle(color: Colors.white,fontSize: 15.0),
       ));
    }
    return list;
  }

  void doLoginOut() async{
    //退出登录
    await dataUtils.getLoginOut();
    //发出 登录成功事件
    Application.eventBus.fire(new LoginOutEvent());
    dataUtils.setUserName("");
    dataUtils.setLoginState(false);
    ToolUtils.showToast(msg: "退出登录成功");
  }

  //判断页面跳转是否需要检查登录
  void checkLoginGoPage(bool isNeedCheck,String pageType) {
    if(isNeedCheck){
      //是否需要检查登录
      if(!isLogin){
        // 没有登录 跳转登录页面
        Application.router.navigateTo(context,Routes.login);
      }else{
        ///关闭侧边栏
        Navigator.pop(context);
        //登录则跳转用户中心
        Application.router.navigateTo(context,pageType);
      }
    }else{
      ///关闭侧边栏
      Navigator.pop(context);
      Application.router.navigateTo(context, pageType);
    }
  }
}
