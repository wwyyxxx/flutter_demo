import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fultter/config/string.dart';
import 'package:fultter/page/home/home_body_page.dart';
import 'package:fultter/widget/app_bar.dart';
import 'package:fultter/widget/loading_state_widget.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

/// AutomaticKeepAliveClientMixin作用：切换tab后保留tab的状态，避免initState方法重复调用
/// 1.需重写 wantKeepAlive 返回 true
/// 2.必须调用 super.build(context);
class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: appBar(WyxString.home,
          showBack: false),
      body: HomeBodyPage(),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
