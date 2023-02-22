import 'package:dtlive/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:pod_player/pod_player.dart';

class PlayerWeb extends StatefulWidget {
  final int? videoId, videoType, typeId, stopTime;
  final String? playType, videoUrl, vSubTitleUrl, vUploadType;
  const PlayerWeb(this.playType, this.videoId, this.videoType, this.typeId,
      this.videoUrl, this.vSubTitleUrl, this.stopTime, this.vUploadType,
      {Key? key})
      : super(key: key);

  @override
  State<PlayerWeb> createState() => _PlayerWebState();
}

class _PlayerWebState extends State<PlayerWeb> {
  late final PodPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  late PlayVideoFrom playVideoFrom;

  @override
  void initState() {
    debugPrint("========> ${widget.vUploadType}");
    debugPrint("========> ${widget.videoUrl}");
    if (widget.vUploadType == "youtube") {
      playVideoFrom = PlayVideoFrom.youtube(
        /* widget.videoUrl ??  */ "https://youtu.be/A3ltMaM6noM",
      );
    } else if (widget.vUploadType == "vimeo") {
      playVideoFrom = PlayVideoFrom.vimeo(
        /* widget.videoUrl ??  */ "10679287",
      );
    } else {
      playVideoFrom = PlayVideoFrom.network(widget.videoUrl ?? "");
    }
    _controller = PodPlayerController(
      playVideoFrom: playVideoFrom,
      podPlayerConfig: const PodPlayerConfig(
        autoPlay: true,
        isLooping: false,
        videoQualityPriority: [1080, 720, 360],
      ),
    );
    _initializeVideoPlayerFuture = _controller.initialise();
    super.initState();
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
              child: PodVideoPlayer(controller: _controller),
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
    if (!mounted) return Future.value(false);
    Navigator.pop(context, false);
    return Future.value(true);
  }
}
