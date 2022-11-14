import 'dart:developer';

import 'package:dtlive/firebase_options.dart';
import 'package:dtlive/pages/splash.dart';
import 'package:dtlive/provider/channelsectionprovider.dart';
import 'package:dtlive/provider/findprovider.dart';
import 'package:dtlive/provider/generalprovider.dart';
import 'package:dtlive/provider/homeprovider.dart';
import 'package:dtlive/provider/mystuffprovider.dart';
import 'package:dtlive/provider/profileprovider.dart';
import 'package:dtlive/provider/rentstoreprovider.dart';
import 'package:dtlive/provider/searchprovider.dart';
import 'package:dtlive/provider/sectionbytypeprovider.dart';
import 'package:dtlive/provider/sectiondataprovider.dart';
import 'package:dtlive/provider/showdetailsprovider.dart';
import 'package:dtlive/provider/subscriptionprovider.dart';
import 'package:dtlive/provider/videobyidprovider.dart';
import 'package:dtlive/provider/videodetailsprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

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
        ChangeNotifierProvider(create: (_) => FindProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => ChannelSectionProvider()),
        ChangeNotifierProvider(create: (_) => RentStoreProvider()),
        ChangeNotifierProvider(create: (_) => VideoByIDProvider()),
        ChangeNotifierProvider(create: (_) => SectionByTypeProvider()),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
        ChangeNotifierProvider(create: (_) => MyStuffProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: primaryColor,
        primaryColorDark: primaryDarkColor,
        primaryColorLight: primaryLight,
        scaffoldBackgroundColor: appBgColor,
      ),
      title: Constant.appName,
      home: const Splash(),
    );
  }
}
