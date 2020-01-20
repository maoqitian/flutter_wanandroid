/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/1/8 0008
/// email: maoqitian068@163.com
/// des:
import 'package:flutter/material.dart';
import 'package:flutter_tags/tag.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/model/knowledge/knowledge_hierarchy_data.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';

class KnowledgeGridItem extends StatefulWidget {
  final KnowledgeHierarchyData knowledgeHierarchyData;

  KnowledgeGridItem(this.knowledgeHierarchyData);

  @override
  _KnowledgeGridItemState createState() => _KnowledgeGridItemState();
}

class _KnowledgeGridItemState extends State<KnowledgeGridItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: Colors.white,
        elevation: 4.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: ListTile(
              onTap: (){
                Application.router.navigateTo(context,'${Routes.knowledgedetail}?type=${Uri.encodeComponent(Constants.RESULT_CODE_KNOWLEDGE_PAGE)}&knowledgeJson=${ToolUtils.object2string(widget.knowledgeHierarchyData)}');
              },
              title: Text(widget.knowledgeHierarchyData.name),
              subtitle: Wrap(
                spacing: 10, //主轴上子控件的间距
                runSpacing: 10, //交叉轴上子控件之间的间距
                // 扩展方式，横向堆砌
                direction: Axis.horizontal,
                // 对齐方式
                alignment: WrapAlignment.start,
                // run的对齐方式 开始位置
                runAlignment: WrapAlignment.start,
                // 交叉轴对齐方式
                crossAxisAlignment: WrapCrossAlignment.end,
                // 文本对齐方向
                textDirection: TextDirection.ltr,
                // 确定垂直放置子元素的顺序，以及如何在垂直方向上解释开始和结束。 默认down
                verticalDirection: VerticalDirection.down,
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                //mainAxisSize: MainAxisSize.max,//表示尽可能多的占用水平方向的空间，此时无论子widgets实际占用多少水平空间，Row的宽度始终等于水平方向的最大宽度
                //children: buildTagItem(widget.knowledgeHierarchyData.children),
              ),
        ));
  }

  buildTagItem(List<KnowledgeHierarchyData> list) {
    return Tags(
       itemCount: list.length,
       itemBuilder: (int index){
         KnowledgeHierarchyData knowledgeHierarchyData = list[index];
        return Tooltip(
            message: knowledgeHierarchyData.name,
            child:ItemTags(
              key: Key(index.toString()),
              index: index,
              title: knowledgeHierarchyData.name,
            )
        );
      },
    );
  }
}
