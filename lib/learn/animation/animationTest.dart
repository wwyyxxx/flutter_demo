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

  bool forward = true;

  late ColorTween tween;

  late Animation<double> animation;
  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      // 动画的时长
      duration: Duration(milliseconds: 2000),
      // 提供 vsync 最简单的方式，就是直接继承 SingleTickerProviderStateMixin
      vsync: this,
    );
    //使用Color
    tween = ColorTween(begin: Colors.blue, end: Colors.yellow);
    //添加动画值修改监听
    tween.animate(controller).addListener(() => setState(() {}));
    controller.addStatusListener((status) {
      debugPrint("status:$status");
      /// 正向完成
      if(status == AnimationStatus.completed) {
        // controller.reverse();
      } else if(status == AnimationStatus.dismissed) {/// 反向完成
        // controller.forward();
      }
    });

    //弹性
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceIn);
    animation = Tween(begin: 10.0, end: 100.0).animate(animation)
      ..addListener(() {
        setState(() => {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: animation.value,
          height: animation.value,
          //获取动画当前值
          color: Colors.blue,
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