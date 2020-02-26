import 'package:flutter_wanandroid/model/todo/todo_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'todo_list_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/2/26 0026
/// email: maoqitian068@163.com
/// des:  todolist 数据


@JsonSerializable()
class TodoListData{
  int curPage;
  List<TodoData> datas;
  int offset;
  bool over;
  int pageCount;
  int size;
  int total;


  TodoListData(this.curPage, this.datas, this.offset, this.over,
      this.pageCount, this.size, this.total);

  factory TodoListData.fromJson(Map<String, dynamic> json){
    return _$TodoListDataFromJson(json);
  }

  Map<String,dynamic> toJson() => _$TodoListDataToJson(this);
}

