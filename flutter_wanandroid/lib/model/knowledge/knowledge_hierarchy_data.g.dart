// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'knowledge_hierarchy_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KnowledgeHierarchyData _$KnowledgeHierarchyDataFromJson(
    Map<String, dynamic> json) {
  return KnowledgeHierarchyData(
    json['courseId'] as int,
    json['id'] as int,
    json['name'] as String,
    json['order'] as int,
    json['parentChapterId'] as int,
    json['userControlSetTop'] as bool,
    json['visible'] as int,
    (json['children'] as List)
        ?.map((e) => e == null
            ? null
            : KnowledgeHierarchyData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$KnowledgeHierarchyDataToJson(
        KnowledgeHierarchyData instance) =>
    <String, dynamic>{
      'courseId': instance.courseId,
      'id': instance.id,
      'name': instance.name,
      'order': instance.order,
      'parentChapterId': instance.parentChapterId,
      'userControlSetTop': instance.userControlSetTop,
      'visible': instance.visible,
      'children': instance.children,
    };
