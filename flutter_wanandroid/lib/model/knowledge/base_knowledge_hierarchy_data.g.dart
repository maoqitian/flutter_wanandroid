// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_knowledge_hierarchy_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseKnowledgeHierarchyData _$BaseKnowledgeHierarchyDataFromJson(
    Map<String, dynamic> json) {
  return BaseKnowledgeHierarchyData(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : KnowledgeHierarchyData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['errorCode'] as int,
    json['errorMsg'] as String,
  );
}

Map<String, dynamic> _$BaseKnowledgeHierarchyDataToJson(
        BaseKnowledgeHierarchyData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'errorCode': instance.errorCode,
      'errorMsg': instance.errorMsg,
    };
