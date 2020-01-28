/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-12-31
/// email: maoqitian068@163.com
/// des:  简单dialog 布局 用于 添加收藏 dialog

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';


class SimpleInputDialogLayout extends StatefulWidget {

  //收藏标题
  final String collectTitle;
  //收藏作者
  final String collectAuthor;
  //收藏地址
  final String collectUrl;

  // 自定义分享 配置
  final String dialogTitleText; //弹窗title
  final String themeText; //自定Dialog 主题文字 （例如 分享）
  //是否自定义 弹窗文字显示
  final bool isDIYText;

  //收藏模块配置
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
        this.outsideDismiss = true,
        this.isDIYText = false,
        this.dialogTitleText, this.themeText}):
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
  TextEditingController _collectAuthorController =
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

  _confirmDialog() async{
    if (widget.confirmCallback1 != null && widget.isCollectArticle) {
        await widget.confirmCallback1(collectTitle,collectAuthor,collectUrl);
      }
    if(widget.confirmCallback2 != null && !widget.isCollectArticle) {
       await widget.confirmCallback2(collectTitle,collectUrl);
      }
    _dismissDialog();
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
              body: SingleChildScrollView( //让包裹的 widget 可以滑动 防止布局溢出
                child: Center(
                      child:Container(
                          width: MediaQuery.of(context).size.width*0.85,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(8.0)),
                            color: Colors.white,
                          ),
                          child: buildContent()
                      )
                )
              )
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
                Text(widget.isDIYText ? widget.dialogTitleText :(widget.isCollectArticle ? "收藏站外文章" :"收藏网站"))
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
          //设置默认值 和光标位置  编辑
          controller: TextEditingController.fromValue(TextEditingValue(
            text: ToolUtils.isNullOrEmpty(widget.collectTitle) ? "" : widget.collectTitle,
            selection: TextSelection.fromPosition(TextPosition(
                affinity: TextAffinity.downstream,
                offset:ToolUtils.isNullOrEmpty(widget.collectTitle) ? 0 : widget.collectTitle.length
            ))
          )),
          focusNode: _collectTitleFocusNode,
          autofocus: true, //自动获取焦点 打开键盘
          onEditingComplete: (){
            if(_focusScopeNode == null){
              _focusScopeNode = FocusScope.of(context);
            }
            _focusScopeNode.requestFocus(_collectAuthorNode);
          },
          decoration: InputDecoration(
              hintText: widget.isDIYText? widget.themeText+"标题":(widget.isCollectArticle? "收藏文章标题":"收藏网站名称"),
              border: InputBorder.none
          ),
          style: TextStyle(fontSize: 16,color: Colors.black),
          //输入验证
          validator: (collecttitle){
            if(collecttitle ==null ||collecttitle.isEmpty){
              return widget.isDIYText? widget.themeText+"标题不能为空!":"收藏标题不能为空!";
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
          controller: TextEditingController.fromValue(TextEditingValue(
              text: ToolUtils.isNullOrEmpty(widget.collectUrl) ? "" : widget.collectUrl,
              selection: TextSelection.fromPosition(TextPosition(
                  affinity: TextAffinity.downstream,
                  offset:ToolUtils.isNullOrEmpty(widget.collectUrl) ? 0 : widget.collectUrl.length
              ))
          )),
          focusNode: _collectUrlFocusNode,
          decoration: InputDecoration(
            hintText: "链接地址",
            border: InputBorder.none,
          ),
          style: TextStyle(fontSize: 16,color: Colors.black),
          //输入验证
          validator: (collecturl){
            if(collecturl ==null || collecturl.isEmpty){
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
                    widget.isDIYText ? widget.themeText : "收藏",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  onPressed: (){
                     if(_dialogFormKey.currentState.validate()){
                       _dialogFormKey.currentState.save();
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
