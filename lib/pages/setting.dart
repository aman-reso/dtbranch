import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/myimage.dart';
import 'package:dtlive/utils/mytext.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => SettingState();
}

class SettingState extends State<Setting> {
  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        Utils().showToast("Notification On");
      });
    } else {
      setState(() {
        isSwitched = false;
        Utils().showToast("Notification Off");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: primary,
        centerTitle: true,
        title: MyText(
            color: white,
            text: "Settings",
            fontsize: 16,
            maxline: 1,
            overflow: TextOverflow.ellipsis,
            fontwaight: FontWeight.w600,
            textalign: TextAlign.center,
            fontstyle: FontStyle.normal),
      ),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
          color: primary,
          child: Column(
            children: [
              accountDetail(),
              subscription(),
              changePasssword(),
              language(),
              notification(),
              clearCache(),
              clearVideo(),
              signin(),
              rateUs(),
              shareApp(),
              about(),
              privacyPolicy(),
              termsCondition(),
            ],
          ),
        ),
      ),
    );
  }

  Widget accountDetail() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                      color: white,
                      text: "Account details",
                      fontsize: 14,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w500,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                      color: white,
                      text: "Manage your profile",
                      fontsize: 10,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w400,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: white,
          ),
        ],
      ),
    );
  }

  Widget subscription() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                      color: white,
                      text: "Subscription",
                      fontsize: 14,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w500,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                      color: white,
                      text: "Upgrade to get more out of your Subscription",
                      fontsize: 10,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w400,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: white,
          ),
        ],
      ),
    );
  }

  Widget changePasssword() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          color: white,
                          text: "Change password",
                          fontsize: 14,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                      const SizedBox(
                        height: 10,
                      ),
                      MyText(
                          color: white,
                          text: "Update your password",
                          fontsize: 10,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w400,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                    ],
                  ),
                  MyImage(width: 15, height: 15, imagePath: "ic_down.png")
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: white,
          ),
        ],
      ),
    );
  }

  Widget language() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                      color: white,
                      text: "Language",
                      fontsize: 14,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w500,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                      color: white,
                      text: "English",
                      fontsize: 10,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w400,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: white,
          ),
        ],
      ),
    );
  }

  Widget notification() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          color: white,
                          text: "Notification",
                          fontsize: 14,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                      const SizedBox(
                        height: 10,
                      ),
                      MyText(
                          color: white,
                          text: "Recieve notification",
                          fontsize: 10,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w400,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                    ],
                  ),
                  Switch(
                    activeColor: bottomnavigationText,
                    activeTrackColor: bottomnavigationText,
                    inactiveTrackColor: white,
                    value: isSwitched,
                    onChanged: toggleSwitch,
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: white,
          ),
        ],
      ),
    );
  }

  Widget clearCache() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                          color: white,
                          text: "Clear cache",
                          fontsize: 14,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                      const SizedBox(
                        height: 10,
                      ),
                      MyText(
                          color: white,
                          text: "clear locally cached data",
                          fontsize: 10,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w400,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal),
                    ],
                  ),
                  MyImage(width: 25, height: 25, imagePath: "ic_clear.png")
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: white,
          ),
        ],
      ),
    );
  }

  Widget clearVideo() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: MyText(
                  color: white,
                  text: "Clear video search history",
                  textalign: TextAlign.center,
                  fontsize: 12,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  fontwaight: FontWeight.w400,
                  fontstyle: FontStyle.normal),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: white,
          )
        ],
      ),
    );
  }

  Widget signin() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Column(
        children: [
          Expanded(
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: 160,
                      color: downloadBg,
                      child: Column(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                      color: white,
                                      text: "Confirm sign out",
                                      textalign: TextAlign.center,
                                      fontsize: 14,
                                      fontwaight: FontWeight.w500,
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontstyle: FontStyle.normal),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  MyText(
                                      color: white,
                                      text: "Are you sure want to sign out?",
                                      textalign: TextAlign.center,
                                      fontsize: 10,
                                      fontwaight: FontWeight.w500,
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      fontstyle: FontStyle.normal)
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                              alignment: Alignment.centerRight,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color: white,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: MyText(
                                          color: white,
                                          text: "Cancel",
                                          textalign: TextAlign.center,
                                          fontsize: 14,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          fontwaight: FontWeight.w400,
                                          fontstyle: FontStyle.normal),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Container(
                                      width: 80,
                                      height: 50,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: bottomnavigationText,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: MyText(
                                          color: primary,
                                          text: "Sign out",
                                          textalign: TextAlign.center,
                                          fontsize: 14,
                                          maxline: 1,
                                          overflow: TextOverflow.ellipsis,
                                          fontwaight: FontWeight.w400,
                                          fontstyle: FontStyle.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MyText(
                        color: white,
                        text: "Signed in as IMS-128-VRAJRAVAL",
                        fontsize: 14,
                        maxline: 1,
                        overflow: TextOverflow.ellipsis,
                        fontwaight: FontWeight.w500,
                        textalign: TextAlign.center,
                        fontstyle: FontStyle.normal),
                    const SizedBox(
                      height: 10,
                    ),
                    MyText(
                        color: white,
                        text: "Sign out",
                        fontsize: 10,
                        maxline: 1,
                        overflow: TextOverflow.ellipsis,
                        fontwaight: FontWeight.w400,
                        textalign: TextAlign.center,
                        fontstyle: FontStyle.normal),
                  ],
                ),
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: white,
          ),
        ],
      ),
    );
  }

  Widget rateUs() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                      color: white,
                      text: "Rate us",
                      fontsize: 14,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w500,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                      color: white,
                      text: "Rate our app on appstore",
                      fontsize: 10,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w400,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: white,
          ),
        ],
      ),
    );
  }

  Widget shareApp() {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 80,
      child: Column(
        children: [
          Expanded(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MyText(
                      color: white,
                      text: "Share app",
                      fontsize: 14,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w500,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                  const SizedBox(
                    height: 10,
                  ),
                  MyText(
                      color: white,
                      text: "Share app with your friends",
                      fontsize: 10,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w400,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal),
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: white,
          ),
        ],
      ),
    );
  }

  Widget about() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: MyText(
                  color: white,
                  text: "About & Legal",
                  textalign: TextAlign.center,
                  fontsize: 12,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  fontwaight: FontWeight.w400,
                  fontstyle: FontStyle.normal),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: white,
          )
        ],
      ),
    );
  }

  Widget privacyPolicy() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: MyText(
                  color: white,
                  text: "Privacy policy",
                  textalign: TextAlign.center,
                  fontsize: 12,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  fontwaight: FontWeight.w400,
                  fontstyle: FontStyle.normal),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: white,
          )
        ],
      ),
    );
  }

  Widget termsCondition() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      color: white,
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: primary,
              alignment: Alignment.centerLeft,
              child: MyText(
                  color: white,
                  text: "Terms & Conditions",
                  textalign: TextAlign.center,
                  fontsize: 12,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  fontwaight: FontWeight.w400,
                  fontstyle: FontStyle.normal),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 1,
            color: white,
          )
        ],
      ),
    );
  }
}
