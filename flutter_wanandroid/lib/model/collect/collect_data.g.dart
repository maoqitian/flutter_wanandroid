// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collect_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CollectData _$CollectDataFromJson(Map<String, dynamic> json) {
  return CollectData(
    json['author'] as String,
    json['chapterId'] as int,
    json['chapterName'] as String,
    json['courseId'] as int,
    json['desc'] as String,
    json['envelopePic'] as String,
    json['id'] as int,
    json['link'] as String,
    json['niceDate'] as String,
    json['origin'] as String,
    json['originId'] as int,
    json['publishTime'] as int,
    json['title'] as String,
    json['userId'] as int,
    json['visible'] as int,
    json['zan'] as int,
  );
}

Map<String, dynamic> _$CollectDataToJson(CollectData instance) =>
    <String, dynamic>{
      'author': instance.author,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'envelopePic': instance.envelopePic,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'origin': instance.origin,
      'originId': instance.originId,
      'publishTime': instance.publishTime,
      'title': instance.title,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan,
    };
