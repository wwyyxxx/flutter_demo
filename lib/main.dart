import 'package:flutter/material.dart';
import 'package:fultter/ui/page/page_article.dart';

void main() => runApp(new ArticleApp());


class ArticleApp extends StatelessWidget {
  const ArticleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
        appBar: new AppBar(
          title: Text('文章',
          style: const TextStyle(color: Colors.white)),
        ),
        body: new ArticlePage(),
      ),
    );
  }
}
