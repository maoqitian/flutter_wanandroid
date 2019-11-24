// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_base_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginBaseData _$LoginBaseDataFromJson(Map<String, dynamic> json) {
  return LoginBaseData(
    json['data'] == null
        ? null
        : LoginData.fromJson(json['data'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$LoginBaseDataToJson(LoginBaseData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
