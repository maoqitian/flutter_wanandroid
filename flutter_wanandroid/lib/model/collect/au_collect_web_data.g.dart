// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'au_collect_web_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuCollectWebData _$AuCollectWebDataFromJson(Map<String, dynamic> json) {
  return AuCollectWebData(
    json['data'] == null
        ? null
        : CollectWebData.fromJson(json['data'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$AuCollectWebDataToJson(AuCollectWebData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
