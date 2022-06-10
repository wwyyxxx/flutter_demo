import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fultter/utils/cache_image.dart';

import '../../model/common_item.dart';
import '../../utils/date_util.dart';

class VideoItemWidget extends StatelessWidget {
  // 路径：common_item包
  final Data? data;

  // 点击回调方法
  final VoidCallback? callBack;

  // 是否开启hero动画，默认为false
  final bool openHero;
  final Color titleColor;
  final Color categoryColor;

  const VideoItemWidget(
      {Key? key,
      this.data,
      this.callBack,
      this.titleColor = Colors.white,
      this.categoryColor = Colors.white,
      this.openHero = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        callBack!();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        child: Row(
          children: [
            _videoImage(),
            _videoText()
          ],
        ),
      ),
    );
  }

  Expanded _videoText() {
    return Expanded(child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  data!.title!,
                  style: TextStyle(
                      color: titleColor, fontSize: 14, fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 15),
                  child: Text(
                    '#${data!.category} / ${data!.author?.name}',
                    style: TextStyle(color: categoryColor, fontSize: 12),
                  ),
                ),
              ],
            ),
          ));
  }

  Stack _videoImage() {
    return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child:
                    cacheImage(data!.cover!.detail!, width: 135, height: 80),
              ),
              Positioned(
                  right: 5,
                  bottom: 5,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.black54),
                      padding: EdgeInsets.all(3),
                      child: Text(
                        formatDateMsByMS(data!.duration! * 1000),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ))
            ],
          );
  }
}
