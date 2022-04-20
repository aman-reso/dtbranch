import 'package:flutter/material.dart';
import 'package:primevideo/bottom/articlescreen.dart';

// ignore: must_be_immutable
class MoviesNews extends StatefulWidget {
  PageController controller;
  String img;
  MoviesNews(this.controller, this.img, {Key? key}) : super(key: key);

  @override
  State<MoviesNews> createState() => _MoviesNewsState();
}

class _MoviesNewsState extends State<MoviesNews> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.15,
        child: PageView.builder(
          controller: widget.controller,
          padEnds: false,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                right: 8,
              ),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ArticleScreen()));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(05),
                      image: DecorationImage(
                          image: AssetImage(widget.img), fit: BoxFit.fill)),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
