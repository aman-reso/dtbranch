import 'dart:developer';

import 'package:dtlive/provider/generalprovider.dart';
import 'package:dtlive/provider/homeprovider.dart';
import 'package:dtlive/provider/sectiondataprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class LoginSocialWeb extends StatefulWidget {
  const LoginSocialWeb({super.key});

  @override
  State<LoginSocialWeb> createState() => _LoginSocialWebState();
}

class _LoginSocialWebState extends State<LoginSocialWeb> {
  SharedPre sharedPref = SharedPre();
  final numberController = TextEditingController();
  String? mobileNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      constraints: const BoxConstraints(
        minWidth: 300,
        minHeight: 0,
        maxWidth: 350,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: MyImage(
                    fit: BoxFit.contain,
                    imagePath: "appicon.png",
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: MyImage(
                      fit: BoxFit.contain,
                      imagePath: "ic_close.png",
                      color: otherColor,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            MyText(
              color: white,
              text: "welcomeback",
              fontsizeNormal: 16,
              fontsizeWeb: 18,
              multilanguage: true,
              fontweight: FontWeight.bold,
              maxline: 1,
              overflow: TextOverflow.ellipsis,
              textalign: TextAlign.start,
              fontstyle: FontStyle.normal,
            ),
            const SizedBox(height: 7),
            MyText(
              color: otherColor,
              text: "login_with_mobile_note",
              fontsizeNormal: 13,
              fontsizeWeb: 14,
              multilanguage: true,
              fontweight: FontWeight.w500,
              maxline: 2,
              overflow: TextOverflow.ellipsis,
              textalign: TextAlign.start,
              fontstyle: FontStyle.normal,
            ),
            const SizedBox(height: 20),

            /* Enter Mobile Number */
            Container(
              width: MediaQuery.of(context).size.width,
              height: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                  color: primaryColor,
                  width: 0.7,
                ),
                color: edtBG,
                borderRadius: const BorderRadius.all(
                  Radius.circular(5),
                ),
              ),
              child: IntlPhoneField(
                disableLengthCheck: true,
                controller: numberController,
                textAlignVertical: TextAlignVertical.center,
                autovalidateMode: AutovalidateMode.disabled,
                style: const TextStyle(
                  color: white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
                showCountryFlag: false,
                showDropdownIcon: false,
                initialCountryCode: 'IN',
                dropdownTextStyle: GoogleFonts.montserrat(
                  color: white,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isCollapsed: true,
                  border: InputBorder.none,
                  hintStyle: GoogleFonts.montserrat(
                    color: otherColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  hintText: enterYourMobileNumber,
                ),
                onChanged: (phone) {
                  log('===> ${phone.completeNumber}');
                  mobileNumber = phone.completeNumber;
                  log('===>mobileNumber $mobileNumber');
                },
                onCountryChanged: (country) {
                  log('===> ${country.name}');
                  log('===> ${country.code}');
                },
              ),
            ),
            const SizedBox(height: 30),

            /* Login Button */
            InkWell(
              onTap: () {
                debugPrint("Click mobileNumber ==> $mobileNumber");
                if (numberController.text.toString().isEmpty) {
                  Utils.showSnackbar(
                      context, "TextField", "login_with_mobile_note");
                } else {
                  log("mobileNumber ==> $mobileNumber");
                  Utils.buildWebAlertDialog(context, "otp", mobileNumber);
                }
              },
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 35,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      primaryLight,
                      primaryDark,
                    ],
                    begin: FractionalOffset(0.0, 0.0),
                    end: FractionalOffset(1.0, 0.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                alignment: Alignment.center,
                child: MyText(
                  color: white,
                  text: "login",
                  multilanguage: true,
                  fontsizeNormal: 15,
                  fontsizeWeb: 14,
                  fontweight: FontWeight.w600,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  textalign: TextAlign.center,
                  fontstyle: FontStyle.normal,
                ),
              ),
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 1,
                  color: accentColor,
                ),
                const SizedBox(width: 15),
                MyText(
                  color: otherColor,
                  text: "or",
                  multilanguage: true,
                  fontsizeNormal: 14,
                  fontsizeWeb: 14,
                  fontweight: FontWeight.w500,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  textalign: TextAlign.center,
                  fontstyle: FontStyle.normal,
                ),
                const SizedBox(width: 15),
                Container(
                  width: 80,
                  height: 1,
                  color: accentColor,
                ),
              ],
            ),
            const SizedBox(height: 25),

