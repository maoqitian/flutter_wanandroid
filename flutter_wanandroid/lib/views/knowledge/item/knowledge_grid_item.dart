/// Created with Android Studio.
/// User: maoqitian
/// Date: 2020/1/8 0008
/// email: maoqitian068@163.com
/// des: 知识体系 item
import 'package:flutter/material.dart';
import 'package:flutter_wanandroid/common/application.dart';
import 'package:flutter_wanandroid/common/constants.dart';
import 'package:flutter_wanandroid/components/tag_item_view.dart';
import 'package:flutter_wanandroid/model/knowledge/knowledge_hierarchy_data.dart';
import 'package:flutter_wanandroid/routers/routes.dart';
import 'package:flutter_wanandroid/utils/tool_utils.dart';

class KnowledgeGridItem extends StatefulWidget {
  final KnowledgeHierarchyData knowledgeHierarchyData;

  KnowledgeGridItem(this.knowledgeHierarchyData);

  @override
  _KnowledgeGridItemState createState() => _KnowledgeGridItemState();
}

class _KnowledgeGridItemState extends State<KnowledgeGridItem> with AutomaticKeepAliveClientMixin{

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Card(
        color: Colors.white,
        elevation: 4.0,
        margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
        child: ListTile(
              onTap: (){
                Application.router.navigateTo(context,'${Routes.knowledgedetail}?type=${Uri.encodeComponent(Constants.RESULT_CODE_KNOWLEDGE_PAGE)}&knowledgeJson=${ToolUtils.object2string(widget.knowledgeHierarchyData)}');
              },
              title: Text(widget.knowledgeHierarchyData.name,
                style:TextStyle(color: Colors.black, fontSize: 15.0,fontWeight: FontWeight.bold),),
              subtitle: buildTagItem(widget.knowledgeHierarchyData.children),
        ));
  }

  buildTagItem(List<KnowledgeHierarchyData> list) {
    /*List<Widget> tiles = [];
    list.map(f)
    for (var item in list) {
      tiles.add(TagItemView(textTitle: item.name));
    }*/
    return Wrap(
      spacing: 3, //主轴上子控件的间距
      runSpacing: 3, //交叉轴上子控件之间的间距
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
      children: list.map((KnowledgeHierarchyData knowledgeHierarchyData){
        return TagItemView(textTitle: knowledgeHierarchyData.name);
      }).toList(),
    );
  }
}
