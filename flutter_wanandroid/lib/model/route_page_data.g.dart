// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route_page_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutePageData _$RoutePageDataFromJson(Map<String, dynamic> json) {
  return RoutePageData(
    json['id'] as int,
    json['title'] as String,
    json['url'] as String,
    json['type'] as String,
    json['collect'] as bool,
  );
}

Map<String, dynamic> _$RoutePageDataToJson(RoutePageData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'url': instance.url,
      'type': instance.type,
      'collect': instance.collect,
    };
