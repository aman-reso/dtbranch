import 'dart:developer';

import 'package:dtlive/pages/aboutprivacyterms.dart';
import 'package:dtlive/pages/loginsocial.dart';
import 'package:dtlive/pages/profileedit.dart';
import 'package:dtlive/pages/subscription.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
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
      appBar: Utils.myAppBar(context, "setting"),
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
                    if (Constant.userID != "0") {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const ProfileEdit(),
                        ),
                      );
                    } else {
                      Navigator.of(context).push(
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
                          text: "accountdetails",
                          fontsize: 15,
                          maxline: 1,
                          multilanguage: true,
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
                          text: "manageprofile",
                          multilanguage: true,
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
                InkWell(
                  borderRadius: BorderRadius.circular(2),
                  onTap: () {
                    if (Constant.userID != "0") {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const Subscription(),
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
                          text: "subsciption",
                          fontsize: 15,
                          multilanguage: true,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
                          textalign: TextAlign.left,
                          fontstyle: FontStyle.normal,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        MyText(
                          color: otherColor,
                          text: "subsciptionnotes",
                          fontsize: 13,
                          multilanguage: true,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.normal,
                          textalign: TextAlign.left,
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
                            text: "notification",
                            fontsize: 15,
                            maxline: 1,
                            multilanguage: true,
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
                            text: "recivepushnotification",
                            fontsize: 13,
                            multilanguage: true,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontwaight: FontWeight.normal,
                            textalign: TextAlign.center,
                            fontstyle: FontStyle.normal,
                          ),
                        ],
                      ),
                      Switch(
                        activeColor: primaryDark,
                        activeTrackColor: primaryLight,
                        inactiveTrackColor: gray,
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
                  onTap: () async {
                    await Utils.deleteCacheDir();
                    // ignore: use_build_context_synchronously
                    Utils.showSnackbar(context, "success", "cacheclearmsg");
                  },
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
                              text: "clearcatch",
                              fontsize: 15,
                              multilanguage: true,
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
                              text: "clearlocallycatch",
                              fontsize: 13,
                              maxline: 1,
                              multilanguage: true,
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
                          text: (userId ?? "") == ""
                              ? youAreNotSignIn
                              : (userType == "3" && (userName ?? "").isEmpty)
                                  ? ("$signedInAs ${userMobileNo ?? ""}")
                                  : ("$signedInAs ${userName ?? ""}"),
                          fontsize: 15,
                          maxline: 1,
                          multilanguage: false,
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
                          text: (userId ?? "") == "" ? "sign_in" : "sign_out",
                          fontsize: 13,
                          multilanguage: true,
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
                          text: "rateus",
                          fontsize: 15,
                          multilanguage: true,
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
                          text: "rateourapp",
                          multilanguage: true,
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
                          text: "shareapp",
                          fontsize: 15,
                          maxline: 1,
                          multilanguage: true,
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
                          text: "sharewithfriends",
                          fontsize: 13,
                          maxline: 1,
                          multilanguage: true,
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
                          appBarTitle: "aboutus",
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
                          text: "aboutus",
                          fontsize: 15,
                          maxline: 1,
                          multilanguage: true,
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
                          text: "version",
                          fontsize: 13,
                          multilanguage: true,
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
                          appBarTitle: "privacypolicy",
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          color: white,
                          text: "privacypolicy",
                          fontsize: 15,
                          multilanguage: true,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
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
                          appBarTitle: "termcondition",
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
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          color: white,
                          text: "termcondition",
                          fontsize: 15,
                          multilanguage: true,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
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
                  margin: const EdgeInsets.only(top: 8, bottom: 8),
                  color: white,
                ),

                /* MaltiLanguage */
                InkWell(
                  borderRadius: BorderRadius.circular(2),
                  onTap: () {
                    _languageChangeDialog();
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
                          text: "language_",
                          multilanguage: true,
                          fontsize: 15,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
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
                          text: "confirmsognout",
                          multilanguage: true,
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
                          text: "areyousurewanrtosignout",
                          multilanguage: true,
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
                              text: "cancle",
                              multilanguage: true,
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
                              text: "sign_out",
                              textalign: TextAlign.center,
                              fontsize: 16,
                              multilanguage: true,
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

  _languageChangeDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: lightBlack,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(0),
        ),
      ),
      elevation: 20,
      builder: (BuildContext context) {
        return BottomSheet(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(0),
            ),
          ),
          onClosing: () {},
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (BuildContext context, state) {
                return Wrap(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: lightBlack,
                      padding: const EdgeInsets.all(23),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  color: white,
                                  text: "changelanguage",
                                  multilanguage: true,
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
                                  text: "selectyourlanguage",
                                  multilanguage: true,
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

                          /* English */
                          InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              state(() {});
                              LocaleNotifier.of(context)?.change('en');
                              Navigator.pop(context);
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width,
                              ),
                              height: 48,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: primaryLight,
                                  width: .5,
                                ),
                                color: primaryDarkColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: MyText(
                                color: white,
                                text: "English",
                                textalign: TextAlign.center,
                                fontsize: 16,
                                multilanguage: false,
                                maxline: 1,
                                overflow: TextOverflow.ellipsis,
                                fontwaight: FontWeight.w500,
                                fontstyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          /* Arabic */
                          InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              state(() {});
                              LocaleNotifier.of(context)?.change('ar');
                              Navigator.pop(context);
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width,
                              ),
                              height: 48,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: primaryLight,
                                  width: .5,
                                ),
                                color: primaryDarkColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: MyText(
                                color: white,
                                text: "Arabic",
                                textalign: TextAlign.center,
                                fontsize: 16,
                                multilanguage: false,
                                maxline: 1,
                                overflow: TextOverflow.ellipsis,
                                fontwaight: FontWeight.w500,
                                fontstyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),

                          /* Hindi */
                          InkWell(
                            borderRadius: BorderRadius.circular(5),
                            onTap: () {
                              state(() {});
                              LocaleNotifier.of(context)?.change('hi');
                              Navigator.pop(context);
                            },
                            child: Container(
                              constraints: BoxConstraints(
                                minWidth: MediaQuery.of(context).size.width,
                              ),
                              height: 48,
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: primaryLight,
                                  width: .5,
                                ),
                                color: primaryDarkColor,
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: MyText(
                                color: white,
                                text: "Hindi",
                                textalign: TextAlign.center,
                                fontsize: 16,
                                multilanguage: false,
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
                );
              },
            );
          },
        );
      },
    );
  }
}
