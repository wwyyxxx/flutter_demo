# FlutterDemo

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