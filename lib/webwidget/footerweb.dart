import 'package:dtlive/provider/generalprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/web_js/js_helper.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:dtlive/webwidget/interactive_icon.dart';
import 'package:dtlive/webwidget/interactive_text.dart';
import 'package:provider/provider.dart';

class FooterWeb extends StatefulWidget {
  const FooterWeb({super.key});

  @override
  State<FooterWeb> createState() => _FooterWebState();
}

class _FooterWebState extends State<FooterWeb> {
  final JSHelper _jsHelper = JSHelper();
  SharedPre sharedPref = SharedPre();
  String? appDescription,
      aboutUsUrl,
      privacyUrl,
      termsConditionUrl,
      refundPolicyUrl;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _redirectToUrl(loadingUrl) async {
    debugPrint("loadingUrl -----------> $loadingUrl");
    /*
      _blank => open new Tab
      _self => open in current Tab
    */
    String dataFromJS = await _jsHelper.callOpenTab(loadingUrl, '_blank');
    debugPrint("dataFromJS -----------> $dataFromJS");
  }

  _getData() async {
    final generalProvider =
        Provider.of<GeneralProvider>(context, listen: false);
    appDescription = await sharedPref.read("app_desripation") ?? "";

    await generalProvider.getPages();
    if (!generalProvider.loading) {
      if (generalProvider.pagesModel.status == 200) {
        if (generalProvider.pagesModel.result != null &&
            (generalProvider.pagesModel.result?.length ?? 0) > 0) {
          for (var i = 0;
              i < (generalProvider.pagesModel.result?.length ?? 0);
              i++) {
            if (generalProvider.pagesModel.result?[i].pageName == "about-us") {
              aboutUsUrl = generalProvider.pagesModel.result?[i].url ?? "";
            }
            if (generalProvider.pagesModel.result?[i].pageName ==
                "privacy-policy") {
              privacyUrl = generalProvider.pagesModel.result?[i].url ?? "";
            }
            if (generalProvider.pagesModel.result?[i].pageName ==
                "terms-and-conditions") {
              termsConditionUrl =
                  generalProvider.pagesModel.result?[i].url ?? "";
            }
            if (generalProvider.pagesModel.result?[i].pageName ==
                "refund-policy") {
              refundPolicyUrl = generalProvider.pagesModel.result?[i].url ?? "";
            }
          }
        }
      }
    }
    debugPrint('appDescription =====> $appDescription');
    debugPrint('aboutUsUrl =========> $aboutUsUrl');
    debugPrint('privacyUrl =========> $privacyUrl');
    debugPrint('termsConditionUrl ==> $termsConditionUrl');
    debugPrint('refundPolicyUrl ====> $refundPolicyUrl');

    Future.delayed(Duration.zero).then((value) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
      child: (MediaQuery.of(context).size.width < 800)
          ? _buildColumnFooter()
          : _buildRowFooter(),
    );
  }

  Widget _buildRowFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /* App Icon & Desc. */
        Expanded(
          flex: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 90,
                height: 35,
                alignment: Alignment.centerLeft,
                child: MyImage(
                  fit: BoxFit.fill,
                  imagePath: "appicon.png",
                ),
              ),
              const SizedBox(height: 8),
              MyText(
                color: lightGray,
                multilanguage: false,
                text: appDescription ?? "",
                fontweight: FontWeight.w500,
                fontsizeWeb: 12,
                fontsizeNormal: 12,
                textalign: TextAlign.start,
                fontstyle: FontStyle.normal,
                maxline: 50,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 30),

