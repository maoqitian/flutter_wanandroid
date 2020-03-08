import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/http/http_utils.dart';
import 'package:flutter_wanandroid/model/article/article_base_data.dart';
import 'package:flutter_wanandroid/model/article/article_top_base_data.dart';
import 'package:flutter_wanandroid/model/banner/banner_base_data.dart';
import 'package:flutter_wanandroid/model/article/article_data.dart';
import 'package:flutter_wanandroid/model/article/article_list_data.dart';
import 'package:flutter_wanandroid/model/banner/banner_data.dart';
import 'package:flutter_wanandroid/model/coin/base_coin_info.dart';
import 'package:flutter_wanandroid/model/coin/base_coin_sign_list_data.dart';
import 'package:flutter_wanandroid/model/coin/base_rank_list_data.dart';
import 'package:flutter_wanandroid/model/coin/coin_sign_in_list_data.dart';
import 'package:flutter_wanandroid/model/coin/coin_user_info.dart';
import 'package:flutter_wanandroid/model/coin/rank_list_data.dart';
import 'package:flutter_wanandroid/model/collect/au_collect_web_data.dart';
import 'package:flutter_wanandroid/model/collect/base_collect_article_data.dart';
import 'package:flutter_wanandroid/model/collect/base_collect_list_data.dart';
import 'package:flutter_wanandroid/model/collect/base_collect_web_data.dart';
import 'package:flutter_wanandroid/model/collect/collect_data.dart';
import 'package:flutter_wanandroid/model/collect/collect_list_data.dart';
import 'package:flutter_wanandroid/model/collect/collect_web_data.dart';
import 'package:flutter_wanandroid/model/friend/base_friend_data.dart';
import 'package:flutter_wanandroid/model/friend/friend_data.dart';
import 'package:flutter_wanandroid/model/hotkey/base_hot_key_data.dart';
import 'package:flutter_wanandroid/model/hotkey/hot_key_data.dart';
import 'package:flutter_wanandroid/model/knowledge/base_knowledge_hierarchy_data.dart';
import 'package:flutter_wanandroid/model/knowledge/knowledge_hierarchy_data.dart';
import 'package:flutter_wanandroid/model/login/base_login_data.dart';
import 'package:flutter_wanandroid/model/login/login_data.dart';
import 'package:flutter_wanandroid/model/navigation/base_navigation_data.dart';
import 'package:flutter_wanandroid/model/navigation/navigation_data.dart';
import 'package:flutter_wanandroid/model/search/search_history.dart';
import 'package:flutter_wanandroid/model/todo/base_todo_data.dart';
import 'package:flutter_wanandroid/model/todo/base_todo_list_data.dart';
import 'package:flutter_wanandroid/model/todo/todo_data.dart';
import 'package:flutter_wanandroid/model/todo/todo_list_data.dart';
import 'package:flutter_wanandroid/model/usershare/base_user_share_data.dart';
import 'package:flutter_wanandroid/model/usershare/user_share_data.dart';
import 'api/Api.dart';


/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-11-03
/// email: maoqitian068@163.com
/// des:  数据获取帮助类

DataUtils dataUtils = new DataUtils();

class DataUtils{

  SearchHistoryList searchHistoryList;

  //私有构造函数
  DataUtils._internal(){
    if(null == searchHistoryList){
      searchHistoryList = SearchHistoryList(Application.sp);
    }
  }

  //保存单例
  static DataUtils _singleton = new DataUtils._internal();

  //工厂构造函数
  factory DataUtils()=> _singleton;



  /// 首页数据模块
  //获取首页banner 数据
  Future<List<BannerData>> getBannerData() async{
    Response response = await httpUtils.get(Api.BANNER_JSON);
    return BannerBaseData.fromJson(response.data).data;
  }

  // 首页文章列表
  //方法：GET
  //参数：页码，拼接在连接中，从0开始。
  Future<ArticleListData> getArticleData(int pageNum) async{
    String path = 'article/list/$pageNum/json';
    Response response = await httpUtils.get(path);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }

  // 首页 最新项目 列表数据
  //方法：GET
  //参数：页码，拼接在连接中，从0开始。
  Future<ArticleListData> getLatestProjectData(int pageNum) async{
    String path = 'article/listproject/$pageNum/json';
    Response response = await httpUtils.get(path);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }

  //常用网站
  Future<List<FriendData>> getFriendListData(BuildContext context) async{
    Response response = await HttpUtils().get(Api.FRIEND_JSON,isAddLoading:true,context: context,loadingText: "正在加载...");
    BaseFriendData baseFriendData = BaseFriendData.fromJson(response.data);
    return baseFriendData.data;
  }

