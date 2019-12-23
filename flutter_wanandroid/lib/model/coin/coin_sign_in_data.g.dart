// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_sign_in_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinSignInData _$CoinSignInDataFromJson(Map<String, dynamic> json) {
  return CoinSignInData(
    json['coinCount'] as int,
    json['date'] as int,
    json['desc'] as String,
    json['id'] as int,
    json['reason'] as String,
    json['type'] as int,
    json['userId'] as int,
    json['userName'] as String,
  );
}

Map<String, dynamic> _$CoinSignInDataToJson(CoinSignInData instance) =>
    <String, dynamic>{
      'coinCount': instance.coinCount,
      'date': instance.date,
      'desc': instance.desc,
      'id': instance.id,
      'reason': instance.reason,
      'type': instance.type,
      'userId': instance.userId,
      'userName': instance.userName,
    };
