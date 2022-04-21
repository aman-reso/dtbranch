import 'package:flutter/material.dart';
import 'package:primevideo/utils/colors.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
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
            const Text("Edit Profile",
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
                    children: [
                      const Text(
                        "Remove profile",
                        style: TextStyle(color: textColor, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 05,
                      ),
                      Text(
                        "The account holder's profile can't be removed",
                        style: TextStyle(color: blueGrey300),
                      )
                    ],
                  ),
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
}
