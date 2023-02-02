import 'dart:developer';

import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
// ignore: depend_on_referenced_packages
import 'package:html/parser.dart' show parse;
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';

class Utils {
  showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: white,
      textColor: black,
      fontSize: 16,
    );
  }

  static void getUserId() async {
    SharedPre sharedPref = SharedPre();
    Constant.userID = await sharedPref.read("userid") ?? "";
    log('Constant userID ==> ${Constant.userID}');
  }

  static void getCurrencySymbol() async {
    SharedPre sharedPref = SharedPre();
    Constant.currencySymbol = await sharedPref.read("currency_code") ?? "";
    log('Constant currencySymbol ==> ${Constant.currencySymbol}');
  }

  static setUserId(userID) async {
    SharedPre sharedPref = SharedPre();
    await sharedPref.save("userid", userID ?? "0");
    Constant.userID = await sharedPref.read("userid");
    log('setUserId userID ==> ${Constant.userID}');
  }

  static setFirstTime(value) async {
    SharedPre sharedPref = SharedPre();
    await sharedPref.save("seen", value);
    String seenValue = await sharedPref.read("seen");
    log('setFirstTime seen ==> $seenValue');
  }

  static Future<void> deleteCacheDir() async {
    var tempDir = await getTemporaryDirectory();

    if (tempDir.existsSync()) {
      tempDir.deleteSync(recursive: true);
    }
  }

  static BoxDecoration textFieldBGWithBorder() {
    return BoxDecoration(
      color: white,
      border: Border.all(
        color: otherColor,
        width: .2,
      ),
      borderRadius: BorderRadius.circular(4),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration r4BGWithBorder() {
    return BoxDecoration(
      color: white,
      border: Border.all(
        color: otherColor,
        width: .5,
      ),
      borderRadius: BorderRadius.circular(4),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration r4DarkBGWithBorder() {
    return BoxDecoration(
      color: primaryDarkColor,
      border: Border.all(
        color: primaryDarkColor,
        width: .5,
      ),
      borderRadius: BorderRadius.circular(4),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration r10BGWithBorder() {
    return BoxDecoration(
      color: white,
      border: Border.all(
        color: otherColor,
        width: .5,
      ),
      borderRadius: BorderRadius.circular(10),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration setBackground(Color color, double radius) {
    return BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(radius),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration setBGWithBorder(
      Color color, double radius, double border) {
    return BoxDecoration(
      color: color,
      border: Border.all(
        color: otherColor,
        width: border,
      ),
      borderRadius: BorderRadius.circular(radius),
      shape: BoxShape.rectangle,
    );
  }

  static BoxDecoration primaryDarkButton() {
    return BoxDecoration(
      color: primaryDarkColor,
      borderRadius: BorderRadius.circular(4),
      shape: BoxShape.rectangle,
    );
  }

  static AppBar myAppBar(BuildContext context, String appBarTitle) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: appBgColor,
      centerTitle: true,
      title: MyText(
        color: primaryColor,
        text: appBarTitle,
        multilanguage: true,
        fontsize: 17,
        maxline: 1,
        overflow: TextOverflow.ellipsis,
        fontwaight: FontWeight.bold,
        textalign: TextAlign.center,
        fontstyle: FontStyle.normal,
      ),
    );
  }

  static AppBar myAppBarWithBack(BuildContext context, String appBarTitle) {
    return AppBar(
      elevation: 5,
      backgroundColor: appBgColor,
      centerTitle: true,
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: MyImage(
          imagePath: "back.png",
          fit: BoxFit.contain,
          height: 17,
          width: 17,
          color: white,
        ),
      ),
      title: MyText(
        text: appBarTitle,
        fontsize: 20,
        fontstyle: FontStyle.normal,
        fontwaight: FontWeight.w500,
        textalign: TextAlign.center,
        color: primaryColor,
      ),
    );
  }

  static Widget pageLoader() {
    return const Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: primaryColor,
      ),
    );
  }

  static void showSnackbar(
      BuildContext context, String showFor, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        backgroundColor: showFor == "WatchlistAdd"
            ? successBG
            : showFor == "WatchlistRemove"
                ? successBG
                : showFor == "fail"
                    ? failureBG
                    : showFor == "TextField"
                        ? infoBG
                        : showFor == "success"
                            ? successBG
                            : infoBG,
        content: MyText(
          text: message,
          fontsize: 14,
          multilanguage: true,
          fontstyle: FontStyle.normal,
          fontwaight: FontWeight.normal,
          color: white,
          textalign: TextAlign.center,
        ),
      ),
    );
  }

  static void showProgress(
      BuildContext context, ProgressDialog prDialog) async {
    prDialog = ProgressDialog(context);
    //For normal dialog
    prDialog = ProgressDialog(context,
        type: ProgressDialogType.normal, isDismissible: false, showLogs: false);

    prDialog.style(
      message: pleaseWait,
      borderRadius: 5,
      progressWidget: Container(
        padding: const EdgeInsets.all(8),
        child: const CircularProgressIndicator(),
      ),
      maxProgress: 100,
      progressTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 13,
        fontWeight: FontWeight.w400,
      ),
      backgroundColor: white,
      insetAnimCurve: Curves.easeInOut,
      messageTextStyle: const TextStyle(
        color: black,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    );

    await prDialog.show();
  }

  static String convertToColonText(int timeInMilli) {
    String convTime = "";

    try {
      log("timeInMilli ==> $timeInMilli");
      if (timeInMilli > 0) {
        int seconds = ((timeInMilli / 1000) % 60).round();
        int minutes = ((timeInMilli / (1000 * 60)) % 60).round();
        int hours = ((timeInMilli / (1000 * 60 * 60)) % 24).round();

        log("==>seconds : $seconds");
        log("==>minutes : $minutes");
        log("==>hours : $hours");

        if (hours > 0) {
          if (minutes > 0 && seconds > 0) {
            convTime = "$hours:$minutes:$seconds hr";
          } else if (minutes > 0 && seconds == 0) {
            convTime = "$hours:$minutes:00 hr";
          } else if (minutes == 0 && seconds > 0) {
            convTime = "$hours:00:$seconds hr";
          } else if (minutes == 0 && seconds == 0) {
            convTime = "$hours:00 hr";
          }
        } else if (minutes > 0) {
          if (seconds > 0) {
            convTime = "$minutes:$seconds min";
          } else if (minutes > 0 && seconds == 0) {
            convTime = "$minutes:00 min";
          }
        } else if (seconds > 0) {
          convTime = "00:$seconds sec";
        }
      } else {
        convTime = "0";
      }
    } catch (e) {
      log("ConvTimeE Exception ==> $e");
    }
    return convTime;
  }

  static String convertTimeToText(int timeInMilli) {
    String convTime = "";

    try {
      log("timeInMilli ==> $timeInMilli");
      if (timeInMilli > 0) {
        int seconds = ((timeInMilli / 1000) % 60).round();
        int minutes = ((timeInMilli / (1000 * 60)) % 60).round();
        int hours = ((timeInMilli / (1000 * 60 * 60)) % 24).round();

        log("==>seconds : $seconds");
        log("==>minutes : $minutes");
        log("==>hours : $hours");

        if (hours > 0) {
          if (minutes > 0 && seconds > 0) {
            convTime = "$hours hr $minutes min $seconds sec";
          } else if (minutes > 0 && seconds == 0) {
            convTime = "$hours hr $minutes min";
          } else if (minutes == 0 && seconds > 0) {
            convTime = "$hours hr $seconds sec";
          } else if (minutes == 0 && seconds == 0) {
            convTime = "$hours hr";
          }
        } else if (minutes > 0) {
          if (seconds > 0) {
            convTime = "$minutes min $seconds sec";
          } else if (minutes > 0 && seconds == 0) {
            convTime = "$minutes min";
          }
        } else if (seconds > 0) {
          convTime = "$seconds sec";
        }
      } else {
        convTime = "0";
      }
    } catch (e) {
      log("ConvTimeE Exception ==> $e");
    }
    return convTime;
  }

  static String remainTimeInMin(int remainWatch) {
    String convTime = "";

    try {
      log("remainWatch ==> ${(remainWatch / 1000)}");
      if (remainWatch > 0) {
        int seconds = ((remainWatch / 1000) % 60).round();
        int minutes = ((remainWatch / (1000 * 60)) % 60).round();
        int hours = ((remainWatch / (1000 * 60 * 60)) % 24).round();

        log("second ==> $seconds");
        log("minutes ==> $minutes");
        log("hour ==> $hours");

        if (hours > 0) {
          if (minutes > 0 && seconds > 0) {
            convTime = "$hours hr $minutes min $seconds sec";
          } else if (minutes > 0 && seconds == 0) {
            convTime = "$hours hr $minutes min";
          } else if (minutes == 0 && seconds > 0) {
            convTime = "$hours hr $seconds sec";
          } else if (minutes == 0 && seconds == 0) {
            convTime = "$hours hr";
          }
        } else if (minutes > 0) {
          if (seconds > 0) {
            convTime = "$minutes min $seconds sec";
          } else if (minutes > 0 && seconds == 0) {
            convTime = "$minutes min";
          }
        } else if (seconds > 0) {
          convTime = "$seconds sec";
        }
      } else {
        convTime = "0";
      }
    } catch (e) {
      log("ConvTimeE Exception ==> $e");
    }
    return convTime;
  }

  static String convertInMin(int remainWatch) {
    String convTime = "";

    try {
      log("remainWatch ==> ${(remainWatch / 1000)}");
      if (remainWatch > 0) {
        int minutes = ((remainWatch / (1000 * 60)) % 60).round();
        log("minutes ==> $minutes");
        if (minutes == 0) {
          convTime = "00 min";
        } else if (minutes < 10) {
          convTime = "0$minutes min";
        } else {
          convTime = "$minutes min";
        }
      } else {
        convTime = "00 min";
      }
    } catch (e) {
      log("convertInMin Exception ==> $e");
    }
    return convTime;
  }

  static double getPercentage(int totalValue, int usedValue) {
    double percentage = 0.0;
    try {
      if (totalValue != 0) {
        percentage = ((usedValue / totalValue).clamp(0.0, 1.0) * 100);
      } else {
        percentage = 0.0;
      }
      log("getPercentage percentage ==> $percentage");
    } catch (e) {
      log("getPercentage Exception ==> $e");
      percentage = 0.0;
    }
    percentage = (percentage.round() / 100);
    log("getPercentage percentage ===FINAL===> $percentage");
    return percentage;
  }

  //Convert Html to simple String
  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }

  static Future<String> getFileUrl(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/$fileName";
  }
}
