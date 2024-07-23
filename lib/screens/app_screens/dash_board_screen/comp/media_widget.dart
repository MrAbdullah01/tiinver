import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:tiinver_project/models/feedTimeLineModel/feed_time_line_model.dart';
import 'package:get/get.dart';
import '../../detailScreen/detail_screen.dart';

class MediaWidget extends StatelessWidget {
  final Activity activity;

  MediaWidget({required this.activity});

  @override
  Widget build(BuildContext context) {
    if (activity.isImage()) {
      return GestureDetector(
        onTap: () {
          Get.to(() => DetailScreen(activity: activity));
        },
        child: Image.network(activity.objectUrl!, fit: BoxFit.cover),
      );
    } else if (activity.isVideo()) {
      return GestureDetector(
        onTap: () {
          Get.to(() => DetailScreen(activity: activity));
        },
        child: VideoWidget(activity: activity),
      );
    } else {
      return Container();
    }
  }
}

class VideoWidget extends StatefulWidget {
  final Activity activity;

  VideoWidget({required this.activity});

  @override
  _VideoWidgetState createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.activity.objectUrl!))
      ..initialize().then((_) {
        setState(() {}); // When your video has been loaded
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    )
        : Center(child: CircularProgressIndicator());
  }
}
