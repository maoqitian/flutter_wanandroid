// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_sign_in_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinSignInListData _$CoinSignInListDataFromJson(Map<String, dynamic> json) {
  return CoinSignInListData(
    json['curPage'] as int,
    (json['datas'] as List)
        ?.map((e) => e == null
            ? null
            : CoinSignInData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['offset'] as int,
    json['over'] as bool,
    json['pageCount'] as int,
    json['size'] as int,
    json['total'] as int,
  );
}

Map<String, dynamic> _$CoinSignInListDataToJson(CoinSignInListData instance) =>
    <String, dynamic>{
      'curPage': instance.curPage,
      'datas': instance.datas,
      'offset': instance.offset,
      'over': instance.over,
      'pageCount': instance.pageCount,
      'size': instance.size,
      'total': instance.total,
    };
