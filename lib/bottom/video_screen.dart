import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    videoPlayerController = VideoPlayerController.network(
        'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4');
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: videoPlayerController.value.aspectRatio,
        autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.5,
            child: Chewie(controller: chewieController),
            //child: VideoPlayer(videoPlayerController),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                  onPressed: () {
                    print('Chewiw Controll : ' +
                        chewieController
                            .videoPlayerController.value.duration.inSeconds
                            .toString());

                    print("VideoPlayer : " +
                        videoPlayerController.value.duration.inSeconds
                            .toString());

                    print("VideoPlayer current value : " +
                        videoPlayerController.value.position.inSeconds
                            .toString());

                    print(videoPlayerController.value.position -
                        Duration(seconds: 10));

                    videoPlayerController.value.position.inSeconds - 5;
                    videoPlayerController.seekTo(
                        videoPlayerController.value.position -
                            Duration(seconds: 5));
                  },
                  icon: Icon(Icons.fast_rewind)),
              IconButton(
                  onPressed: () {
                    videoPlayerController.seekTo(
                        videoPlayerController.value.position +
                            Duration(seconds: 5));
                  },
                  icon: Icon(Icons.fast_forward))
            ],
          )
        ],
      ),
    );
  }

  Future forward10Seconds() async => goToPosition(
      (currentPosition) => currentPosition - Duration(seconds: 10));
  Future rewind10Seconds() async => goToPosition(
      (currentPosition) => currentPosition - Duration(seconds: 10));
  Future goToPosition(
    Duration Function(Duration currentPosition) builder,
  ) async {
    final currentPosition = await videoPlayerController.position;
    final newPosition = builder(currentPosition!);

    await videoPlayerController.seekTo(newPosition);
  }
}
