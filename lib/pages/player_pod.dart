import 'dart:developer';
import 'dart:io';

import 'package:dtlive/provider/playerprovider.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pod_player/pod_player.dart';
import 'package:provider/provider.dart';

class PlayerPod extends StatefulWidget {
  final int? videoId, videoType, typeId, stopTime;
  final String? playType, videoUrl, vSubTitleUrl, vUploadType, videoThumb;
  const PlayerPod(
      this.playType,
      this.videoId,
      this.videoType,
      this.typeId,
      this.videoUrl,
      this.vSubTitleUrl,
      this.stopTime,
      this.vUploadType,
      this.videoThumb,
      {Key? key})
      : super(key: key);

  @override
  State<PlayerPod> createState() => _PlayerPodState();
}

class _PlayerPodState extends State<PlayerPod> {
  late PlayerProvider playerProvider;
  late final PodPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late PlayVideoFrom playVideoFrom;
  int? playerCPosition, videoDuration;

  @override
  void initState() {
    playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    debugPrint("========> ${widget.vUploadType}");
    debugPrint("========> ${widget.videoUrl}");
    _playerInit();
    super.initState();
  }

  _playerInit() async {
    if (widget.vUploadType == "youtube") {
      playVideoFrom = PlayVideoFrom.youtube(widget.videoUrl ?? "");
    } else if (widget.vUploadType == "vimeo") {
      playVideoFrom = PlayVideoFrom.vimeo(widget.videoUrl ?? "");
    } else if (widget.playType == "Download") {
      playVideoFrom = PlayVideoFrom.file(File(widget.videoUrl ?? ""));
    } else {
      playVideoFrom = PlayVideoFrom.network(widget.videoUrl ?? "");
    }
    _controller = PodPlayerController(
      playVideoFrom: playVideoFrom,
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: true,
        isLooping: false,
        videoQualityPriority: [2160, 1440, 1080, 720, 360, 240, 144],
      ),
    );
    _controller.videoSeekTo(Duration(milliseconds: widget.stopTime ?? 0));
    _initializeVideoPlayerFuture = _controller.initialise();

    _controller.addListener(() async {
      playerCPosition =
          (_controller.videoPlayerValue?.position)?.inMilliseconds ?? 0;
      videoDuration =
          (_controller.videoPlayerValue?.duration)?.inMilliseconds ?? 0;
      log("playerCPosition :===> $playerCPosition");
      log("videoDuration :===> $videoDuration");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return WillPopScope(
              onWillPop: onBackPressed,
              child: PodVideoPlayer(
                controller: _controller,
                videoThumbnail: DecorationImage(
                    image: NetworkImage(widget.videoThumb ?? "")),
              ),
            );
          } else {
            return Center(
              child: Utils.pageLoader(),
            );
          }
        },
      ),
    );
  }

  Future<bool> onBackPressed() async {
    log("onBackPressed playerCPosition :===> $playerCPosition");
    log("onBackPressed videoDuration :===> $videoDuration");
    log("onBackPressed playType :===> ${widget.playType}");

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    if (widget.playType == "Video" || widget.playType == "Show") {
      if ((playerCPosition ?? 0) > 0 &&
          (playerCPosition == videoDuration ||
              (playerCPosition ?? 0) > (videoDuration ?? 0))) {
        /* Remove From Continue */
        await playerProvider.removeFromContinue(
            "${widget.videoId}", "${widget.videoType}");
        if (!mounted) return Future.value(false);
        Navigator.pop(context, true);
        return Future.value(true);
      } else if ((playerCPosition ?? 0) > 0) {
        /* Add to Continue */
        await playerProvider.addToContinue(
            "${widget.videoId}", "${widget.videoType}", "$playerCPosition");
        if (!mounted) return Future.value(false);
        Navigator.pop(context, true);
        return Future.value(true);
      } else {
        if (!mounted) return Future.value(false);
        Navigator.pop(context, false);
        return Future.value(true);
      }
    } else {
      if (!mounted) return Future.value(false);
      Navigator.pop(context, false);
      return Future.value(true);
    }
  }
}