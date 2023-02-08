import 'dart:developer';
import 'dart:io';
import 'dart:math' as number;

import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:html/parser.dart' show parse;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

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

  static void getCurrencySymbol() async {
    SharedPre sharedPref = SharedPre();
    Constant.currencySymbol = await sharedPref.read("currency_code") ?? "";
    log('Constant currencySymbol ==> ${Constant.currencySymbol}');
  }

  static setUserId(userID) async {
    SharedPre sharedPref = SharedPre();
    if (userID != null) {
      await sharedPref.save("userid", userID);
    } else {
      await sharedPref.remove("userid");
      await sharedPref.remove("username");
      await sharedPref.remove("userimage");
      await sharedPref.remove("useremail");
      await sharedPref.remove("usermobile");
      await sharedPref.remove("usertype");
    }
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
      Color color, Color borderColor, double radius, double border) {
    return BoxDecoration(
      color: color,
      border: Border.all(
        color: borderColor,
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
          Navigator.pop(context);
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
        multilanguage: true,
        fontsize: 18,
        fontstyle: FontStyle.normal,
        fontwaight: FontWeight.w600,
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
          multilanguage: showFor != "response" ? true : false,
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

  static Future<File?> saveImageInStorage(imgUrl) async {
    try {
      var response = await http.get(Uri.parse(imgUrl));
      Directory? documentDirectory;
      if (Platform.isAndroid) {
        documentDirectory = await getExternalStorageDirectory();
      } else {
        documentDirectory = await getApplicationDocumentsDirectory();
      }
      File file = File(path.join(documentDirectory?.path ?? "",
          '${DateTime.now().millisecondsSinceEpoch.toString()}.png'));
      file.writeAsBytesSync(response.bodyBytes);
      // This is a sync operation on a real
      // app you'd probably prefer to use writeAsByte and handle its Future
      return file;
    } catch (e) {
      debugPrint("saveImageInStorage Exception ===> $e");
      return null;
    }
  }

  static Html htmlTexts(var strText) {
    return Html(
      data: strText,
      style: {
        "body": Style(
          color: otherColor,
          fontSize: FontSize(15),
          fontWeight: FontWeight.w500,
        ),
        "link": Style(
          color: primaryDarkColor,
          fontSize: FontSize(15),
          fontWeight: FontWeight.w500,
        ),
      },
      onLinkTap: (url, _, __, ___) async {
        if (await canLaunchUrl(Uri.parse(url!))) {
          await launchUrl(
            Uri.parse(url),
            mode: LaunchMode.platformDefault,
          );
        } else {
          throw 'Could not launch $url';
        }
      },
      shrinkWrap: false,
    );
  }

  static Future<void> shareVideo(context, videoTitle) async {
    try {
      String? shareMessage, shareDesc;
      shareDesc =
          "Hey I'm watching $videoTitle . Check it out now on ${Constant.appName}!\nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName} and more.";
      if (Platform.isAndroid) {
        shareMessage = "$shareDesc\n${Constant.androidAppUrl}";
      } else {
        shareMessage = "$shareDesc\n${Constant.iosAppUrl}";
      }
      await FlutterShare.share(
        title: Constant.appName ?? "DTLive",
        linkUrl: shareMessage,
      );
    } catch (e) {
      debugPrint("shareFile Exception ===> $e");
      return;
    }
  }

  static Future<void> redirectToUrl(String url) async {
    debugPrint("_launchUrl url ===> $url");
    if (await canLaunchUrl(Uri.parse(url.toString()))) {
      await launchUrl(
        Uri.parse(url.toString()),
        mode: LaunchMode.platformDefault,
      );
    } else {
      throw "Could not launch $url";
    }
  }

  static Future<void> shareApp(shareMessage) async {
    try {
      await FlutterShare.share(
        title: Constant.appName ?? "",
        linkUrl: shareMessage,
      );
    } catch (e) {
      debugPrint("shareFile Exception ===> $e");
      return;
    }
  }

  /* ***************** generate Unique OrderID START ***************** */
  static String generateRandomOrderID() {
    int getRandomNumber;
    String? finalOID;
    debugPrint("fixFourDigit =>>> ${Constant.fixFourDigit}");
    debugPrint("fixSixDigit =>>> ${Constant.fixSixDigit}");

    number.Random r = number.Random();
    int ran5thDigit = r.nextInt(9);
    debugPrint("Random ran5thDigit =>>> $ran5thDigit");

    int randomNumber = number.Random().nextInt(9999999);
    debugPrint("Random randomNumber =>>> $randomNumber");
    if (randomNumber < 0) {
      randomNumber = -randomNumber;
    }
    getRandomNumber = randomNumber;
    debugPrint("getRandomNumber =>>> $getRandomNumber");

    finalOID = "${Constant.fixFourDigit.toInt()}"
        "$ran5thDigit"
        "${Constant.fixSixDigit.toInt()}"
        "$getRandomNumber";
    debugPrint("finalOID =>>> $finalOID");

    return finalOID;
  }
  /* ***************** generate Unique OrderID END ***************** */
}
