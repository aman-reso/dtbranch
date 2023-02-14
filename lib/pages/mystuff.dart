import 'package:dtlive/pages/mypurchaselist.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:dtlive/pages/setting.dart';
import 'package:dtlive/provider/mystuffprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/pages/mywatchlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MyStuff extends StatefulWidget {
  const MyStuff({Key? key}) : super(key: key);

  @override
  State<MyStuff> createState() => MyStuffState();
}

class MyStuffState extends State<MyStuff> with TickerProviderStateMixin {
  late MyStuffProvider myStuffProvider;
  late TabController tabController =
      TabController(length: tabname.length, vsync: this);

  List<String> tabname = <String>[
    "downloads",
    "watchlist",
    "purchases",
  ];

  List<String> downloadList = <String>[
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
    "ic_actionmovi1.png",
    "ic_actionmovi2.png",
  ];

  List<String> downloadTitleList = <String>[
    "K.G.F Chapter 2",
    "R R R",
    "Dance Deewano",
    "Kapil Sharma Show",
    "K.G.F Chapter 2",
    "R R R",
    "Dance Deewano",
    "Kapil Sharma Show",
    "K.G.F Chapter 2",
    "R R R",
    "Dance Deewano",
    "Kapil Sharma Show",
  ];

  @override
  void initState() {
    super.initState();
    myStuffProvider = Provider.of<MyStuffProvider>(context, listen: false);
    if (Constant.userID != null) {
      _getData();
    } else {
      myStuffProvider.clearProvider();
      Future.delayed(Duration.zero).then((value) {
        if (mounted) return setState(() {});
      });
    }
  }

  _getData() async {
    await myStuffProvider.getProfile();
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
                  toolbarHeight: 90,
                  title: Container(
                    width: MediaQuery.of(context).size.width,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Consumer<MyStuffProvider>(
                            builder: (context, myStuffProvider, child) {
                              return Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(45),
                                    clipBehavior: Clip.antiAlias,
                                    child: MyNetworkImage(
                                      imageUrl:
                                          myStuffProvider.profileModel.status ==
                                                  200
                                              ? myStuffProvider.profileModel
                                                          .result !=
                                                      null
                                                  ? (myStuffProvider
                                                          .profileModel
                                                          .result
                                                          ?.image
                                                          .toString() ??
                                                      Constant.userPlaceholder)
                                                  : Constant.userPlaceholder
                                              : Constant.userPlaceholder,
                                      fit: BoxFit.cover,
                                      imgHeight: 50,
                                      imgWidth: 50,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  MyText(
                                    color: white,
                                    multilanguage: false,
                                    text: myStuffProvider.profileModel.status ==
                                            200
                                        ? myStuffProvider.profileModel.result !=
                                                null
                                            ? (myStuffProvider.profileModel
                                                    .result?.name ??
                                                guestUser)
                                            : guestUser
                                        : guestUser,
                                    fontsize: 16,
                                    fontwaight: FontWeight.w600,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textalign: TextAlign.center,
                                    fontstyle: FontStyle.normal,
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  MyImage(
                                    width: 15,
                                    height: 15,
                                    imagePath: "ic_down.png",
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const Setting();
                                },
                              ),
                            );
                            if (Constant.userID != null) {
                              _getData();
                            } else {
                              myStuffProvider.clearProvider();
                              Future.delayed(Duration.zero).then((value) {
                                if (mounted) return setState(() {});
                              });
                            }
                          },
                          child: MyImage(
                            width: 20,
                            height: 20,
                            imagePath: "ic_setting.png",
                          ),
                        ),
                      ],
                    ),
                  ), // This is the title in the app bar.
                  pinned: false,
                  expandedHeight: 0,
                  forceElevated: innerBoxIsScrolled,
                ),
              ),
            ];
          },
          body: Column(
            children: [
              TabBar(
                indicatorColor: white,
                indicatorSize: TabBarIndicatorSize.tab,
                isScrollable: false,
                physics: const AlwaysScrollableScrollPhysics(),
                unselectedLabelColor: white,
                labelStyle: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  fontStyle: FontStyle.normal,
                ),
                labelColor: white,
                labelPadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                controller: tabController,
                tabs: List<Widget>.generate(
                  tabname.length,
                  (int index) {
                    return Tab(
                      child: MyText(
                        color: white,
                        text: tabname[index],
                        fontsize: 14,
                        maxline: 1,
                        multilanguage: true,
                        overflow: TextOverflow.ellipsis,
                        fontwaight: FontWeight.w600,
                        textalign: TextAlign.center,
                        fontstyle: FontStyle.normal,
                      ),
                    );
                  },
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: otherColor,
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    /* Downloads */
                    Consumer<MyStuffProvider>(
                      builder: (context, myStuffProvider, child) {
                        if (myStuffProvider.loadingDownload) {
                          return Utils.pageLoader();
                        } else {
                          if (myStuffProvider.profileModel.status == 200) {
                            return _buildDownloadlist();
                          } else {
                            return const NoData(
                              title: 'no_downloads',
                              subTitle: '',
                            );
                          }
                        }
                      },
                    ),

                    /* WatchList */
                    const MyWatchlist(),

                    /* Purchases */
                    const MyPurchaselist(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDownloadlist() {
    return AlignedGridView.count(
      shrinkWrap: true,
      crossAxisCount: 1,
      padding: const EdgeInsets.only(top: 12, bottom: 8),
      crossAxisSpacing: 0,
      mainAxisSpacing: 8,
      itemCount: downloadList.length,
      itemBuilder: (BuildContext context, int position) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: 95,
          constraints: const BoxConstraints(
            minHeight: 90,
            maxHeight: 110,
          ),
          color: lightBlack,
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.44,
                height: MediaQuery.of(context).size.height,
                child: MyImage(
                  fit: BoxFit.fill,
                  imagePath: downloadList[position],
                  width: MediaQuery.of(context).size.width,
                  height: 95,
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Stack(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8),
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            MyText(
                              color: white,
                              text: downloadTitleList[position],
                              multilanguage: false,
                              textalign: TextAlign.center,
                              maxline: 3,
                              overflow: TextOverflow.ellipsis,
                              fontsize: 14,
                              fontwaight: FontWeight.w700,
                              fontstyle: FontStyle.normal,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: (position == 1 || position == 2)
                                      ? true
                                      : false,
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 8),
                                    child: MyText(
                                      color: otherColor,
                                      multilanguage: false,
                                      text: "Season 1",
                                      maxline: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textalign: TextAlign.center,
                                      fontsize: 12,
                                      fontwaight: FontWeight.normal,
                                      fontstyle: FontStyle.normal,
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(right: 8),
                                  child: MyText(
                                    color: otherColor,
                                    text: "140 min",
                                    multilanguage: false,
                                    maxline: 1,
                                    overflow: TextOverflow.ellipsis,
                                    textalign: TextAlign.center,
                                    fontsize: 12,
                                    fontwaight: FontWeight.normal,
                                    fontstyle: FontStyle.normal,
                                  ),
                                ),
                                MyText(
                                  color: otherColor,
                                  text: "140 MB",
                                  textalign: TextAlign.center,
                                  multilanguage: false,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontsize: 12,
                                  fontwaight: FontWeight.normal,
                                  fontstyle: FontStyle.normal,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Container(
                          width: 25,
                          height: 25,
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10, right: 15),
                            child: MyImage(
                              width: 18,
                              height: 18,
                              imagePath: (position == 1 || position == 2)
                                  ? "ic_right.png"
                                  : "ic_more.png",
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
