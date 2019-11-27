/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/27 0027
/// email: maoqitian068@163.com
/// des:  loading 效果使用 flutter_spinkit 库
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingWidget extends StatefulWidget {

  String loadingText;
  bool outsideDismiss;

  Function dismissDialog;


  LoadingWidget({Key key,
    this.loadingText = "loading...",
    this.outsideDismiss = true,
    this.dismissDialog}):super(key:key);

  @override
  _LoadingWidgetState createState() => _LoadingWidgetState();
}



class _LoadingWidgetState extends State<LoadingWidget> {


  @override
  void initState() {
    super.initState();
    if(widget.dismissDialog!=null){
      widget.dismissDialog(
        /// 将关闭 Loading 的方法传递到调用的页面.
              () {
            Navigator.of(context).pop();
          });
    }
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.outsideDismiss ? _dismissLoading : null,
      child: Material(
           type: MaterialType.transparency,
           child: Center(
             child: new SizedBox(
               width: 120.0,
               height: 120.0,
               child: new Container(
                 decoration: ShapeDecoration(
                 color:Colors.white ,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.all(
                   Radius.circular(8.0),
                              ),
                    ),
                   ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SpinKitWave(color: Theme.of(context).primaryColor, type: SpinKitWaveType.start),
                    ],
                  ),
                  Padding(
                    child: Text(widget.loadingText,
                        style: TextStyle(color: Colors.black54, fontSize: 10.0)),
                    padding: EdgeInsets.all(15.0),
                  )
                ],
                ),
               )
             )
           ),
      )
    );
  }

  //关闭 loading
  _dismissLoading() {
    Navigator.of(context).pop();
  }

}
