import 'package:flutter/material.dart';
import 'package:primevideo/utils/colors.dart';

class DividerUI extends StatelessWidget {
  const DividerUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Divider(
      color: textColor,
    );
  }
}
