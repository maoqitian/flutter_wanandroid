// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_collect_article_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseCollectArticleData _$BaseCollectArticleDataFromJson(
    Map<String, dynamic> json) {
  return BaseCollectArticleData(
    json['data'] == null
        ? null
        : CollectData.fromJson(json['data'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BaseCollectArticleDataToJson(
        BaseCollectArticleData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
