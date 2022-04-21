import 'package:flutter/material.dart';

import 'package:primevideo/bottom/channels/channels.dart';
import 'package:primevideo/bottom/downloads/downloads.dart';
import 'package:primevideo/bottom/find/search.dart';
import 'package:primevideo/bottom/home/home.dart';
import 'package:primevideo/bottom/stuff/profile.dart';
import 'package:primevideo/utils/colors.dart';

class BottomBarUI extends StatefulWidget {
  const BottomBarUI({Key? key}) : super(key: key);

  @override
  State<BottomBarUI> createState() => _BottomBarUIState();
}

class _BottomBarUIState extends State<BottomBarUI> {
  int tabindex = 0;

  static const List<Widget> tabs = [
    HomePage(),
    ChannelsPage(),
    SearchPage(),
    DownloadPage(),
    ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: tabs.elementAt(tabindex),
      bottomNavigationBar: bottombar(),
    );
  }

  bottombar() {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: blackColor,
          primaryColor: textColor,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: const TextStyle(color: greyColor))),
      child: BottomNavigationBar(
        backgroundColor: blackColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_align_right_outlined),
            label: 'Channels',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Find',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.get_app_sharp),
            label: 'Downloads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: 'My Stuff',
          ),
        ],
        unselectedItemColor: greyColor,
        unselectedLabelStyle: const TextStyle(color: greyColor),
        onTap: _onItemTapped,
        currentIndex: tabindex,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      tabindex = index;
    });
  }
}
