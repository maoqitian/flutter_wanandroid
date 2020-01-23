/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/1/20 0020
/// email: maoqitian068@163.com
/// des:  瀑布流刷新页面  根据状态改变页面 显示
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';

class RefreshGridPage extends StatefulWidget {
  // 模块item
  final renderItem;
  //数据获取方法
  final requestApi;
  //头部
  final headerView;
  //是否添加头部 默认不添加 头部逻辑目前没有添加 TODO
  final bool isHaveHeader;
  //是否支持下拉刷新 默认可以下拉刷新
  final bool isCanRefresh;
  //是否支持上拉加载更多 默认可以加载更多
  final bool isCanLoadMore;

  const RefreshGridPage({
    @required this.requestApi,
    @required this.renderItem,
    this.headerView,
    this.isHaveHeader = false,
    this.isCanRefresh = true,
    this.isCanLoadMore = true,
  })  : assert(requestApi is Function),
        assert(renderItem is Function),
        super();

  @override
  _RefreshGridPageState createState() => _RefreshGridPageState();
}

class _RefreshGridPageState extends State<RefreshGridPage> {
  bool isLoading = false; // 是否正在请求数据中
  bool isLoadMore = false; // 是否正在请求数据中
  bool _hasMore = true; // 是否还有更多数据可加载
  int _pageIndex = 0; // 页面的索引
  int _pageTotal = 0; // 页面的索引
  List items = new List();
  //页面状态
  String pageStatus;

