/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019-11-30
/// email: maoqitian068@163.com
/// des:  知识体系

import 'package:flutter/material.dart';


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


}