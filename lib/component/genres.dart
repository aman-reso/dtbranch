import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevideo/utils/colors.dart';

// ignore: must_be_immutable
class GenresNews extends StatefulWidget {
  PageController controller;
  String image;
  String text;
  GenresNews(this.controller, this.image, this.text, {Key? key})
      : super(key: key);

  @override
  State<GenresNews> createState() => _GenresNewsState();
}

class _GenresNewsState extends State<GenresNews> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.22,
        child: PageView.builder(
          controller: widget.controller,
          padEnds: false,
          itemCount: 4,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                right: 8,
              ),
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height * 0.22,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(03),
                        color: blackColor,
                        image: DecorationImage(
                            image: AssetImage(widget.image), fit: BoxFit.fill)),
                  ),
                  Positioned(
                      bottom: 03,
                      child: Text(
                        widget.text,
                        style: const TextStyle(color: textColor),
                      ))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
