import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
                    color: Colors.white,
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
                  style: TextStyle(color: Colors.grey, fontSize: 17),
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
                      Text(
                        "Kid's profile?",
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      SizedBox(
                        height: 05,
                      ),
                      Text(
                        "Learn more",
                        style: TextStyle(color: Colors.blue),
                      )
                    ],
                  ),
                  Transform.scale(
                      scale: 1,
                      child: Switch(
                        onChanged: toggleSwitch1,
                        value: isSwitched1,
                        activeColor: Colors.blue,
                        activeTrackColor: Colors.blue[200],
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.blueGrey,
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
                  color: Color(0xff0e1c29),
                  borderRadius: BorderRadius.circular(05)),
              child: Center(
                child: Text(
                  "Save",
                  style: TextStyle(color: Colors.blueGrey[600], fontSize: 17),
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
          style: const TextStyle(color: Colors.black),
          onEditingComplete: () {},
          decoration: const InputDecoration(
            hintText: "Enter Name",
            hintStyle:
                TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            filled: true,
            fillColor: Colors.white,
            disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(07),
                ),
                borderSide: BorderSide(color: Colors.yellow, width: 2)),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(07.0)),
              borderSide: BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(07)),
              borderSide: BorderSide(color: Colors.grey, width: 1),
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
