/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/3/2 0002
/// email: maoqitian068@163.com
/// des:  todo内容page
import 'package:flutter/material.dart';


class TodoContentPage extends StatefulWidget {

  final int state;

  const TodoContentPage({Key key, this.state = 0}) : super(key: key);


  @override
  _TodoContentPageState createState() => _TodoContentPageState();
}

class _TodoContentPageState extends State<TodoContentPage> {




  @override
  Widget build(BuildContext context) {
    return Container(
       child: Center(child: Text(widget.state.toString()),),
    );
  }
}
