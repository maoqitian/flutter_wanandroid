// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hot_key_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotKeyData _$HotKeyDataFromJson(Map<String, dynamic> json) {
  return HotKeyData(
    json['id'] as int,
    json['link'] as String,
    json['name'] as String,
    json['order'] as int,
    json['visible'] as int,
  );
}

Map<String, dynamic> _$HotKeyDataToJson(HotKeyData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'link': instance.link,
      'name': instance.name,
      'order': instance.order,
      'visible': instance.visible,
    };