  //搜索热词
  Future<List<HotKeyData>> getHotKeyListData() async{
    Response response = await httpUtils.get(Api.HOT_KEY_JSON);
    BaseHotKeyData baseHotKeyData = BaseHotKeyData.fromJson(response.data);
    return baseHotKeyData.data;
  }

  //置顶文章
  Future<List<ArticleData>> getArticleTopData() async{
    Response response = await httpUtils.get(Api.ARTICLE_TOP);
    return ArticleTopBaseData.fromJson(response.data).data;
  }


  /// 知识体系

  //体系数据
  Future<List<KnowledgeHierarchyData>> getKnowledgeTreeData() async{
    Response response = await httpUtils.get(Api.KNOWLEDGE_TREE_JSON);
    BaseKnowledgeHierarchyData baseKnowledgeHierarchyData = BaseKnowledgeHierarchyData.fromJson(response.data);
    return baseKnowledgeHierarchyData.data;
  }

  //知识体系下的文章
  Future<ArticleListData> getKnowledgeArticleData(int cid,int pageNum) async{
    String path = 'article/list/$pageNum/json';
    Map<String, dynamic> params={"cid": cid};
    Response response = await httpUtils.get(path,params: params);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }

  // 按照作者昵称搜索文章(点击文章作者头像)
  Future<ArticleListData> getAuthorArticleData(String author,int pageNum) async{
    String path = 'article/list/$pageNum/json';
    Map<String, dynamic> params={"author": author};
    Response response = await httpUtils.get(path,params: params);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }

  ///公众号Tab
  //获取公众号列表
  Future<List<KnowledgeHierarchyData>> getWXArticleChaptersData() async{
    Response response = await httpUtils.get(Api.WXARTICLE_CHAPTERS);
    BaseKnowledgeHierarchyData baseKnowledgeHierarchyData = BaseKnowledgeHierarchyData.fromJson(response.data);
    return baseKnowledgeHierarchyData.data;
  }

  //查看某个公众号历史数据（公众号文章列表数据）
  //公众号 ID：拼接在 url 中，eg:405
  //	公众号页码：拼接在url 中，eg:1
  Future<ArticleListData> getWXArticleHistoryData(int id,int pageNum) async{
    String path = 'article/list/$id/$pageNum/json';
    Response response = await httpUtils.get(path);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }

  //在某个公众号中搜索历史文章
  //k : 字符串，eg:Java 搜索字段
  //	公众号 ID：拼接在 url 中，eg:405
  //	公众号页码：拼接在url 中，eg:1
  Future<ArticleListData> getSearchWXArticleData(String searchKey,int id,int pageNum) async{
    String path = '/wxarticle/list/$id/$pageNum/json';
    Map<String, dynamic> params={"k": searchKey};
    Response response = await httpUtils.get(path,params: params);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }
  /// 导航
  //导航数据
  Future<List<NavigationData>> getNavigationData(BuildContext context,bool isRefresh) async{
    Response response = await httpUtils.get(Api.NAVIGATION_JSON,isAddLoading:isRefresh,context: context,loadingText: "正在加载...");
    BaseNavigationData baseNavigationData = BaseNavigationData.fromJson(response.data);
    return baseNavigationData.data;
  }

  ///项目
  //项目分类
  Future<List<KnowledgeHierarchyData>> getProjectClassifyData(BuildContext context) async{
    Response response = await httpUtils.get(Api.PROJECT_TREE_JSON,isAddLoading:true,context: context,loadingText: "正在加载...");
    BaseKnowledgeHierarchyData baseKnowledgeHierarchyData = BaseKnowledgeHierarchyData.fromJson(response.data);
    return baseKnowledgeHierarchyData.data;
  }

  //项目列表数据
  //cid 分类的id，上面项目分类接口
  //页码：拼接在链接中，从1开始
  Future<ArticleListData> getProjectListData(int cid,int pageNum) async{
    String path = 'article/list/$pageNum/json';
    Map<String, dynamic> params={"cid": cid};
    Response response = await httpUtils.get(path,params: params);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }

  /// 登录注册
  //登录
  Future<LoginData> getLoginData(String username,String password,BuildContext context) async{
    FormData formData = FormData.fromMap({"username": username, "password": password});
    Response response = await httpUtils.post(Api.LOGIN_JSON,formData: formData,isAddLoading:true,context: context,loadingText: "正在登陆...");
    return BaseLoginData.fromJson(response.data).data;
  }

