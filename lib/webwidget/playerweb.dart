import 'package:dtlive/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class PlayerWeb extends StatefulWidget {
  final int? videoId, videoType, typeId, stopTime;
  final String? playType, videoUrl, vSubTitleUrl;
  const PlayerWeb(this.playType, this.videoId, this.videoType, this.typeId,
      this.videoUrl, this.vSubTitleUrl, this.stopTime,
      {Key? key})
      : super(key: key);

  @override
  State<PlayerWeb> createState() => _PlayerWebState();
}

class _PlayerWebState extends State<PlayerWeb> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    debugPrint("========> ${widget.videoUrl}");
    _controller = VideoPlayerController.network(widget.videoUrl ?? "")
      ..initialize().then((_) async {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        await _controller.play();
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: appBgColor,
        body: Center(
          child: _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
        ),
      ),
    );
  }

  Future<bool> onBackPressed() async {
    if (!mounted) return Future.value(false);
    Navigator.pop(context, false);
    return Future.value(true);
  }
}
