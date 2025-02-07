# FlutterDemo
<!-- ![image](https://github.com/wwyyxxx/FlutterDemo/blob/main/Screenshot_20220613_163403.png)
![image](https://github.com/wwyyxxx/FlutterDemo/blob/main/Screenshot_20220613_163340.png) -->
<img src="https://github.com/wwyyxxx/FlutterDemo/blob/main/Screenshot_20220613_163403.png" width="270" height="635">         <img src="https://github.com/wwyyxxx/FlutterDemo/blob/main/Screenshot_20220613_163340.png" width="270" height="635">


    one day:
        1.flutter sdk环境配置
        2.demo运行
        3.热重载不支持构造函数更改
        4.构造函数不能setState()
        5.State生命周期方法
            a.构造函数    1次
            新建时：
                b.initState
                    当Widget第一次插入到Widget树时会被调用，对于每一个State对象，Flutter framework只会调用一次该回调
                c.didChangeDependencies
                    当依赖的InheritedWidget rebuild,会触发此接口被调用
                d.build
                    绘制界面，当setState触发的时候会再次被调用
            移除时：
                e.didUpdateWidget
                    状态改变的时候会调用该方法,比如调用了setState
                f.deactivate
                    当State对象从树中被移除时，会调用此回调
                g.dispose
                    当State对象从树中被永久移除时调用；通常在此回调中释放资源

    two day:
        路由跳转  注意context
        动画设置

    three day:
        Plugin--通讯-原生通讯
        混合开发--原生（通讯同Plugin库通讯）

    fourth day:
        动画：forward->completed  reverse->dismissed
            AnimationController
            Tween 补间--如颜色改变
            自定义动画....重写lerp()
            Curve--插值器
            AnimatedWidget
            HeroAnimate： 共享元素动画--不能同一个tag
                Stack大小为内容的大小
    
    fifth day:
        1.网络请求框架
        2.闪屏页框架
        3.启动逻辑初始化
        4.底部BottomNavagetion逻辑添加
            导航返回拦截--WillPopScope
            异步UI更新--FutureBuilder
        
    Day 6:
        1.首页的Banner图View
        2.bottomNavigationBar跳转方式更改
        3.ViewModel使用
        4.extended_image/provider
    
    Day 7:
        首页ListView
            1.ListView.separated
            2.GestureDetector
            3.EdgeInsets.fromLTRB
            4.Offstage

    Day 8:
        添加视频详情页面
            1.VideoPlay -- Chewie
            2.ProviderWidget
            3.Column、AnnotatedRegion、Expanded、ClipOval、BoxDecoration、Divider、Row、DecorationImage
            4.CustomScrollView、SliverToBoxAdapter、SliverList、SliverChildBuilderDelegate


    Day N:
        1.现有项目接入Flutter
            Flutter 当前仅支持 x86_64，armeabi-v7a, arm64-v8a 构建预编（AOT）的库
            cmd- flutter create -t module --org com.example my_flutter
            源码依赖：
                setBinding(new Binding([gradle: this]))
                evaluate(new File(
                settingsDir.parentFile, //注意路径
                'my_flutter/.android/include_flutter.groovy'
                ))
                implementation project(':flutter')

        2.添加 FlutterFragment
            通过 FlutterFragment.createDefault() 创建
            fragmentManager 进行提交展示
            Activity 回调某些操作 （onPostResume、onNewIntent、onBackPressed、onRequestPermissionsResult）
            FlutterEngine / FlutterEngineCache 提前初始化和缓存