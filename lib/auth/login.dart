import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevideo/auth/otpscreen.dart';
import 'package:primevideo/utils/colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: appBgColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
            child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.091,
              ),
              Container(
                width: 100,
                height: 100,
                color: Colors.white,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.054,
              ),
              Text(
                "Welcome back,",
                style: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              SizedBox(
                height: 04,
              ),
              Text(
                "Enter your mobile number to login",
                style: TextStyle(
                    fontFamily: 'Popins   ', fontSize: 16, color: blueGrey500),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.052,
              ),
              textfield(context),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.028,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.83,
                height: MediaQuery.of(context).size.height * 0.07,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    gradient: LinearGradient(
                      colors: gradiant,
                      end: Alignment.centerRight,
                      begin: Alignment.centerLeft,
                    ),
                    color: Colors.blue),
                child: TextButton(
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => OTPScreen()));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontFamily: 'RubikMedium',
                        color: textColor,
                        fontSize: 18,
                      ),
                    )),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 35.0, right: 15.0),
                        child: Divider(
                          color: Color(0xff999999),
                        )),
                  ),
                  Text(
                    "Or",
                    style: TextStyle(
                        fontFamily: 'Popins',
                        fontSize: 14,
                        color: Color(0xff999999)),
                  ),
                  Expanded(
                    child: Container(
                        margin: const EdgeInsets.only(left: 15.0, right: 35.0),
                        child: Divider(
                          color: Color(0xff999999),
                        )),
                  ),
                ],
              ),
              SizedBox(
                height: 17,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.83,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffF4F4F4)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Image.asset(
                          'assets/images/google.png',
                          width: 23,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Text("Login with Google",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () async {},
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.83,
                    height: MediaQuery.of(context).size.height * 0.07,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Color(0xffF4F4F4)),
                    child: Row(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Image.asset(
                          'assets/images/fb_logo.png',
                          width: 11,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.12,
                        ),
                        Text(
                          "Login with Facebook",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )),
      ),
    );
  }

  Container textfield(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.08,
        child: TextField(
          //controller: phoneController,
          autocorrect: true,
          style: TextStyle(color: textColor),
          keyboardType: TextInputType.phone,
          decoration: InputDecoration(
            hintText: 'Enter Your mobile number',
            hintStyle: TextStyle(color: Colors.grey),
            filled: true,
            fillColor: btnPrimaryblue,
            prefixText: "+91   ",
            prefixStyle: TextStyle(color: textColor),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: borderColor, width: 1),
            ),
          ),
        ));
  }
}
