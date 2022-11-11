import 'package:dtlive/pages/channels.dart';
import 'package:dtlive/pages/home.dart';
import 'package:dtlive/pages/search.dart';
import 'package:dtlive/pages/setting.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({Key? key}) : super(key: key);

  @override
  State<Bottombar> createState() => BottombarState();
}

class BottombarState extends State<Bottombar> {
  int selectedIndex = 0;

  static List<Widget> widgetOptions = <Widget>[
    const Home(),
    const Search(),
    const Channels(),
    // const Store(),
    const Setting(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetOptions.elementAt(selectedIndex),
      ),
      bottomNavigationBar: Container(
        height: 70,
        alignment: Alignment.center,
        color: black,
        child: BottomNavigationBar(
          backgroundColor: black,
          selectedLabelStyle: GoogleFonts.inter(
            fontSize: 10,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 10,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: primaryColor,
          ),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 5,
          currentIndex: selectedIndex,
          unselectedItemColor: gray,
          selectedItemColor: primaryColor,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              backgroundColor: black,
              label: bottomView1,
              activeIcon: Padding(
                padding: const EdgeInsets.all(7),
                child: Image.asset(
                  "assets/images/ic_home.png",
                  width: 22,
                  height: 22,
                  color: primaryColor,
                ),
              ),
              icon: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Image.asset(
                    "assets/images/ic_home.png",
                    width: 22,
                    height: 22,
                    color: gray,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: black,
              label: bottomView2,
              activeIcon: Padding(
                padding: const EdgeInsets.all(7),
                child: Image.asset(
                  "assets/images/ic_find.png",
                  width: 22,
                  height: 22,
                  color: primaryColor,
                ),
              ),
              icon: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Image.asset(
                    "assets/images/ic_find.png",
                    width: 22,
                    height: 22,
                    color: gray,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: black,
              label: bottomView3,
              activeIcon: Padding(
                padding: const EdgeInsets.all(7),
                child: Image.asset(
                  "assets/images/ic_channels.png",
                  width: 22,
                  height: 22,
                  color: primaryColor,
                ),
              ),
              icon: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Image.asset(
                    "assets/images/ic_channels.png",
                    width: 22,
                    height: 22,
                    color: gray,
                  ),
                ),
              ),
            ),
            // BottomNavigationBarItem(
            //   backgroundColor: black,
            //   label: bottomView4,
            //   activeIcon: Padding(
            //     padding: const EdgeInsets.all(7),
            //     child: Image.asset(
            //       "assets/images/ic_store.png",
            //       width: 22,
            //       height: 22,
            //       color: primaryColor,
            //     ),
            //   ),
            //   icon: Align(
            //     alignment: Alignment.center,
            //     child: Padding(
            //       padding: const EdgeInsets.all(7),
            //       child: Image.asset(
            //         "assets/images/ic_store.png",
            //         width: 22,
            //         height: 22,
            //         color: gray,
            //       ),
            //     ),
            //   ),
            // ),
            BottomNavigationBarItem(
              backgroundColor: black,
              label: bottomView5,
              activeIcon: Padding(
                padding: const EdgeInsets.all(7),
                child: Image.asset(
                  "assets/images/ic_setting.png",
                  width: 22,
                  height: 22,
                  color: primaryColor,
                ),
              ),
              icon: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Image.asset(
                    "assets/images/ic_setting.png",
                    width: 22,
                    height: 22,
                    color: gray,
                  ),
                ),
              ),
            ),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
