import 'dart:developer';

import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:dtlive/webwidget/interactive_icon.dart';
import 'package:dtlive/webwidget/interactive_text.dart';
import 'package:js/js.dart';

@JS('launchUrl')
external String launchUrl(String url, String target);
_redirectToUrl(loadingUrl) async {
  log("loadingUrl ---------> $loadingUrl");
  /* 
      _blank => open new Tab
      _self => open in current Tab 
    */
  launchUrl(loadingUrl, '_blank');
}

class FooterWeb extends StatefulWidget {
  const FooterWeb({super.key});

  @override
  State<FooterWeb> createState() => _FooterWebState();
}

class _FooterWebState extends State<FooterWeb> {
  SharedPre sharedPref = SharedPre();
  String? aboutUsUrl, privacyUrl, termsConditionUrl, refundPolicyUrl;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    aboutUsUrl = await sharedPref.read("about-us") ?? "";
    privacyUrl = await sharedPref.read("privacy-policy") ?? "";
    termsConditionUrl = await sharedPref.read("terms-and-conditions") ?? "";
    refundPolicyUrl = await sharedPref.read("refund-policy") ?? "";
    log('aboutUsUrl ==> $aboutUsUrl');
    log('privacyUrl ==> $privacyUrl');
    log('termsConditionUrl ==> $termsConditionUrl');
    log('refundPolicyUrl ==> $refundPolicyUrl');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: (MediaQuery.of(context).size.width < 800)
          ? _buildColumnFooter()
          : _buildRowFooter(),
    );
  }

  Widget _buildRowFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /* Quick Links */
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.start,
                alignment: WrapAlignment.spaceEvenly,
                runAlignment: WrapAlignment.spaceEvenly,
                spacing: 5.0,
                runSpacing: 5.0,
                direction: Axis.horizontal,
                children: [
                  InkWell(
                    onTap: () {
                      _redirectToUrl(aboutUsUrl ?? "");
                    },
                    child: const InteractiveText(
                      text: "aboutus",
                      multilanguage: true,
                      maxline: 2,
                      textalign: TextAlign.justify,
                      fontstyle: FontStyle.normal,
                      fontsizeWeb: 13,
                      fontweight: FontWeight.w500,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _redirectToUrl(termsConditionUrl ?? "");
                    },
                    child: const InteractiveText(
                      text: "termcondition",
                      multilanguage: true,
                      maxline: 2,
                      textalign: TextAlign.justify,
                      fontstyle: FontStyle.normal,
                      fontsizeWeb: 13,
                      fontweight: FontWeight.w500,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _redirectToUrl(privacyUrl ?? "");
                    },
                    child: const InteractiveText(
                      text: "privacypolicy",
                      multilanguage: true,
                      maxline: 2,
                      textalign: TextAlign.justify,
                      fontstyle: FontStyle.normal,
                      fontsizeWeb: 13,
                      fontweight: FontWeight.w500,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _redirectToUrl(refundPolicyUrl ?? "");
                    },
                    child: const InteractiveText(
                      text: "refundpolicy",
                      multilanguage: true,
                      maxline: 2,
                      textalign: TextAlign.justify,
                      fontstyle: FontStyle.normal,
                      fontsizeWeb: 13,
                      fontweight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              MyText(
                color: lightGray,
                multilanguage: false,
                text:
                    "© 2023 STAR. All Rights Reserved. HBO, Home Box Office and all related channel and programming logos are service marks of, and all related programming visuals and elements are the property of, Home Box Office, Inc. All rights reserved.",
                fontweight: FontWeight.normal,
                fontsizeWeb: 12,
                textalign: TextAlign.start,
                fontstyle: FontStyle.normal,
                maxline: 50,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        /* Contact With us & Store Icons */
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    color: white,
                    multilanguage: false,
                    text: "Connect with us",
                    fontweight: FontWeight.w600,
                    fontsizeWeb: 14,
                    textalign: TextAlign.center,
                    fontstyle: FontStyle.normal,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  /* Social Icons */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {},
                        child: InteractiveIcon(
                          width: 18,
                          height: 18,
                          imagePath: "ic_facebook.png",
                          withBG: true,
                          iconColor: otherColor,
                          iconColorHover: black,
                          bgRadius: 3,
                          bgColor: lightBlack,
                          bgHoverColor: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 3),
                      InkWell(
                        onTap: () {},
                        borderRadius: BorderRadius.circular(30),
                        child: InteractiveIcon(
                          width: 18,
                          height: 18,
                          imagePath: "ic_insta.png",
                          withBG: true,
                          iconColor: otherColor,
                          iconColorHover: black,
                          bgRadius: 3,
                          bgColor: lightBlack,
                          bgHoverColor: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(width: 30),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                    color: white,
                    multilanguage: false,
                    text: "DTLive App",
                    fontweight: FontWeight.w600,
                    fontsizeWeb: 14,
                    textalign: TextAlign.center,
                    fontstyle: FontStyle.normal,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  /* Social Icons */
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {
                          _redirectToUrl(Constant.androidAppUrl);
                        },
                        borderRadius: BorderRadius.circular(3),
                        child: InteractiveIcon(
                          imagePath: "playstore.png",
                          height: 23,
                          width: 60,
                          withBG: true,
                          bgRadius: 3,
                          bgColor: lightBlack,
                          bgHoverColor: primaryColor,
                        ),
                      ),
                      const SizedBox(width: 3),
                      InkWell(
                        onTap: () {
                          _redirectToUrl(Constant.iosAppUrl);
                        },
                        borderRadius: BorderRadius.circular(3),
                        child: InteractiveIcon(
                          height: 23,
                          width: 60,
                          imagePath: "applestore.png",
                          withBG: true,
                          bgRadius: 3,
                          bgColor: lightBlack,
                          bgHoverColor: primaryColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildColumnFooter() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        /* Quick Links */
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.start,
          alignment: WrapAlignment.spaceEvenly,
          runAlignment: WrapAlignment.spaceEvenly,
          spacing: 5.0,
          runSpacing: 5.0,
          direction: Axis.horizontal,
          children: [
            InkWell(
              onTap: () {
                _redirectToUrl(aboutUsUrl ?? "");
              },
              child: const InteractiveText(
                text: "aboutus",
                multilanguage: true,
                maxline: 2,
                textalign: TextAlign.justify,
                fontstyle: FontStyle.normal,
                fontsizeWeb: 13,
                fontweight: FontWeight.w500,
              ),
            ),
            InkWell(
              onTap: () {
                _redirectToUrl(termsConditionUrl ?? "");
              },
              child: const InteractiveText(
                text: "termcondition",
                multilanguage: true,
                maxline: 2,
                textalign: TextAlign.justify,
                fontstyle: FontStyle.normal,
                fontsizeWeb: 13,
                fontweight: FontWeight.w500,
              ),
            ),
            InkWell(
              onTap: () {
                _redirectToUrl(privacyUrl ?? "");
              },
              child: const InteractiveText(
                text: "privacypolicy",
                multilanguage: true,
                maxline: 2,
                textalign: TextAlign.justify,
                fontstyle: FontStyle.normal,
                fontsizeWeb: 13,
                fontweight: FontWeight.w500,
              ),
            ),
            InkWell(
              onTap: () {
                _redirectToUrl(refundPolicyUrl ?? "");
              },
              child: const InteractiveText(
                text: "refundpolicy",
                multilanguage: true,
                maxline: 2,
                textalign: TextAlign.justify,
                fontstyle: FontStyle.normal,
                fontsizeWeb: 13,
                fontweight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        MyText(
          color: lightGray,
          multilanguage: false,
          text:
              "© 2023 STAR. All Rights Reserved. HBO, Home Box Office and all related channel and programming logos are service marks of, and all related programming visuals and elements are the property of, Home Box Office, Inc. All rights reserved.",
          fontweight: FontWeight.normal,
          fontsizeWeb: 12,
          textalign: TextAlign.start,
          fontstyle: FontStyle.normal,
          maxline: 50,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 20),

        /* Contact With us & Store Icons */
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  color: white,
                  multilanguage: false,
                  text: "Connect with us",
                  fontweight: FontWeight.w600,
                  fontsizeWeb: 14,
                  textalign: TextAlign.center,
                  fontstyle: FontStyle.normal,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                /* Social Icons */
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {},
                      child: InteractiveIcon(
                        width: 18,
                        height: 18,
                        imagePath: "ic_facebook.png",
                        withBG: true,
                        iconColor: otherColor,
                        iconColorHover: black,
                        bgRadius: 3,
                        bgColor: lightBlack,
                        bgHoverColor: primaryColor,
                      ),
                    ),
                    const SizedBox(width: 3),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(30),
                      child: InteractiveIcon(
                        width: 18,
                        height: 18,
                        imagePath: "ic_insta.png",
                        withBG: true,
                        iconColor: otherColor,
                        iconColorHover: black,
                        bgRadius: 3,
                        bgColor: lightBlack,
                        bgHoverColor: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(width: 30),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MyText(
                  color: white,
                  multilanguage: false,
                  text: "DTLive App",
                  fontweight: FontWeight.w600,
                  fontsizeWeb: 14,
                  textalign: TextAlign.center,
                  fontstyle: FontStyle.normal,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(
                  height: 5,
                ),
                /* Social Icons */
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        _redirectToUrl(Constant.androidAppUrl);
                      },
                      borderRadius: BorderRadius.circular(3),
                      child: InteractiveIcon(
                        imagePath: "playstore.png",
                        height: 23,
                        width: 60,
                        withBG: true,
                        bgRadius: 3,
                        bgColor: lightBlack,
                        bgHoverColor: primaryColor,
                      ),
                    ),
                    const SizedBox(width: 3),
                    InkWell(
                      onTap: () {
                        _redirectToUrl(Constant.iosAppUrl);
                      },
                      borderRadius: BorderRadius.circular(3),
                      child: InteractiveIcon(
                        height: 23,
                        width: 60,
                        imagePath: "applestore.png",
                        withBG: true,
                        bgRadius: 3,
                        bgColor: lightBlack,
                        bgHoverColor: primaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}