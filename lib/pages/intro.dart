import 'package:dtlive/pages/bottombar.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/mytext.dart';
import 'package:dtlive/widget/mysvg.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Intro extends StatefulWidget {
  const Intro({Key? key}) : super(key: key);

  @override
  State<Intro> createState() => IntroState();
}

class IntroState extends State<Intro> {
  PageController pageController = PageController();

  List<String> introimgList = [
    "ic_vacter2.svg",
    "ic_vacter1.svg",
  ];

  List<String> introMainText = [
    "Watch movies, Tv shows, etc.",
    "Download and watch free videos!!!",
  ];

  List<String> introChildText = [
    "Lörem ipsum skynka klimatmat befagt. Hemiskade uviliga hubot atar. Monor miteheten. Agödat sasamma bepp. Fapp tösade intralogi. Vesm ilåbel milingar det mörka nätet. .",
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,",
  ];

  int position = 0;

  Future chack() async {
    SharedPreferences homeprefs = await SharedPreferences.getInstance();
    homeprefs.setBool('seen', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [inroGradiantOne, inroGradiantTwo])),
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PageView.builder(
                itemCount: introimgList.length,
                controller: pageController,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 300,
                        height: 270,
                        child: MySvg(
                          imagePath: introimgList[index],
                          width: 250,
                          height: 250,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        alignment: Alignment.center,
                        child: MyText(
                            color: white,
                            text: introMainText[position],
                            fontsize: 16,
                            fontwaight: FontWeight.w500,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 15),
                        child: MyText(
                            color: inrochildText,
                            text: introChildText[position],
                            fontsize: 14,
                            fontwaight: FontWeight.w400,
                            maxline: 4,
                            overflow: TextOverflow.ellipsis,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal),
                      ),
                    ],
                  );
                },
                onPageChanged: (index) {
                  setState(() {
                    position = index;
                  });
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Align(
                alignment: Alignment.topLeft,
                child: MySvg(
                    width: 150, height: 150, imagePath: "ic_introcorner.svg"),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: SmoothPageIndicator(
                    controller: pageController,
                    count: introimgList.length,
                    effect: const WormEffect(
                      dotWidth: 20,
                      dotColor: inroGradiantTwo,
                      dotHeight: 7,
                      activeDotColor: white,
                      radius: 100,
                      strokeWidth: 1,
                      spacing: 10,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  margin: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const Bottombar();
                              },
                            ),
                          );
                        },
                        child: Container(
                          width: 100,
                          height: 50,
                          alignment: Alignment.center,
                          child: MyText(
                              color: white,
                              text: "Skip",
                              textalign: TextAlign.center,
                              fontsize: 16,
                              fontwaight: FontWeight.w600,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (position == introimgList.length - 1) {
                            chack();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Bottombar(),
                              ),
                            );
                          }
                          pageController.nextPage(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5),
                          child: MySvg(
                              width: 45,
                              height: 45,
                              imagePath: "ic_introNext.svg"),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
