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