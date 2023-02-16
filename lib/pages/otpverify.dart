import 'dart:developer';

import 'package:dtlive/pages/bottombar.dart';
import 'package:dtlive/provider/generalprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class OTPVerify extends StatefulWidget {
  final String mobileNumber;
  const OTPVerify(this.mobileNumber, {Key? key}) : super(key: key);

  @override
  State<OTPVerify> createState() => OTPVerifyState();
}

class OTPVerifyState extends State<OTPVerify> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late ProgressDialog prDialog;
  SharedPre sharePref = SharedPre();
  final numberController = TextEditingController();
  final pinPutController = TextEditingController();
  ScrollController scollController = ScrollController();
  String? verificationId, finalOTP;
  int? forceResendingToken;
  bool codeResended = false;

  @override
  void initState() {
    super.initState();
    prDialog = ProgressDialog(context);
    Utils.showProgress(context, prDialog);
    codeSend(false);
  }

  @override
  void dispose() {
    FocusManager.instance.primaryFocus?.unfocus();
    numberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          margin: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.centerLeft,
                child: InkWell(
                  borderRadius: BorderRadius.circular(25),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    alignment: Alignment.centerLeft,
                    child: MyImage(
                      fit: BoxFit.fill,
                      imagePath: "backwith_bg.png",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              MyText(
                color: white,
                text: "verifyphonenumber",
                fontsizeNormal: 26,
                multilanguage: true,
                fontweight: FontWeight.bold,
                maxline: 1,
                overflow: TextOverflow.ellipsis,
                textalign: TextAlign.center,
                fontstyle: FontStyle.normal,
              ),
              const SizedBox(
                height: 8,
              ),
              MyText(
                color: otherColor,
                text: "code_sent_desc",
                fontsizeNormal: 15,
                fontweight: FontWeight.normal,
                maxline: 3,
                overflow: TextOverflow.ellipsis,
                textalign: TextAlign.center,
                multilanguage: true,
                fontstyle: FontStyle.normal,
              ),
              MyText(
                color: otherColor,
                text: widget.mobileNumber,
                fontsizeNormal: 15,
                fontweight: FontWeight.normal,
                maxline: 3,
                overflow: TextOverflow.ellipsis,
                textalign: TextAlign.center,
                multilanguage: false,
                fontstyle: FontStyle.normal,
              ),
              const SizedBox(
                height: 40,
              ),

              /* Enter Received OTP */
              Pinput(
                length: 6,
                keyboardType: TextInputType.number,
                controller: pinPutController,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                defaultPinTheme: PinTheme(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 0.7),
                    shape: BoxShape.rectangle,
                    color: edtBG,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  textStyle: GoogleFonts.inter(
                    color: white,
                    fontSize: 16,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),

              /* Confirm Button */
              InkWell(
                borderRadius: BorderRadius.circular(26),
                onTap: () {
                  debugPrint(
                      "Clicked sms Code =====> ${pinPutController.text}");
                  if (pinPutController.text.toString().isEmpty) {
                    Utils.showSnackbar(
                        context, "TextField", "enterreceivedotp");
                  } else {
                    Utils.showProgress(context, prDialog);
                    _login(widget.mobileNumber.toString());
                  }
                },
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
                    borderRadius: BorderRadius.circular(26),
                  ),
                  alignment: Alignment.center,
                  child: MyText(
                    color: white,
                    text: "confirm",
                    fontsizeNormal: 17,
                    multilanguage: true,
                    fontweight: FontWeight.w700,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.center,
                    fontstyle: FontStyle.normal,
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),

              /* Resend */
              InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () {
                  if (!codeResended) {
                    codeSend(true);
                  }
                },
                child: Container(
                  constraints: const BoxConstraints(minWidth: 70),
                  padding: const EdgeInsets.all(5),
                  child: MyText(
                    color: white,
                    text: "resend",
                    multilanguage: true,
                    fontsizeNormal: 16,
                    fontweight: FontWeight.w700,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    textalign: TextAlign.center,
                    fontstyle: FontStyle.normal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  codeSend(bool isResend) async {
    codeResended = isResend;
    await phoneSignIn(
        phoneNumber: widget.mobileNumber.toString(), isResend: isResend);
    prDialog.hide();
  }

  Future<void> phoneSignIn(
      {required String phoneNumber, required bool isResend}) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: _onVerificationCompleted,
      verificationFailed: _onVerificationFailed,
      codeSent: _onCodeSent,
      codeAutoRetrievalTimeout: _onCodeTimeout,
    );
  }

  _onVerificationCompleted(PhoneAuthCredential authCredential) async {
    log("verification completed ${authCredential.smsCode}");
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      finalOTP = authCredential.smsCode ?? "";
      pinPutController.text = authCredential.smsCode ?? "";
      log("finalOTP =====> $finalOTP");
    });

    if (authCredential.smsCode != null) {
      try {
        UserCredential? credential =
            await user?.linkWithCredential(authCredential);
        log("_onVerificationCompleted credential =====> ${credential?.user?.phoneNumber ?? ""}");
      } on FirebaseAuthException catch (e) {
        if (e.code == 'provider-already-linked') {
          await _auth.signInWithCredential(authCredential);
        }
      }
      log("Firebase Verification Complated");
      _login(widget.mobileNumber.toString());
    }
  }

  _onVerificationFailed(FirebaseAuthException exception) {
    if (exception.code == 'invalid-phone-number') {
      log("The phone number entered is invalid!");
      Utils.showSnackbar(context, "fail", "invalidphonenumber");
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    this.forceResendingToken = forceResendingToken;
    log("resendingToken =======> ${forceResendingToken.toString()}");
    log("code sent");
  }

  _onCodeTimeout(String timeout) {
    prDialog.hide();
    codeResended = false;
    return null;
  }

  _login(String mobile) async {
    log("click on Submit mobile => $mobile");
    var generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    Utils.showProgress(context, prDialog);
    await generalProvider.loginWithOTP(mobile);

    if (!generalProvider.loading) {
      await prDialog.hide();

      if (generalProvider.loginOTPModel.status == 200) {
        log('loginOTPModel ==>> ${generalProvider.loginOTPModel.toString()}');
        log('Login Successfull!');
        sharePref.save(
            "userid", generalProvider.loginOTPModel.result?.id.toString());
        sharePref.save("username",
            generalProvider.loginOTPModel.result?.name.toString() ?? "");
        sharePref.save("userimage",
            generalProvider.loginOTPModel.result?.image.toString() ?? "");
        sharePref.save("useremail",
            generalProvider.loginOTPModel.result?.email.toString() ?? "");
        sharePref.save("usermobile",
            generalProvider.loginOTPModel.result?.mobile.toString() ?? "");
        sharePref.save("usertype",
            generalProvider.loginOTPModel.result?.type.toString() ?? "");

        // Set UserID for Next
        Constant.userID = generalProvider.loginOTPModel.result?.id.toString();
        log('Constant userID ==>> ${Constant.userID}');

        if (!mounted) return;
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Bottombar(),
          ),
        );
      } else {
        if (!mounted) return;
        Utils.showSnackbar(
            context, "fail", "${generalProvider.loginOTPModel.message}");
      }
    }
  }
}
