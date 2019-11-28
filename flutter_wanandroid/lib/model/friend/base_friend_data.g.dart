// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_friend_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseFriendData _$BaseFriendDataFromJson(Map<String, dynamic> json) {
  return BaseFriendData(
    (json['data'] as List)
        ?.map((e) =>
            e == null ? null : FriendData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BaseFriendDataToJson(BaseFriendData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
