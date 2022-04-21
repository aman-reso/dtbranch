import 'package:flutter/material.dart';
import 'package:primevideo/utils/colors.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  bool isSwitched1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0e171e),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            const Text("New",
                style: TextStyle(
                    fontSize: 17,
                    color: textColor,
                    fontWeight: FontWeight.w700)),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.04,
            ),
            CircleAvatar(
              radius: 45,
              child: Image.asset('assets/images/profile.png'),
            ),
            TextButton(
                onPressed: () {},
                child: const Text(
                  "Change",
                  style: TextStyle(color: greyColor, fontSize: 17),
                )),
            textfiledbuild(context),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.065,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Kid's profile?",
                        style: TextStyle(color: textColor, fontSize: 15),
                      ),
                      SizedBox(
                        height: 05,
                      ),
                      Text(
                        "Learn more",
                        style: TextStyle(color: bluetext),
                      )
                    ],
                  ),
                  Transform.scale(
                      scale: 1,
                      child: Switch(
                        onChanged: toggleSwitch1,
                        value: isSwitched1,
                        activeColor: bluetext,
                        activeTrackColor: blueColor200,
                        inactiveThumbColor: greyColor,
                        inactiveTrackColor: blueGreyColor,
                      )),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.85,
              height: MediaQuery.of(context).size.height * 0.065,
              decoration: BoxDecoration(
                  color: btnPrimaryblue,
                  borderRadius: BorderRadius.circular(05)),
              child: Center(
                child: Text(
                  "Save",
                  style: TextStyle(color: blueGrey600, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }

  SizedBox textfiledbuild(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      height: MediaQuery.of(context).size.height * 0.065,
      child: TextField(
          style: const TextStyle(color: blackColor),
          onEditingComplete: () {},
          decoration: const InputDecoration(
            hintText: "Enter Name",
            hintStyle: TextStyle(color: greyColor, fontWeight: FontWeight.bold),
            filled: true,
            fillColor: textColor,
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(07),
                ),
                borderSide: BorderSide(color: yellowColor, width: 2)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(07.0)),
              borderSide: BorderSide(color: greyColor, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(07)),
              borderSide: BorderSide(color: greyColor, width: 1),
            ),
          )),
    );
  }

  void toggleSwitch1(bool value) {
    if (isSwitched1 == false) {
      setState(() {
        isSwitched1 = true;
      });
      print('Switch Button is ON');
    } else {
      setState(() {
        isSwitched1 = false;
      });
      print('Switch Button is OFF');
    }
  }
}
