import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/common_item.dart';

class VideoDetailPage extends StatefulWidget {
  final Data? videoDta;

  const VideoDetailPage({Key? key,this.videoDta}) : super(key: key);

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  @override
  Widget build(BuildContext context) {
    // return Container(color: Colors.blue,);
    print("videoDta ${widget.videoDta}");
    return Container(
        color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Text(
                'widget.videoDta!.title!',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
