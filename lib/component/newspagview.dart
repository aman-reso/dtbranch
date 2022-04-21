import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:primevideo/bottom/articlescreen.dart';
import 'package:primevideo/utils/colors.dart';

// ignore: must_be_immutable
class NewsSlider extends StatefulWidget {
  List<String> images;
  NewsSlider(this.images, {Key? key}) : super(key: key);

  @override
  State<NewsSlider> createState() => _NewsSliderState();
}

class _NewsSliderState extends State<NewsSlider> {
  int currentIndex = 0;
  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.25,
      child: Stack(
        children: [
          CarouselSlider(
              items: widget.images
                  .map((image) => Builder(builder: (BuildContext context) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ArticleScreen()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(image),
                                    fit: BoxFit.fill)),
                          ),
                        );
                      }))
                  .toList(),
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.25,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      currentIndex = index;
                    });
                  })),
          Positioned(
            bottom: 05,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.03,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: widget.images.map((url) {
                    int index = widget.images.indexOf(url);
                    print(widget.images.indexOf(url));
                    return Container(
                        width: 8,
                        height: 8,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color:
                                currentIndex == index ? greyColor : greyShade));
                  }).toList()),
            ),
          )
        ],
      ),
    );
  }
}
