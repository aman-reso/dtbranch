import 'dart:developer';

import 'package:dtlive/provider/playerprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerYoutube extends StatefulWidget {
  final int? videoId, videoType, typeId, stopTime;
  final String? playType, videoUrl, vUploadType, videoThumb;
  const PlayerYoutube(this.playType, this.videoId, this.videoType, this.typeId,
      this.videoUrl, this.stopTime, this.vUploadType, this.videoThumb,
      {Key? key})
      : super(key: key);

  @override
  State<PlayerYoutube> createState() => PlayerYoutubeState();
}

class PlayerYoutubeState extends State<PlayerYoutube> {
  late YoutubePlayerController controller;
  bool fullScreen = false;
  late PlayerProvider playerProvider;
  int? playerCPosition, videoDuration;

  @override
  void initState() {
    playerProvider = Provider.of<PlayerProvider>(context, listen: false);
    debugPrint("videourlget:===${widget.videoUrl}");
    var videoId = YoutubePlayer.convertUrlToId(widget.videoUrl ?? "");
    controller = YoutubePlayerController(
      initialVideoId: videoId ?? "",
      flags:
          const YoutubePlayerFlags(autoPlay: true, mute: false, forceHD: true),
    );
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        body: Stack(
          children: [
            YoutubePlayerBuilder(
              onEnterFullScreen: () {
                fullScreen = true;
              },
              onExitFullScreen: () {
                fullScreen = false;
              },
              builder: (context, player) {
                return Column(
                  children: <Widget>[player],
                );
              },
              player: YoutubePlayer(
                controller: controller,
                aspectRatio: 16 / 9,
                showVideoProgressIndicator: true,
                width: MediaQuery.of(context).size.width,
                bottomActions: [
                  CurrentPosition(),
                  ProgressBar(isExpanded: true),
                ],
                onReady: () {
                  playerCPosition = controller.value.position.inMilliseconds;
                  videoDuration = controller.metadata.duration.inMilliseconds;
                  log("playerCPosition :===> $playerCPosition");
                  log("videoDuration :===> $videoDuration");
                },
                onEnded: (metaData) async {
                  /* Remove From Continue */
                  await playerProvider.removeFromContinue(
                      "${widget.videoId}", "${widget.videoType}");
                },
              ),
            ),
            if (!kIsWeb)
              Positioned(
                top: 15,
                left: 15,
                child: SafeArea(
                  child: InkWell(
                    onTap: onBackPressed,
                    focusColor: gray.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                    child: Utils.buildBackBtnDesign(context),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  Future<bool> onBackPressed() async {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
