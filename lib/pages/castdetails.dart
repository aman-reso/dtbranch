import 'package:dtlive/provider/castdetailsprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CastDetails extends StatefulWidget {
  final String? castID;
  const CastDetails({Key? key, required this.castID}) : super(key: key);

  @override
  State<CastDetails> createState() => _CastDetailsState();
}

class _CastDetailsState extends State<CastDetails> {
  late CastDetailsProvider castDetailsProvider;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    castDetailsProvider =
        Provider.of<CastDetailsProvider>(context, listen: false);
    await castDetailsProvider.getCastDetails(widget.castID);
    Future.delayed(Duration.zero).then((value) => setState(() {}));
  }

  @override
  void dispose() {
    castDetailsProvider.clearProvider();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  automaticallyImplyLeading: false,
                  backgroundColor: appBgColor,
                  titleSpacing: 0,
                  toolbarHeight: MediaQuery.of(context).size.height * 0.65,
                  title: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.65,
                    alignment: Alignment.center,
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      children: [
                        MyNetworkImage(
                          imageUrl:
                              castDetailsProvider.castDetailModel.status == 200
                                  ? castDetailsProvider
                                              .castDetailModel.result !=
                                          null
                                      ? (castDetailsProvider
                                              .castDetailModel.result?[0].image
                                              .toString() ??
                                          Constant.userPlaceholder)
                                      : Constant.userPlaceholder
                                  : Constant.userPlaceholder,
                          fit: BoxFit.cover,
                          imgHeight: MediaQuery.of(context).size.height * 0.65,
                          imgWidth: MediaQuery.of(context).size.width,
                        ),
                        Container(
                          padding: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.65,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                                transparentColor,
                                blackTransparent,
                                black,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  expandedHeight: MediaQuery.of(context).size.height * 0.65,
                ),
              ),
            ];
          },
          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(23),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      MyText(
                        text: castDetailsProvider.castDetailModel.status == 200
                            ? castDetailsProvider.castDetailModel.result != null
                                ? (castDetailsProvider
                                        .castDetailModel.result?[0].name
                                        .toString() ??
                                    "-")
                                : "-"
                            : "-",
                        color: white,
                        textalign: TextAlign.start,
                        fontwaight: FontWeight.w700,
                        fontsize: 29,
                        multilanguage: false,
                        maxline: 1,
                        overflow: TextOverflow.ellipsis,
                        fontstyle: FontStyle.normal,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        constraints: const BoxConstraints(minHeight: 0),
                        alignment: Alignment.centerLeft,
                        child: ExpandableText(
                          castDetailsProvider.castDetailModel.status == 200
                              ? castDetailsProvider.castDetailModel.result !=
                                      null
                                  ? (castDetailsProvider.castDetailModel
                                          .result?[0].personalInfo
                                          .toString() ??
                                      "-")
                                  : "-"
                              : "-",
                          expandText: more,
                          collapseText: less_,
                          maxLines: 10,
                          linkColor: otherColor,
                          textAlign: TextAlign.start,
                          style: GoogleFonts.inter(
                            letterSpacing: 0.5,
                            wordSpacing: 0.2,
                            fontSize: 14,
                            fontStyle: FontStyle.normal,
                            color: white,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                  margin: const EdgeInsets.fromLTRB(23, 25, 23, 12),
                  alignment: Alignment.centerLeft,
                  child: MyImage(
                    width: 60,
                    height: 25,
                    imagePath: "imdb.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}