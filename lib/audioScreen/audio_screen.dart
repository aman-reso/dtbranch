import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/webwidget/commonappbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/sectiondetailmodel.dart';
import '../webservice/apiservices.dart';
import '../widget/mytext.dart';

class AudioScreen extends StatefulWidget {
  final Bhajan? bhajan;

  const AudioScreen(this.bhajan, {Key? key}) : super(key: key);

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  bool isFavorite = false;

  final chapterlist = [
    "1",
    "2",
    "3",
    "4",
    "5",
  ];

  String? chapterText;

  AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  SectionDetailModel? sectionDetailModel;

  @override
  void initState() {
    chapterText = chapterlist[1];
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
    super.initState();
    if (widget.bhajan != null) {
      getSectionDetails(widget.bhajan?.typeId, widget.bhajan?.videoType,
          widget.bhajan?.id, widget.bhajan?.upcomingType);
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  Future setAudio() async {
    audioPlayer.setReleaseMode(ReleaseMode.loop);
    audioPlayer.setSourceUrl(sectionDetailModel?.result?.video320 ?? "");
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          backgroundColor: whiteLight1,
          foregroundColor: whiteLight1,
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: const Text(
            "Read",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: black,
            ),
            // Icon for the back button
            onPressed: () {
              Navigator.of(context).pop(); // Navigate back to previous screen
            },
          )),
      body: Column(
        children: [
          imageAndTitle(size),
          heightSpace,
          heightSpace,
          playPauseButton(),
          heightSpace,
          timeText(),
          slider(),
          heightSpace,
          descriptionText(),
          heightSpace,
          heightSpace,
        ],
      ),
    );
  }

  Widget descriptionText() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
        child: MyText(
          color: black,
          text: sectionDetailModel?.result?.description ?? "",
          fontsizeNormal: 15,
          fontsizeWeb: 17,
          maxline: 1,
          multilanguage: false,
          overflow: TextOverflow.ellipsis,
          fontweight: FontWeight.w600,
          textalign: TextAlign.start,
          fontstyle: FontStyle.normal,
        ));
  }

  slider() {
    return Slider(
      activeColor: primaryColor,
      inactiveColor: const Color(0xffC4C4C4),
      thumbColor: primaryColor,
      min: 0,
      max: duration.inSeconds.toDouble(),
      value: position.inSeconds.toDouble(),
      onChanged: (value) async {
        final position = Duration(seconds: value.toInt());
        await audioPlayer.seek(position);
        await audioPlayer.resume();
      },
    );
  }

  timeText() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatTime(position),
          ),
          Text(
            formatTime(duration - position),
          )
        ],
      ),
    );
  }

  playPauseButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () async {
            if (isPlaying) {
              await audioPlayer.pause();
            } else {
              await audioPlayer.resume();
            }
          },
          child: Icon(
            isPlaying ? Icons.pause_circle : Icons.play_circle,
            color: primaryColor,
            size: 50,
          ),
        ),
        widthSpace,
      ],
    );
  }

  buttonWidget(Size size, String text, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: size.height * 0.07,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: black.withOpacity(0.2),
                blurRadius: 24,
                offset: const Offset(12, 12),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }

  shareBottomSheet(BuildContext context, Size size) {
    return showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(fixPadding * 2),
          decoration: const BoxDecoration(
            color: accentColor,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Audio Book",
              ),
              heightSpace,
              heightSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  socialOptions(context, size,
                      "assets/storyDetail/facebook image1.png", "Facebook"),
                  socialOptions(context, size,
                      "assets/storyDetail/whatsapp image1.png", "WhatsApp"),
                  socialOptions(context, size,
                      "assets/storyDetail/instagram image1.png", "Instagram"),
                ],
              )
            ],
          ),
        );
      },
    );
  }

  socialOptions(BuildContext context, Size size, String image, String name) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Column(
        children: [
          Image.asset(
            image,
            height: size.height * 0.045,
            width: size.height * 0.045,
            fit: BoxFit.cover,
          ),
          height5Space,
          Text(
            name,
          )
        ],
      ),
    );
  }

  detailBox() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: fixPadding / 2),
        padding: const EdgeInsets.symmetric(
            horizontal: fixPadding * 2.5, vertical: fixPadding),
        decoration: BoxDecoration(
          color: accentColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              blurRadius: 5,
              color: black.withOpacity(0.25),
            )
          ],
        ),
      ),
    );
  }

  imageAndTitle(Size size) {
    return Column(children: [
      Container(
          height: size.height * 0.3,
          width: double.maxFinite,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(sectionDetailModel?.result?.thumbnail ?? ""),
              fit: BoxFit.cover,
            ),
          )),
      heightSpace,
      heightSpace,
      MyText(
          color: black,
          text: sectionDetailModel?.result?.name ?? "",
          fontsizeNormal: 15,
          fontsizeWeb: 17,
          maxline: 1,
          multilanguage: false,
          overflow: TextOverflow.ellipsis,
          fontweight: FontWeight.w600,
          textalign: TextAlign.start,
          fontstyle: FontStyle.normal)
    ]);
  }

  divider() {
    return Container(
      height: 22,
      width: 1,
      color: const Color(0xFFD4D4D4),
      margin: const EdgeInsets.symmetric(
        horizontal: fixPadding,
      ),
    );
  }

  detailWidget(IconData icon, String title, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Icon(
              icon,
              color: primaryColor,
              size: 14,
            ),
            width5Space,
            Text(
              title,
            )
          ],
        ),
      ),
    );
  }

  Future<void> getSectionDetails(
      typeId, videoType, videoId, upcomingType) async {
    debugPrint("getSectionDetails typeId :========> $typeId");
    debugPrint("getSectionDetails videoType :=====> $videoType");
    debugPrint("getSectionDetails videoId :=======> $videoId");
    debugPrint("getSectionDetails upcomingType :==> $upcomingType");
    ApiService()
        .sectionDetails(typeId, videoType, videoId, upcomingType)
        .then((value) => {
              setState(() {
                sectionDetailModel = value;
                setAudio();
              })
            });
  }
}

const double fixPadding = 10.0;

const SizedBox widthSpace = SizedBox(width: fixPadding);

const SizedBox heightSpace = SizedBox(height: fixPadding);

const SizedBox width5Space = SizedBox(width: 5.0);

const SizedBox height5Space = SizedBox(height: 5.0);

class Bhajan {
  final String url;
  final String title;
  final String description;
  final String thumbnail;
  final int id;
  final int typeId;
  final int upcomingType;
  final int videoType;

  Bhajan(
      {required this.url,
      required this.title,
      required this.description,
      required this.thumbnail,
      required this.id,
      required this.typeId,
      required this.upcomingType,
      required this.videoType});
}
