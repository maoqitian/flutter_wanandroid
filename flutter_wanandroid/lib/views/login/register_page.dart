/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/27 0027
/// email: maoqitian068@163.com
/// des:  注册页面
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/event/login_event.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/login/login_data.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';


class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {


  GlobalKey<FormState> _registerFormKey = new GlobalKey();

  // 利用FocusNode和_focusScopeNode来控制焦点 可以通过FocusNode.of(context)来获取widget树中默认的_focusScopeNode
  FocusNode _userNameFocusNode = new FocusNode();
  FocusNode _passwordFocusNode = new FocusNode();
  FocusNode _rePasswordFocusNode = new FocusNode();
  FocusScopeNode _focusScopeNode = new FocusScopeNode();

  //获取用户输入的 Controller
  TextEditingController _userNameEditingController =
  new TextEditingController();
  TextEditingController _passwordEditingController =
  new TextEditingController();
  TextEditingController _rePasswordEditingController =
  new TextEditingController();

  //是否显示输入的密码
  bool isShowPassWord = false;
  bool isShowRePassWord = false;
  //输入的用户名 密码
  String userName = '';
  String passWord = '';
  String rePassWord = '';

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
        title: Text("注册",style: TextStyle(color: Colors.white)),
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
                              SizedBox(height: 15.0),
                              buildSignInButton(),
                              SizedBox(height: 15.0),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
               )
      ),
    );
  }

  void _pushBack() {
    Navigator.of(context).pop(this);
  }

  Widget buildSignInTextForm() {
    return Container(
      width: MediaQuery.of(context).size.width*0.8,
      height: 250,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
      ),

      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
                child: TextFormField(
                  controller: _userNameEditingController,
                  focusNode: _userNameFocusNode,
                  onEditingComplete: (){
                    if(_focusScopeNode == null){
                      _focusScopeNode = FocusScope.of(context);
                    }
                    _focusScopeNode.requestFocus(_passwordFocusNode);
                   },
                  decoration: InputDecoration(
                      icon: Icon(Icons.person,color: Colors.black),
                      hintText: "WanAndroid 用户名",
                      border: InputBorder.none
                  ),
                  style: TextStyle(fontSize: 16,color: Colors.black),
                  //输入验证
                  validator: (username){
                    if(username ==null ||username.isEmpty){
                      return "用户名不能为空!";
                    }
                    return null;
                  },
                  onSaved: (username){
                    setState(() {
                      userName = username;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.grey[400],
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
                child: TextFormField(
                  controller: _passwordEditingController,
                  focusNode: _passwordFocusNode,
                  keyboardType: TextInputType.visiblePassword,
                  autofocus: true, //自动获取焦点 打开键盘
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock,color: Colors.black),
                      hintText: "WanAndroid 登录密码",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        color: Colors.black,
                        onPressed: showPassWord,
                      )
                  ),
                  obscureText: !isShowPassWord,
                  style: TextStyle(fontSize: 16,color: Colors.black),
                  //输入验证
                  validator: (password){
                    if(password ==null || password.isEmpty){
                      return "密码不能为空!";
                    }
                    return null;
                  },
                  onSaved: (password){
                    setState(() {
                      passWord = password;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.grey[400],
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
                child: TextFormField(
                  controller: _rePasswordEditingController,
                  focusNode: _rePasswordFocusNode,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock,color: Colors.black),
                      hintText: "确认登录密码",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        color: Colors.black,
                        onPressed: showRePassWord,
                      )
                  ),
                  obscureText: !isShowRePassWord,
                  style: TextStyle(fontSize: 16,color: Colors.black),
                  //输入验证
                  validator: (repassword){
                    if(repassword ==null || repassword.isEmpty){
                      return "确认密码不能为空!";
                    }
                    return null;
                  },
                  onSaved: (repassword){
                    setState(() {
                      rePassWord = repassword;
                    });
                  },
                ),
              ),
            ),
            Container(
              height: 1,
              width: MediaQuery.of(context).size.width * 0.75,
              color: Colors.grey[400],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSignInButton() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          buildSingButton("完成注册并登录")
        ],
      ),
    );
  }

  void showPassWord() {
    setState(() {
      isShowPassWord = !isShowPassWord;
    });
  }

  void showRePassWord() {
    setState(() {
      isShowRePassWord = !isShowRePassWord;
    });
  }

    Widget buildSingButton(String text) {
      return GestureDetector(
        child: Container(
          padding: EdgeInsets.only(left: 42, right: 42, top: 8, bottom: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Theme.of(context).primaryColor,boxShadow: [ //阴影
            BoxShadow( //阴影
                color:Colors.black12,
                offset: Offset(2.0,2.0),
                blurRadius: 4.0
            )
          ]
          ),
          child: Text(
            text,
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
        ),
        onTap: () {
          // 利用key来获取widget的状态FormState,可以用过FormState对Form的子孙FromField进行统一的操作
          if (_registerFormKey.currentState.validate() ) {
            // 如果输入都检验通过，则进行注册操作
            // 注册
            doRegister();
          }
        },
      );
    }

  void doRegister() async {
     _registerFormKey.currentState.save();
     if(passWord != rePassWord){
       ToolUtils.ShowToast(msg: "两次输入的密码不一致！！");
       return;
     }
     LoginData loginData = await DataUtils.getRegisterData(userName, passWord, rePassWord,context);
     // events_bus
     DataUtils.setUserName(loginData.username);
     DataUtils.setLoginState(true);
     //发出 登录成功事件
     Application.eventBus.fire(new LoginEvent(loginData));
     ToolUtils.ShowToast(msg: "注册成功");
     //退出当前页面
     Application.router.navigateTo(context,Routes.root);
  }
}
