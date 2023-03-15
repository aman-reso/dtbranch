import 'dart:developer';

import 'package:dtlive/pages/bottombar.dart';
import 'package:dtlive/pages/home.dart';
import 'package:dtlive/pages/intro.dart';
import 'package:dtlive/provider/generalprovider.dart';
import 'package:dtlive/provider/homeprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => SplashState();
}

class SplashState extends State<Splash> {
  String? seen, userID, generalSettingDate;
  SharedPre sharedPre = SharedPre();

  @override
  void initState() {
    _getData();
    final generalsetting = Provider.of<GeneralProvider>(context, listen: false);
    generalsetting.getGeneralsetting(context);
    super.initState();
  }

  void _getData() async {
    final generalsetting = Provider.of<GeneralProvider>(context, listen: false);
    generalSettingDate = await sharedPre.read('gsDate');
    debugPrint('generalSettingDate ==> $generalSettingDate');
    debugPrint('DateTime now ==> ${DateTime.now().day}');

    if (generalSettingDate != null) {
      log('comparision ==========> ${DateTime.parse(generalSettingDate ?? "").day < (DateTime.now().day)}');
      if (DateTime.parse(generalSettingDate ?? "").day < (DateTime.now().day)) {
        /* Update GeneralSetting call Date */
        await sharedPre.save('gsDate', DateTime.now().toString());
        if (!mounted) return;
        await generalsetting.getGeneralsetting(context);
      }
    } else {
      /* Update GeneralSetting call Date */
      await sharedPre.save('gsDate', DateTime.now().toString());
      if (!mounted) return;
      await generalsetting.getGeneralsetting(context);
    }

    isFirstCheck();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.center,
        color: appBgColor,
        child: MyImage(
          imagePath: (kIsWeb || Constant.isTV) ? "appicon.png" : "splash.png",
          fit: (kIsWeb || Constant.isTV) ? BoxFit.contain : BoxFit.cover,
        ),
      ),
    );
  }

  Future<void> isFirstCheck() async {
    final generalsettingData =
        Provider.of<GeneralProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    await homeProvider.setLoading(true);

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
    }
    await Future.delayed(const Duration(seconds: 1));

    seen = await sharedPre.read('seen') ?? "0";
    Constant.userID = await sharedPre.read('userid');
    log('seen ==> $seen');
    log('Constant userID ==> ${Constant.userID}');
    if (!mounted) return;
    if (kIsWeb || Constant.isTV) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const Home(pageName: "");
          },
        ),
      );
    } else {
      if (seen == "1") {
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
              return const Intro();
            },
          ),
        );
      }
    }
  }
}
