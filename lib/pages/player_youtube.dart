import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlayerYoutube extends StatefulWidget {
  final String? videoUrl;
  const PlayerYoutube({Key? key, this.videoUrl}) : super(key: key);

  @override
  State<PlayerYoutube> createState() => PlayerYoutubeState();
}

class PlayerYoutubeState extends State<PlayerYoutube> {
  late YoutubePlayerController controller;
  bool fullScreen = false;

  @override
  void initState() {
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
    return Scaffold(
      body: YoutubePlayerBuilder(
        onEnterFullScreen: () {
          fullScreen = true;
        },
        onExitFullScreen: () {
          fullScreen = true;
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}
