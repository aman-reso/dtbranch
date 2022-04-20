import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevideo/component/genres.dart';
import 'package:primevideo/component/movies.dart';
import 'package:primevideo/component/news.dart';
import 'package:primevideo/component/newspagview.dart';
import 'package:primevideo/component/newstext.dart';

List<String> images = [
  'assets/images/magic.jpg',
  'assets/images/tom_jerry.jpg',
  'assets/images/balganesh.jpg',
];

class Kids extends StatefulWidget {
  const Kids({Key? key}) : super(key: key);

  @override
  State<Kids> createState() => _KidsState();
}

class _KidsState extends State<Kids> {
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
          News("Pick your pals"),
          GenresNews(controller, 'assets/images/motu_patlu.jpg', "Motu Patlu"),
          NewsText("Kids and family movies", () {}),
          MoviesNews(controller, 'assets/images/balganesh.jpg'),
          NewsText("Kids and family TV", () {}),
          MoviesNews(controller, 'assets/images/magic.jpg'),
          News("Indian Toons"),
          MoviesNews(controller, 'assets/images/bheem.jpg'),
          NewsText("Original special kids series", () {}),
          MoviesNews(controller, 'assets/images/harry_potter.jpg'),
          NewsText("Preschool kids videos", () {}),
          MoviesNews(controller, 'assets/images/balganesh.jpg'),
        ],
      ),
    );
  }
}
