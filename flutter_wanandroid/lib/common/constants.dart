import 'package:path_provider/path_provider.dart';

/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/25 0025
/// email: maoqitian068@163.com
/// des:  常量类

class SharedPreferencesKeys {

  //搜索历史key
  static const String SEARCH_HISTORY_KEY = 'search_history_key';
  //主题颜色
  static const String THEME_COLOR_KEY = 'theme_color_key';
  //用户名
  static const String USER_NAME_KEY = 'user_name_key';
  //密码
  static const String PASSWORD_KEY = 'password_key';
  //登录状态
  static const String LOGIN_STATE_KEY = 'login_state_key';



}


class Constants{

  //页面跳转类型
  //首页跳转
  static const String RESULT_CODE_HOME_PAGE = 'result_code_home_page';
  //最新项目跳转
  static const String RESULT_CODE_LATEST_PROJECT_PAGE = 'result_code_latest_project_page';
  //知识体系跳转
  static const String RESULT_CODE_KNOWLEDGE_PAGE = 'result_code_knowledge_page';
  //作者文章查看
  static const String RESULT_CODE_AUTHOR_ARTICLE_PAGE = 'result_code_author_article_page';

}
