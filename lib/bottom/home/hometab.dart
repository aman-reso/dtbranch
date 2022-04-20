import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevideo/component/genres.dart';
import 'package:primevideo/component/movies.dart';
import 'package:primevideo/component/news.dart';
import 'package:primevideo/component/newspagview.dart';
import 'package:primevideo/component/newstext.dart';
import 'package:primevideo/component/newsvideo.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({Key? key}) : super(key: key);

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int currentIndex = 0;
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
    return SingleChildScrollView(
      child: Column(
        children: [
          NewsSlider(
            images,
          ),
          News("Continue watching"),
          NewsVideos(controller),
          NewsText("Top Movies", () {}),
          MoviesNews(controller, 'assets/images/money_heist.jpg'),
          News("TV shows we think you'll like"),
          MoviesNews(controller, 'assets/images/serial.jpg'),
          NewsText("Original special movies", () {}),
          MoviesNews(controller, 'assets/images/money_heist.jpg'),
          NewsText("Top-rated TV shows on IMDb", () {}),
          MoviesNews(controller, 'assets/images/serial.jpg'),
          NewsText("Recently added movies", () {}),
          MoviesNews(controller, 'assets/images/kgf.jpg'),
          News("Movie by language"),
          GenresNews(controller, 'assets/images/language.png', "Hindi"),
          News("TV genres"),
          GenresNews(
              controller, 'assets/images/serial.jpg', "Action and adventure"),
          News("Movie genres"),
          GenresNews(controller, 'assets/images/action_jection.jpg', "Dance"),
          NewsText("Dance movies", () {}),
          MoviesNews(controller, 'assets/images/money_heist.jpg'),
          NewsText("Top-rated movie on IMDb", () {}),
          MoviesNews(controller, 'assets/images/money_heist.jpg'),
          NewsText("Action and adventure TV", () {}),
          MoviesNews(controller, 'assets/images/serial.jpg'),
          NewsText("Original special series", () {}),
          MoviesNews(controller, 'assets/images/money_heist.jpg'),
          News("Live TV/channels"),
          MoviesNews(controller, 'assets/images/serial.jpg'),
          NewsText("English movies", () {}),
          MoviesNews(controller, 'assets/images/money_heist.jpg'),
          NewsText("Recently added TV shows", () {}),
          MoviesNews(controller, 'assets/images/serial.jpg'),
        ],
      ),
    );
  }

  List<String> images = [
    'assets/images/action_jection.jpg',
    'assets/images/money_heist.jpg',
    'assets/images/kgf.jpg',
  ];
}
