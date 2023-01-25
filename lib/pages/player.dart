import 'dart:developer';

import 'package:better_player/better_player.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  // GlobalKey _betterPlayerKey = GlobalKey();

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
              backgroundColor: transparentColor,
              fontColor: Colors.white,
              outlineColor: Colors.black,
              fontSize: 12,
              alignment: Alignment.bottomCenter,
            ),
            deviceOrientationsOnFullScreen: [
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight
        ]);

    _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    _betterPlayerController.addEventsListener((event) {
      if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
        log("Current subtitle line: ${_betterPlayerController.renderedSubtitle}");
      }
    });

    _setupDataSource();

    super.initState();
  }

  void _setupDataSource() async {
    BetterPlayerDataSource dataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.network,
      Constant.exampleResolutionsUrls.values.first,
      resolutions: Constant.exampleResolutionsUrls,
      subtitles: [
        BetterPlayerSubtitlesSource(
            type: BetterPlayerSubtitlesSourceType.network,
            name: "EN",
            urls: [
              "https://dl.dropboxusercontent.com/s/71nzjo2ux3evxqk/example_subtitles.srt"
            ],
            selectedByDefault: true),
        BetterPlayerSubtitlesSource(
          type: BetterPlayerSubtitlesSourceType.network,
          name: "DE",
          urls: ["https://divinetechs.in/example.srt"],
        ),
      ],
    );
    _betterPlayerController.setupDataSource(dataSource);
    // _betterPlayerController.setBetterPlayerGlobalKey(_betterPlayerKey);
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
            // key: _betterPlayerKey,
          ),
        ),
      ),
    );
  }
}
