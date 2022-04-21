import 'package:flutter/material.dart';
import 'package:primevideo/utils/colors.dart';

class LearnMore extends StatefulWidget {
  const LearnMore({Key? key}) : super(key: key);

  @override
  State<LearnMore> createState() => _LearnMoreState();
}

class _LearnMoreState extends State<LearnMore> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: appBgColor,
    );
  }
}
