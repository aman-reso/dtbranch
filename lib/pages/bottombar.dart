import 'package:dtlive/bottombar/channels.dart';
import 'package:dtlive/bottombar/find.dart';
import 'package:dtlive/bottombar/home.dart';
import 'package:dtlive/bottombar/mystuff.dart';
import 'package:dtlive/bottombar/store.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/myimage.dart';
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
      bottomNavigationBar: SizedBox(
        height: 75,
        child: BottomNavigationBar(
          backgroundColor: primary,
          selectedLabelStyle: GoogleFonts.inter(
            fontSize: 10,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            color: bottomnavigationText,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 10,
            fontStyle: FontStyle.normal,
            fontWeight: FontWeight.w600,
            color: white,
          ),
          selectedFontSize: 12,
          unselectedFontSize: 12,
          selectedIconTheme: const IconThemeData(color: bottomnavigationText),
          unselectedIconTheme: const IconThemeData(color: white),
          elevation: 0,
          currentIndex: selectedIndex,
          selectedItemColor: white,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              backgroundColor: primary,
              label: "Home",
              activeIcon: Image.asset(
                "assets/images/ic_home.png",
                width: 25,
                height: 25,
                color: bottomnavigationText,
              ),
              icon: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/ic_home.png",
                  width: 25,
                  height: 25,
                  color: white,
                ),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: primary,
              label: "Find",
              activeIcon: Image.asset(
                "assets/images/ic_find.png",
                width: 25,
                height: 25,
                color: bottomnavigationText,
              ),
              icon: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/ic_find.png",
                  width: 25,
                  height: 25,
                  color: white,
                ),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: primary,
              label: "Channels",
              activeIcon: Image.asset(
                "assets/images/ic_channels.png",
                width: 25,
                height: 25,
                color: bottomnavigationText,
              ),
              icon: Align(
                alignment: Alignment.topCenter,
                child: Image.asset(
                  "assets/images/ic_channels.png",
                  width: 25,
                  height: 25,
                  color: white,
                ),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: primary,
              label: "Store",
              activeIcon: Image.asset(
                "assets/images/ic_store.png",
                width: 25,
                height: 25,
                color: bottomnavigationText,
              ),
              icon: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/ic_store.png",
                  width: 25,
                  height: 25,
                  color: white,
                ),
              ),
            ),
            BottomNavigationBarItem(
              backgroundColor: primary,
              label: "My Stuff",
              activeIcon: Image.asset(
                "assets/images/ic_mystuff.png",
                width: 25,
                height: 25,
                color: bottomnavigationText,
              ),
              icon: Align(
                alignment: Alignment.center,
                child: Image.asset(
                  "assets/images/ic_mystuff.png",
                  width: 25,
                  height: 25,
                  color: white,
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
