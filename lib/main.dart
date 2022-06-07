import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fultter/tab_navigation.dart';
import 'package:get/get.dart';
import 'app_init.dart';
import 'http/http_manger.dart';

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
    HttpManager.getData(
      "http://baobab.kaiyanapp.com/api/v2/feed?num=1",
      success: (result) {
        print(result);
      },
      fail: (result){
        print("fail:"+result);
      }
    );
    return FutureBuilder(
        future: AppInit.init(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          print(snapshot.connectionState);
          var widget = snapshot.connectionState == ConnectionState.done
              ? TabNavigation()
              : Scaffold(
                  body: Center(
                    // 圈
                    child: CircularProgressIndicator(),
                  ),
                );
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
    return MaterialApp(
      title: 'Tungbo',
      initialRoute: '/',
      routes: {'/': (BuildContext context) => widget.child!},
    );
    // return GetMaterialApp(
    //   title: 'Tungbo',
    //   initialRoute: '/',
    //   getPages: [
    //     GetPage(name: "/", page: ()=> widget.child!)
    //   ],
    // );
  }
}
