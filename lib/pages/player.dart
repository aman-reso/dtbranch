import 'package:dtlive/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_view/flutter_video_view.dart';

class PlayerPage extends StatefulWidget {
  final double displayHeight;
  final int videoId, videoType, typeId;
  final String videoUrl, videoTitle;
  const PlayerPage(this.displayHeight, this.videoId, this.videoType,
      this.typeId, this.videoUrl, this.videoTitle,
      {Key? key})
      : super(key: key);

  @override
  State<PlayerPage> createState() => _PlayerPageState();
}

class _PlayerPageState extends State<PlayerPage> {
  late VideoViewController controller;

  @override
  void initState() {
    controller = VideoViewController(
      videoPlayerController: VideoPlayerController.network(widget.videoUrl),
      videoViewConfig: VideoViewConfig(
        height: widget.displayHeight * 0.3,
        autoInitialize: true,
        autoPlay: true,
        canShowLock: true,
        canBack: true,
        videoViewProgressColors: VideoViewProgressColors(
          handleColor: Colors.white,
        ),
        title: widget.videoTitle,
        deviceOrientationsExitFullScreen: <DeviceOrientation>[
          DeviceOrientation.portraitUp,
        ],
      ),
    );
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: Center(
        child: VideoView(
          controller: controller,
        ),
      ),
    );
  }
}
