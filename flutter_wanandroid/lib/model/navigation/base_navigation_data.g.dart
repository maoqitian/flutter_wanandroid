// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_navigation_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseNavigationData _$BaseNavigationDataFromJson(Map<String, dynamic> json) {
  return BaseNavigationData(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : NavigationData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BaseNavigationDataToJson(BaseNavigationData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
