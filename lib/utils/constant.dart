class Constant {
  static const String baseurl =
      'http://demo.divinetechs.in/apps/dtlive/public/api/';

  // static const String baseurl =
  //     'http://demo.divinetechs.com/apps/dtlive/public/api/';

  //  static const String baseurl =
  //     'https://divinetechs.in/dtlive-admin/public/api/';

  static String? appName = "DTLive";
  static String? appPackageName = "com.divinetechs.dtlive";
  static String? appVersion = "1";
  static String? appBuildNumber = "1.0";

  /* Constant for TV check */
  static bool isTV = false;

  /* OneSignal App ID */
  static const String oneSignalAppId = "08e33367-9a65-431f-a995-bbe95a0f0769";

  static String? userID;
  static String currencySymbol = "";

  static String androidAppShareUrlDesc =
      "Let me recommend you this application\n\nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName}";
  static String iosAppShareUrlDesc =
      "Let me recommend you this application\n\nhttps://apps.apple.com/us/app/${appName?.toLowerCase()}/${Constant.appPackageName}";

  static String androidAppUrl =
      "https://play.google.com/store/apps/details?id=${Constant.appPackageName}";
  static String iosAppUrl =
      "https://apps.apple.com/us/app/${appName?.toLowerCase()}/${Constant.appPackageName}";
  static String facebookUrl = "https://www.facebook.com/divinetechs";
  static String instagramUrl = "https://www.instagram.com/divinetechs/";

  static Map<String, String> resolutionsUrls = <String, String>{};

  /* Download config */
  static String videoDownloadPort = 'video_downloader_send_port';
  static String showDownloadPort = 'show_downloader_send_port';
  static String hawkVIDEOList = "myVideoList_";
  static String hawkKIDSVIDEOList = "myKidsVideoList_";
  static String hawkSHOWList = "myShowList_";
  static String hawkSEASONList = "mySeasonList_";
  static String hawkEPISODEList = "myEpisodeList_";
  /* Download config */

  static int fixFourDigit = 1317;
  static int fixSixDigit = 161613;
  static int bannerDuration = 10000; // in milliseconds
  static int animationDuration = 800; // in milliseconds
}
