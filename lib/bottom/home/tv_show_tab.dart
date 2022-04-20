import 'package:flutter/cupertino.dart';
import 'package:primevideo/component/genres.dart';
import 'package:primevideo/component/movies.dart';
import 'package:primevideo/component/news.dart';
import 'package:primevideo/component/newspagview.dart';
import 'package:primevideo/component/newstext.dart';

List<String> images = [
  'assets/images/action_jection.jpg',
  'assets/images/money_heist.jpg',
  'assets/images/kgf.jpg',
];

class TVShow extends StatefulWidget {
  const TVShow({Key? key}) : super(key: key);

  @override
  State<TVShow> createState() => _TVShowState();
}

class _TVShowState extends State<TVShow> {
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
          NewsSlider(images),
          NewsText("Top-rated TV shows on IMDb", () {}),
          MoviesNews(controller, 'assets/images/serial.jpg'),
          NewsText("Original special movies", () {}),
          MoviesNews(controller, 'assets/images/money_heist.jpg'),
          News("TV shows we think you'll like"),
          MoviesNews(controller, 'assets/images/serial.jpg'),
          NewsText("Action and adventure TV", () {}),
          MoviesNews(controller, 'assets/images/serial.jpg'),
          News("TV genres"),
          GenresNews(
              controller, 'assets/images/serial.jpg', "Action and adventure"),
          News("Live TV/channels"),
          MoviesNews(controller, 'assets/images/serial.jpg'),
          NewsText("Recently added TV shows", () {}),
          MoviesNews(controller, 'assets/images/serial.jpg'),
        ],
      ),
    );
  }
}
