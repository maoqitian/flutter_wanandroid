import 'package:flutter_wanandroid/model/article/article_tag_data.dart';
import 'package:json_annotation/json_annotation.dart';
part 'article_data.g.dart';
/// Created with Android Studio.
/// User: maoqitian
/// Date: 2019/11/4 0004
/// email: maoqitian068@163.com
/// des:  每篇文章对应 bean
/// "apkLink": "",
//    "audit": 1,
//    "author": "",
//    "chapterId": 502,
//    "chapterName": "自助",
//    "collect": false,
//    "courseId": 13,
//    "desc": "",
//    "envelopePic": "",
//    "fresh": false,
//    "id": 10010,
//    "link": "https://juejin.im/post/5db9889ae51d4529e8394e63",
//    "niceDate": "2019-10-31",
//    "niceShareDate": "2019-10-30",
//    "origin": "",
//    "prefix": "",
//    "projectLink": "",
//    "publishTime": 1572454456000,
//    "selfVisible": 0,
//    "shareDate": 1572446121000,
//    "shareUser": "星星y",
//    "superChapterId": 494,
//    "superChapterName": "广场Tab",
//    "tags": [],
//    "title": "面对Flutter，我终于迈出了第一步",
//    "type": 0,
//    "userId": 15603,
//    "visible": 1,
//    "zan": 0
//

@JsonSerializable()
class ArticleData{

   String apkLink;
   String author;
   int chapterId;
   String chapterName;
   bool collect;
   int courseId;
   String desc;
   String envelopePic;
   bool fresh;
   int id;
   String link;
   String niceDate;
   String origin;
   String prefix;
   String projectLink;
   int publishTime;
   int superChapterId;
   String superChapterName;
   String title;
   int type;
   int userId;
   int visible;
   int zan;
   int audit;
   List<ArticleTagData> tags;
   String niceShareDate;
   int selfVisible;
   int shareDate;
   String shareUser;


   ArticleData(this.apkLink, this.author, this.chapterId, this.chapterName,
       this.collect, this.courseId, this.desc, this.envelopePic, this.fresh,
       this.id, this.link, this.niceDate, this.origin, this.prefix,
       this.projectLink, this.publishTime, this.superChapterId,
       this.superChapterName, this.title, this.type, this.userId, this.visible,
       this.zan, this.audit, this.tags, this.niceShareDate, this.selfVisible,
       this.shareDate, this.shareUser);

   factory ArticleData.fromJson(Map<String, dynamic> json) => _$ArticleDataFromJson(json);

   Map<String,dynamic> toJson() => _$ArticleDataToJson(this);
}

