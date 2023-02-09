class Constant {
  static const String baseurl =
      'http://demo.divinetechs.in/apps/dtlive/public/api/';

  static String? appName = "DTLive";
  static String? appPackageName = "com.divinetechs.primevideoapp";

  /* OneSignal App ID */
  static const String oneSignalAppId = "08e33367-9a65-431f-a995-bbe95a0f0769";

  /* Google Client ID & Client Secret */
  static const String googleClientId =
      "346606981660-juds0qd8k9p651md7gv38bd1bn9jq66v.apps.googleusercontent.com";
  static const String googleClientSecret =
      "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";
  static int fixFourDigit = 1317;
  static int fixSixDigit = 161613;

  static String? userID;
  static String userPlaceholder =
      "https://i.pinimg.com/564x/5d/69/42/5d6942c6dff12bd3f960eb30c5fdd0f9.jpg";
  static String placeHolderLand =
      "https://propertywiselaunceston.com.au/wp-content/themes/property-wise/images/no-image.png";
  static String placeHolderPort =
      "https://stream-cinema.online/images/no-image.png";
  static String currencySymbol = "";

  static String androidAppShareUrlDesc =
      "Let me recommend you this application\n\nhttps://play.google.com/store/apps/details?id=${Constant.appPackageName}";
  static String iosAppShareUrlDesc =
      "Let me recommend you this application\n\nhttps://apps.apple.com/us/app/${appName?.toLowerCase()}/${Constant.appPackageName}";

  static String androidAppUrl =
      "https://play.google.com/store/apps/details?id=${Constant.appPackageName}";
  static String iosAppUrl =
      "https://apps.apple.com/us/app/${appName?.toLowerCase()}/${Constant.appPackageName}";

  static Map<String, String> resolutionsUrls = <String, String>{};
}
