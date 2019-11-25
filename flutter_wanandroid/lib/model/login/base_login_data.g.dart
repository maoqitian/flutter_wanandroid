// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_login_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseLoginData _$BaseLoginDataFromJson(Map<String, dynamic> json) {
  return BaseLoginData(
    json['data'] == null
        ? null
        : LoginData.fromJson(json['data'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BaseLoginDataToJson(BaseLoginData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
