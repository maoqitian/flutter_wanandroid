// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collect_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectListData _$CollectListDataFromJson(Map<String, dynamic> json) {
  return CollectListData(
    json['curPage'] as int,
    (json['datas'] as List)
        ?.map((e) =>
            e == null ? null : CollectData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['offset'] as int,
    json['over'] as bool,
    json['pageCount'] as int,
    json['size'] as int,
    json['total'] as int,
  );
}

Map<String, dynamic> _$CollectListDataToJson(CollectListData instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
    };
