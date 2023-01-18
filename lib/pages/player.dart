import 'dart:developer';

import 'package:better_player/better_player.dart';
import 'package:dtlive/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_video_view/flutter_video_view.dart';

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
  // late VideoViewController controller;
  late BetterPlayerController _betterPlayerController;
  GlobalKey _betterPlayerKey = GlobalKey();

  @override
  void initState() {
    BetterPlayerConfiguration betterPlayerConfiguration =
        const BetterPlayerConfiguration(
            aspectRatio: 16 / 9,
            fit: BoxFit.fill,
            allowedScreenSleep: false,
            expandToFill: true,
            autoPlay: true,
            autoDetectFullscreenDeviceOrientation: true,
            subtitlesConfiguration: BetterPlayerSubtitlesConfiguration(
              backgroundColor: Colors.green,
              fontColor: Colors.white,
              outlineColor: Colors.black,
              fontSize: 20,
            ),
            deviceOrientationsOnFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ]);
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      widget.videoUrl,
    );
    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.setupDataSource(dataSource);
    _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);

    super.initState();
  }

  @override
  void dispose() {
    // controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("===> ${widget.videoUrl}");
    return Scaffold(
      backgroundColor: appBgColor,
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer(
            controller: _betterPlayerController,
            key: _betterPlayerKey,
          ),
        ),
      ),
    );
  }
}
