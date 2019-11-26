class Api{

  static const String BASE_URL = 'https://www.wanandroid.com/';
  //首页 banner
  static const String BANNER_JSON = BASE_URL+'banner/json';
  //首页 置顶 文章
  static const String ARTICLE_TOP = BASE_URL+'article/top/json';
  //常用网站
  static const String FRIEND_JSON = BASE_URL+'friend/json';
  //搜索热词
  static const String HOT_KEY_JSON = BASE_URL+'hotkey/json';

  //知识体系
  static const String KNOWLEDGE_TREE_JSON = BASE_URL+'tree/json';


  //导航数据
  static const String NAVIGATION_JSON = BASE_URL+'navi/json';

  //项目分类
  static const String PROJECT_TREE_JSON = BASE_URL+'project/tree/json';

  //登录
  static const String LOGIN_JSON = BASE_URL+'user/login';
  //注册
  static const String REGISTER_JSON = BASE_URL+'user/register';
  //退出登录
  static const String LOGIN_OUT_JSON = BASE_URL+'user/logout/json';

  //个人积分
  static const String COIN_USER_INFO_JSON = BASE_URL+'lg/coin/userinfo/json';
}