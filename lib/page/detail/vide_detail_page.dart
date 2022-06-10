import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fultter/utils/cache_image.dart';
import 'package:fultter/utils/navigaor_util.dart';
import 'package:fultter/widget/loading_state_widget.dart';
import 'package:fultter/widget/provider_widget.dart';
import 'package:fultter/widget/video/video_item_widget.dart';

import '../../config/string.dart';
import '../../model/common_item.dart';
import '../../utils/date_util.dart';
import '../../viewmodel/video/video_detail_viewmodel.dart';
import '../../widget/video/video_play_widget.dart';

class VideoDetailPage extends StatefulWidget {
  final Data? videoDta;

  const VideoDetailPage({Key? key, this.videoDta}) : super(key: key);

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with WidgetsBindingObserver {
  late Data data;
// 允许element在树周围移动(改变父节点), 而不会丢失状态
  final GlobalKey<VideoPlayWidgetState> videoKey = GlobalKey();
  @override
  void initState() {
    data = widget.videoDta ?? arguments();
    //监听页面可见与不可见状态
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    //AppLifecycleState当前页面的状态(是否可见)
    if (state == AppLifecycleState.paused) {
      // 页面不可见时,暂停视频
      // videoKey.currentState：树中当前具有此全局密钥的小部件的State对象
      videoKey.currentState!.pause();
    } else if (state == AppLifecycleState.resumed) {
      videoKey.currentState!.play();
    }
  }

  @override
  void dispose() {
    //移除监听页面可见与不可见状态
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("videoDta ${data.itemList}");
    return ProviderWidget<VideoDetailViewModel>(
        model: VideoDetailViewModel(),
        onModelInit: (model) => model.loadVideoData(data.id!),
        builder: (context, model, chile) {
          return _scaffold(model);
        });
  }

  Scaffold _scaffold(model) {
    print("_scaffold ${data.playUrl}");
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // AnnotatedRegion：改变状态栏内容的颜色
          AnnotatedRegion(
            // 设置状态栏的背景色为黑色
            child: _statusBar(),
            value: SystemUiOverlayStyle.light,
          ),
          VideoPlayWidget(
            key: videoKey,
            url: data.playUrl,
          ),
          Expanded(
            flex: 1,
            child: LoadingStateWidget(
              viewState: model.viewState,
              retry: model.retry,
              child: Container(
                decoration: _backGroundBoxDecoration(context),
                child: CustomScrollView(
                  slivers: [_videoDetailText(), _videoList(model)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 设置状态栏的背景色为黑色
  _statusBar() {
    return Container(
      height: MediaQuery.of(context).padding.top,
      color: Colors.black,
    );
  }

  SliverList _videoList(model) {
    return SliverList(
        delegate: SliverChildBuilderDelegate((context, index) {
      if (model.itemList?[index].type == 'videoSmallCard') {
        return VideoItemWidget(data: model?.itemList[index].data,);
      }
      return Padding(
        padding: EdgeInsets.only(left: 10, top: 10),
        child: Text(
          model.itemList?[index].data?.text ?? '',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );
    }, childCount: model.itemList?.length));
  }

  SliverToBoxAdapter _videoDetailText() {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _videoTitle(),
          _videoTime(),
          _videoDesc(),
          _videoState(),
          _divider(),
          _videoAuthor(),
          _divider(),
        ],
      ),
    );
  }

  Padding _videoAuthor() {
    return Padding(
      padding: EdgeInsets.only(top: 10, left: 10),
      child: Row(
        children: [
          ClipOval(
            child: cacheImage(data.author!.icon!, height: 40, width: 40),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(data.author!.name!,
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                  Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: Text(
                      data.author!.description!,
                      style: TextStyle(fontSize: 13, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              padding: EdgeInsets.all(5),
              child: Text(
                WyxString.add_follow,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Padding _divider() {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Divider(height: 0.5, color: Colors.white),
    );
  }

  Padding _videoState() {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      // 水平 LinearLayout
      child: Row(
        children: <Widget>[
          _row('images/ic_like.png', '${data.consumption?.collectionCount}'),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: _row(
                'images/ic_share_white.png', '${data.consumption?.shareCount}'),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: _row(
                'images/icon_comment.png', '${data.consumption?.replyCount}'),
          ),
        ],
      ),
    );
  }

  Padding _videoTime() {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Text(
          '#${data.category} / ${formatDateMsByYMDHM(data.author!.latestReleaseTime!)}',
          style: TextStyle(color: Colors.white, fontSize: 12)),
    );
  }

  Decoration _backGroundBoxDecoration(BuildContext context) {
    return BoxDecoration(
      image: DecorationImage(
          fit: BoxFit.cover,
          image: cachedNetworkImageProvider(
              '${data.cover?.blurred}}/thumbnail/${MediaQuery.of(context).size.height}x${MediaQuery.of(context).size.width}')),
    );
  }

  /// 视频分类及上架时间
  Widget _videoTitle() {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10),
      child: Text(
        data.title!,
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
      ),
    );
  }

  Padding _videoDesc() {
    return Padding(
      padding: EdgeInsets.only(left: 10, top: 10, right: 10),
      child: Text(
        data.description!,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _row(String image, String text) {
    return Row(
      children: <Widget>[
        Image.asset(
          image,
          height: 22,
          width: 22,
        ),
        Padding(
          padding: EdgeInsets.only(left: 3),
          child: Text(
            text,
            style: TextStyle(color: Colors.white, fontSize: 13),
          ),
        ),
      ],
    );
  }
}
