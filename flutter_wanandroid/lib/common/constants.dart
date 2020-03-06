import 'Page.dart';

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
  //是否为夜间模式
  static const String THEME_DARK_MODE_KEY = 'theme_dark_mode_key';


}


class Constants{

  //页面跳转类型
  //首页跳转
  static const String RESULT_CODE_HOME_PAGE = 'result_code_home_page';
  //最新项目跳转
  static const String RESULT_CODE_LATEST_PROJECT_PAGE = 'result_code_latest_project_page';
  //知识体系跳转
  static const String RESULT_CODE_KNOWLEDGE_PAGE = 'result_code_knowledge_page';
  //微信公众号模块跳转
  static const String RESULT_CODE_WECHAT_PAGE = 'result_code_wechat_page';
  //作者文章查看
  static const String RESULT_CODE_AUTHOR_ARTICLE_PAGE = 'result_code_author_article_page';
  //收藏文章 type code
  static const String RESULT_CODE_COLLECT_ARTICLE_PAGE = 'result_code_collect_article_page';
  //收藏网站 type code
  static const String RESULT_CODE_COLLECT_WEB_PAGE = 'result_code_collect_web_page';


  //页面是否支持收藏 type
  static const String COLLECT_PAGE_TYPE = 'collect_page_type';
  static const String NOT_COLLECT_PAGE_TYPE = 'not_collect_page_type';

  //个人中心显示数据
  static const String USER_CENTER_PAGE_TYPE = 'user_center_page_type';
  //用户个人中心
  static const String USER_SHARE_CENTER_PAGE_TYPE = 'user_center_share_page_type';

  //搜索 页面 类型
  static const String NORMAL_SEARCH_PAGE_TYPE = 'normal_search_page_type';
  static const String WECHAT_SEARCH_PAGE_TYPE = 'wechat_search_page_type';

  //页面标题和id对象 集合 首页
  static final List<Page> allPages = <Page>[
    Page('最新博文', 1),
    Page('最新项目', 2),
  ];


  //页面标题和id对象 集合 用户中心
  static final List<Page> collectPages = <Page>[
    Page('收藏文章', 1),
    Page('分享文章', 2),
  ];

  //页面标题和id对象 集合 用户中心
  static final List<Page> userPages = <Page>[
    Page('分享文章', 0),
    Page('收藏文章', 1),
    Page('收藏网站', 2),
  ];

  static final List<String> settingItems = [
    "夜间模式",
    "清除缓存",
    "关于我们",
  ];


  static final List<Page> todoTypes = [
    Page('只用这一个', 0),
    Page('工作', 1),
    Page('学习', 2),
    Page('生活', 3)
  ];


  //页面标题和id对象 集合 用户中心
  static final List<Page> todoPages = <Page>[
    Page('待办', 0),
    Page('完成', 1),
  ];


  //页面标题和id对象 集合 用户中心
  static final List<Page> userSharePages = <Page>[
    Page('分享文章', 0),
  ];

  static const String LOAD = 'load';

  static const String LOAD_MORD = 'load_more';

  static const SUCCESS = 'success';

  static const ERROR = 'error';

  static const EMPTY = 'empty';
}



