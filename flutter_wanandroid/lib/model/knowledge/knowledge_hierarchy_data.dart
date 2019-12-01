import 'package:json_annotation/json_annotation.dart';
part 'knowledge_hierarchy_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-11-30
/// email: maoqitian068@163.com
/// des:  知识体系



@JsonSerializable()
class KnowledgeHierarchyData{

  int courseId;
  int id;
  String name;
  int order;
  int parentChapterId;
  bool userControlSetTop;
  int visible;
  List<KnowledgeHierarchyData> children;

  KnowledgeHierarchyData(this.courseId, this.id, this.name, this.order,
      this.parentChapterId, this.userControlSetTop, this.visible,
      this.children);


  factory KnowledgeHierarchyData.fromJson(Map<String, dynamic> json){
    return _$KnowledgeHierarchyDataFromJson(json);
  }


  Map<String,dynamic> toJson() => _$KnowledgeHierarchyDataToJson(this);
}