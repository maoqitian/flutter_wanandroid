// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_share_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserShareData _$UserShareDataFromJson(Map<String, dynamic> json) {
  return UserShareData(
    json['coinInfo'] == null
        ? null
        : CoinUserInfo.fromJson(json['coinInfo'] as Map<String, dynamic>),
    json['shareArticles'] == null
        ? null
        : ArticleListData.fromJson(
            json['shareArticles'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserShareDataToJson(UserShareData instance) =>
    <String, dynamic>{
      'coinInfo': instance.coinInfo,
      'shareArticles': instance.shareArticles,
    };
