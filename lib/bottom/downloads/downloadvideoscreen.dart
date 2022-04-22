import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevideo/bottom/episodearticle.dart';
import 'package:primevideo/component/smalltext.dart';
import 'package:primevideo/utils/colors.dart';

class DownloadVideosList extends StatefulWidget {
  const DownloadVideosList({Key? key}) : super(key: key);

  @override
  State<DownloadVideosList> createState() => _DownloadVideosListState();
}

class _DownloadVideosListState extends State<DownloadVideosList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              const Text("The Family Man",
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SmallText("5 videos"),
                        const SizedBox(width: 10),
                        SmallText("150 min"),
                        const SizedBox(width: 10),
                        SmallText("150 MB")
                      ],
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.15,
                      height: MediaQuery.of(context).size.height * 0.05,
                      decoration: BoxDecoration(
                          color: blueGrey500,
                          borderRadius: BorderRadius.circular(03)),
                      child: const Center(
                        child: Text(
                          "Edit",
                          style: TextStyle(color: textColor),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 05),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => EpisodeScreens()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.14,
                          color: blueGrey900,
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    height: MediaQuery.of(context).size.height *
                                        0.14,
                                    decoration: const BoxDecoration(
                                        image: DecorationImage(
                                            image: AssetImage(
                                                'assets/images/kgf.jpg'),
                                            fit: BoxFit.fill)),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Spacer(),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.play_circle_outlined,
                                              color: textColor,
                                              size: 35,
                                            )),
                                        Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.007,
                                            decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(05),
                                                    bottomRight:
                                                        Radius.circular(05))),
                                            child:
                                                const LinearProgressIndicator(
                                              value: 0.5,
                                              backgroundColor: blackColor,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                      lightBlue),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "1. Exile",
                                      style: TextStyle(
                                          color: textColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 05,
                                    ),
                                    Row(
                                      children: [
                                        text("2021"),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        text("50  mmmin")
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 05,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                "prime",
                                                style: TextStyle(
                                                    color: bluetext,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        listIcon(Icons.more_vert_rounded, () {})
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  text(text) {
    return Text(
      text,
      style: TextStyle(
        color: blueGrey500,
      ),
    );
  }

  listIcon(icon, VoidCallback ontap) {
    return InkWell(
      onTap: ontap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.1,
        height: MediaQuery.of(context).size.height * 0.05,
        child: Icon(
          icon,
          color: greyColor,
          size: 30,
        ),
      ),
    );
  }
}
