import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:flutter/material.dart';

class QuickLinksWeb extends StatefulWidget {
  final String pageName, pageData;
  const QuickLinksWeb(
      {required this.pageName, required this.pageData, super.key});

  @override
  State<QuickLinksWeb> createState() => _QuickLinksWebState();
}

class _QuickLinksWebState extends State<QuickLinksWeb> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(50, 25, 50, 25),
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: Dimens.homeTabHeight),
          Padding(
            padding: const EdgeInsets.only(left: 40, right: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 3,
                    decoration: Utils.setGradientBGWithCenter(
                        primaryTras5, primaryTras50, primaryColor, 1),
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                MyText(
                  color: white,
                  text: widget.pageName.toUpperCase(),
                  multilanguage: true,
                  fontsizeNormal: 25,
                  fontsizeWeb: 25,
                  fontweight: FontWeight.w500,
                  maxline: 2,
                  overflow: TextOverflow.ellipsis,
                  textalign: TextAlign.center,
                  fontstyle: FontStyle.normal,
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: Container(
                    height: 3,
                    decoration: Utils.setGradientBGWithCenter(
                        primaryColor, primaryTras50, primaryTras5, 1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          _buildPageByName(widget.pageName),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget _buildPageByName(name) {
    switch (name) {
      case "privacypolicy":
        return loadHtmlText();
      case "aboutus":
        return loadHtmlText();
      case "termcondition":
        return loadHtmlText();
      case "refundpolicy":
        return loadHtmlText();
      default:
        return Container();
    }
  }

  Widget loadHtmlText() {
    return Container(
      padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
      child: MyText(
        text: Utils.parseHtmlString(widget.pageData),
        color: otherColor,
        fontstyle: FontStyle.normal,
        fontsizeNormal: 15,
        fontsizeWeb: 15,
        maxline: 10000,
        fontweight: FontWeight.w500,
        textalign: TextAlign.start,
      ),
    );
  }
}
