/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/28 0028
/// email: maoqitian068@163.com
/// des:  通用下拉刷新 拉加载更多 page
import 'package:flutter/material.dart';

class RefreshPage extends StatefulWidget {


  final renderItem;
  final requestApi;
  final headerView;

  const RefreshPage([this.requestApi, this.renderItem, this.headerView]) : super();

  @override
  _RefreshPageState createState() => _RefreshPageState();
}



class _RefreshPageState extends State<RefreshPage> {

  bool isLoading = false; // 是否正在请求数据中
  bool _hasMore = true; // 是否还有更多数据可加载
  int _pageIndex = 0; // 页面的索引
  int _pageTotal = 0; // 页面的索引
  List items = new List();

  //滑动监听
  final ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    _getMoreData();
    //添加滑动监听
    _scrollController.addListener((){
      // 如果下拉的当前位置到scroll的最下面
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        if (this._getMoreData != null && _hasMore) {
          _getMoreData();
        }
      }
    });

    super.initState();

  }

  // ListView 触底 ，触发加载更多
  Future _getMoreData() async {
    if (!isLoading && _hasMore) {
      // 如果上一次异步请求数据完成 同时有数据可以加载
      if (mounted) {
        setState(() => isLoading = true);
      }
      //if(_hasMore){ // 还有数据可以拉新
      List newEntries = await mokeHttpRequest(false);
      //if (newEntries.isEmpty) {
      _hasMore = (_pageIndex <= _pageTotal);
      if (this.mounted) {
        setState(() {
          items.addAll(newEntries);
          isLoading = false;
        });
      }
      //backElasticEffect();
    } else if (!isLoading && !_hasMore) {
      // 这样判断,减少以后的绘制
      _pageIndex = 0;
      //backElasticEffect();
    }
  }

  Future<List> mokeHttpRequest(bool isRefresh) async {
    if (widget.requestApi is Function) {
      Map listObj = new Map<String, dynamic>();
      if(isRefresh){
        //下拉刷新
        listObj = await widget.requestApi({'pageIndex': 0});
      }else{
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

  ///根据配置状态返回实际列表数量
  ///实际上这里可以根据你的需要做更多的处理
  ///比如多个头部，是否需要空页面，是否需要显示加载更多。
  _getListCount() {
    ///是否需要头部
    if (widget.headerView is Function) {
      ///如果需要头部，用Item 0 的 Widget 作为ListView的头部
      ///列表数量大于0时，因为头部和底部加载更多选项，需要对列表数据总数+2
      return (items.length > 0) ? items.length + 2 : items.length + 1;
    } else {
      ///如果不需要头部，在没有数据时，固定返回数量1用于空页面呈现
      if (items.length == 0) {
        return 1;
      }
      ///如果有数据,因为部加载更多选项，需要对列表数据总数+1
      return (items.length > 0) ? items.length + 1 : items.length;
    }
  }

  ///根据配置状态返回实际列表渲染Item
  _getItem(int index) {
    if (!widget.headerView is Function && index == items.length && items.length != 0) {
      ///如果不需要头部，并且数据不为0，当index等于数据长度时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (widget.headerView is Function && index == _getListCount() - 1 && items.length != 0) {
      ///如果需要头部，并且数据不为0，当index等于实际渲染长度 - 1时，渲染加载更多Item（因为index是从0开始）
      return _buildProgressIndicator();
    } else if (!widget.headerView is Function && items.length == 0) {
      ///如果不需要头部，并且数据为0，渲染空页面
      return _buildEmpty();
    } else {
      ///回调外部正常渲染Item，如果这里有需要，可以直接返回相对位置的index
      return widget.renderItem(index, items[index]);
    }
  }


  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      child: ListView.builder(
          ///保持ListView任何情况都能滚动，解决在RefreshIndicator的兼容问题。
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context,index){
              return _getItem(index);
          },
          ///根据状态返回数量
          itemCount: _getListCount(),
          ///滑动监听
          controller: _scrollController,
      ),
      onRefresh: _handleRefresh,
    );
  }

  // 下拉加载的事件，清空之前list内容，取前X个
  // 其实就是列表重置
  Future<Null> _handleRefresh() async {
    List newEntries = await mokeHttpRequest(true);
    if (this.mounted) { //mounted == true  保证 当前widget 状态可以更新
      setState(() {
        items.clear();
        items.addAll(newEntries);
        isLoading = false;
        _hasMore = true;
        return null;
      });
    }
  }

  ///上拉加载更多
  Widget _buildProgressIndicator() {
    return Container(
      child: new Center(
        child: new Text("上拉加载更多 Widget"),
      ),
    );
  }

  ///空页面
  Widget _buildEmpty() {
   return Container(
      child: new Center(
        child: new Text("空页面 Widget"),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }
}
