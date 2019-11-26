// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_user_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinUserInfo _$CoinUserInfoFromJson(Map<String, dynamic> json) {
  return CoinUserInfo(
    json['coinCount'] as int,
    json['rank'] as int,
    json['level'] as int,
    json['userId'] as int,
    json['username'] as String,
  );
}

Map<String, dynamic> _$CoinUserInfoToJson(CoinUserInfo instance) =>
    <String, dynamic>{
      'coinCount': instance.coinCount,
      'rank': instance.rank,
      'level': instance.level,
      'userId': instance.userId,
      'username': instance.username,
    };
