// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_collect_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseCollectListData _$BaseCollectListDataFromJson(Map<String, dynamic> json) {
  return BaseCollectListData(
    json['data'] == null
        ? null
        : CollectListData.fromJson(json['data'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BaseCollectListDataToJson(
        BaseCollectListData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
