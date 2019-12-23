// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_rank_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseRankListData _$BaseRankListDataFromJson(Map<String, dynamic> json) {
  return BaseRankListData(
    json['data'] == null
        ? null
        : RankListData.fromJson(json['data'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BaseRankListDataToJson(BaseRankListData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
