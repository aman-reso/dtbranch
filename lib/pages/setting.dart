import 'dart:developer';

import 'package:dtlive/pages/aboutprivacyterms.dart';
import 'package:dtlive/pages/loginsocial.dart';
import 'package:dtlive/pages/profileedit.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class Setting extends StatefulWidget {
  const Setting({Key? key}) : super(key: key);

  @override
  State<Setting> createState() => SettingState();
}

class SettingState extends State<Setting> {
  bool? isSwitched;
  String? userId,
      userName,
      userType,
      userMobileNo,
      aboutUsUrl,
      privacyUrl,
      termsConditionUrl;
  SharedPre sharedPref = SharedPre();
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  void toggleSwitch(bool value) async {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
    log('toggleSwitch isSwitched ==> $isSwitched');
    // Flutter SDK 3.x.x use
    await OneSignal.shared.disablePush(isSwitched ?? true);
    await sharedPref.saveBool("PUSH", isSwitched);
  }

  void getUserData() async {
    userId = await sharedPref.read("userid");
    userName = await sharedPref.read("username");
    userType = await sharedPref.read("usertype");
    userMobileNo = await sharedPref.read("mobile");
    log('getUserData userId ==> $userId');
    log('getUserData userName ==> $userName');
    log('getUserData userType ==> $userType');
    log('getUserData userMobileNo ==> $userMobileNo');

    aboutUsUrl = await sharedPref.read("about-us") ?? "";
    privacyUrl = await sharedPref.read("privacy-policy") ?? "";
    termsConditionUrl = await sharedPref.read("terms-and-conditions") ?? "";

    isSwitched = await sharedPref.readBool("PUSH");
    log('getUserData isSwitched ==> $isSwitched');
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: Utils.myAppBar(context, settings),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(22),
            child: Column(
              children: [
                /* Account Details */
                InkWell(
                  borderRadius: BorderRadius.circular(2),
                  onTap: () {
                    log("Tapped on : $accountDetails");
                    if (Constant.userID != "0") {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfileEdit(),
                        ),
                      );
                    } else {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginSocial(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      minHeight: Constant.minHeightSettings,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          color: white,
                          text: accountDetails,
                          fontsize: 15,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MyText(
                          color: otherColor,
                          text: manageYourProfile,
                          fontsize: 13,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.normal,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  color: white,
                ),
                /* Subscription */
                // InkWell(
                //   borderRadius: BorderRadius.circular(2),
                //   onTap: () {},
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     constraints: BoxConstraints(
                //       minHeight: Constant.minHeightSettings,
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         MyText(
                //           color: white,
                //           text: subscription,
                //           fontsize: 15,
                //           maxline: 1,
                //           overflow: TextOverflow.ellipsis,
                //           fontwaight: FontWeight.w500,
                //           textalign: TextAlign.center,
                //           fontstyle: FontStyle.normal,
                //         ),
                //         const SizedBox(
                //           height: 5,
                //         ),
                //         MyText(
                //           color: otherColor,
                //           text: subscriptionNote,
                //           fontsize: 13,
                //           maxline: 1,
                //           overflow: TextOverflow.ellipsis,
                //           fontwaight: FontWeight.normal,
                //           textalign: TextAlign.center,
                //           fontstyle: FontStyle.normal,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 0.5,
                //   margin: const EdgeInsets.only(top: 16, bottom: 16),
                //   color: white,
                // ),
                /* Language */
                // InkWell(
                //   borderRadius: BorderRadius.circular(2),
                //   onTap: () {},
                //   child: Container(
                //     width: MediaQuery.of(context).size.width,
                //     constraints: BoxConstraints(
                //       minHeight: Constant.minHeightSettings,
                //     ),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         MyText(
                //           color: white,
                //           text: language,
                //           fontsize: 15,
                //           maxline: 1,
                //           overflow: TextOverflow.ellipsis,
                //           fontwaight: FontWeight.w500,
                //           textalign: TextAlign.center,
                //           fontstyle: FontStyle.normal,
                //         ),
                //         const SizedBox(
                //           height: 5,
                //         ),
                //         MyText(
                //           color: otherColor,
                //           text: "English",
                //           fontsize: 13,
                //           maxline: 1,
                //           overflow: TextOverflow.ellipsis,
                //           fontwaight: FontWeight.normal,
                //           textalign: TextAlign.center,
                //           fontstyle: FontStyle.normal,
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // Container(
                //   width: MediaQuery.of(context).size.width,
                //   height: 0.5,
                //   margin: const EdgeInsets.only(top: 16, bottom: 16),
                //   color: white,
                // ),
                /* Push Notification enable/disable */
                Container(
                  width: MediaQuery.of(context).size.width,
                  constraints: BoxConstraints(
                    minHeight: Constant.minHeightSettings,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            color: white,
                            text: notifications,
                            fontsize: 15,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontwaight: FontWeight.w500,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          MyText(
                            color: otherColor,
                            text: receivePushNotification,
                            fontsize: 13,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontwaight: FontWeight.normal,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal,
                          ),
                        ],
                      ),
                      Switch(
                        activeColor: primaryColor,
                        activeTrackColor: accentColor,
                        inactiveTrackColor: white,
                        value: isSwitched ?? true,
                        onChanged: toggleSwitch,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  color: white,
                ),
                /* Clear Cache */
                InkWell(
                  borderRadius: BorderRadius.circular(2),
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      minHeight: Constant.minHeightSettings,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              color: white,
                              text: clearCache,
                              fontsize: 15,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontwaight: FontWeight.w500,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            MyText(
                              color: otherColor,
                              text: clearLocallyCachedData,
                              fontsize: 13,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontwaight: FontWeight.normal,
                              textalign: TextAlign.center,
                              fontstyle: FontStyle.normal,
                            ),
                          ],
                        ),
                        MyImage(
                          width: 28,
                          height: 28,
                          imagePath: "ic_clear.png",
                          color: primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  color: white,
                ),
                /* SignIn / SignOut */
                InkWell(
                  borderRadius: BorderRadius.circular(2),
                  onTap: () {
                    log("Tapped on : $signIn");
                    if (Constant.userID != "0") {
                      logoutConfirmDialog();
                    } else {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const LoginSocial(),
                        ),
                      );
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      minHeight: Constant.minHeightSettings,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          color: white,
                          text: (userId ?? "0") == "0"
                              ? youAreNotSignIn
                              : userType == "3"
                                  ? ("$signedInAs ${userMobileNo ?? ""}")
                                  : ("$signedInAs ${userName ?? ""}"),
                          fontsize: 15,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MyText(
                          color: otherColor,
                          text: (userId ?? "") == "" ? signIn : signOut,
                          fontsize: 13,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.normal,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  color: white,
                ),
                /* Rate App */
                InkWell(
                  borderRadius: BorderRadius.circular(2),
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      minHeight: Constant.minHeightSettings,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          color: white,
                          text: rateUs,
                          fontsize: 15,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MyText(
                          color: otherColor,
                          text: rateOurApp,
                          fontsize: 13,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.normal,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  color: white,
                ),
                /* Share App */
                InkWell(
                  borderRadius: BorderRadius.circular(2),
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      minHeight: Constant.minHeightSettings,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          color: white,
                          text: shareApp,
                          fontsize: 15,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MyText(
                          color: otherColor,
                          text: shareWithFriends,
                          fontsize: 13,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.normal,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                  margin: const EdgeInsets.only(top: 16, bottom: 16),
                  color: white,
                ),
                /* About Us */
                InkWell(
                  borderRadius: BorderRadius.circular(2),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutPrivacyTerms(
                          appBarTitle: aboutUs,
                          loadURL: aboutUsUrl ?? "",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      minHeight: Constant.minHeightSettings,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          color: white,
                          text: aboutUs,
                          fontsize: 15,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MyText(
                          color: otherColor,
                          text: version,
                          fontsize: 13,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.normal,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal,
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(top: 16, bottom: 8),
                  height: 0.5,
                  color: white,
                ),
                /* Privacy Policy */
                InkWell(
                  borderRadius: BorderRadius.circular(2),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutPrivacyTerms(
                          appBarTitle: privacyPolicy,
                          loadURL: privacyUrl ?? "",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      minHeight: Constant.minHeightSettings,
                    ),
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      color: white,
                      text: privacyPolicy,
                      fontsize: 15,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w500,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  color: white,
                ),
                /* Terms & Conditions */
                InkWell(
                  borderRadius: BorderRadius.circular(2),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => AboutPrivacyTerms(
                          appBarTitle: termsAndConditions,
                          loadURL: termsConditionUrl ?? "",
                        ),
                      ),
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                      minHeight: Constant.minHeightSettings,
                    ),
                    alignment: Alignment.centerLeft,
                    child: MyText(
                      color: white,
                      text: termsAndConditions,
                      fontsize: 15,
                      maxline: 1,
                      overflow: TextOverflow.ellipsis,
                      fontwaight: FontWeight.w500,
                      textalign: TextAlign.center,
                      fontstyle: FontStyle.normal,
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 0.5,
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  color: white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void logoutConfirmDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: lightBlack,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(0),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(23),
              color: lightBlack,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          color: white,
                          text: confirmSignOut,
                          textalign: TextAlign.center,
                          fontsize: 16,
                          fontwaight: FontWeight.bold,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontstyle: FontStyle.normal,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        MyText(
                          color: white,
                          text: areYouSureWantToSignOut,
                          textalign: TextAlign.center,
                          fontsize: 13,
                          fontwaight: FontWeight.normal,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontstyle: FontStyle.normal,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
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
                            constraints: const BoxConstraints(
                              minWidth: 75,
                            ),
                            height: 50,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: otherColor,
                                width: .5,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: MyText(
                              color: white,
                              text: cancel,
                              textalign: TextAlign.center,
                              fontsize: 16,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontwaight: FontWeight.w500,
                              fontstyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        InkWell(
                          onTap: () async {
                            // Firebase Signout
                            await auth.signOut();

                            await Utils.setUserId("0");
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => const LoginSocial(),
                              ),
                            );
                          },
                          child: Container(
                            constraints: const BoxConstraints(
                              minWidth: 75,
                            ),
                            height: 50,
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: primaryLight,
                              borderRadius: BorderRadius.circular(5),
                              shape: BoxShape.rectangle,
                            ),
                            child: MyText(
                              color: black,
                              text: signOut,
                              textalign: TextAlign.center,
                              fontsize: 16,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontwaight: FontWeight.w500,
                              fontstyle: FontStyle.normal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
