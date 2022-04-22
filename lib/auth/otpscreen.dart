import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:primevideo/utils/colors.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  int start = 59;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SafeArea(
            child: Column(
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    height: MediaQuery.of(context).size.height * 0.1,
                    child: Image.asset(
                      'assets/images/back.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              "Verify Phone Number",
              style: TextStyle(
                  fontSize: 26, color: textColor, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "We have sent code to your number",
              style: TextStyle(fontSize: 16, color: blueGreyColor),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              "+916354856324",
              style: TextStyle(fontSize: 16, color: blueGreyColor),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.039,
            ),
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 50,
              fieldStyle: FieldStyle.box,
              otpFieldStyle: OtpFieldStyle(
                  backgroundColor: btnPrimaryblue, borderColor: textColor),
              outlineBorderRadius: 15,
              style: TextStyle(fontSize: 15, color: textColor),
              onChanged: (pin) {
                print("Changed: " + pin);
              },
              onCompleted: (pin) {
                // print("Completed: " + pin);
                // otpcontroller.text = pin;
                // setState(() {
                //   smscode = pin;
                // });
              },
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.020,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Code expire soon : ',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: blueGreyColor, fontSize: 14),
                ),
                Text(
                  "$start",
                  style: TextStyle(color: textColor, fontSize: 14),
                )
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.030,
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
                    "Confirm",
                    style: TextStyle(
                      fontFamily: 'RubikMedium',
                      color: textColor,
                      fontSize: 18,
                    ),
                  )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.031,
            ),
            TextButton(
                onPressed: () {},
                child: Text(
                  "Resend",
                  style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ))
          ],
        )),
      ),
    );
  }
}
