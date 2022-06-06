

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fultter/utils/toast_util.dart';

import 'config/string.dart';

class TabNavigation extends StatefulWidget {
  const TabNavigation({Key? key}) : super(key: key);

  @override
  State<TabNavigation> createState() => _TabNavigationState();
}

class _TabNavigationState extends State<TabNavigation> {
  late DateTime lastTime;
  int _currentIndex = 0;

  Widget _currentBody = Container(
    color: Colors.blue,
  );

  @override
  Widget build(BuildContext context) {
    print("_TabNavigationState");
    return WillPopScope(child: Scaffold(
      body: _currentBody,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xff000000),
        unselectedItemColor: Color(0xff9a9a9a),
        items: _item(),
        onTap: _onTap,
      ),
    ), onWillPop: _onWillPop);
  }

  _onTap(int index) {
    switch (index) {
      case 0:
        _currentBody = Container(color: Colors.blue);
        break;
      case 1:
        _currentBody = Container(color: Colors.brown);
        break;
      case 2:
        _currentBody = Container(color: Colors.amber);
        break;
      case 3:
        _currentBody = Container(color: Colors.red);
        break;
    }
    setState(() {
      _currentIndex = index;
    });
  }

  List<BottomNavigationBarItem> _item() {
    return [
      _bottomItem(WyxString.home, 'images/ic_home_normal.png',
          'images/ic_home_selected.png'),
      _bottomItem(WyxString.discovery, 'images/ic_discovery_normal.png',
          'images/ic_discovery_selected.png'),
      _bottomItem(WyxString.hot, 'images/ic_hot_normal.png',
          'images/ic_hot_selected.png'),
      _bottomItem(WyxString.mine, 'images/ic_mine_normal.png',
          'images/ic_mine_selected.png'),
    ];
  }

  _bottomItem(String title, String normalIcon, String selectorIcon) {
    return BottomNavigationBarItem(
      icon: Image.asset(
        normalIcon,
        width: 24,
        height: 24,
      ),
      activeIcon: Image.asset(
        selectorIcon,
        width: 24,
        height: 24,
      ),
      label: title,
    );
  }

  Future<bool> _onWillPop() async {
    if (lastTime == null ||
        DateTime.now().difference(lastTime) > Duration(seconds: 2)) {
      lastTime = DateTime.now();
      WyxToast.showTip(WyxString.exit_tip);
      return false;
    } else {
      // 自动出栈
      return true;
    }
  }
}
