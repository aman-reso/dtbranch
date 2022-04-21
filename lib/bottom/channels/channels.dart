import 'package:flutter/material.dart';
import 'package:primevideo/component/channel_news_text.dart';
import 'package:primevideo/component/channel_text.dart';
import 'package:primevideo/component/movies.dart';
import 'package:primevideo/component/news.dart';
import 'package:primevideo/component/newspagview.dart';
import 'package:primevideo/utils/colors.dart';

class ChannelsPage extends StatefulWidget {
  const ChannelsPage({Key? key}) : super(key: key);

  @override
  State<ChannelsPage> createState() => _ChannelsPageState();
}

class _ChannelsPageState extends State<ChannelsPage> {
  // ignore: prefer_typing_uninitialized_variables
  var controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: 0, viewportFraction: 0.5);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            NewsSlider(images),
            ChannelText(),
            ChannelNewsText("Most popular", () {}),
            MoviesNews(controller, 'assets/images/motu_patlu.jpg'),
            ChannelText(),
            ChannelNewsText("Most popular", () {}),
            MoviesNews(controller, 'assets/images/harry_potter.jpg'),
            ChannelText(),
            ChannelNewsText("Most popular", () {}),
            MoviesNews(controller, 'assets/images/motu_patlu.jpg'),
            ChannelText(),
            ChannelNewsText("Most popular", () {}),
            MoviesNews(controller, 'assets/images/harry_potter.jpg'),
            ChannelText(),
            ChannelNewsText("Most popular", () {}),
            MoviesNews(controller, 'assets/images/motu_patlu.jpg'),
            News("Subscribe to Channels"),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.22,
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.22,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(07),
                            image: DecorationImage(
                                image: AssetImage(images[index]),
                                fit: BoxFit.fill)),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> images = [
    'assets/images/action_jection.jpg',
    'assets/images/money_heist.jpg',
    'assets/images/kgf.jpg',
    'assets/images/action_jection.jpg',
    'assets/images/money_heist.jpg',
    'assets/images/kgf.jpg',
    'assets/images/action_jection.jpg',
  ];
}
