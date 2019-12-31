/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-12-31
/// email: maoqitian068@163.com
/// des:  简单dialog 布局 用于 添加收藏 dialog

import 'package:flutter/material.dart';


class SimpleInputDialogLayout extends StatefulWidget {

  //收藏标题
  final String collectTitle;
  //收藏作者
  final String collectAuthor;
  //收藏地址
  final String collectUrl;

  final bool isCollectArticle; //dialog 默认为展示 收藏文章

  final Function(String collectTitle,String collectAuthor,String collectUrl) confirmCallback1; //点击确定按钮回调 收藏文章
  final Function(String collectTitle,String collectUrl) confirmCallback2; //点击确定按钮回调 收藏网站
  final Function dismissCallback ; //弹窗关闭回调
  final bool outsideDismiss; //点击弹窗外部，关闭弹窗，默认为true true：可以关闭 false：不可以关闭


  SimpleInputDialogLayout(
      {this.isCollectArticle = true,
        this.collectTitle,
        this.collectAuthor,
        this.collectUrl,
        this.confirmCallback1,
        this.confirmCallback2,
        this.dismissCallback,
        this.outsideDismiss = true}):
        super();

  @override
  _SimpleInputDialogLayoutState createState() => _SimpleInputDialogLayoutState();
}

class _SimpleInputDialogLayoutState extends State<SimpleInputDialogLayout> {


  GlobalKey<FormState> _dialogFormKey = new GlobalKey();

  // 利用FocusNode和_focusScopeNode来控制焦点 可以通过FocusNode.of(context)来获取widget树中默认的_focusScopeNode
  FocusNode _collectTitleFocusNode = new FocusNode();
  FocusNode _collectAuthorNode = new FocusNode();
  FocusNode _collectUrlFocusNode = new FocusNode();
  FocusScopeNode _focusScopeNode = new FocusScopeNode();

  //获取用户输入的 Controller
  TextEditingController _collectTitleController =
  new TextEditingController();
  TextEditingController _collectAuthorController =
  new TextEditingController();
  TextEditingController _collectUrlController =
  new TextEditingController();


  //输入的收藏标题 作者 链接
  String collectTitle = '';
  String collectAuthor = '';
  String collectUrl = '';


  _dismissDialog() {
    if (widget.dismissCallback != null) {
      widget.dismissCallback();
    }
    Navigator.of(context).pop();
  }

  _confirmDialog() {
    _dismissDialog();
    if (widget.confirmCallback1 != null && widget.isCollectArticle) {
        widget.confirmCallback1(collectTitle,collectAuthor,collectUrl);
      }

    if(widget.confirmCallback2 != null && !widget.isCollectArticle) {
        widget.confirmCallback2(collectTitle,collectUrl);
      }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
        onTap: (){
          widget.outsideDismiss ? _dismissDialog() : null;
        },
        child: Material(
            type: MaterialType.transparency,
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(child: Column( //包裹Column 防止Container 设置宽高不生效 https://zhuanlan.zhihu.com/p/41801871
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: MediaQuery.of(context).size.width*0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        color: Colors.white,
                      ),
                      child: buildContent()
                  )
                ],
              ),)
            ),
        ),
      ),
      onWillPop: () async{
        return widget.outsideDismiss;
      },
    );


  }

  buildContent(){
    return Stack(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SizedBox(height: 20.0),//能强制子控件具有特定宽高
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(widget.isCollectArticle ? "收藏站外文章" :"收藏网站")
              ],
            ),
            buildTextForm(),
            SizedBox(height: 15.0),
            buildButton(),
            SizedBox(height: 15.0),
          ],
        ),
      ],
    );
  }

  normalItemLine(){
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width * 0.75,
      color: Colors.grey[400],
    );
  }

  List<Widget> buildTextFormList(){
    List<Widget> list = [];
    list.add(Flexible(
      child: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
        child: TextFormField(
          controller: _collectTitleController,
          focusNode: _collectTitleFocusNode,
          autofocus: true, //自动获取焦点 打开键盘
          onEditingComplete: (){
            if(_focusScopeNode == null){
              _focusScopeNode = FocusScope.of(context);
            }
            _focusScopeNode.requestFocus(_collectAuthorNode);
          },
          decoration: InputDecoration(
              hintText: widget.isCollectArticle? "收藏文章标题":"收藏网站名称",
              border: InputBorder.none
          ),
          style: TextStyle(fontSize: 16,color: Colors.black),
          //输入验证
          validator: (collecttitle){
            if(collecttitle ==null ||collecttitle.isEmpty){
              return "收藏标题不能为空!";
            }
            return null;
          },
          onSaved: (collecttitle){
            setState(() {
              collectTitle = collecttitle;
            });
          },
        ),
      ),
    ));
    list.add(normalItemLine());
    if(widget.isCollectArticle){ //收藏站外文章
      list.add(Flexible(
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
          child: TextFormField(
            controller: _collectAuthorController,
            focusNode: _collectAuthorNode,
            decoration: InputDecoration(
              hintText: "作者名称",
              border: InputBorder.none,

            ),
            style: TextStyle(fontSize: 16,color: Colors.black),
            //输入验证
            validator: (collectauthor){
              if(collectauthor ==null || collectauthor.isEmpty){
                return "作者名称不能为空!";
              }
              return null;
            },
            onSaved: (collectauthor){
              setState(() {
                collectAuthor = collectauthor;
              });
            },
          ),
        ),
      ));
      list.add(normalItemLine());
    }
    list.add(Flexible(
      child: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
        child: TextFormField(
          controller: _collectUrlController,
          focusNode: _collectUrlFocusNode,
          decoration: InputDecoration(
            hintText: "链接地址",
            border: InputBorder.none,

          ),
          style: TextStyle(fontSize: 16,color: Colors.black),
          //输入验证
          validator: (collectUrl){
            if(collectUrl ==null || collectUrl.isEmpty){
              return "链接地址不能为空!";
            }
            return null;
          },
          onSaved: (collecturl){
            setState(() {
              collectUrl = collecturl;
            });
          },
        ),
      ),
    ),);
    list.add(normalItemLine());
    return list;
  }

  buildTextForm() {
      return Form(
        key: _dialogFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: buildTextFormList(),
        ),
      );
  }

  buildButton() {
    return Container(
      child: Padding(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child:
             RaisedButton(
               color: Theme.of(context).primaryColor,
               child: Text(
                "取消",
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
              onPressed: (){
                _dismissDialog();
              },
            )),
            SizedBox(width: 15.0),
            Expanded(
                child:
                 RaisedButton(
                   color: Theme.of(context).primaryColor,
                   child: Text(
                    "收藏",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: (){
                     if(_dialogFormKey.currentState.validate()){
                       //验证通过
                       _confirmDialog();
                     }
                  },
                ))
          ],
        ),
        padding: EdgeInsets.only(left: 20.0,right: 20.0),
      )
    );
  }
}
