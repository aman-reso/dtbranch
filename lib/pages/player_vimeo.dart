import 'dart:developer';

import 'package:dtlive/provider/playerprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

class PlayerVimeo extends StatefulWidget {
  final int? videoId, videoType, typeId, stopTime;
  final String? playType, videoUrl, vSubTitleUrl, vUploadType, videoThumb;
  const PlayerVimeo(
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
  State<PlayerVimeo> createState() => PlayerVimeoState();
}

class PlayerVimeoState extends State<PlayerVimeo> {
  String? vUrl;
  late PlayerProvider playerProvider;
  int? playerCPosition, videoDuration;

  @override
  void initState() {
    super.initState();
    vUrl = widget.videoUrl;
    if (!(vUrl ?? "").contains("https://vimeo.com/")) {
      vUrl = "https://vimeo.com/$vUrl";
    }
    log("vUrl===> $vUrl");
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: black,
        body: SafeArea(
          child: VimeoVideoPlayer(
            vimeoPlayerModel: VimeoPlayerModel(
              url: vUrl ?? "",
              systemUiOverlay: [],
              deviceOrientation: DeviceOrientation.landscapeLeft,
              startAt: Duration(milliseconds: widget.stopTime ?? 0),
              onProgress: (timePoint) {
                playerCPosition = timePoint.inMilliseconds;
                log("playerCPosition :===> $playerCPosition");
              },
              onFinished: () async {
                /* Remove From Continue */
                await playerProvider.removeFromContinue(
                    "${widget.videoId}", "${widget.videoType}");
              },
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPressed() async {
    log("onBackPressed playerCPosition :===> $playerCPosition");
    log("onBackPressed videoDuration :===> $videoDuration");
    log("onBackPressed playType :===> ${widget.playType}");
    if (widget.playType == "Video" || widget.playType == "Show") {
      if ((playerCPosition ?? 0) > 0) {
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
