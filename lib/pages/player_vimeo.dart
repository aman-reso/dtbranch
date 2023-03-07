import 'dart:developer';

import 'package:dtlive/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vimeo_video_player/vimeo_video_player.dart';

class PlayerVimeo extends StatefulWidget {
  final String? url;
  const PlayerVimeo({Key? key, required this.url}) : super(key: key);

  @override
  State<PlayerVimeo> createState() => PlayerVimeoState();
}

class PlayerVimeoState extends State<PlayerVimeo> {
  String? vUrl;

  @override
  void initState() {
    super.initState();
    vUrl = widget.url;
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
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPressed() async {
    // log("onBackPressed playerCPosition :===> $playerCPosition");
    // log("onBackPressed videoDuration :===> $videoDuration");
    // log("onBackPressed playType :===> ${widget.playType}");
    // if (widget.playType == "Video" || widget.playType == "Show") {
    //   if ((playerCPosition ?? 0) > 0 &&
    //       (playerCPosition == videoDuration ||
    //           (playerCPosition ?? 0) > (videoDuration ?? 0))) {
    //     /* Remove From Continue */
    //     await playerProvider.removeFromContinue(
    //         "${widget.videoId}", "${widget.videoType}");
    //     if (!mounted) return Future.value(false);
    //     Navigator.pop(context, true);
    //     return Future.value(true);
    //   } else if ((playerCPosition ?? 0) > 0) {
    //     /* Add to Continue */
    //     await playerProvider.addToContinue(
    //         "${widget.videoId}", "${widget.videoType}", "$playerCPosition");
    //     if (!mounted) return Future.value(false);
    //     Navigator.pop(context, true);
    //     return Future.value(true);
    //   } else {
    //     if (!mounted) return Future.value(false);
    //     Navigator.pop(context, false);
    //     return Future.value(true);
    //   }
    // } else {
    if (!mounted) return Future.value(false);
    Navigator.pop(context, false);
    return Future.value(true);
    // }
  }
}
