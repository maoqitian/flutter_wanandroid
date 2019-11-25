
import 'package:event_bus/event_bus.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter_wanandroid/common/shared_preferences.dart';

class Application{

  /// 通过Application设计环境变量

  // 配置跳转路由对象
  static Router router;

  //时间总线
  static EventBus eventBus;

  static SpUtil sp;
}