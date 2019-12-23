// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_coin_sign_list_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseCoinSignListData _$BaseCoinSignListDataFromJson(Map<String, dynamic> json) {
  return BaseCoinSignListData(
    json['data'] == null
        ? null
        : CoinSignInListData.fromJson(json['data'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BaseCoinSignListDataToJson(
        BaseCoinSignListData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
