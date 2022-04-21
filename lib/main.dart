import 'package:flutter/material.dart';
import 'package:primevideo/bottom/bottombarscreen.dart';
import 'package:primevideo/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PrimeVideo',
        theme: ThemeData(
          primarySwatch: bluetext,
        ),
        home: const BottomBarUI());
  }
}
