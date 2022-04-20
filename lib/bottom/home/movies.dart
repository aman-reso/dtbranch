import 'package:flutter/cupertino.dart';
import 'package:primevideo/component/genres.dart';
import 'package:primevideo/component/movies.dart';
import 'package:primevideo/component/news.dart';
import 'package:primevideo/component/newspagview.dart';
import 'package:primevideo/component/newstext.dart';
import 'package:primevideo/component/newsvideo.dart';

List<String> images = [
  'assets/images/action_jection.jpg',
  'assets/images/money_heist.jpg',
  'assets/images/kgf.jpg',
];

class Movies extends StatefulWidget {
  const Movies({Key? key}) : super(key: key);

  @override
  State<Movies> createState() => _MoviesState();
}

class _MoviesState extends State<Movies> {
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
          NewsText("Recently added movies", () {}),
          MoviesNews(controller, 'assets/images/kgf.jpg'),
          NewsText("Top Movies", () {}),
          MoviesNews(controller, 'assets/images/money_heist.jpg'),
          NewsText("Original special movies", () {}),
          MoviesNews(controller, 'assets/images/money_heist.jpg'),
          NewsText("Dance movies", () {}),
          MoviesNews(controller, 'assets/images/money_heist.jpg'),
          NewsText("Top-rated movie on IMDb", () {}),
          MoviesNews(controller, 'assets/images/money_heist.jpg'),
          News("Movie by language"),
          GenresNews(controller, 'assets/images/language.png', "Hindi"),
          News("Movie genres"),
          GenresNews(controller, 'assets/images/action_jection.jpg', "Dance"),
          NewsText("English movies", () {}),
          MoviesNews(controller, 'assets/images/money_heist.jpg'),
        ],
      ),
    );
  }
}
