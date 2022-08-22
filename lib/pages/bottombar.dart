import 'package:dtlive/bottombar/channels.dart';
import 'package:dtlive/bottombar/find.dart';
import 'package:dtlive/bottombar/home.dart';
import 'package:dtlive/bottombar/mystuff.dart';
import 'package:dtlive/bottombar/store.dart';
import 'package:dtlive/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Bottombar extends StatefulWidget {
  const Bottombar({Key? key}) : super(key: key);

  @override
  State<Bottombar> createState() => BottombarState();
}

class BottombarState extends State<Bottombar> {
  int selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<Widget> widgetOptions = <Widget>[
    const Home(),
    const Find(),
    const Channels(),
    const Store(),
    const MyStuff(),
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
        color: primary,
        child: BottomNavigationBar(
          backgroundColor: primary,
          selectedLabelStyle: GoogleFonts.inter(
            fontSize: 10,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: bottomnavigationText,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 10,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w500,
            color: primary,
          ),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          elevation: 5,
          currentIndex: selectedIndex,
          unselectedItemColor: white,
          selectedItemColor: bottomnavigationText,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              backgroundColor: primary,
              label: "Home",
              activeIcon: Padding(
                padding: const EdgeInsets.all(7),
                child: Image.asset(
                  "assets/images/ic_home.png",
                  width: 22,
                  height: 22,
                  color: bottomnavigationText,
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
                    color: white,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: primary,
              label: "Find",
              activeIcon: Padding(
                padding: const EdgeInsets.all(7),
                child: Image.asset(
                  "assets/images/ic_find.png",
                  width: 22,
                  height: 22,
                  color: bottomnavigationText,
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
                    color: white,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: primary,
              label: "Channels",
              activeIcon: Padding(
                padding: const EdgeInsets.all(7),
                child: Image.asset(
                  "assets/images/ic_channels.png",
                  width: 22,
                  height: 22,
                  color: bottomnavigationText,
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
                    color: white,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: primary,
              label: "Store",
              activeIcon: Padding(
                padding: const EdgeInsets.all(7),
                child: Image.asset(
                  "assets/images/ic_store.png",
                  width: 22,
                  height: 22,
                  color: bottomnavigationText,
                ),
              ),
              icon: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Image.asset(
                    "assets/images/ic_store.png",
                    width: 22,
                    height: 22,
                    color: white,
                  ),
                ),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: primary,
              label: "My Stuff",
              activeIcon: Padding(
                padding: const EdgeInsets.all(7),
                child: Image.asset(
                  "assets/images/ic_mystuff.png",
                  width: 22,
                  height: 22,
                  color: bottomnavigationText,
                ),
              ),
              icon: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Image.asset(
                    "assets/images/ic_mystuff.png",
                    width: 22,
                    height: 22,
                    color: white,
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