  //注册
  Future<LoginData> getRegisterData(String username,String password,String repassword,BuildContext context) async{
    FormData formData =FormData.fromMap({"username": username, "password": password,"repassword": repassword});
    Response response = await httpUtils.post(Api.REGISTER_JSON,formData: formData,isAddLoading:true,context: context,loadingText: "正在登陆...");
    return BaseLoginData.fromJson(response.data).data;
  }
  //退出登录
  Future<String> getLoginOut() async{
    Response response = await httpUtils.get(Api.LOGIN_OUT_JSON);
    return response.data["data"];
  }


  /// 收藏模块

  //收藏文章列表
  //方法：GET
  //参数： 页码：拼接在链接中，从0开始。
  Future<CollectListData> getCollectArticleListData(int pageNum) async{
    String path = 'lg/collect/list/$pageNum/json';
    Response response = await httpUtils.get(path);
    BaseCollectListData baseCollectListData = BaseCollectListData.fromJson(response.data);
    return baseCollectListData.data;
  }


  // 站内文章收藏 （文章列表）
  //方法：POST
  //参数： 文章id，拼接在链接中。
  Future<String> getCollectInnerArticle(int id) async{
    String path = 'lg/collect/$id/json';
    Response response = await httpUtils.post(path);
    return response.data["data"];
  }

  //收藏站外文章
  //方法：POST
  //参数：
  //	title，author，link
  Future<CollectData> getCollectOutsideArticle(String title,String author,String link,BuildContext context) async{
    String path = 'lg/collect/add/json';
    FormData formData =FormData.fromMap({"title": title, "author": author,"link": link});
    Response response = await httpUtils.post(path,formData: formData,isAddLoading: true,loadingText: "收藏文章",context: context);
    BaseCollectArticleData baseCollectArticleData= BaseCollectArticleData.fromJson(response.data);
    return baseCollectArticleData.data;
  }

  //取消收藏 文章列表
  //方法：POST
  //参数：
  //id:拼接在链接上
  Future<String> getCancelCollectInnerArticle(int id) async{
    String path = 'lg/uncollect_originId/$id/json';
    Response response = await httpUtils.post(path);
    return response.data["data"];
  }

  //取消收藏 我的收藏页面（该页面包含自己录入的内容）
  //取消收藏 文章列表
  //方法：POST
  //参数：
  //	id:拼接在链接上
  //	originId:列表页下发，无则为-1
  Future<String> getCancelCollect(int id,int originId,BuildContext context) async{
    String path = 'lg/uncollect/$id/json';
    FormData formData = FormData.fromMap({"originId": originId});
    Response response = await httpUtils.post(path,formData: formData,isAddLoading: true,loadingText: "取消收藏",context: context);
    return response.data["data"];
  }

  //收藏网站列表
  //方法：GET
  //参数：无
  Future<List<CollectWebData>> getCollectWebListData() async{
    Response response = await httpUtils.get(Api.COLLECT_WEB_LIST_JSON);
    BaseCollectWebData baseCollectWebData = BaseCollectWebData.fromJson(response.data);
    return baseCollectWebData.data;
  }

  //收藏网址
  //方法：POST
  //参数：
  //	name,link
  Future<CollectWebData> getCollectWebData(String name,String link,BuildContext context) async{
    String path = 'lg/collect/addtool/json';
    FormData formData =FormData.fromMap({"name": name, "link": link});
    Response response = await httpUtils.post(path,formData: formData,isAddLoading: true,loadingText: "收藏网站",context: context);
    AuCollectWebData auCollectWebData= AuCollectWebData.fromJson(response.data);
    return auCollectWebData.data;
  }

  //编辑收藏网站
  //方法：POST
  //参数：
  //	id,name,link
  Future<CollectWebData> getUpdateCollectWebData(int id,String name,String link,BuildContext context) async{
    String path = 'lg/collect/updatetool/json';
    FormData formData =FormData.fromMap({"id": id,"name": name, "link": link});
    Response response = await httpUtils.post(path,formData: formData,isAddLoading: true,loadingText: "编辑收藏网站",context: context);
    AuCollectWebData auCollectWebData= AuCollectWebData.fromJson(response.data);
    return auCollectWebData.data;
  }

  //删除收藏网站
  //方法：POST
  //参数：
  //	id
  Future<String> getDeleteCollectWeb(int id) async{
    String path = 'lg/collect/deletetool/json';
    FormData formData = FormData.fromMap({"id": id});
    Response response = await httpUtils.post(path,formData: formData);
    return response.data["data"];
  }

  ///搜索
  //搜索 文章
  //方法：POST
  //参数：
  //	页码：拼接在链接上，从0开始。
  //	k ： 搜索关键词
  Future<ArticleListData> getSearchListData(int pageNum,String key) async{
    String path = 'article/query/$pageNum/json';
    FormData formData =FormData.fromMap({"k": key});
    Response response = await httpUtils.post(path,formData: formData);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }

