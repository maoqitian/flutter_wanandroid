// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_top_base_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleTopBaseData _$ArticleTopBaseDataFromJson(Map<String, dynamic> json) {
  return ArticleTopBaseData(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : ArticleData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$ArticleTopBaseDataToJson(ArticleTopBaseData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
