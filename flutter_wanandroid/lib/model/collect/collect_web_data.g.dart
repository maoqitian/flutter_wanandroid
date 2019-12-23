// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collect_web_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectWebData _$CollectWebDataFromJson(Map<String, dynamic> json) {
  return CollectWebData(
    json['desc'] as String,
    json['id'] as int,
    json['icon'] as String,
    json['isVisible'] as int,
    json['order'] as int,
    json['title'] as String,
    json['type'] as int,
    json['url'] as String,
  );
}

Map<String, dynamic> _$CollectWebDataToJson(CollectWebData instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'id': instance.id,
      'icon': instance.icon,
      'isVisible': instance.isVisible,
      'order': instance.order,
      'title': instance.title,
      'type': instance.type,
      'url': instance.url,
    };
