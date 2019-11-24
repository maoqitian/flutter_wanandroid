// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginData _$LoginDataFromJson(Map<String, dynamic> json) {
  return LoginData(
    json['email'] as String,
    json['icon'] as String,
    json['id'] as int,
    json['password'] as String,
    json['token'] as String,
    json['type'] as int,
    json['username'] as String,
    json['nickname'] as String,
    json['publicName'] as String,
    (json['collectIds'] as List)?.map((e) => e as int)?.toList(),
    (json['chapterTops'] as List)?.map((e) => e as String)?.toList(),
    json['admin'] as bool,
  );
}

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'email': instance.email,
      'icon': instance.icon,
      'id': instance.id,
      'password': instance.password,
      'token': instance.token,
      'type': instance.type,
      'username': instance.username,
      'nickname': instance.nickname,
      'publicName': instance.publicName,
      'collectIds': instance.collectIds,
      'chapterTops': instance.chapterTops,
      'admin': instance.admin,
    };
