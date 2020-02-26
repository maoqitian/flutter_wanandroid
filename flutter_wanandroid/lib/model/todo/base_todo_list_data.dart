import 'package:flutter_wanandroid/model/base_response.dart';
import 'package:flutter_wanandroid/model/todo/todo_list_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'base_todo_list_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/2/26 0026
/// email: maoqitian068@163.com
/// des:  

@JsonSerializable()
class BaseTodoListData extends BaseResponseBody<TodoListData>{


  BaseTodoListData(TodoListData data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);


  factory BaseTodoListData.fromJson(Map<String, dynamic> json){
    return _$BaseTodoListDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$BaseTodoListDataToJson(this);

}
