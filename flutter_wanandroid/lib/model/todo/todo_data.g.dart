// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoData _$TodoDataFromJson(Map<String, dynamic> json) {
  return TodoData(
    json['completeDate'] as int,
    json['completeDateStr'] as String,
    json['content'] as String,
    json['date'] as int,
    json['dateStr'] as String,
    json['id'] as int,
    json['priority'] as int,
    json['status'] as int,
    json['title'] as String,
    json['type'] as int,
    json['userId'] as int,
  );
}

Map<String, dynamic> _$TodoDataToJson(TodoData instance) => <String, dynamic>{
      'completeDate': instance.completeDate,
      'completeDateStr': instance.completeDateStr,
      'content': instance.content,
      'date': instance.date,
      'dateStr': instance.dateStr,
      'id': instance.id,
      'priority': instance.priority,
      'status': instance.status,
      'title': instance.title,
      'type': instance.type,
      'userId': instance.userId,
    };
