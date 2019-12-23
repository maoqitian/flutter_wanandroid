// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_collect_web_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseCollectWebData _$BaseCollectWebDataFromJson(Map<String, dynamic> json) {
  return BaseCollectWebData(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : CollectWebData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BaseCollectWebDataToJson(BaseCollectWebData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
