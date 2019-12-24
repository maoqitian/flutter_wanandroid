// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_user_share_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseUserShareData _$BaseUserShareDataFromJson(Map<String, dynamic> json) {
  return BaseUserShareData(
    json['data'] == null
        ? null
        : UserShareData.fromJson(json['data'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BaseUserShareDataToJson(BaseUserShareData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
