// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_todo_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseTodoData _$BaseTodoDataFromJson(Map<String, dynamic> json) {
  return BaseTodoData(
    json['data'] == null
        ? null
        : TodoData.fromJson(json['data'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BaseTodoDataToJson(BaseTodoData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
