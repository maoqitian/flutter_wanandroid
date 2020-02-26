// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_todo_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseTodoListData _$BaseTodoListDataFromJson(Map<String, dynamic> json) {
  return BaseTodoListData(
    json['data'] == null
        ? null
        : TodoListData.fromJson(json['data'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BaseTodoListDataToJson(BaseTodoListData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
