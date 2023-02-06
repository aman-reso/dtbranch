import 'dart:developer';

import 'package:dtlive/pages/bottombar.dart';
import 'package:dtlive/pages/intro.dart';
import 'package:dtlive/provider/generalprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {
  String? seen, userID;
  SharedPre sharedPre = SharedPre();

  @override
  void initState() {
    final generalsetting = Provider.of<GeneralProvider>(context, listen: false);
    generalsetting.getGeneralsetting(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isFirstCheck();

    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        color: appBgColor,
        child: MyImage(
          imagePath: "splash.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> isFirstCheck() async {
    final generalsettingData = Provider.of<GeneralProvider>(context);

    log('Is generalsettingData loading...? ==> ${generalsettingData.loading}');
    if (!generalsettingData.loading) {
      log('generalSettingData status ==> ${generalsettingData.generalSettingModel.status}');
      for (var i = 0;
          i < (generalsettingData.generalSettingModel.result?.length ?? 0);
          i++) {
        await sharedPre.save(
          generalsettingData.generalSettingModel.result?[i].key.toString() ??
              "",
          generalsettingData.generalSettingModel.result?[i].value.toString() ??
              "",
        );
        log('${generalsettingData.generalSettingModel.result?[i].key.toString()} ==> ${generalsettingData.generalSettingModel.result?[i].value.toString()}');
      }

      seen = await sharedPre.read('seen') ?? "0";
      Constant.userID = await sharedPre.read('userid') ?? "0";
      log('seen ==> $seen');
      log('Constant userID ==> ${Constant.userID}');
      if (!mounted) return;
      if (seen == "1") {
        if (Constant.userID != "0") {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const Bottombar();
              },
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const Bottombar();
              },
            ),
          );
        }
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const Intro();
            },
          ),
        );
      }
    }
  }
}
