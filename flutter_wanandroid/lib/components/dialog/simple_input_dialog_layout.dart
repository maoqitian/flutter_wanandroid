import 'package:date_format/date_format.dart';

/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-12-31
/// email: maoqitian068@163.com
/// des:  简单dialog 布局 用于 添加收藏 dialog

import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/Page.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/components/tag/single_select_tag_view.dart';
import 'package:flutter_wanandroid/http/data_utils.dart';
import 'package:flutter_wanandroid/model/todo/todo_data.dart';
import 'package:flutter_wanandroid/res/colours.dart';
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

  final bool isTodoDialog; //是否为 tododialog 默认为fals

  final Function(String collectTitle, String collectAuthor, String collectUrl)
      confirmCallback1; //点击确定按钮回调 收藏文章
  final Function(String collectTitle, String collectUrl)
      confirmCallback2; //点击确定按钮回调 收藏网站
  final Function(Map<String, dynamic> requestParams)
      confirmCallback3; //点击确定按钮回调 清单文件完成
  final Function dismissCallback; //弹窗关闭回调
  final bool outsideDismiss; //点击弹窗外部，关闭弹窗，默认为true true：可以关闭 false：不可以关闭

  final TodoData todoData;

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
      this.dialogTitleText,
      this.themeText,
      this.isTodoDialog = false, this.todoData, this.confirmCallback3})
      : super();

  @override
  _SimpleInputDialogLayoutState createState() =>
      _SimpleInputDialogLayoutState();
}

class _SimpleInputDialogLayoutState extends State<SimpleInputDialogLayout> {
  GlobalKey<FormState> _dialogFormKey = new GlobalKey();

  // 利用FocusNode和_focusScopeNode来控制焦点 可以通过FocusNode.of(context)来获取widget树中默认的_focusScopeNode
  FocusNode _collectTitleFocusNode = new FocusNode();
  FocusNode _collectAuthorNode = new FocusNode();
  FocusNode _collectUrlFocusNode = new FocusNode();
  FocusScopeNode _focusScopeNode = new FocusScopeNode();

  //获取用户输入的 Controller
  TextEditingController _textTitleController = new TextEditingController();
  TextEditingController _collectAuthorController = new TextEditingController();
  TextEditingController _textUrlController = new TextEditingController();

  //输入的收藏标题 作者 链接
  String collectTitle = '';
  String collectAuthor = '';
  String collectUrl = '';

  int priorityValue = 0; // 优先级  0:一般  1:重要
  String selectedDate = ''; // 选择日期
  //初始选择 类型 工作 学习 生活 0 1 2 3
  int selectedType = 0;

  @override
  void initState() {
    super.initState();
    if(widget.isTodoDialog && widget.todoData!=null){
      collectTitle = widget.todoData.title;
      collectUrl = widget.todoData.content;
      selectedDate = widget.todoData.dateStr;
      selectedType = widget.todoData.type;
      priorityValue = widget.todoData.priority;
    }else{
      collectTitle = widget.collectTitle;
      collectUrl = widget.collectUrl;
      selectedDate = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
    }
    if(collectUrl!=null && collectTitle!=null){
      _textTitleController.text = collectTitle;
      _textUrlController.text = collectUrl;
    }
  }

  ValueChanged<int> onSelectedChanged(int _index) {
    print("当前选择的tag位置" + _index.toString());
    setState(() {
      selectedType = _index;
    });
  }

  _dismissDialog() {
    if (widget.dismissCallback != null) {
      widget.dismissCallback();
    }
    Navigator.of(context).pop();
  }

