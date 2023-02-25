import 'dart:developer';

import 'package:dtlive/utils/color.dart';
import 'package:flutter/material.dart';
// import 'package:vimeo_video_player/vimeo_video_player.dart';

class PlayerVimeo extends StatefulWidget {
  final String? url;
  const PlayerVimeo({Key? key, required this.url}) : super(key: key);

  @override
  State<PlayerVimeo> createState() => PlayerVimeoState();
}

class PlayerVimeoState extends State<PlayerVimeo> {
  @override
  Widget build(BuildContext context) {
    log("===> URL ${widget.url.toString()}");
    return const Scaffold(
      backgroundColor: white,
      // body: SafeArea(
      // child: VimeoVideoPlayer(
      //   vimeoPlayerModel: VimeoPlayerModel(
      //     url: widget.url.toString(),
      //     deviceOrientation: DeviceOrientation.portraitUp,
      //     systemUiOverlay: const [
      //       SystemUiOverlay.top,
      //       SystemUiOverlay.bottom,
      //     ],
      //   ),
      // ),
      // ),
    );
  }
}
