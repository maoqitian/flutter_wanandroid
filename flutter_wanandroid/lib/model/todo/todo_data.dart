import 'package:json_annotation/json_annotation.dart';
part 'todo_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/2/26 0026
/// email: maoqitian068@163.com
/// des:  TODO数据

@JsonSerializable()
class TodoData{

  int completeDate;
  String completeDateStr;
  String content;
  int date;
  String dateStr;
  int id;
  int priority;
  int status;
  String title;
  int type;
  int userId;

  TodoData(this.completeDate, this.completeDateStr, this.content, this.date,
      this.dateStr, this.id, this.priority, this.status, this.title, this.type,
      this.userId);


  factory TodoData.fromJson(Map<String, dynamic> json) => _$TodoDataFromJson(json);

  Map<String,dynamic> toJson() => _$TodoDataToJson(this);

}