  //滑动监听
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    //第一次进入加载数据
    _getMoreData();
    pageStatus = Constants.LOAD;
    //正常页面 添加滑动监听
    _scrollController.addListener(() {
      // 如果下拉的当前位置到scroll的最下面
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        if (this._getMoreData != null && _hasMore && widget.isCanLoadMore) {
          setState(() {
            isLoadMore = true;
          });
          _getMoreData();
        }
      }
    });
    super.initState();
  }

  // grid view  触底 ，触发加载更多
  Future _getMoreData() async {
    print("上拉加载更多,或者第一次加载");
    if (!isLoading && _hasMore) {
      // 如果上一次异步请求数据完成 同时有数据可以加载
      if (mounted) {
        setState(() {
          if (!isLoadMore) {
            //如果不是加载更多
            isLoading = true;
          }
        });
      }

      List newEntries = await makeHttpRequest(false);
      _hasMore = (_pageIndex < _pageTotal);
      if (this.mounted) {
        setState(() {
          items.addAll(newEntries);
          isLoading = false;
          isLoadMore = false;
          if(newEntries.length == 0){
            pageStatus =Constants.ERROR;
          }else{
            pageStatus =Constants.SUCCESS;
          }
        });
      }
    } else if (!isLoading && !_hasMore) {
      // 这样判断,减少以后的绘制
      _pageIndex = 0;
    }
  }

  Future<List> makeHttpRequest(bool isRefresh) async {
    if (widget.requestApi is Function) {
      Map listObj = new Map<String, dynamic>();
      if (isRefresh) {
        //下拉刷新
        listObj = await widget.requestApi({'pageIndex': 0});
      } else {
        //上拉加载更多
        listObj = await widget.requestApi({'pageIndex': _pageIndex});
      }
      _pageIndex = listObj['pageIndex'];
      _pageTotal = listObj['total'];
      return listObj['list'];
    } else {
      return Future.delayed(Duration(seconds: 2), () {
        return [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (pageStatus){
      case Constants.LOAD:
        return _buildIsLoading();
        break;
      case Constants.SUCCESS:
        return _buildPage();
        break;
      case Constants.ERROR:
        return _buildEmptyError();
        break;
      default:
        return Container(
          child: new Center(
            child: new Text("暂未实现 Page"),
          ),
        );
        break;
    }
      /*isLoading
        ? _buildIsLoading()
        : Column(
            children: <Widget>[
              //主界面
              Expanded(
                  child: RefreshIndicator(
                   onRefresh: _handleRefresh,
                   color: ToolUtils.getPrimaryColor(context), //指示器颜色
                   child: StaggeredGridView.countBuilder(
                   padding: EdgeInsets.all(8),
                   crossAxisCount: 4,
                   controller: _scrollController,
                   itemCount: items.length,
                   itemBuilder: (BuildContext context, int index) {
                    return widget.renderItem(index, items[index]);
                  },
                  staggeredTileBuilder: (index) =>
                      new StaggeredTile.count(2, index == 0 ? 2.5 : 3),
                ),
              )),
              //加载更多
              Offstage(offstage: !isLoadMore, child: _buildProgressIndicator()),
            ],
          );*/
  }

  // 下拉加载的事件，清空之前list内容，取前X个
  // 其实就是列表重置
  Future<Null> _handleRefresh() async {
    print("下拉刷新 ");
    List newEntries = await makeHttpRequest(true);
    if (this.mounted) {
      //mounted == true  保证 当前widget 状态可以更新
      setState(() {
        items.clear();
        items.addAll(newEntries);
        isLoading = false;
        return null;
      });
    }
  }
  //主界面
  Widget _buildPage() {
    List<Widget> list = [];
    list.add(
      //是否支持下拉刷新
      Expanded(
        child: widget.isCanRefresh ?
        RefreshIndicator(
          onRefresh: _handleRefresh,
          color: ToolUtils.getPrimaryColor(context), //指示器颜色
          child: _buildGridWidget())
            : _buildGridWidget()
      )
    );
    if(widget.isCanLoadMore){
       list.add(
         //是否支持 加载更多
         Offstage(offstage: !isLoadMore,
             child: _buildProgressIndicator()),);
    }
    return Column(
      children: list,
    );
  }

  // Grid Widget
  Widget _buildGridWidget(){
    //瀑布流 高度自适应
    return StaggeredGridView.countBuilder(
      primary: false,
      crossAxisCount: 4,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      controller: _scrollController,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return widget.renderItem(items[index]);
      },
      //高度自适应
      staggeredTileBuilder: (index) =>
      new StaggeredTile.fit(2),
    );
  }

  ///上拉加载更多 Widget
  Widget _buildProgressIndicator() {
    return _hasMore
        ? Container(
            child: new Center(
             child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SpinKitFadingCircle(color: ToolUtils.getPrimaryColor(context)),
                Padding(
                    child: Text("正在加载..",
                        style:
                            TextStyle(color: Colors.black54, fontSize: 15.0)),
                    padding: EdgeInsets.only(left: 10.0))
              ],
            ),
          )) : Container(
            padding: EdgeInsets.all(15),
            child: new Center(
             child: new Text("哥，这回真没了！！",
                style: TextStyle(color: Colors.black54, fontSize: 15.0)),
          ));
  }

  ///  loading
  Widget _buildIsLoading() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.85,
        child: new Center(
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.center,
             mainAxisAlignment: MainAxisAlignment.center,
             children: <Widget>[
             Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                SpinKitCubeGrid(
                    size: 55.0, color: ToolUtils.getPrimaryColor(context)),
              ],
             ),
             Padding(
              child: Text("正在加载..",
                  style: TextStyle(color: Colors.black54, fontSize: 15.0)),
              padding: EdgeInsets.all(15.0),
            )
          ],
        )));
  }

  ///空页面  错误 页面 empty error
  Widget _buildEmptyError() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.85,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("页面出错了！！"),
          RaisedButton(
            textColor: Colors.white,
            color: Theme.of(context).primaryColor,
            child: Text("重新加载"),
            onPressed: () {
              if (this.mounted) {
                //mounted == true  保证 当前widget 状态可以更新
                setState(() {
                  items.clear();
                  isLoading = false;
                  _hasMore = true;
                  _pageIndex = 0;
                  pageStatus = Constants.LOAD;
                });
                _getMoreData();
              }
            },
          )
        ],
      ),
    );
  }
}