  ///TODO工具

  //  获取todo列表
  //  页码从1开始，拼接在url 上
  //	status 状态， 1-完成；0未完成; 默认全部展示；
  //	type 创建时传入的类型, 默认全部展示
  //	priority 创建时传入的优先级；默认全部展示 priority 主要用于定义优先级，在app 中预定义几个优先级：
      //重要（1）
      //一般（2）等
  //	orderby 1:完成日期顺序；2.完成日期逆序；3.创建日期顺序；4.创建日期逆序(默认)；

  Future<TodoListData> getTodoListData(int pageNum,{ Map<String, dynamic> params }) async{
    String path = 'lg/todo/v2/list/$pageNum/json';
    Response response ;
    if((params!=null)){
      FormData formData = FormData.fromMap(params);
      response = await httpUtils.post(path,formData: formData);
    }else{
      response = await httpUtils.post(path);
    }
    BaseTodoListData baseTodoListData = BaseTodoListData.fromJson(response.data);
    return baseTodoListData.data;
  }

  // 新增一个TODO
  //方法：POST
  //参数：
  //	title: 新增标题（必须）
  //	content: 新增详情（必须）
  //	date: 2018-08-01 预定完成时间（不传默认当天，建议传）
  //	type: 大于0的整数（可选）；
  //	priority 大于0的整数（可选）；
  Future<TodoData> getAddTodoData(Map<String, dynamic> params,BuildContext context) async{
    String path = 'lg/todo/add/json';
    Response response = await httpUtils.post(path,queryParameters: params,isAddLoading: true,loadingText: "正在新增清单",context: context);
    BaseTodoData baseTodoData = BaseTodoData.fromJson(response.data);
    return baseTodoData.data;
  }

  //更新一个TODO
  //方法：POST
  //参数：
  //	id: 拼接在链接上，为唯一标识，列表数据返回时，每个todo 都会有个id标识 （必须）
  //	title: 更新标题 （必须）
  //	content: 新增详情（必须）
  //	date: 2018-08-01（必须）
  //	status: 0 // 0为未完成，1为完成
  //	type: ；
  //	priority:

  Future<TodoData> getUpdateTodoData(int id,Map<String, dynamic> params,BuildContext context) async{
    String path = 'lg/todo/update/$id/json';
    Response response = await httpUtils.post(path,queryParameters: params,isAddLoading: true,loadingText: "正在更新",context: context);
    BaseTodoData baseTodoData = BaseTodoData.fromJson(response.data);
    return baseTodoData.data;
  }

  //删除一个TODO
  //方法：POST
  //参数：
  //id: 拼接在链接上，为唯一标识
  Future<String> getDeleteTodoData(int id,BuildContext context) async{
    String path = 'lg/todo/delete/$id/json';
    Response response = await httpUtils.post(path,isAddLoading: true,loadingText: "正在删除",context: context);
    return response.data["data"];
  }

  // 仅更新完成状态TODO
  //方法：POST
  //参数：
  //	id: 拼接在链接上，为唯一标识
  //	status: 0或1，传1代表未完成到已完成，反之则反之。
  Future<TodoData> getUpdateDoneTodo(int id,Map<String, dynamic> params,BuildContext context) async{
    String path = 'lg/todo/done/$id/json';
    Response response = await httpUtils.post(path,queryParameters: params,isAddLoading: true,loadingText: "正在处理",context: context);
    BaseTodoData baseTodoData = BaseTodoData.fromJson(response.data);
    return baseTodoData.data;
  }

  /// 积分
  //积分排行榜
  //方法：get
  //参数：
  //页码：拼接在链接上，从1开始。
  Future<RankListData> getCoinRankListData(int pageNum) async{
    String path = 'coin/rank/$pageNum/json';
    Response response = await httpUtils.get(path);
    BaseRankListData baseRankListData = BaseRankListData.fromJson(response.data);
    return baseRankListData.data;
  }

  //个人积分 需登录
  Future<CoinUserInfo> getCoinUserInfo() async{
    Response response = await httpUtils.get(Api.COIN_USER_INFO_JSON);
    return BaseCoinInfo.fromJson(response.data).data;
  }

  //获取个人积分获取列表
  //方法：get
  //参数：
  //页码：拼接在链接上，从1开始。
  Future<CoinSignInListData> getCoinSignListData(int pageNum) async{
    String path = 'lg/coin/list/$pageNum/json';
    Response response = await httpUtils.get(path);
    BaseCoinSignListData baseCoinSignListData = BaseCoinSignListData.fromJson(response.data);
    return baseCoinSignListData.data;
  }

