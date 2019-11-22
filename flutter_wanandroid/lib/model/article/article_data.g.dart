// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleData _$ArticleDataFromJson(Map<String, dynamic> json) {
  return ArticleData(
    json['apkLink'] as String,
    json['author'] as String,
    json['chapterId'] as int,
    json['chapterName'] as String,
    json['collect'] as bool,
    json['courseId'] as int,
    json['desc'] as String,
    json['envelopePic'] as String,
    json['fresh'] as bool,
    json['id'] as int,
    json['link'] as String,
    json['niceDate'] as String,
    json['origin'] as String,
    json['prefix'] as String,
    json['projectLink'] as String,
    json['publishTime'] as int,
    json['superChapterId'] as int,
    json['superChapterName'] as String,
    json['title'] as String,
    json['type'] as int,
    json['userId'] as int,
    json['visible'] as int,
    json['zan'] as int,
    json['audit'] as int,
    (json['tags'] as List)
        ?.map((e) => e == null
            ? null
            : ArticleTagData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['niceShareDate'] as String,
    json['selfVisible'] as int,
    json['shareDate'] as int,
    json['shareUser'] as String,
  );
}

Map<String, dynamic> _$ArticleDataToJson(ArticleData instance) =>
    <String, dynamic>{
      'apkLink': instance.apkLink,
      'author': instance.author,
      'chapterId': instance.chapterId,
      'chapterName': instance.chapterName,
      'collect': instance.collect,
      'courseId': instance.courseId,
      'desc': instance.desc,
      'envelopePic': instance.envelopePic,
      'fresh': instance.fresh,
      'id': instance.id,
      'link': instance.link,
      'niceDate': instance.niceDate,
      'origin': instance.origin,
      'prefix': instance.prefix,
      'projectLink': instance.projectLink,
      'publishTime': instance.publishTime,
      'superChapterId': instance.superChapterId,
      'superChapterName': instance.superChapterName,
      'title': instance.title,
      'type': instance.type,
      'userId': instance.userId,
      'visible': instance.visible,
      'zan': instance.zan,
      'audit': instance.audit,
      'tags': instance.tags,
      'niceShareDate': instance.niceShareDate,
      'selfVisible': instance.selfVisible,
      'shareDate': instance.shareDate,
      'shareUser': instance.shareUser,
    };
