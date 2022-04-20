import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  String text = "more";
  bool isReadMore = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.2;

    return Scaffold(
      backgroundColor: const Color(0xff0e171e),
      body: Stack(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          Positioned(
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/kgf.jpg'),
                      fit: BoxFit.fill)),
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Padding(
                padding: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Allu Arjun",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontWeight: FontWeight.bold),
                      ),
                      buildText(),
                      InkWell(
                          onTap: () {
                            setState(() => isReadMore = !isReadMore);
                          },
                          child: Text(
                            isReadMore ? 'Less-' : 'More+',
                            style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          )),
                      const SizedBox(height: 30),
                      const Text(
                        "Trivia",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.9,
                        height: MediaQuery.of(context).size.height * 0.17,
                        //color: Color(0xff0e1c29),
                        color: Colors.blueGrey[900],
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard text.",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.13,
                        height: MediaQuery.of(context).size.height * 0.035,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(03),
                            border: Border.all(
                              color: Colors.blueGrey,
                            )),
                        child: Center(
                          child: Text(
                            "IMDb",
                            style: TextStyle(
                                color: Colors.blueGrey,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Text buildText() {
    final maxLine = isReadMore ? null : 4;
    return Text(
      "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummmy text ever since.Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry standard dummmy tex ever since.",
      style: TextStyle(color: Colors.white),
      maxLines: maxLine,
    );
  }
} // ReadMoreText(
                    //   'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
                    //   trimLines: 2,
                    //   colorClickableText: Colors.blue,
                    //   trimMode: TrimMode.Line,
                    //   trimCollapsedText: 'more',
                    //   trimExpandedText: 'less',
                    //   style: TextStyle(color: Colors.white),
                    // ),