import 'package:flutter/material.dart';
import 'package:primevideo/bottom/stuff/createprofilepage.dart';
import 'package:primevideo/bottom/stuff/learnmore.dart';
import 'package:primevideo/bottom/stuff/manage_profile.dart';
import 'package:primevideo/bottom/stuff/settings.dart';
import 'package:primevideo/utils/colors.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool show = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
            Positioned(
              top: 0,
              child: appbar(context),
            ),
            Positioned(
              bottom: 0,
              child: videolistbild(context),
            ),
            show
                ? Positioned(top: 70, child: profiledetails(context))
                : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Padding appbar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 10),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height * 0.06,
            child: InkWell(
              onTap: () {
                if (show == false) {
                  setState(() {
                    show = true;
                  });
                } else {
                  setState(() {
                    show = false;
                  });
                }
              },
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundColor: textColor,
                  ),
                  const SizedBox(width: 10),
                  const Text(
                    "Anand",
                    style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 18),
                  ),
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
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.115,
            height: MediaQuery.of(context).size.height * 0.06,
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsUI()));
              },
              child: const Icon(
                Icons.settings,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container profiledetails(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.4,
      color: const Color(0xff0e171e),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Row(
              children: const [
                SizedBox(
                    width: 30,
                    height: 30,
                    child: CircleAvatar(backgroundColor: textColor)),
                SizedBox(
                  width: 10,
                ),
                Text("Chirag",
                    style: TextStyle(
                        color: textColor, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: Row(
              children: const [
                SizedBox(
                    width: 30,
                    height: 30,
                    child: CircleAvatar(backgroundColor: textColor)),
                SizedBox(
                  width: 10,
                ),
                Text("Kids",
                    style: TextStyle(
                        color: textColor, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(
            color: textColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CreateProfile()));
              },
              child: Row(
                children: const [
                  Icon(Icons.add, color: greyColor, size: 35),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Create profile",
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ManageProfile()));
              },
              child: Row(
                children: const [
                  Icon(Icons.create_outlined, color: greyColor, size: 35),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Manage profile",
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10),
            child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LearnMore()));
              },
              child: Row(
                children: const [
                  Icon(Icons.info, color: greyColor, size: 35),
                  SizedBox(
                    width: 10,
                  ),
                  Text("Learn more about profile",
                      style: TextStyle(
                          color: textColor, fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox videolistbild(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.75,
      child: Column(
        children: [
          const Text(
            "Watchlist",
            style: TextStyle(color: textColor, fontSize: 18),
          ),
          const Divider(
            color: textColor,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "5 videos",
                  style: TextStyle(
                    color: blueGrey500,
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.15,
                  height: MediaQuery.of(context).size.height * 0.05,
                  decoration: BoxDecoration(
                      color: blueGrey500,
                      borderRadius: BorderRadius.circular(03)),
                  child: const Center(
                    child: Text(
                      "Filter",
                      style: TextStyle(color: textColor),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.63,
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(top: 05),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.14,
                    color: blueGrey900,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.4,
                              height: MediaQuery.of(context).size.height * 0.14,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/kgf.jpg'),
                                      fit: BoxFit.fill)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Spacer(),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.play_circle_outlined,
                                        color: textColor,
                                        size: 35,
                                      )),
                                  Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.5,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.007,
                                      decoration: const BoxDecoration(
                                          borderRadius: BorderRadius.only(
                                              bottomLeft: Radius.circular(05),
                                              bottomRight:
                                                  Radius.circular(05))),
                                      child: const LinearProgressIndicator(
                                        value: 0.5,
                                        backgroundColor: blackColor,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                                lightBlue),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "The Family Man",
                                style: TextStyle(
                                    color: textColor,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 05,
                              ),
                              Row(
                                children: [
                                  text("2021"),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  text("50  mmmin")
                                ],
                              ),
                              const SizedBox(
                                height: 05,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.45,
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "prime",
                                          style: TextStyle(
                                              color: bluetext,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                  listIcon(
                                    Icons.more_vert_rounded,
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  text(text) {
    return Text(
      text,
      style: TextStyle(
        color: blueGrey500,
      ),
    );
  }

  listIcon(icon) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Icon(
        icon,
        color: greyColor,
        size: 30,
      ),
    );
  }
}
