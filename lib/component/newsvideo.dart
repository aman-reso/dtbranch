import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevideo/bottom/articlescreen.dart';

// ignore: must_be_immutable
class NewsVideos extends StatefulWidget {
  PageController controller;
  NewsVideos(this.controller, {Key? key}) : super(key: key);

  @override
  State<NewsVideos> createState() => _NewsVideosState();
}

class _NewsVideosState extends State<NewsVideos> {
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
                      image: const DecorationImage(
                          image: AssetImage('assets/images/action_jection.jpg'),
                          fit: BoxFit.fill)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.play_circle_outline_sharp,
                            color: Colors.white,
                            size: 30,
                          )),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: MediaQuery.of(context).size.height * 0.007,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(05),
                                  bottomRight: Radius.circular(05))),
                          child: LinearProgressIndicator(
                            value: 0.5,
                            backgroundColor: Colors.black,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.lightBlue),
                          )),
                    ],
                  ),
                ),
              ),

              // child: Stack(
              //   children: [
              //     Container(
              //       width: MediaQuery.of(context).size.width * 0.5,
              //       height: MediaQuery.of(context).size.height * 0.15,
              //       decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(03),
              //           image: const DecorationImage(
              //               image:
              //                   AssetImage('assets/images/action_jection.jpg'),
              //               fit: BoxFit.fill)),
              //     ),
              //     Positioned(
              //       bottom: 10,
              //       child: IconButton(
              //           onPressed: () {},
              //           icon: const Icon(
              //             Icons.play_circle_outline_sharp,
              //             color: Colors.white,
              //             size: 30,
              //           )),
              //     ),
              //     Positioned(
              //       bottom: 0,
              //       child: Container(
              //         width: MediaQuery.of(context).size.width * 0.5,
              //         height: MediaQuery.of(context).size.height * 0.02,
              //         color: Colors.white,
              //       ),
              //     )
              //   ],
              // ),
            );
          },
        ),
      ),
    );
  }
}
