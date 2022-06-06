import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp2());
}

class MyApp extends StatelessWidget {
  MyApp() {
    Future.delayed(Duration(seconds: 3)).then((s) => {this.data = "tungbo"});
  }

  String data = "wyx";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("haha"),
            ),
            body: Center(child: Text(data))));
  }
}

class MyApp2 extends StatefulWidget {
  const MyApp2({Key? key}) : super(key: key);

  @override
  State<MyApp2> createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  String data = "wyx";

  //构造函数不能setState()
  //build --> Future
  _MyApp2State() {
    //Future Event队列
    Future.delayed(Duration(microseconds: 1)).then((s) {
      debugPrint("Future");
      setState(() {
        this.data = "tungbo11";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build");
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              title: Text("haha"),
            ),
            body: Center(child: Text(data))));
  }
}
