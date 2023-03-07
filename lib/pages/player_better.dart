import 'dart:developer';

// import 'package:better_player/better_player.dart';
import 'package:dtlive/provider/playerprovider.dart';
import 'package:dtlive/utils/color.dart';
// import 'package:dtlive/utils/constant.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PlayerBetter extends StatefulWidget {
  final int? videoId, videoType, typeId, stopTime;
  final String? playType, videoUrl, vSubTitleUrl, vUploadType, videoThumb;
  const PlayerBetter(
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
  State<PlayerBetter> createState() => _PlayerBetterState();
}

class _PlayerBetterState extends State<PlayerBetter> {
  late PlayerProvider playerProvider;
  int? playerCPosition, videoDuration;
  // late BetterPlayerController _betterPlayerController;

  @override
  void initState() {
    debugPrint("videoUrl ========> ${widget.videoUrl}");
    debugPrint("vUploadType ========> ${widget.vUploadType}");
    playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    // BetterPlayerConfiguration betterPlayerConfiguration =
    //     BetterPlayerConfiguration(
    //   aspectRatio: 16 / 9,
    //   fit: BoxFit.fill,
    //   allowedScreenSleep: false,
    //   expandToFill: true,
    //   autoPlay: true,
    //   controlsConfiguration: const BetterPlayerControlsConfiguration(
    //       enablePip: true, pipMenuIcon: Icons.picture_in_picture_alt_outlined),
    //   startAt: Duration(milliseconds: widget.stopTime ?? 0),
    //   fullScreenByDefault: true,
    //   autoDetectFullscreenDeviceOrientation: true,
    //   subtitlesConfiguration: const BetterPlayerSubtitlesConfiguration(
    //     backgroundColor: transparentColor,
    //     fontColor: Colors.white,
    //     outlineColor: Colors.black,
    //     fontSize: 12,
    //     alignment: Alignment.bottomCenter,
    //   ),
    //   deviceOrientationsOnFullScreen: [
    //     DeviceOrientation.landscapeLeft,
    //     DeviceOrientation.landscapeRight
    //   ],
    // );

    // _betterPlayerController = BetterPlayerController(betterPlayerConfiguration);
    // _betterPlayerController.addEventsListener((event) async {
    //   if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
    //     log("Current subtitle line: ${_betterPlayerController.renderedSubtitle}");
    //     playerCPosition =
    //         (_betterPlayerController.videoPlayerController?.value.position)
    //                 ?.inMilliseconds ??
    //             0;
    //     videoDuration =
    //         (_betterPlayerController.videoPlayerController?.value.duration)
    //                 ?.inMilliseconds ??
    //             0;
    //     log("playerCPosition :===> $playerCPosition");
    //     log("videoDuration :===> $videoDuration");
    //   }
    // });

    _setupDataSource();

    super.initState();
  }

  void _setupDataSource() async {
    debugPrint("vSubTitle URL =======> ${widget.vSubTitleUrl}");
    // BetterPlayerDataSourceType dataSourceType;
    // if (widget.playType == "Download") {
    //   dataSourceType = BetterPlayerDataSourceType.file;
    // } else {
    //   dataSourceType = BetterPlayerDataSourceType.network;
    // }
    // BetterPlayerDataSource dataSource = BetterPlayerDataSource(
    //   dataSourceType,
    //   widget.videoUrl ?? "",
    //   resolutions:
    //       Constant.resolutionsUrls.isNotEmpty ? Constant.resolutionsUrls : {},
    //   subtitles: (widget.vSubTitleUrl ?? "").isNotEmpty
    //       ? [
    //           BetterPlayerSubtitlesSource(
    //             type: BetterPlayerSubtitlesSourceType.network,
    //             name: "En",
    //             urls: [(widget.vSubTitleUrl ?? "")],
    //             selectedByDefault: true,
    //           ),
    //         ]
    //       : [],
    // );
    // _betterPlayerController.setupDataSource(dataSource);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("===> ${widget.videoUrl}");
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: appBgColor,
        body: Center(
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: /* BetterPlayer(
              controller: _betterPlayerController,
            ) */
                Container(),
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
