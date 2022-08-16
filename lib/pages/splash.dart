import 'package:dtlive/pages/bottombar.dart';
import 'package:dtlive/pages/intro.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/myimage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {
 
  @override
  Widget build(BuildContext context) {
     checkappFirsttime();
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        color: primary,
        child: MyImage(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            imagePath: "ic_appicon.png"),
      ),
    );
  }

  Future checkappFirsttime() async {
    int splashtime = 3;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool seen = (prefs.getBool('seen') ?? false);
    debugPrint("boolian Main statement is : $seen");

    if (seen) {
      debugPrint("Boolian statement if Condition : $seen");
      Future.delayed(
        Duration(seconds: splashtime),
        () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const Bottombar();
              },
            ),
          );
        },
      );
    } else {
      debugPrint("Boolian statement Else Condition : $seen");
      Future.delayed(
        Duration(seconds: splashtime),
        () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const Intro();
              },
            ),
          );
        },
      );
    }
  }
}
