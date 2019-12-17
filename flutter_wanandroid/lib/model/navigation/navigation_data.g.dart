// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'navigation_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NavigationData _$NavigationDataFromJson(Map<String, dynamic> json) {
  return NavigationData(
    (json['articles'] as List)
        ?.map((e) =>
            e == null ? null : ArticleData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['cid'] as int,
    json['name'] as String,
  );
}

Map<String, dynamic> _$NavigationDataToJson(NavigationData instance) =>
    <String, dynamic>{
      'articles': instance.articles,
      'cid': instance.cid,
      'name': instance.name,
    };
