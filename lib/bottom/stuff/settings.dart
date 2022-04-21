import 'package:flutter/material.dart';
import 'package:primevideo/component/settingstext.dart';
import 'package:primevideo/component/smalltext.dart';
import 'package:primevideo/component/textfield.dart';
import 'package:primevideo/utils/colors.dart';

class SettingsUI extends StatefulWidget {
  const SettingsUI({Key? key}) : super(key: key);

  @override
  State<SettingsUI> createState() => _SettingsUIState();
}

class _SettingsUIState extends State<SettingsUI> {
  bool isSwitched1 = false;
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.1,
            child: const Center(
              child: Text(
                "Settings",
                style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.86,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SettingUIText("Account details"),
                    const SizedBox(
                      height: 07,
                    ),
                    SmallText("Manage your profile"),
                    divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SettingUIText("Change password"),
                            const SizedBox(
                              height: 07,
                            ),
                            SmallText("Update your password"),
                          ],
                        ),
                        Column(
                          children: [
                            show
                                ? InkWell(
                                    onTap: () {
                                      setState(() {
                                        show = false;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.keyboard_arrow_up_outlined,
                                      color: greyColor,
                                    ),
                                  )
                                : InkWell(
                                    onTap: () {
                                      setState(() {
                                        show = true;
                                      });
                                    },
                                    child: const Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: greyColor,
                                    ),
                                  )
                          ],
                        )
                      ],
                    ),
                    show
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.35,
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 05,
                                ),
                                TextFieldUI("Current password"),
                                TextFieldUI("New password"),
                                TextFieldUI("Confirm password"),
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 07, right: 25),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.5,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(07),
                                            border:
                                                Border.all(color: greyColor)),
                                        child: Center(
                                          child: TextButton(
                                              onPressed: () {},
                                              child: const Text(
                                                "CHANGE PASSWORD",
                                                style: TextStyle(
                                                    color: bluetext,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                        : const SizedBox(),
                    divider(),
                    SettingUIText("Language"),
                    const SizedBox(
                      height: 07,
                    ),
                    SmallText("English"),
                    divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SettingUIText("Notifications"),
                            const SizedBox(
                              height: 07,
                            ),
                            SmallText("Receive notifications"),
                          ],
                        ),
                        Column(
                          children: [
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
                        )
                      ],
                    ),
                    divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SettingUIText("Clear cache"),
                            const SizedBox(
                              height: 07,
                            ),
                            SmallText("Clear locally cached data"),
                          ],
                        ),
                        Column(
                          children: const [],
                        )
                      ],
                    ),
                    divider(),
                    SettingUIText("Clear video search history"),
                    divider(),
                    SettingUIText("Signed in as"),
                    const SizedBox(
                      height: 07,
                    ),
                    SmallText("Sign out"),
                    divider(),
                    SettingUIText("Rate us"),
                    const SizedBox(
                      height: 07,
                    ),
                    SmallText("Rate our app on appstore"),
                    divider(),
                    SettingUIText("Share app"),
                    const SizedBox(
                      height: 7,
                    ),
                    SmallText("Share app with your friends"),
                    divider(),
                    SettingUIText("About us"),
                    divider(),
                    SettingUIText("Privacy pollicy"),
                    divider(),
                    SettingUIText("Terms & Conditions"),
                    divider(),
                  ],
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  divider() {
    return const Padding(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      child: Divider(
        color: textColor,
      ),
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
