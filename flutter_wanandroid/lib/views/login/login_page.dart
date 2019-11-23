import 'dart:math';

/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/21 0021
/// email: maoqitian068@163.com
/// des:  登录页
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  GlobalKey<FormState> _signInFormKey = new GlobalKey();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back,color: Colors.white,),
              onPressed: _pushBack),
          title: Text("登录", style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
           child: Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
             color: Theme.of(context).primaryColor,
             child: Center(
               child: Container(
                 width: MediaQuery.of(context).size.width*0.85,
                 decoration: BoxDecoration(
                   borderRadius: BorderRadius.all(Radius.circular(8.0)),
                   color: Colors.white,
                 ),
                 child: Stack(
                    children: <Widget>[
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(height: 20.0),//能强制子控件具有特定宽高
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Image.asset(ToolUtils.getImage("ic_launcher"),
                                  fit: BoxFit.contain,
                                  width: 60.0,
                                  height: 60.0
                              )
                            ],
                          ),
                          buildSignInTextForm(),
                          buildSignInButton(),
                          SizedBox(height: 15.0),
                        ],
                      ),

                    ],
                 ),
               ),
             ),
           ),
        ),
    );
  }

  //创建登录界面的TextForm
  Widget buildSignInTextForm() {

    return Container(

    );

  }

  //创建登录界面的登录 注册按钮
  Widget buildSignInButton() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          buildSingButton("注册",false),
          SizedBox(width: 15.0),
          buildSingButton("登录", true)
        ],
      ),
    );

  }

  void _pushBack() {
    Navigator.of(context).pop(this);
  }

  //登录
  void doLogin() {
    print("执行登录逻辑");
  }
  //注册
  doRegister() {
    print("执行注册逻辑");
  }

  Widget buildSingButton(String text,bool isLogin) {
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.only(left: 42, right: 42, top: 8, bottom: 8),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            color: Theme.of(context).primaryColor),
        child: Text(
          text,
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
      ),
      onTap: () {
        // 利用key来获取widget的状态FormState,可以用过FormState对Form的子孙FromField进行统一的操作
        if (_signInFormKey.currentState.validate() && isLogin) {
          // 如果输入都检验通过，则进行登录操作
          // Scaffold.of(context)
          //     .showSnackBar(new SnackBar(content: new Text("执行登录操作")));
          //调用所有自孩子��save回调，保存表单内容
          doLogin();
        }else{
          // 跳转注册
          doRegister();
        }
      },
    );
  }


}
