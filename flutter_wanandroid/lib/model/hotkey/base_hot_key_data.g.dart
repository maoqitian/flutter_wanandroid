// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_hot_key_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseHotKeyData _$BaseHotKeyDataFromJson(Map<String, dynamic> json) {
  return BaseHotKeyData(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : HotKeyData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BaseHotKeyDataToJson(BaseHotKeyData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
