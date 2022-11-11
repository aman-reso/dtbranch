import 'dart:developer';

import 'package:dtlive/pages/bottombar.dart';
import 'package:dtlive/provider/generalprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';

class VerifyOTP extends StatefulWidget {
  final String mobileNumber;
  const VerifyOTP(this.mobileNumber, {Key? key}) : super(key: key);

  @override
  State<VerifyOTP> createState() => VerifyOTPState();
}

class VerifyOTPState extends State<VerifyOTP> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late ProgressDialog prDialog;
  SharedPre sharePref = SharedPre();
  final numberController = TextEditingController();
  final pinPutController = TextEditingController();
  ScrollController scollController = ScrollController();
  String? verificationId;

  @override
  void initState() {
    super.initState();
    prDialog = ProgressDialog(context);
    Utils.showProgress(context, prDialog);
    codeSend();
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
                text: verifyPhoneNumber,
                fontsize: 26,
                fontwaight: FontWeight.bold,
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
                text: '$codeSentDesc \n ${widget.mobileNumber}',
                fontsize: 15,
                fontwaight: FontWeight.normal,
                maxline: 3,
                overflow: TextOverflow.ellipsis,
                textalign: TextAlign.center,
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
                    Utils.showSnackbar(context, "TextField", enterReceivedOtp);
                  } else {
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
                    text: confirm,
                    fontsize: 17,
                    fontwaight: FontWeight.w700,
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
              Container(
                constraints: const BoxConstraints(minWidth: 70),
                padding: const EdgeInsets.all(5),
                child: MyText(
                  color: white,
                  text: resend,
                  fontsize: 16,
                  fontwaight: FontWeight.w700,
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
    );
  }

  codeSend() async {
    await phoneSignIn(phoneNumber: widget.mobileNumber.toString());
    prDialog.hide();
  }

  Future<void> phoneSignIn({required String phoneNumber}) async {
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
      pinPutController.text = authCredential.smsCode!;
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
      Utils.showSnackbar(context, "loginFail", invalidPhoneNumber);
    }
  }

  _onCodeSent(String verificationId, int? forceResendingToken) {
    this.verificationId = verificationId;
    log(forceResendingToken.toString());
    log("code sent");
  }

  _onCodeTimeout(String timeout) {
    prDialog.hide();
    return null;
  }

  _login(String mobile) async {
    log("click on Submit mobile => $mobile");
    var generalProvider = Provider.of<GeneralProvider>(context, listen: false);
    Utils.showProgress(context, prDialog);
    await generalProvider.loginWithOTP(mobile);

    if (!generalProvider.loading) {
      prDialog.hide();

      if (generalProvider.loginOTPModel.status == 200) {
        log('loginOTPModel ==>> ${generalProvider.loginOTPModel.toString()}');
        log('Login Successfull!');
        sharePref.save("userid",
            generalProvider.loginOTPModel.result?.id.toString() ?? "0");
        sharePref.save("username",
            generalProvider.loginOTPModel.result?.name.toString() ?? "");
        sharePref.save("userimage",
            generalProvider.loginOTPModel.result?.image.toString() ?? "");
        sharePref.save("email",
            generalProvider.loginOTPModel.result?.email.toString() ?? "");
        sharePref.save("mobile",
            generalProvider.loginOTPModel.result?.mobile.toString() ?? "");
        sharePref.save("usertype",
            generalProvider.loginOTPModel.result?.type.toString() ?? "");

        // Set UserID for Next
        Constant.userID =
            generalProvider.loginOTPModel.result?.id.toString() ?? "0";
        log('Constant userID ==>> ${Constant.userID}');

        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Bottombar(),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        Utils.showSnackbar(
            context, "loginFail", "${generalProvider.loginOTPModel.message}");
      }
    }
  }
}
