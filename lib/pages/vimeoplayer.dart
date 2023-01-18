import 'dart:developer';

import 'package:dtlive/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:vimeo_video_player/vimeo_video_player.dart';

class VimeoPlayerPage extends StatefulWidget {
  var url;
  VimeoPlayerPage({Key? key, required this.url});

  @override
  State<VimeoPlayerPage> createState() => VimeoPlayerPageState();
}

class VimeoPlayerPageState extends State<VimeoPlayerPage> {
  @override
  Widget build(BuildContext context) {
    log("===> URL ${widget.url.toString()}");
    return Scaffold(
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
