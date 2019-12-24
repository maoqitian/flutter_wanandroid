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
    json['visible'] as int,
    json['order'] as int,
    json['name'] as String,
    json['userId'] as int,
    json['link'] as String,
  );
}

Map<String, dynamic> _$CollectWebDataToJson(CollectWebData instance) =>
    <String, dynamic>{
      'desc': instance.desc,
      'id': instance.id,
      'icon': instance.icon,
      'visible': instance.visible,
      'order': instance.order,
      'name': instance.name,
      'userId': instance.userId,
      'link': instance.link,
    };
