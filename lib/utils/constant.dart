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

  // Dimentions START
  static double appBarHeight = 60;
  static double appBarTextSize = 20;
  static double textFieldHeight = 50;
  static double buttonHeight = 45;
  static double backBtnHeight = 15;
  static double backBtnWidth = 19;

  static double cardRadius = 4;
  static double widthPort = 115;
  static double heightPort = 155;
  static double widthLand = 172;
  static double heightLand = 100;
  static double widthSquare = 172;
  static double heightSquare = 172;

  static double widthContiPort = 115;
  static double heightContiPort = 155;
  static double widthContiLand = 172;
  static double heightContiLand = 104;
  static double widthContiSquare = 172;
  static double heightContiSquare = 172;

  static double widthCast = 116;
  static double heightCast = 164;

  static double widthLangGen = 172;
  static double heightLangGen = 177;

  static double homeBanner = 190;
  static double detailPoster = 255;
  static double detailTabs = 50;
  static double featureSize = 50;
  static double featureIconSize = 20;
  static double epiPoster = 240;
  static double castCrewPoster = 525;
  static double channelPoster = 222;
  static double channelBanner = 180;
  static double channelVideoBanner = 195;
  static double rentBanner = 103;
  static double dialogIconSize = 22;
  static double dialogButtonHeight = 48;

  static double minHeightSettings = 45;
  // Dimentions END

  static String userID = "0";
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

  static const Map<String, String> exampleResolutionsUrls = {
    "LOW":
        "http://173.249.44.9/apps/dt_live/public/images/video/o_1ge4hrsmigb21ccd5iu3cs12u7.mp4",
    "MEDIUM":
        "http://173.249.44.9/apps/dt_live/public/images/video/o_1ge4hrsmigb21ccd5iu3cs12u7.mp4",
    "LARGE":
        "http://173.249.44.9/apps/dt_live/public/images/video/o_1ge4hrsmigb21ccd5iu3cs12u7.mp4",
    "EXTRA_LARGE":
        "http://173.249.44.9/apps/dt_live/public/images/video/o_1ge4hrsmigb21ccd5iu3cs12u7.mp4"
  };
}
