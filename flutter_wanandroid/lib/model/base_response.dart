
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/7 0007
/// email: maoqitian068@163.com
/// des:  请求数据基本返回


class BaseResponseBody<T>{

  
  T data;
  int errorCode;
  String errorMsg;

  BaseResponseBody(this.data, this.errorCode, this.errorMsg);


}