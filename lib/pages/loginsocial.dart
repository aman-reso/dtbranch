// ignore_for_file: use_build_context_synchronously
import 'dart:developer';

import 'package:dtlive/pages/bottombar.dart';
import 'package:dtlive/pages/otpverify.dart';
import 'package:dtlive/provider/generalprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert' show json;
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';

GoogleSignIn _googleSignIn = GoogleSignIn(
  // clientId:
  //     '346606981660-juds0qd8k9p651md7gv38bd1bn9jq66v.apps.googleusercontent.com',
  serverClientId: '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',
  scopes: <String>[
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ],
);

class LoginSocial extends StatefulWidget {
  const LoginSocial({Key? key}) : super(key: key);

  @override
  State<LoginSocial> createState() => LoginSocialState();
}

class LoginSocialState extends State<LoginSocial> {
  late ProgressDialog prDialog;
  SharedPre sharePref = SharedPre();
  final numberController = TextEditingController();
  GoogleSignInAccount? _currentUser;
  String? mobileNumber, email, userName;

  @override
  void initState() {
    super.initState();
    prDialog = ProgressDialog(context);
    _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
      setState(() {
        _currentUser = account;
      });
      if (_currentUser != null) {
        _handleGetContact(_currentUser!);
      }
    });
    _googleSignIn.signInSilently();
  }

  @override
  void dispose() {
    numberController.dispose();
    super.dispose();
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    final http.Response response = await http.get(
      Uri.parse(
          'https://people.googleapis.com/v1/people/me/connections?requestMask.includeField=person.names'),
      headers: await user.authHeaders,
    );
    if (response.statusCode != 200) {
      log('People API ${response.statusCode} response: ${response.body}');
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;
    final String? namedContact = _pickFirstNamedContact(data);
    if (namedContact != null) {
      log('I see you know $namedContact!');
    } else {
      log('No contacts to display.');
    }
  }

  String? _pickFirstNamedContact(Map<String, dynamic> data) {
    final List<dynamic>? connections = data['connections'] as List<dynamic>?;
    final Map<String, dynamic>? contact = connections?.firstWhere(
      (dynamic contact) => contact['names'] != null,
      orElse: () => null,
    ) as Map<String, dynamic>?;
    if (contact != null) {
      final Map<String, dynamic>? name = contact['names'].firstWhere(
        (dynamic name) => name['displayName'] != null,
        orElse: () => null,
      ) as Map<String, dynamic>?;
      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleSignIn() async {
    final GoogleSignInAccount? user = _currentUser;
    try {
      await _googleSignIn.signIn();
      if (user != null) {
        log("_handleSignIn displayName ====> ${user.displayName}");
        log("_handleSignIn email ====> ${user.email}");
        email = user.email.toString();
        userName = user.displayName.toString();
        checkAndNavigate();
      }
    } catch (error) {
      log("_handleSignIn error ====> $error");
      prDialog.hide();
    }
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
                fontsize: 25,
                multilanguage: true,
                fontwaight: FontWeight.bold,
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
                text: "enter_mobileNumberytologin",
                fontsize: 15,
                multilanguage: true,
                fontwaight: FontWeight.normal,
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
                  dropdownTextStyle: GoogleFonts.inter(
                    color: white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    filled: false,
                    hintStyle: GoogleFonts.inter(
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
                        context, "TextField", enterYourMobileNumber);
                  } else {
                    log("mobileNumber ==> $mobileNumber");
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => OTPVerify(mobileNumber ?? ""),
                      ),
                    );
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
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: MyText(
                    color: white,
                    text: "login",
                    multilanguage: true,
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
                    fontsize: 14,
                    fontwaight: FontWeight.normal,
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
                  _handleSignIn();
                },
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
                        fontsize: 14,
                        multilanguage: true,
                        fontwaight: FontWeight.w600,
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

  void checkAndNavigate() async {
    log('checkAndNavigate email ==>> $email');
    log('checkAndNavigate userName ==>> $userName');
    Utils.showProgress(context, prDialog);
    final generalProvider =
        Provider.of<GeneralProvider>(context, listen: false);
    await generalProvider.loginWithSocial(email, userName, '2');
    log('checkAndNavigate loading ==>> ${generalProvider.loading}');
    if (!generalProvider.loading) {
      // Hide Progress Dialog
      prDialog.hide();

      if (generalProvider.loginGmailModel.status == 200) {
        log('loginGmailModel ==>> ${generalProvider.loginGmailModel.toString()}');
        log('Login Successfull!');
        sharePref.save("userid",
            generalProvider.loginGmailModel.result?.id.toString() ?? "0");
        sharePref.save("username",
            generalProvider.loginGmailModel.result?.name.toString() ?? "");
        sharePref.save("userimage",
            generalProvider.loginGmailModel.result?.image.toString() ?? "");
        sharePref.save("email",
            generalProvider.loginGmailModel.result?.email.toString() ?? "");
        sharePref.save("mobile",
            generalProvider.loginGmailModel.result?.mobile.toString() ?? "");
        sharePref.save("usertype",
            generalProvider.loginGmailModel.result?.type.toString() ?? "");

        // Set UserID for Next
        Constant.userID =
            generalProvider.loginGmailModel.result?.id.toString() ?? "0";
        log('Constant userID ==>> ${Constant.userID}');

        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Bottombar(),
          ),
        );
      } else {
        Utils.showSnackbar(
            context, "fail", "${generalProvider.loginGmailModel.message}");
      }
    }
  }
}
