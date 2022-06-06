import 'package:flutter/material.dart';

void main() => runApp(AnimationApp());

class AnimationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "animation",
      home: Scaffold(
        appBar: AppBar(
          title: Text('animation'),
        ),
        body: AnimWidget(),
      ),
    );
  }
}

// 动画是有状态的
class AnimWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AnimWidgetState();
  }
}

class _AnimWidgetState extends State<AnimWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;
  bool forward = true;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      // 动画的时长
      duration: Duration(milliseconds: 2000),
      // 提供 vsync 最简单的方式，就是直接继承 SingleTickerProviderStateMixin
      vsync: this,
    );

    //弹性
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    //使用Color
    animation = Tween(begin: 10.0, end: 100.0).animate(animation);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ScaleTransition(
          child:  Container(
            width: 100,
            height: 100,
            color: Colors.blue,
          ),
          scale: controller,
        ),
        RaisedButton(
          child: Text("播放"),
          onPressed: () {
            if (forward) {
              controller.forward();
            } else {
              controller.reverse();
            }
            forward = !forward;
          },
        ),
        RaisedButton(
          child: Text("停止"),
          onPressed: () {
            controller.stop();
          },
        )
      ],
    );
  }
}