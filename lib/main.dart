import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fultter/page/detail/vide_detail_page.dart';
import 'package:fultter/tab_navigation.dart';
import 'package:get/get.dart';
import 'app_init.dart';

void main() {
  runApp(MyApp());
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  }
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AppInit.init(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          var widget = snapshot.connectionState == ConnectionState.done
              ? TabNavigation()
              : Scaffold(
                  body: Center(
                    // 圈
                    child: CircularProgressIndicator(),
                  ),
                );
          // print(widget);
          return GetMaterialAppWidget(child: widget);
        });
  }
}

class GetMaterialAppWidget extends StatefulWidget {
  final Widget? child;

  const GetMaterialAppWidget({Key? key, this.child}) : super(key: key);

  @override
  State<GetMaterialAppWidget> createState() => _GetMaterialAppWidgetState();
}

class _GetMaterialAppWidgetState extends State<GetMaterialAppWidget> {
  @override
  Widget build(BuildContext context) {
    // return GetMaterialApp(
    //   title: 'Tungbo',
    //   initialRoute: '/',
    //   routes: {'/': (BuildContext context) => widget.child!},
    // );
    return GetMaterialApp(
      title: 'Tungbo',
      initialRoute: '/',
      getPages: [
        GetPage(name: "/", page: ()=> widget.child!),
        GetPage(name: '/detail', page: () => VideoDetailPage()),
      ],
    );
  }
}
