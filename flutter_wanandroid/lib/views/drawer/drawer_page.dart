/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/8 0008
/// email: maoqitian068@163.com
/// des:  侧边栏 抽屉
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/components/single_theme_color.dart';
import 'package:flutter_wanandroid/routers/application.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
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

  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        UserAccountsDrawerHeader(
           accountName: Text("maoqitian"),
           accountEmail: Container(
             padding: const EdgeInsets.only(bottom: 20.0),
             child: Text(
               //hasLogin ? widget.userInfo.username : ' ',
               "maoqitian@gmail.com",
               style: TextStyle(fontSize: 15.0),
             ),
           ),
           currentAccountPicture: CircleAvatar(
               backgroundImage: NetworkImage('https://hbimg.huabanimg.com/9bfa0fad3b1284d652d370fa0a8155e1222c62c0bf9d-YjG0Vt_fw658'),
           ),
           onDetailsPressed: (){
              print("点击跳转用户中心或者登录页");
              Application.router.navigateTo(context,Routes.login);
           },
           /*decoration: BoxDecoration(
             image: new DecorationImage(
               fit: BoxFit.cover,
               image: new NetworkImage(
                   //hasLogin ? widget.userInfo.avatarPic :
                   'https://hbimg.huabanimg.com/9bfa0fad3b1284d652d370fa0a8155e1222c62c0bf9d-YjG0Vt_fw658'),
             ),
           ),*/
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
            //pushPage(context, SearchPage(), pageName: "SearchPage");
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
            //pushPage(context, SearchPage(), pageName: "SearchPage");
            ///关闭侧边栏
            Navigator.pop(context);
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
            //pushPage(context, SearchPage(), pageName: "SearchPage");
            ///关闭侧边栏
            Navigator.pop(context);
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
            //pushPage(context, SearchPage(), pageName: "SearchPage");
            ///关闭侧边栏
            Navigator.pop(context);
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
            //pushPage(context, SearchPage(), pageName: "SearchPage");
            ///关闭侧边栏
            Navigator.pop(context);
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
            //pushPage(context, SearchPage(), pageName: "SearchPage");
            ///关闭侧边栏
            Navigator.pop(context);
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
            //pushPage(context, SearchPage(), pageName: "SearchPage");
            ///关闭侧边栏
            Navigator.pop(context);
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
            //pushPage(context, SearchPage(), pageName: "SearchPage");
            ///关闭侧边栏
            Navigator.pop(context);
          },
        ),
      ],
    );
  }

  Future<Dialog> buildSimpleDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context){
          return Dialog(
            child: Container(
               //symmetric({ vertical, horizontal })：用于设置对称方向的填
               padding: const EdgeInsets.symmetric(vertical: 10.0),
               height: 300,
               color: Colors.white,
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
                      padding: const EdgeInsets.only(top: 20.0),
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
}
