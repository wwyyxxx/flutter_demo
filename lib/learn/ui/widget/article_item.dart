import 'package:flutter/material.dart';

class ArticleItem extends StatelessWidget {
  final itemData;

  const ArticleItem(this.itemData);

  @override
  Widget build(BuildContext context) {
    ///时间与作者
    Row author = Row( //水平线性布局
      children: <Widget>[
        //expanded 最后摆我，相当于linearlayout的weight权重
        Expanded(
            child: Text.rich(TextSpan(children: [
          const TextSpan(text: "作者: "),
          TextSpan(
              text: itemData['author'],
              style: TextStyle(color: Theme.of(context).primaryColor))
        ]))),
        Text(itemData['niceDate'])//时间
      ],
    );

    ///标题
    Text title = Text(
      itemData['title'],
      style: const TextStyle(fontSize: 16.0, color: Colors.black),
      textAlign: TextAlign.left,
    );

    ///章节名
    Text chapterName = Text(itemData['chapterName'],
        style: TextStyle(color: Theme.of(context).primaryColor));

    Column column = Column( //垂直线性布局
      crossAxisAlignment: CrossAxisAlignment.start, //子控件左对齐
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: author,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: title,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
          child: chapterName,
        ),
      ],
    );

    return Card(
      ///阴影效果
      elevation: 4.0,
      child: column,
    );
  }
}

