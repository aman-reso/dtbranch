import 'dart:developer';

import 'package:dtlive/pages/bottombar.dart';
import 'package:dtlive/pages/otpverify.dart';
import 'package:dtlive/provider/generalprovider.dart';
import 'package:dtlive/provider/homeprovider.dart';
import 'package:dtlive/provider/sectiondataprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';

class LoginSocial extends StatefulWidget {
  const LoginSocial({Key? key}) : super(key: key);

  @override
  State<LoginSocial> createState() => LoginSocialState();
}

class LoginSocialState extends State<LoginSocial> {
  FacebookLogin? plugin;
  late ProgressDialog prDialog;
  SharedPre sharePref = SharedPre();
  final numberController = TextEditingController();
  String? mobileNumber, email, userName, strType;

  @override
  void initState() {
    super.initState();
    prDialog = ProgressDialog(context);
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.fromLTRB(25, 0, 25, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 170,
                height: 60,
                alignment: Alignment.centerLeft,
                child: MyImage(
                  fit: BoxFit.fill,
                  imagePath: "appicon.png",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyText(
                color: white,
                text: "welcomeback",
                fontsizeNormal: 25,
                fontsizeWeb: 27,
                multilanguage: true,
                fontweight: FontWeight.bold,
                maxline: 1,
                overflow: TextOverflow.ellipsis,
                textalign: TextAlign.center,
                fontstyle: FontStyle.normal,
              ),
              const SizedBox(
                height: 7,
              ),
              MyText(
                color: otherColor,
                text: "login_with_mobile_note",
                fontsizeNormal: 15,
                fontsizeWeb: 16,
                multilanguage: true,
                fontweight: FontWeight.w500,
                maxline: 1,
                overflow: TextOverflow.ellipsis,
                textalign: TextAlign.center,
                fontstyle: FontStyle.normal,
              ),
              const SizedBox(
                height: 40,
              ),

              /* Enter Mobile Number */
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
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
                  textAlignVertical: TextAlignVertical.center,
                  autovalidateMode: AutovalidateMode.disabled,
                  controller: numberController,
                  style: const TextStyle(fontSize: 16, color: white),
                  showCountryFlag: false,
                  showDropdownIcon: false,
                  initialCountryCode: 'IN',
                  dropdownTextStyle: GoogleFonts.montserrat(
                    color: white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    hintStyle: GoogleFonts.montserrat(
                      color: otherColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                    hintText: enterYourMobileNumber,
                  ),
                  onChanged: (phone) {
                    log('===> ${phone.completeNumber}');
                    log('===> ${numberController.text}');
                    mobileNumber = phone.completeNumber;
                    log('===>mobileNumber $mobileNumber');
                  },
                  onCountryChanged: (country) {
                    log('===> ${country.name}');
                    log('===> ${country.code}');
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              /* Login Button */
              InkWell(
                onTap: () {
                  debugPrint("Click mobileNumber ==> $mobileNumber");
                  if (numberController.text.toString().isEmpty) {
                    Utils.showSnackbar(
                        context, "TextField", "login_with_mobile_note");
                  } else {
                    log("mobileNumber ==> $mobileNumber");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OTPVerify(mobileNumber ?? ""),
                      ),
                    );
                  }
                },
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 52,
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
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: MyText(
                    color: white,
                    text: "login",
                    multilanguage: true,
                    fontsizeNormal: 17,
                    fontsizeWeb: 19,
                    fontweight: FontWeight.w700,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.center,
                    fontstyle: FontStyle.normal,
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 1,
                    color: accentColor,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  MyText(
                    color: otherColor,
                    text: "or",
                    multilanguage: true,
                    fontsizeNormal: 14,
                    fontsizeWeb: 16,
                    fontweight: FontWeight.w500,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.center,
                    fontstyle: FontStyle.normal,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: 80,
                    height: 1,
                    color: accentColor,
                  ),
                ],
              ),
              const SizedBox(
                height: 25,
              ),

              /* Google Login Button */
              InkWell(
                onTap: () {
                  debugPrint("Clicked on : ====> loginWith Google");
                  _gmailLogin();
                },
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 52,
                  padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(26),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MyImage(
                        width: 30,
                        height: 30,
                        imagePath: "ic_google.png",
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      MyText(
                        color: black,
                        text: "loginwithgoogle",
                        fontsizeNormal: 14,
                        fontsizeWeb: 16,
                        multilanguage: true,
                        fontweight: FontWeight.w600,
                        maxline: 1,
                        overflow: TextOverflow.ellipsis,
                        textalign: TextAlign.center,
                        fontstyle: FontStyle.normal,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* Facebook Login */
  Future<void> facebookLogin() async {
    await plugin?.logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email,
    ]);

    final token = await plugin?.accessToken;
    debugPrint("_getFBLoginInfo token ====> $token");
    FacebookUserProfile? profile;
    String? imageUrl;

    if (token != null) {
      profile = await plugin?.getUserProfile();
      if (token.permissions.contains(FacebookPermission.email.name)) {
        email = await plugin?.getUserEmail();
      }
      imageUrl = await plugin?.getProfileImageUrl(width: 100);
      debugPrint("_getFBLoginInfo firstname ====> ${profile?.firstName ?? ""}");
      debugPrint("_getFBLoginInfo lastname ====> ${profile?.lastName ?? ""}");
      debugPrint("_getFBLoginInfo email ====> $email");
      debugPrint("_getFBLoginInfo imageUrl ====> $imageUrl");
      debugPrint("_getFBLoginInfo name ====> ${profile?.name ?? ""}");
      strType = "1";
      // Login to Firebase Console
      googleSignInUser(email ?? "", profile?.name ?? "");
    }
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

    strType = "2";
    googleSignInUser(user.email, user.displayName ?? "");
  }

  googleSignInUser(String mail, String displayName) async {
    Utils.showProgress(context, prDialog);
    debugPrint("Email : $mail and Name : $displayName");
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: '123456');
      debugPrint("uid ===> ${userCredential.user?.uid}");
      String firebasedid = userCredential.user?.uid ?? "";
      debugPrint('firebasedid :===> $firebasedid');

      email = mail;
      userName = displayName;

      checkAndNavigate();
    } on FirebaseAuthException catch (e) {
      debugPrint('===>Exp${e.code.toString()}');
      debugPrint('===>Exp${e.message.toString()}');
      if (e.code.toString() == "user-not-found") {
        registerFirebaseUser(mail, displayName);
      } else if (e.code == 'wrong-password') {
        // Hide Progress Dialog
        await prDialog.hide();
        debugPrint('Wrong password provided.');
        Utils().showToast('Wrong password provided.');
      } else {
        // Hide Progress Dialog
        await prDialog.hide();
      }
    }
  }

  registerFirebaseUser(String mail, String displayName) async {
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

      googleSignInUser(mail, displayName);
    } on FirebaseAuthException catch (e) {
      // Hide Progress Dialog
      await prDialog.hide();
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
        Utils().showToast('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {}
    } catch (e) {
      // Hide Progress Dialog
      await prDialog.hide();
      debugPrint(e.toString());
    }
  }

  void checkAndNavigate() async {
    log('checkAndNavigate email ==>> $email');
    log('checkAndNavigate userName ==>> $userName');
    log('checkAndNavigate strType ==>> $strType');
    if (!prDialog.isShowing()) {
      Utils.showProgress(context, prDialog);
    }
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
        await sharePref.save(
            "userid", generalProvider.loginGmailModel.result?.id.toString());
        await sharePref.save("username",
            generalProvider.loginGmailModel.result?.name.toString() ?? "");
        await sharePref.save("userimage",
            generalProvider.loginGmailModel.result?.image.toString() ?? "");
        await sharePref.save("useremail",
            generalProvider.loginGmailModel.result?.email.toString() ?? "");
        await sharePref.save("usermobile",
            generalProvider.loginGmailModel.result?.mobile.toString() ?? "");
        await sharePref.save("usertype",
            generalProvider.loginGmailModel.result?.type.toString() ?? "");

        // Set UserID for Next
        Constant.userID = generalProvider.loginGmailModel.result?.id.toString();
        log('Constant userID ==>> ${Constant.userID}');

        await homeProvider.setSelectedTab(0);
        await sectionDataProvider.getSectionBanner("0", "1");
        await sectionDataProvider.getSectionList("0", "1");

        // Hide Progress Dialog
        await prDialog.hide();
        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Bottombar(),
          ),
        );
      } else {
        // Hide Progress Dialog
        await prDialog.hide();
        if (!mounted) return;
        Utils.showSnackbar(
            context, "fail", "${generalProvider.loginGmailModel.message}");
      }
    }
  }
}
