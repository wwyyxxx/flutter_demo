import 'package:flutter/material.dart';
import 'package:banner_view/banner_view.dart';
import '../../http/api.dart';
import '../widget/article_item.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  ScrollController _controller = ScrollController();

  bool _isHide = true;

  List articles = [];

  List banners = [];

  var totalCount = 0;

  var curPage = 0;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      var maxScroll = _controller.position.maxScrollExtent;

      var pixels = _controller.position.pixels;

      if (maxScroll == pixels && curPage < totalCount) {
        _getArticlelist();
      }
    });

    _pullToRefresh();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ///正在加载
        Offstage(
          offstage: !_isHide,
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),

        ///内容
        Offstage(
          offstage: _isHide,
          child: RefreshIndicator(
            onRefresh: _pullToRefresh(),
            child: ListView.builder(
              itemBuilder: (context, i) => _buildItem(i),
              itemCount: articles.length + 1,
              controller: _controller,
            ),
          ),
        )
      ],
    );
  }

  _pullToRefresh() async {
    curPage = 0;
    Iterable<Future> futures = [_getArticlelist(), _getBanner()];
    await Future.wait(futures);
    _isHide = false;
    setState(() {});
    return null;
  }

  _getArticlelist([bool update = true]) async {
    var data = await Api.getArticleList(curPage);
    if (data != null) {
      var map = data['data'];
      var datas = map['datas'];

      totalCount = map['pageCount'];
      if (curPage == 0) {
        articles.clear();
      }

      curPage++;

      articles.addAll(datas);

      if (update) {
        setState(() {});
      }
    }
  }

  _getBanner([bool update = true]) async {
    var data = await Api.getBanner();
    if (data != null) {
      banners.clear();
      banners.addAll(data['data']);
      if (update) {
        setState(() {});
      }
    }
  }

  _buildItem(i) {
    if (i == 0) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.3,
        child: _bannerView(),
      );
    }
    var itemData = articles[i - 1];
    return ArticleItem(itemData);
  }

  _bannerView() {
    List<Widget> list = banners.map((item) {
      return Image.network(item['imagePath'], fit: BoxFit.cover);
    }).toList();

    return list.isNotEmpty
        ? BannerView(
            list,
            //控制轮播时间
            intervalDuration: const Duration(seconds: 3),
          )
        : null;
  }
}