  ///广场
  //广场列表数据
  //GET请求
  //页码拼接在url上从0开始
  Future<ArticleListData> getShareArticleData(int pageNum) async{
    String path = 'user_article/list/$pageNum/json';
    Response response = await httpUtils.get(path);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }

  //分享人对应列表数据
  //GET请求
  //参数：
  //	用户id: 拼接在url上
  //	页码拼接在url上从1开始
  Future<UserShareData> getUserShareArticleData(int id,int pageNum) async{
    String path = 'user/$id/share_articles/$pageNum/json';
    Response response = await httpUtils.get(path);
    BaseUserShareData baseUserShareData = BaseUserShareData.fromJson(response.data);
    return baseUserShareData.data;
  }

  //自己的分享的文章列表
  //方法：GET
  //参数：
  //	页码，从1开始
  Future<UserShareData> getPrivateUserShareArticleData(int pageNum) async{
    String path = 'user/lg/private_articles/$pageNum/json';
    Response response = await httpUtils.get(path);
    BaseUserShareData baseUserShareData = BaseUserShareData.fromJson(response.data);
    return baseUserShareData.data;
  }

  //删除自己分享的文章
  //请求:POST
  //参数：文章id，拼接在链接上
  Future<String> getDeleteUserShareArticle(int id,BuildContext context) async{
    String path = 'lg/user_article/delete/$id/json';
    Response response = await httpUtils.post(path,isAddLoading: true,loadingText: "删除分享...",context: context);
    return response.data["data"];
  }

  //分享文章
  //请求：POST
  //参数：
  //	title 文章标题
  //	link 文章链接
  Future<String> getShareArticle(String title,String link,BuildContext context) async{
    String path = 'lg/user_article/add/json';
    FormData formData =FormData.fromMap({"title": title,"link": link});
    Response response = await httpUtils.post(path,formData: formData,isAddLoading: true,loadingText: "分享文章...",context: context);
    return response.data["data"];
  }

  /// 问答
  // 问答列表数据
  //请求:GET
  //参数：
  //pageId,拼接在链接上，1 开始
  Future<ArticleListData> getQuestionListData(int pageNum) async{
    String path = 'wenda/list/$pageNum/json';
    Response response = await httpUtils.get(path);
    ArticleBaseData articleBaseData = ArticleBaseData.fromJson(response.data);
    return articleBaseData.data;
  }


  /// SharedPreferences 存储 用户名 是否登录等状态
  void setUserName(String username){
     Application.sp.putString(SharedPreferencesKeys.USER_NAME_KEY,username);
  }

  String getUserName() {
    return Application.sp.getString(SharedPreferencesKeys.USER_NAME_KEY);
  }

  void setPassWord(String password) {
     Application.sp.putString(SharedPreferencesKeys.PASSWORD_KEY,password);
  }

  String getPassword() {
    return Application.sp.getString(SharedPreferencesKeys.PASSWORD_KEY);
  }

  void setLoginState(bool loginState) {
     Application.sp.putBool(SharedPreferencesKeys.LOGIN_STATE_KEY,loginState);
  }

  bool getLoginState() {
    return Application.sp.getBool(SharedPreferencesKeys.LOGIN_STATE_KEY);
  }
  //是否登录
  bool hasLogin(){
    //是否存在登录的 key
    if(!Application.sp.hasKey(SharedPreferencesKeys.LOGIN_STATE_KEY)) return false;
    return getLoginState();
  }

  //是否为夜间模式
  bool getIsDarkMode(){
    return Application.sp.getBool(SharedPreferencesKeys.THEME_DARK_MODE_KEY);
  }

  void setIsDarkMode(bool isDark){
     Application.sp.putBool(SharedPreferencesKeys.THEME_DARK_MODE_KEY,isDark);
  }


  //是否为夜间模式
  int getPrimaryColor(){
    return Application.sp.getInt(SharedPreferencesKeys.THEME_COLOR_KEY);
  }
  //存储主题颜色
  void setPrimaryColor(int color){
    Application.sp.putInt(SharedPreferencesKeys.THEME_COLOR_KEY,color);
  }

  /// 搜索历史 增加 删除 获取

  //获取搜索历史数据
  Iterable<SearchHistory> getSearchHistoryListData(){
    //数据倒序输出
    var reversed2 = searchHistoryList.getList().reversed;
    return reversed2;
  }

  void addSearchHistory(SearchHistory item){
    searchHistoryList.add(item);
  }

  void clearSearchHistoryListData(){
    searchHistoryList.clear();
  }
}
