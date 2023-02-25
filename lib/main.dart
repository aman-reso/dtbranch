import 'dart:developer';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dtlive/firebase_options.dart';
import 'package:dtlive/pages/moviedetails.dart';
import 'package:dtlive/pages/splash.dart';
import 'package:dtlive/pages/tvshowdetails.dart';
import 'package:dtlive/provider/avatarprovider.dart';
import 'package:dtlive/provider/castdetailsprovider.dart';
import 'package:dtlive/provider/channelsectionprovider.dart';
import 'package:dtlive/provider/downloadprovider.dart';
import 'package:dtlive/provider/episodeprovider.dart';
import 'package:dtlive/provider/findprovider.dart';
import 'package:dtlive/provider/generalprovider.dart';
import 'package:dtlive/provider/homeprovider.dart';
import 'package:dtlive/provider/mystuffprovider.dart';
import 'package:dtlive/provider/paymentprovider.dart';
import 'package:dtlive/provider/playerprovider.dart';
import 'package:dtlive/provider/profileprovider.dart';
import 'package:dtlive/provider/purchaselistprovider.dart';
import 'package:dtlive/provider/rentstoreprovider.dart';
import 'package:dtlive/provider/searchprovider.dart';
import 'package:dtlive/provider/sectionbytypeprovider.dart';
import 'package:dtlive/provider/sectiondataprovider.dart';
import 'package:dtlive/provider/showdetailsprovider.dart';
import 'package:dtlive/provider/subscriptionprovider.dart';
import 'package:dtlive/provider/videobyidprovider.dart';
import 'package:dtlive/provider/videodetailsprovider.dart';
import 'package:dtlive/provider/watchlistprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Locales.init(['en', 'ar', 'hi']);
  //Remove this method to stop OneSignal Debugging
  OneSignal.shared.setLogLevel(OSLogLevel.verbose, OSLogLevel.none);
  OneSignal.shared.setAppId(Constant.oneSignalAppId);
  // The promptForPushNotificationsWithUserResponse function will show the iOS push notification prompt.
  // We recommend removing the following code and instead using an In-App Message to prompt for notification permission
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    log("Accepted permission: ===> $accepted");
  });
  OneSignal.shared.setNotificationWillShowInForegroundHandler(
      (OSNotificationReceivedEvent event) {
    // Will be called whenever a notification is received in foreground
    // Display Notification, pass null param for not displaying the notification
    event.complete(event.notification);
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => GeneralProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => SectionDataProvider()),
        ChangeNotifierProvider(create: (_) => VideoDetailsProvider()),
        ChangeNotifierProvider(create: (_) => ShowDetailsProvider()),
        ChangeNotifierProvider(create: (_) => EpisodeProvider()),
        ChangeNotifierProvider(create: (_) => FindProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ChannelSectionProvider()),
        ChangeNotifierProvider(create: (_) => RentStoreProvider()),
        ChangeNotifierProvider(create: (_) => VideoByIDProvider()),
        ChangeNotifierProvider(create: (_) => SectionByTypeProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => MyStuffProvider()),
        ChangeNotifierProvider(create: (_) => WatchlistProvider()),
        ChangeNotifierProvider(create: (_) => DownloadProvider()),
        ChangeNotifierProvider(create: (_) => PurchaselistProvider()),
        ChangeNotifierProvider(create: (_) => AvatarProvider()),
        ChangeNotifierProvider(create: (_) => CastDetailsProvider()),
        ChangeNotifierProvider(create: (_) => PaymentProvider()),
        ChangeNotifierProvider(create: (_) => PlayerProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    _getDeviceInfo();
    OneSignal.shared.setNotificationOpenedHandler(_handleNotificationOpened);
    super.initState();
  }

  // What to do when the user opens/taps on a notification
  void _handleNotificationOpened(OSNotificationOpenedResult result) {
    /* video_id, video_type, type_id */

    log("setNotificationOpenedHandler additionalData ===> ${result.notification.additionalData.toString()}");
    log("setNotificationOpenedHandler video_id ===> ${result.notification.additionalData?['video_id']}");
    log("setNotificationOpenedHandler video_type ===> ${result.notification.additionalData?['video_type']}");
    log("setNotificationOpenedHandler type_id ===> ${result.notification.additionalData?['type_id']}");

    if (result.notification.additionalData?['video_id'] != null) {
      String? videoID =
          result.notification.additionalData?['video_id'].toString() ?? "";
      String? videoType =
          result.notification.additionalData?['video_type'].toString() ?? "";
      String? typeID =
          result.notification.additionalData?['type_id'].toString() ?? "";
      log("videoID =====> $videoID");
      log("videoType =====> $videoType");
      log("typeID =====> $typeID");

      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) {
            if (videoType == "2") {
              return TvShowDetails(
                int.parse(videoID),
                int.parse(videoType),
                int.parse(typeID),
              );
            } else {
              return MovieDetails(
                int.parse(videoID),
                int.parse(videoType),
                int.parse(typeID),
              );
            }
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Shortcuts(
      shortcuts: <LogicalKeySet, Intent>{
        LogicalKeySet(LogicalKeyboardKey.select): const ActivateIntent(),
      },
      child: LocaleBuilder(
        builder: (locale) => MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: primaryColor,
            primaryColorDark: primaryDarkColor,
            primaryColorLight: primaryLight,
            scaffoldBackgroundColor: appBgColor,
          ).copyWith(
            scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor: MaterialStateProperty.all(white),
              trackVisibility: MaterialStateProperty.all(true),
              trackColor: MaterialStateProperty.all(whiteTransparent),
            ),
          ),
          title: Constant.appName ?? "DTLive",
          localizationsDelegates: Locales.delegates,
          supportedLocales: Locales.supportedLocales,
          locale: locale,
          localeResolutionCallback:
              (Locale? locale, Iterable<Locale> supportedLocales) {
            return locale;
          },
          builder: (context, child) {
            return ResponsiveWrapper.builder(
              BouncingScrollWrapper.builder(
                context,
                child!,
              ),
              minWidth: 360,
              defaultScale: true,
              breakpoints: [
                const ResponsiveBreakpoint.resize(360, name: MOBILE),
                const ResponsiveBreakpoint.autoScale(800, name: TABLET),
                const ResponsiveBreakpoint.autoScale(1000, name: DESKTOP),
                const ResponsiveBreakpoint.autoScale(1200, name: "4K"),
              ],
              background: Container(
                color: appBgColor,
              ),
            );
          },
          home: const Splash(),
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            dragDevices: {
              PointerDeviceKind.mouse,
              PointerDeviceKind.touch,
              PointerDeviceKind.stylus,
              PointerDeviceKind.unknown,
              PointerDeviceKind.trackpad
            },
          ),
        ),
      ),
    );
  }

  _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    Constant.isTV =
        androidInfo.systemFeatures.contains('android.software.leanback');
    log("isTV =======================> ${Constant.isTV}");
  }
}