            /* Google Login Button */
            InkWell(
              onTap: () {
                debugPrint("Clicked on : ====> loginWith Google");
                _gmailLogin();
              },
              borderRadius: BorderRadius.circular(18),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 35,
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                decoration: BoxDecoration(
                  color: white,
                  borderRadius: BorderRadius.circular(18),
                ),
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyImage(
                      width: 20,
                      height: 20,
                      imagePath: "ic_google.png",
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Flexible(
                      child: MyText(
                        color: black,
                        text: "loginwithgoogle",
                        fontsizeNormal: 14,
                        fontsizeWeb: 12,
                        multilanguage: true,
                        fontweight: FontWeight.w600,
                        maxline: 1,
                        overflow: TextOverflow.ellipsis,
                        textalign: TextAlign.center,
                        fontstyle: FontStyle.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /* Google(Gmail) Login */
  Future<void> _gmailLogin() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return;

    GoogleSignInAccount user = googleUser;

    debugPrint('GoogleSignIn ===> id : ${user.id}');
    debugPrint('GoogleSignIn ===> email : ${user.email}');
    debugPrint('GoogleSignIn ===> displayName : ${user.displayName}');
    debugPrint('GoogleSignIn ===> photoUrl : ${user.photoUrl}');

    googleSignInUser(user.email, user.displayName ?? "", "2");
  }

  googleSignInUser(String mail, String displayName, String strType) async {
    debugPrint("Email : $mail, Name : $displayName, Type : $strType");
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: '123456');
      debugPrint("uid ===> ${userCredential.user?.uid}");
      String firebasedid = userCredential.user?.uid ?? "";
      debugPrint('firebasedid :===> $firebasedid');

      checkAndNavigate(mail, displayName, strType);
    } on FirebaseAuthException catch (e) {
      debugPrint('===>Exp${e.code.toString()}');
      debugPrint('===>Exp${e.message.toString()}');
      if (e.code.toString() == "user-not-found") {
        registerFirebaseUser(mail, displayName, strType);
      } else if (e.code == 'wrong-password') {
        // Hide Progress Dialog
        debugPrint('Wrong password provided.');
        Utils().showToast('Wrong password provided.');
      } else {
        // Hide Progress Dialog
      }
    }
  }

  registerFirebaseUser(String mail, String displayName, String strType) async {
    debugPrint("Email : $mail and Name : $displayName");
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: '123456')
          .whenComplete(() {});
      debugPrint(
          'RegisterUser mail : ${userCredential.user?.email.toString()}');
      debugPrint("mail ===> $mail");

      debugPrint("uid ===> ${userCredential.user?.uid}");
      String firebasedid = userCredential.user?.uid ?? "";
      debugPrint('firebasedid :===> $firebasedid');

      googleSignInUser(mail, displayName, strType);
    } on FirebaseAuthException catch (e) {
      // Hide Progress Dialog
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        Utils().showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {}
    } catch (e) {
      // Hide Progress Dialog
      debugPrint(e.toString());
    }
  }

  void checkAndNavigate(email, userName, strType) async {
    log('checkAndNavigate email ==>> $email');
    log('checkAndNavigate userName ==>> $userName');
    log('checkAndNavigate strType ==>> $strType');
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    final sectionDataProvider =
        Provider.of<SectionDataProvider>(context, listen: false);
    final generalProvider =
        Provider.of<GeneralProvider>(context, listen: false);
    await generalProvider.loginWithSocial(email, userName, strType);
    log('checkAndNavigate loading ==>> ${generalProvider.loading}');

    if (!generalProvider.loading) {
      if (generalProvider.loginGmailModel.status == 200) {
        log('loginGmailModel ==>> ${generalProvider.loginGmailModel.toString()}');
        log('Login Successfull!');
        await sharedPref.save(
            "userid", generalProvider.loginGmailModel.result?.id.toString());
        await sharedPref.save("username",
            generalProvider.loginGmailModel.result?.name.toString() ?? "");
        await sharedPref.save("userimage",
            generalProvider.loginGmailModel.result?.image.toString() ?? "");
        await sharedPref.save("useremail",
            generalProvider.loginGmailModel.result?.email.toString() ?? "");
        await sharedPref.save("usermobile",
            generalProvider.loginGmailModel.result?.mobile.toString() ?? "");
        await sharedPref.save("usertype",
            generalProvider.loginGmailModel.result?.type.toString() ?? "");

        // Set UserID for Next
        Constant.userID = generalProvider.loginGmailModel.result?.id.toString();
        log('Constant userID ==>> ${Constant.userID}');

        if (!mounted) return;
        Navigator.pop(context);

        await homeProvider.homeNotifyProvider();
        await sectionDataProvider.getSectionBanner("0", "1");
        await sectionDataProvider.getSectionList("0", "1");
      } else {
        // Hide Progress Dialog
        if (!mounted) return;
        Utils.showSnackbar(
            context, "fail", "${generalProvider.loginGmailModel.message}");
      }
    }
  }
}
