import 'package:flutter_wanandroid/model/base_response.dart';
import 'package:json_annotation/json_annotation.dart';
import 'knowledge_hierarchy_data.dart';
part 'base_knowledge_hierarchy_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/6 0006
/// email: maoqitian068@163.com
/// des:  知识体系基础数据



@JsonSerializable()
class BaseKnowledgeHierarchyData extends BaseResponseBody<List<KnowledgeHierarchyData>>{

  BaseKnowledgeHierarchyData(List<KnowledgeHierarchyData> data, int errorCode, String errorMsg) : super(data, errorCode, errorMsg);

  factory BaseKnowledgeHierarchyData.fromJson(Map<String, dynamic> json){
    return _$BaseKnowledgeHierarchyDataFromJson(json);
  }


}