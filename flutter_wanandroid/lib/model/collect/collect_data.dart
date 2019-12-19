import 'package:json_annotation/json_annotation.dart';
part 'collect_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/12/19 0019
/// email: maoqitian068@163.com
/// des:  收藏数据

@JsonSerializable()
class CollectData{

  String author;
  int chapterId;
  String chapterName;
  int courseId;
  String desc;
  String envelopePic;
  int id;
  String link;
  String niceDate;
  String origin;
  int originId;
  int publishTime;
  String title;
  int userId;
  int visible;
  int zan;

  CollectData(this.author, this.chapterId, this.chapterName, this.courseId,
      this.desc, this.envelopePic, this.id, this.link, this.niceDate,
      this.origin, this.originId, this.publishTime, this.title, this.userId,
      this.visible, this.zan);

  factory CollectData.fromJson(Map<String, dynamic> json){
      return _$CollectDataFromJson(json);
  }

}

