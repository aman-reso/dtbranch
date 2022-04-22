import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevideo/bottom/detailsscreen.dart';
import 'package:primevideo/bottom/video_screen.dart';
import 'package:primevideo/component/divider.dart';
import 'package:primevideo/component/moreitems.dart';
import 'package:primevideo/component/movies.dart';
import 'package:primevideo/component/news.dart';
import 'package:primevideo/component/smalltext.dart';
import 'package:primevideo/utils/colors.dart';

class EpisodeScreens extends StatefulWidget {
  const EpisodeScreens({Key? key}) : super(key: key);

  @override
  State<EpisodeScreens> createState() => _EpisodeScreensState();
}

class _EpisodeScreensState extends State<EpisodeScreens> {
  bool show = false;
  // ignore: prefer_typing_uninitialized_variables
  var controller;
  bool showmore = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: 0, viewportFraction: 0.5);
  }

  double height = 120;
  double width = 80;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: appBgColor,
        body: SafeArea(
          child: Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      banner(context),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, top: 15),
                        child: Text(
                          "KGF : Chapter - 1",
                          style: TextStyle(
                              color: textColor,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, top: 05),
                        child: Text(
                          "prime",
                          style: TextStyle(
                              color: bluetext,
                              fontSize: 17,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15, top: 3),
                        child: Text(
                          "included with Prime",
                          style: TextStyle(
                            color: textColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      movieplayer(context),
                      const SizedBox(
                        height: 15,
                      ),
                      icons(context),
                      description(),
                      details(),
                      const SizedBox(
                        height: 15,
                      ),
                      tabbarbuild(context),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 1.5,
                        child: TabBarView(
                          children: [rretaltedtab(), detailstab()],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              showmore
                  ? Positioned(
                      bottom: 0,
                      child: showmoredetails(context),
                    )
                  : const SizedBox(),
              show
                  ? Positioned(
                      bottom: 0,
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.33,
                          color: const Color(0xff262e39),
                          child: languagesTab()),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }

  Container showmoredetails(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.28,
      color: textBlue,
      child: Column(
        children: [
          const SizedBox(
            height: 17,
          ),
          MoreItems(Icons.celebration_outlined, "Watch Party"),
          MoreItems(Icons.share_outlined, "Share"),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 5),
            child: Row(
              children: const [
                Icon(
                  Icons.play_arrow_rounded,
                  color: greyColor,
                  size: 40,
                ),
                SizedBox(
                  width: 15,
                ),
                Text(
                  "Trailer",
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Padding details() {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SmallText("IMDb 8.6"),
          const SizedBox(
            height: 03,
          ),
          Row(
            children: [
              SmallText("2021"),
              const SizedBox(
                width: 10,
              ),
              SmallText("175 min"),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 50,
                height: 17,
                decoration: BoxDecoration(
                    color: transParentColor,
                    border: Border.all(
                      color: blueGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(03)),
                child: Center(
                    child: Text(
                  "U/A 13+",
                  style: TextStyle(color: blueGrey500, fontSize: 10),
                )),
              ),
              const SizedBox(
                width: 10,
              ),
              Container(
                width: 50,
                height: 17,
                decoration: BoxDecoration(
                    color: transParentColor,
                    border: Border.all(
                      color: blueGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(03)),
                child: Center(
                    child: Text(
                  "4K UHD",
                  style: TextStyle(color: blueGrey500, fontSize: 10),
                )),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                Icons.message_outlined,
                size: 18,
                color: blueGrey500,
              )
            ],
          ),
          const SizedBox(
            height: 03,
          ),
          Row(
            children: [
              SmallText("Languages:"),
              const SizedBox(
                width: 05,
              ),
              SmallText("Audio (1)"),
              const SizedBox(
                width: 05,
              ),
              SmallText("Subtitles (1)"),
              show
                  ? InkWell(
                      onTap: () {
                        setState(() {
                          show = false;
                        });
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_up_outlined,
                        color: greyColor,
                      ),
                    )
                  : InkWell(
                      onTap: () {
                        setState(() {
                          show = true;
                        });
                      },
                      child: const Icon(
                        Icons.keyboard_arrow_down_outlined,
                        color: greyColor,
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }

  Padding description() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Text(
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummmy tex ever since.",
        style: TextStyle(color: textColor),
      ),
    );
  }

  Row icons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        iconUI(Icons.rotate_left_outlined, "Start over", () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const VideoScreen()));
        }),
        iconUI(Icons.save_alt, "Download", () {}),
        iconUI(Icons.add, "Watchlist", () {}),
        iconUI(Icons.more_vert_sharp, "More", () {
          if (showmore == true) {
            setState(() {
              showmore = false;
            });
          } else {
            setState(() {
              showmore = true;
            });
          }
        })
      ],
    );
  }

  Padding movieplayer(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.95,
        height: MediaQuery.of(context).size.height * 0.07,
        decoration: BoxDecoration(
            color: lightBlue800, borderRadius: BorderRadius.circular(07)),
        child: Column(
          children: [
            Row(
              children: [
                const SizedBox(width: 5),
                const Icon(
                  Icons.play_arrow_rounded,
                  color: textColor,
                  size: 45,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      "Continue watching",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 03,
                    ),
                    Text("169 min left",
                        style: TextStyle(color: textColor, fontSize: 11))
                  ],
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 05, right: 05),
              child: LinearProgressIndicator(
                value: 0.5,
                backgroundColor: lightBlue200,
                valueColor: const AlwaysStoppedAnimation<Color>(textColor),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container banner(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.3,
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/kgf.jpg'), fit: BoxFit.fill)),
    );
  }

  SizedBox tabbarbuild(BuildContext context) {
    return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.07,
        child: const TabBar(
          tabs: [
            Tab(
              child: Text(
                "Episodes",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
            Tab(
              child: Text(
                "More details",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
            ),
          ],
          indicatorColor: textColor,
          indicatorWeight: 2,
        ));
  }

  iconUI(icon, text, VoidCallback ontap) {
    return Column(
      children: [
        InkWell(
          onTap: ontap,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
                color: transParentColor,
                border: Border.all(color: greyColor),
                borderRadius: BorderRadius.circular(55)),
            child: Icon(
              icon,
              color: greyColor,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          text,
          style: const TextStyle(color: textColor, fontSize: 11),
        )
      ],
    );
  }

  rretaltedtab() {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.4,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            itemCount: 4,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 003),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.09,
                  color: blueGrey900,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: MediaQuery.of(context).size.height * 0.09,
                        child: Row(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.05,
                            ),
                            Icon(
                              Icons.play_circle_outline_outlined,
                              color: textColor,
                              size: 40,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Episode 1",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w800),
                                ),
                                SmallText("Love-Square")
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.25,
                        height: MediaQuery.of(context).size.height * 0.09,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.get_app_outlined,
                              color: greyColor,
                            ),
                            InkWell(
                              onTap: () {
                                if (showmore == false) {
                                  setState(() {
                                    showmore = true;
                                  });
                                } else {
                                  setState(() {
                                    showmore = false;
                                  });
                                }
                              },
                              child: Icon(
                                Icons.more_vert_outlined,
                                color: greyColor,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        News("Customers also watched"),
        MoviesNews(controller, 'assets/images/money_heist.jpg'),
        News("Cast & Crew"),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: Row(
            children: [
              SmallText("Details from"),
              const SizedBox(width: 10),
              Container(
                width: 40,
                height: 17,
                decoration: BoxDecoration(
                    color: transParentColor,
                    border: Border.all(
                      color: blueGreyColor,
                    ),
                    borderRadius: BorderRadius.circular(03)),
                child: Center(
                    child: Text(
                  "IMDb",
                  style: TextStyle(color: blueGrey500, fontSize: 10),
                )),
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.46,
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: GridView.builder(
              itemCount: 5,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                  childAspectRatio: (width / height)),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const DetailsScreen()));
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.22,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/kgf.jpg'),
                                fit: BoxFit.fill)),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.03,
                        child: const Center(
                          child: Text(
                            "Allu Arjun",
                            style: TextStyle(color: textColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 05),
            child: DividerUI()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.3,
                    height: MediaQuery.of(context).size.height * 0.22,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/kgf.jpg'),
                            fit: BoxFit.fill)),
                  ),
                  Positioned(
                    bottom: 10,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      height: MediaQuery.of(context).size.height * 0.03,
                      child: const Center(
                        child: Text(
                          "Allu Arjun",
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.53,
                height: MediaQuery.of(context).size.height * 0.22,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Directors",
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Lorem lpsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500. Lorem Ipsum has been the industry standard dummy text ever since the 1500. Lorem Ipsum has been the industry standard dummy text ever since the 1500.",
                      maxLines: 7,
                      style: TextStyle(color: blueGrey500, fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  detailstab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          genretext(),
          const SizedBox(height: 05),
          tabRow(),
          dividerbuild(),
          genretext(),
          const SizedBox(height: 05),
          tabRow(),
          dividerbuild(),
          genretext(),
          const SizedBox(height: 05),
          tabRow(),
          dividerbuild(),
          genretext(),
          const SizedBox(height: 05),
          tabRow(),
          dividerbuild(),
          genretext(),
          const SizedBox(height: 05),
          tabRow(),
          dividerbuild(),
          genretext(),
          const SizedBox(height: 05),
          tabRow(),
          dividerbuild(),
          genretext(),
          const SizedBox(height: 05),
          tabRow(),
          dividerbuild(),
          genretext(),
          const SizedBox(height: 05),
          tabRow(),
          dividerbuild(),
          genretext(),
          const SizedBox(height: 05),
          tabRow(),
          dividerbuild(),
          genretext(),
          const SizedBox(height: 05),
          tabRow(),
          dividerbuild(),
          const SizedBox(
            height: 40,
          ),
          const Text(
            "Customer reviews",
            style: TextStyle(
                color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "We don't have any customer reviews.",
            style: TextStyle(color: textColor),
          ),
          const SizedBox(
            height: 30,
          ),
          const Text(
            "Did you know?",
            style: TextStyle(
                color: textColor, fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          const Text(
            "Lorem Ipsum is simply dummy text of the printing and typesettings industry. Lorem Ipsum has been the industry standard dummy text ever since the 1500s. Lorem Ipsum has been the industry standard dummy text ever since the 1500s. Lorem Ipsum has been the industry standard dummy text ever since the 1500s.",
            style: TextStyle(color: textColor),
          ),
        ],
      ),
    );
  }

  Padding dividerbuild() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: DividerUI(),
    );
  }

  Text genretext() {
    return const Text("Genres",
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold));
  }

  tabRow() {
    return Row(
      children: [
        SmallText("Action,"),
        const SizedBox(
          width: 05,
        ),
        SmallText("Drama,"),
        const SizedBox(
          width: 05,
        ),
        SmallText("Comedy")
      ],
    );
  }

  languagesTab() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 08, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            lanText("Available languages", textColor),
            lanSubtext("Language can be changed while the video is playing.",
                blueGreyColor),
            lanText("Audio", textColor),
            lanSubtext("हिन्दी (original)", blueGreyColor),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 05),
              child: DividerUI(),
            ),
            lanText("Subtitles", textColor),
            lanSubtext("English", blueGreyColor)
          ],
        ));
  }

  lanText(text, color) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10),
      child: Text(
        text,
        style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: 17, color: color),
      ),
    );
  }

  lanSubtext(text, color) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, top: 10),
      child: Text(
        text,
        style: TextStyle(color: color),
      ),
    );
  }
}
