// ignore_for_file: prefer_typing_uninitialized_variables

import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class MyText extends StatelessWidget {
  String text;
  double? fontsizeNormal, fontsizeWeb;
  var maxline, fontstyle, fontweight, textalign, multilanguage;
  Color color;
  var overflow;

  MyText({
    Key? key,
    required this.color,
    required this.text,
    this.fontsizeNormal,
    this.fontsizeWeb,
    this.maxline,
    this.multilanguage,
    this.overflow,
    this.textalign,
    this.fontweight,
    this.fontstyle,
  }) : super(key: key);

  static getAdaptiveTextSize(BuildContext context, dynamic value) {
    // 720 is medium screen height
    if (kIsWeb) {
      return (value / 630) *
          min(MediaQuery.of(context).size.height,
              MediaQuery.of(context).size.width);
    } else {
      return (value / 720 * MediaQuery.of(context).size.height);
    }
  }

  @override
  Widget build(BuildContext context) {
    return multilanguage == true
        ? LocaleText(
            text,
            textAlign: textalign,
            overflow: TextOverflow.ellipsis,
            maxLines: maxline,
            style: GoogleFonts.inter(
              fontSize: getAdaptiveTextSize(
                  context, kIsWeb ? fontsizeWeb : fontsizeNormal),
              fontStyle: fontstyle,
              color: color,
              fontWeight: fontweight,
            ),
          )
        : Text(
            text,
            textAlign: textalign,
            overflow: TextOverflow.ellipsis,
            maxLines: maxline,
            style: GoogleFonts.inter(
              fontSize: getAdaptiveTextSize(
                  context, kIsWeb ? fontsizeWeb : fontsizeNormal),
              fontStyle: fontstyle,
              color: color,
              fontWeight: fontweight,
            ),
          );
  }
}
