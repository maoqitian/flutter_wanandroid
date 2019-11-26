// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_coin_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseCoinInfo _$BaseCoinInfoFromJson(Map<String, dynamic> json) {
  return BaseCoinInfo(
    json['data'] == null
        ? null
        : CoinUserInfo.fromJson(json['data'] as Map<String, dynamic>),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BaseCoinInfoToJson(BaseCoinInfo instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
