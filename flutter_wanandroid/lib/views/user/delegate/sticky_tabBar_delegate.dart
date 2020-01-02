/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-12-22
/// email: maoqitian068@163.com
/// des:  SliverPersistentHeaderDelegate 对象

import 'package:flutter/material.dart';

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;
  final  Color color;

  StickyTabBarDelegate({@required this.child,this.color});

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: child,
      color: color,
    );//构建渲染的内容
  }

  @override
  double get maxExtent => this.child.preferredSize.height;//展开状态下组件的高度

  @override
  double get minExtent => this.child.preferredSize.height;//收起状态下组件的高度；

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;//类似于react中的shouldComponentUpdate
  }
}