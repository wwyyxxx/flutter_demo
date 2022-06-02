import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MainPage());

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //路由表注册
    return MaterialApp(routes: {
      //默认首页的路由地址
      "/": (_) {
        return MainPageDetail();
      },
      "/page2": (_) => Page2()
    }, title: "第一个页面");
  }
}
class MainPageDetail extends StatefulWidget {
  const MainPageDetail({Key? key}) : super(key: key);

  @override
  State<MainPageDetail> createState() => _MainPageDetailState();
}

class _MainPageDetailState extends State<MainPageDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("第一个页面"),
      ),
      body: Column(
        children: [
          RaisedButton(
            onPressed: () async {
              // Wyx wyx =
               Navigator.pushNamed(context, "/page2");
              // debugPrint(wyx.toString());
            },
            child: Text("跳转第一个页面"),
          )
        ],
      ),
    );
  }
}


class Wyx {
  String name;
  int age;

  Wyx(this.name, this.age);

  @override
  String toString() {
    return 'Wyx{name: $name, age: $age}';
  }
}

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("第二个页面"),
        ),
        body: RaisedButton(
          onPressed: () {
            Navigator.pop(context, Wyx("wyx", 18));
          },
          child: Text("回到第一个页面"),
        ));
  }
}