  _confirmDialog() async {
    if (widget.confirmCallback1 != null && widget.isCollectArticle) {
      await widget.confirmCallback1(collectTitle, collectAuthor, collectUrl);
    }
    if (widget.confirmCallback2 != null && !widget.isCollectArticle) {
      await widget.confirmCallback2(collectTitle, collectUrl);
    }
    if(widget.confirmCallback3 != null && widget.isTodoDialog){
      await widget.confirmCallback3({"title":collectTitle ,"content":collectUrl,"date":selectedDate,
        "type":selectedType,"priority":priorityValue});
    }
    _dismissDialog();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
        onTap: () {
          widget.outsideDismiss ? _dismissDialog() : null;
        },
        child: Material(
          type: MaterialType.transparency,
          child: Scaffold(
              backgroundColor: Colors.transparent,
              body: SingleChildScrollView(
                  //让包裹的 widget 可以滑动 防止布局溢出
                  child: Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.85,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            color: dataUtils.getIsDarkMode()
                                ? Colours.dark_material_bg
                                : Colors.white,
                          ),
                          child: buildContent())))),
        ),
      ),
      onWillPop: () async {
        return widget.outsideDismiss;
      },
    );
  }

  buildContent() {
    return Stack(
      children: <Widget>[
        Column(
          mainAxisSize: MainAxisSize.min,
          children: buildContentPageWidgetList(),
        ),
      ],
    );
  }

  List<Widget> buildContentPageWidgetList() {
    List<Widget> widgetList = List();
    widgetList.add(SizedBox(height: 20.0));
    widgetList.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(widget.isDIYText
              ? widget.dialogTitleText
              : (widget.isCollectArticle ? "收藏站外文章" : "收藏网站"))
        ],
      ),
    );
    widgetList.add(
      buildTextForm(),
    );
    widgetList.add(
      SizedBox(height: 15.0),
    );
    if (widget.isTodoDialog) {
      widgetList.add(
        buildTodoOtherContent(),
      );
      widgetList.add(SizedBox(height: 15.0));
    }
    widgetList.add(
      buildButton(),
    );
    widgetList.add(SizedBox(height: 15.0));
    return widgetList;
  }

  normalItemLine() {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width * 0.75,
      color: Colors.grey[400],
    );
  }

  List<Widget> buildTextFormList() {
    List<Widget> list = [];
    list.add(Flexible(
      child: Padding(
        padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
        child: TextFormField(
          //设置默认值 和光标位置  编辑
          controller: _textTitleController,
          focusNode: _collectTitleFocusNode,
          autofocus: true, //自动获取焦点 打开键盘
          onEditingComplete: () {
            if (_focusScopeNode == null) {
              _focusScopeNode = FocusScope.of(context);
            }
            _focusScopeNode.requestFocus(_collectAuthorNode);
          },
          decoration: InputDecoration(
              hintText: widget.isDIYText
                  ? widget.themeText + "标题"
                  : (widget.isCollectArticle ? "收藏文章标题" : "收藏网站名称"),
              border: InputBorder.none),
          style: TextStyle(fontSize: 16, color: Colors.black),
          //输入验证
          validator: (collecttitle) {
            if (collecttitle == null || collecttitle.isEmpty) {
              return widget.isDIYText
                  ? widget.themeText + "标题不能为空!"
                  : "收藏标题不能为空!";
            }
            return null;
          },
          onSaved: (collecttitle) {
            setState(() {
              collectTitle = collecttitle;
            });
          },
        ),
      ),
    ));
    list.add(normalItemLine());
    if (widget.isCollectArticle) {
      //收藏站外文章
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
            style: TextStyle(fontSize: 16, color: Colors.black),
            //输入验证
            validator: (collectauthor) {
              if (collectauthor == null || collectauthor.isEmpty) {
                return "作者名称不能为空!";
              }
              return null;
            },
            onSaved: (collectauthor) {
              setState(() {
                collectAuthor = collectauthor;
              });
            },
          ),
        ),
      ));
      list.add(normalItemLine());
    }
    list.add(
      Flexible(
        child: Padding(
          padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 20),
          child: TextFormField(
            maxLines: 4,
            controller: _textUrlController,
            focusNode: _collectUrlFocusNode,
            decoration: InputDecoration(
              hintText: widget.isTodoDialog? "清单内容":"链接地址",
              border: InputBorder.none,
            ),
            style: TextStyle(fontSize: 16, color: Colors.black),
            //输入验证
            validator: (collecturl) {
              if (collecturl == null || collecturl.isEmpty) {
                return widget.isTodoDialog?  "清单内容不能为空!":"链接地址不能为空!";
              }
              return null;
            },
            onSaved: (collecturl) {
              setState(() {
                collectUrl = collecturl;
              });
            },
          ),
        ),
      ),
    );
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

  Widget buildDivider() {
    return Padding(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        child:Divider(height: 1));
  }

  buildButton() {
    return Container(
        child: Padding(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              "取消",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () {
              _dismissDialog();
            },
          )),
          SizedBox(width: 15.0),
          Expanded(
              child: RaisedButton(
            color: Theme.of(context).primaryColor,
            child: Text(
              widget.isDIYText ? widget.themeText : "收藏",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
            onPressed: () {
              if (_dialogFormKey.currentState.validate()) {
                _dialogFormKey.currentState.save();
                //验证通过
                _confirmDialog();
              }
            },
          ))
        ],
      ),
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
    ));
  }

  Widget buildTodoOtherContent() {
    return Column(
      children: <Widget>[
        //todo类型 学习 工作 生活
        Wrap(
          // 对齐方式
          alignment: WrapAlignment.start,
          // run的对齐方式 开始位置
          runAlignment: WrapAlignment.start,
          // 使用迭代器的方法生成list
          children: Constants.todoTypes.map((Page page) {
            return SingleSelectTagView(
                index: page.labelIndex, choiceText: page.labelId, parent: this);
          }).toList(),
        ),
        buildDivider(),
        //优先级
        Padding(
          padding: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "优先级：",
                style: TextStyle(fontSize: 16),
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 0,
                    groupValue: this.priorityValue,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      setState(() {
                        this.priorityValue = value;
                      });
                    },
                  ),
                  Text('一般'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: this.priorityValue,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (value) {
                      setState(() {
                        this.priorityValue = value;
                      });
                    },
                  ),
                  Text('重要'),
                ],
              ),
            ],
          ),
        ),
        buildDivider(),
        Padding(
            padding: EdgeInsets.only(left: 20.0, right: 20.0),
            child:
                //时间
                Row(
              children: <Widget>[
                Text(
                  "日期：",
                  style: TextStyle(fontSize: 16),
                ),
                Expanded(
                  child: Text(
                    selectedDate,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.date_range),
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: new DateTime.now(),
                      firstDate: new DateTime.now().subtract(new Duration(days: 30)), // 减 30 天
                      lastDate: DateTime(2030), //最长设置到2030年
                    ).then((DateTime val) {
                      if (val != null&& this.mounted) {
                        setState(() {
                          selectedDate = formatDate(val, [yyyy, '-', mm, '-', dd]);
                        });
                      }// 2018-07-12 00:00:00.000
                    }).catchError((err) {
                      print(err);
                    });
                  },
                )
              ],
            )),
        buildDivider(),
      ],
    );
  }
}