        /* Quick Links */
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildQuickLinkText(
                pageName: "aboutus",
                onClick: () {
                  _redirectToUrl(aboutUsUrl ?? "");
                },
              ),
              const SizedBox(height: 10),
              _buildQuickLinkText(
                pageName: "privacypolicy",
                onClick: () {
                  _redirectToUrl(privacyUrl ?? "");
                },
              ),
              const SizedBox(height: 10),
              _buildQuickLinkText(
                pageName: "termcondition",
                onClick: () {
                  _redirectToUrl(termsConditionUrl ?? "");
                },
              ),
              const SizedBox(height: 10),
              _buildQuickLinkText(
                pageName: "refundpolicy",
                onClick: () {
                  _redirectToUrl(refundPolicyUrl ?? "");
                },
              ),
            ],
          ),
        ),
        const SizedBox(width: 30),

        /* Contact With us & Available On */
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                color: white,
                multilanguage: true,
                text: "connect_with_us",
                fontweight: FontWeight.w600,
                fontsizeWeb: 13,
                fontsizeNormal: 13,
                textalign: TextAlign.start,
                fontstyle: FontStyle.normal,
                maxline: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 10),
              /* Social Icons */
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(3.0),
                    onTap: () {
                      _redirectToUrl(Constant.facebookUrl);
                    },
                    child: InteractiveIcon(
                      height: 20,
                      width: 20,
                      iconColor: white,
                      iconColorHover: black,
                      imagePath: "ic_facebook.png",
                      withBG: true,
                      bgRadius: 3.0,
                      bgColor: lightBlack,
                      bgHoverColor: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      _redirectToUrl(Constant.instagramUrl);
                    },
                    borderRadius: BorderRadius.circular(3.0),
                    child: InteractiveIcon(
                      height: 20,
                      width: 20,
                      iconColor: white,
                      iconColorHover: black,
                      imagePath: "ic_insta.png",
                      withBG: true,
                      bgRadius: 3.0,
                      bgColor: lightBlack,
                      bgHoverColor: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      _redirectToUrl(Constant.youtubeUrl);
                    },
                    borderRadius: BorderRadius.circular(3.0),
                    child: InteractiveIcon(
                      height: 20,
                      width: 20,
                      iconColor: white,
                      iconColorHover: black,
                      imagePath: "ic_youtube.png",
                      withBG: true,
                      bgRadius: 3.0,
                      bgColor: lightBlack,
                      bgHoverColor: primaryColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /* Available On */
              MyText(
                color: white,
                multilanguage: false,
                text: "${Constant.appName} Available On",
                fontweight: FontWeight.w600,
                fontsizeWeb: 13,
                fontsizeNormal: 13,
                textalign: TextAlign.start,
                fontstyle: FontStyle.normal,
                maxline: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),

              /* Store Icons */
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
                      height: 25,
                      width: 25,
                      withBG: true,
                      bgRadius: 3,
                      bgColor: transparentColor,
                      bgHoverColor: primaryColor,
                    ),
                  ),
                  const SizedBox(width: 5),
                  InkWell(
                    onTap: () {
                      _redirectToUrl(Constant.iosAppUrl);
                    },
                    borderRadius: BorderRadius.circular(3),
                    child: InteractiveIcon(
                      height: 25,
                      width: 25,
                      imagePath: "applestore.png",
                      iconColor: white,
                      withBG: true,
                      bgRadius: 3,
                      bgColor: transparentColor,
                      bgHoverColor: primaryColor,
                    ),
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
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /* App Icon & Desc. */
        Container(
          width: 90,
          height: 35,
          alignment: Alignment.centerLeft,
          child: MyImage(
            fit: BoxFit.fill,
            imagePath: "appicon.png",
          ),
        ),
        const SizedBox(height: 8),
        MyText(
          color: lightGray,
          multilanguage: false,
          text: appDescription ?? "",
          fontweight: FontWeight.w500,
          fontsizeWeb: 12,
          fontsizeNormal: 12,
          textalign: TextAlign.start,
          fontstyle: FontStyle.normal,
          maxline: 50,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 30),

        /* Quick Links */
        _buildQuickLinkText(
          pageName: "aboutus",
          onClick: () {
            _redirectToUrl(aboutUsUrl ?? "");
          },
        ),
        const SizedBox(height: 10),
        _buildQuickLinkText(
          pageName: "privacypolicy",
          onClick: () {
            _redirectToUrl(privacyUrl ?? "");
          },
        ),
        const SizedBox(height: 10),
        _buildQuickLinkText(
          pageName: "termcondition",
          onClick: () {
            _redirectToUrl(termsConditionUrl ?? "");
          },
        ),
        const SizedBox(height: 10),
        _buildQuickLinkText(
          pageName: "refundpolicy",
          onClick: () {
            _redirectToUrl(refundPolicyUrl ?? "");
          },
        ),
        const SizedBox(height: 30),

        /* Contact With us & Store Icons */
        MyText(
          color: white,
          multilanguage: true,
          text: "connect_with_us",
          fontweight: FontWeight.w600,
          fontsizeWeb: 13,
          fontsizeNormal: 13,
          textalign: TextAlign.start,
          fontstyle: FontStyle.normal,
          maxline: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 10),
        /* Social Icons */
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(3.0),
              onTap: () {
                _redirectToUrl(Constant.facebookUrl);
              },
              child: InteractiveIcon(
                height: 20,
                width: 20,
                iconColor: white,
                iconColorHover: black,
                imagePath: "ic_facebook.png",
                withBG: true,
                bgRadius: 3.0,
                bgColor: lightBlack,
                bgHoverColor: primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                _redirectToUrl(Constant.instagramUrl);
              },
              borderRadius: BorderRadius.circular(3.0),
              child: InteractiveIcon(
                height: 20,
                width: 20,
                iconColor: white,
                iconColorHover: black,
                imagePath: "ic_insta.png",
                withBG: true,
                bgRadius: 3.0,
                bgColor: lightBlack,
                bgHoverColor: primaryColor,
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              onTap: () {
                _redirectToUrl(Constant.youtubeUrl);
              },
              borderRadius: BorderRadius.circular(3.0),
              child: InteractiveIcon(
                height: 20,
                width: 20,
                iconColor: white,
                iconColorHover: black,
                imagePath: "ic_youtube.png",
                withBG: true,
                bgRadius: 3.0,
                bgColor: lightBlack,
                bgHoverColor: primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),

        /* Available On */
        MyText(
          color: white,
          multilanguage: false,
          text: "${Constant.appName} Available On",
          fontweight: FontWeight.w600,
          fontsizeWeb: 13,
          fontsizeNormal: 13,
          textalign: TextAlign.start,
          fontstyle: FontStyle.normal,
          maxline: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),

        /* Store Icons */
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
                height: 25,
                width: 25,
                withBG: true,
                bgRadius: 3,
                bgColor: transparentColor,
                bgHoverColor: primaryColor,
              ),
            ),
            const SizedBox(width: 5),
            InkWell(
              onTap: () {
                _redirectToUrl(Constant.iosAppUrl);
              },
              borderRadius: BorderRadius.circular(3),
              child: InteractiveIcon(
                height: 25,
                width: 25,
                imagePath: "applestore.png",
                iconColor: white,
                withBG: true,
                bgRadius: 3,
                bgColor: transparentColor,
                bgHoverColor: primaryColor,
              ),
            ),
          ],
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         MyText(
        //           color: white,
        //           multilanguage: true,
        //           text: "connect_with_us",
        //           fontweight: FontWeight.w600,
        //           fontsizeWeb: 14,
        //           fontsizeNormal: 14,
        //           textalign: TextAlign.center,
        //           fontstyle: FontStyle.normal,
        //           maxline: 1,
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //         const SizedBox(height: 5),
        //         /* Social Icons */
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             InkWell(
        //               borderRadius: BorderRadius.circular(30),
        //               onTap: () {
        //                 _redirectToUrl(Constant.facebookUrl);
        //               },
        //               child: InteractiveIcon(
        //                 width: 18,
        //                 height: 18,
        //                 imagePath: "ic_facebook.png",
        //                 withBG: true,
        //                 iconColor: otherColor,
        //                 iconColorHover: black,
        //                 bgRadius: 3,
        //                 bgColor: lightBlack,
        //                 bgHoverColor: primaryColor,
        //               ),
        //             ),
        //             const SizedBox(width: 3),
        //             InkWell(
        //               onTap: () {
        //                 _redirectToUrl(Constant.instagramUrl);
        //               },
        //               borderRadius: BorderRadius.circular(30),
        //               child: InteractiveIcon(
        //                 width: 18,
        //                 height: 18,
        //                 imagePath: "ic_insta.png",
        //                 withBG: true,
        //                 iconColor: otherColor,
        //                 iconColorHover: black,
        //                 bgRadius: 3,
        //                 bgColor: lightBlack,
        //                 bgHoverColor: primaryColor,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //     const SizedBox(width: 30),
        //     Column(
        //       mainAxisAlignment: MainAxisAlignment.start,
        //       crossAxisAlignment: CrossAxisAlignment.start,
        //       children: [
        //         MyText(
        //           color: white,
        //           multilanguage: false,
        //           text: Constant.appName ?? "",
        //           fontweight: FontWeight.w600,
        //           fontsizeWeb: 14,
        //           fontsizeNormal: 14,
        //           textalign: TextAlign.center,
        //           fontstyle: FontStyle.normal,
        //           maxline: 1,
        //           overflow: TextOverflow.ellipsis,
        //         ),
        //         const SizedBox(height: 5),
        //         /* Social Icons */
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //           children: [
        //             InkWell(
        //               onTap: () {
        //                 _redirectToUrl(Constant.androidAppUrl);
        //               },
        //               borderRadius: BorderRadius.circular(3),
        //               child: InteractiveIcon(
        //                 imagePath: "playstore.png",
        //                 height: 23,
        //                 width: 60,
        //                 withBG: true,
        //                 bgRadius: 3,
        //                 bgColor: lightBlack,
        //                 bgHoverColor: primaryColor,
        //               ),
        //             ),
        //             const SizedBox(width: 3),
        //             InkWell(
        //               onTap: () {
        //                 _redirectToUrl(Constant.iosAppUrl);
        //               },
        //               borderRadius: BorderRadius.circular(3),
        //               child: InteractiveIcon(
        //                 height: 23,
        //                 width: 60,
        //                 imagePath: "applestore.png",
        //                 withBG: true,
        //                 bgRadius: 3,
        //                 bgColor: lightBlack,
        //                 bgHoverColor: primaryColor,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
      ],
    );
  }

  Widget _buildQuickLinkText({
    required String pageName,
    required Function() onClick,
  }) {
    return InkWell(
      onTap: onClick,
      child: InteractiveText(
        text: pageName,
        multilanguage: true,
        maxline: 2,
        textalign: TextAlign.justify,
        fontstyle: FontStyle.normal,
        fontsizeWeb: 14,
        fontweight: FontWeight.w600,
      ),
    );
  }
}
