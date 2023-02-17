import 'dart:async';
import 'dart:developer';

import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:dtlive/model/sectionlistmodel.dart';
import 'package:dtlive/model/sectiontypemodel.dart' as type;
import 'package:dtlive/model/sectionlistmodel.dart' as list;
import 'package:dtlive/model/sectionbannermodel.dart' as banner;
import 'package:dtlive/pages/moviedetails.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:dtlive/pages/tvshowdetails.dart';
import 'package:dtlive/pages/videosbyid.dart';
import 'package:dtlive/provider/homeprovider.dart';
import 'package:dtlive/provider/sectiondataprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => HomeState();
}

class HomeState extends State<Home> {
  CarouselController pageController = CarouselController();
  late ScrollController tabScrollController;
  late HomeProvider homeProvider;

  @override
  void initState() {
    homeProvider = Provider.of<HomeProvider>(context, listen: false);
    tabScrollController = ScrollController();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getData();
    });
  }

  _getData() async {
    Utils.deleteCacheDir();
    Utils.getCurrencySymbol();
    final sectionDataProvider =
        Provider.of<SectionDataProvider>(context, listen: false);
    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    if (!homeProvider.loading) {
      if (homeProvider.sectionTypeModel.status == 200 &&
          homeProvider.sectionTypeModel.result != null) {
        if ((homeProvider.sectionTypeModel.result?.length ?? 0) > 0) {
          if ((sectionDataProvider.sectionBannerModel.result?.length ?? 0) ==
                  0 ||
              (sectionDataProvider.sectionListModel.result?.length ?? 0) == 0) {
            getTabData(0, homeProvider.sectionTypeModel.result);
            Future.delayed(Duration.zero).then((value) => setState(() {}));
          }
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
        child: kIsWeb ? _webAppBarWithDetails() : _mobileAppBarWithDetails(),
      ),
    );
  }

  Widget _mobileAppBarWithDetails() {
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
            sliver: SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: appBgColor,
              toolbarHeight: 65,
              title: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                alignment: Alignment.center,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8),
                  splashColor: transparentColor,
                  highlightColor: transparentColor,
                  onTap: () async {
                    await getTabData(0, homeProvider.sectionTypeModel.result);
                  },
                  child:
                      MyImage(width: 80, height: 80, imagePath: "appicon.png"),
                ),
              ), // This is the title in the app bar.
              pinned: false,
              expandedHeight: 0,
              forceElevated: innerBoxIsScrolled,
            ),
          ),
        ];
      },
      body: homeProvider.loading
          ? Utils.pageLoader()
          : (homeProvider.sectionTypeModel.status == 200)
              ? (homeProvider.sectionTypeModel.result != null ||
                      (homeProvider.sectionTypeModel.result?.length ?? 0) > 0)
                  ? Stack(
                      children: [
                        tabItem(homeProvider.sectionTypeModel.result),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: Dimens.homeTabHeight,
                          padding: const EdgeInsets.only(top: 8, bottom: 8),
                          color: black.withOpacity(0.8),
                          child: tabTitle(homeProvider.sectionTypeModel.result),
                        ),
                      ],
                    )
                  : const NoData(title: '', subTitle: '')
              : const NoData(title: '', subTitle: ''),
    );
  }

  Widget _webAppBarWithDetails() {
    if (homeProvider.loading) {
      return Utils.pageLoader();
    } else {
      if (homeProvider.sectionTypeModel.status == 200) {
        if (homeProvider.sectionTypeModel.result != null ||
            (homeProvider.sectionTypeModel.result?.length ?? 0) > 0) {
          return Stack(
            children: [
              tabItem(homeProvider.sectionTypeModel.result),
              Container(
                width: MediaQuery.of(context).size.width,
                height: Dimens.homeTabHeight,
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                color: black.withOpacity(0.75),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    /* Menu */
                    (MediaQuery.of(context).size.width < 800)
                        ? Container(
                            constraints: const BoxConstraints(
                              minWidth: 20,
                            ),
                            padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                            child: Consumer<HomeProvider>(
                                builder: (context, homeProvider, child) {
                              return DropdownButtonHideUnderline(
                                child: DropdownButton2(
                                  isExpanded: false,
                                  customButton: MyImage(
                                    height: 40,
                                    imagePath: "ic_menu.png",
                                    fit: BoxFit.contain,
                                    color: white,
                                  ),
                                  items: _buildWebDropDownItems(),
                                  onChanged: (type.Result? value) async {
                                    debugPrint(
                                        'value id ===============> ${value?.id.toString()}');
                                    if (value?.id == 0) {
                                      await getTabData(0,
                                          homeProvider.sectionTypeModel.result);
                                    } else {
                                      for (var i = 0;
                                          i <
                                              (homeProvider.sectionTypeModel
                                                      .result?.length ??
                                                  0);
                                          i++) {
                                        if (value?.id ==
                                            homeProvider.sectionTypeModel
                                                .result?[i].id) {
                                          await getTabData(
                                              i + 1,
                                              homeProvider
                                                  .sectionTypeModel.result);
                                          return;
                                        }
                                      }
                                    }
                                  },
                                  dropdownPadding: const EdgeInsets.only(
                                      left: 10, right: 10),
                                  dropdownWidth: 150,
                                  dropdownElevation: 8,
                                  dropdownDecoration:
                                      Utils.setBackground(appBgColor, 5),
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                ),
                              );
                            }),
                          )
                        : const SizedBox.shrink(),

                    /* App Icon */
                    InkWell(
                      splashColor: transparentColor,
                      highlightColor: transparentColor,
                      onTap: () async {
                        await getTabData(
                            0, homeProvider.sectionTypeModel.result);
                      },
                      borderRadius: BorderRadius.circular(8),
                      child: MyImage(
                        width: 70,
                        height: 70,
                        imagePath: "appicon.png",
                      ),
                    ),

                    /* Types */
                    (MediaQuery.of(context).size.width >= 800)
                        ? Expanded(
                            child:
                                tabTitle(homeProvider.sectionTypeModel.result),
                          )
                        : const Expanded(child: SizedBox.shrink()),
                    const SizedBox(
                      width: 20,
                    ),

                    /* Feature buttons */
                    /* Search */
                    InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () async {},
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: 20,
                          maxWidth: 40,
                        ),
                        padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
                        child: MyImage(
                          height: 40,
                          imagePath: "ic_find.png",
                          fit: BoxFit.contain,
                          color: white,
                        ),
                      ),
                    ),

                    /* Channels */
                    InkWell(
                      onTap: () async {},
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: MyText(
                          color: white,
                          multilanguage: false,
                          text: bottomView3,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontsizeNormal: 14,
                          fontweight: FontWeight.w600,
                          fontsizeWeb: 15,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal,
                        ),
                      ),
                    ),

                    /* Rent */
                    InkWell(
                      onTap: () async {},
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: MyText(
                          color: white,
                          multilanguage: false,
                          text: bottomView4,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontsizeNormal: 14,
                          fontweight: FontWeight.w600,
                          fontsizeWeb: 15,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal,
                        ),
                      ),
                    ),

                    /* Subscription */
                    InkWell(
                      onTap: () async {},
                      borderRadius: BorderRadius.circular(8),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                        decoration: Utils.setBackground(primaryColor, 4),
                        child: MyText(
                          color: black,
                          multilanguage: true,
                          text: "subscribe",
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontsizeNormal: 14,
                          fontweight: FontWeight.w600,
                          fontsizeWeb: 15,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal,
                        ),
                      ),
                    ),

                    /* Login / MyStuff */
                    InkWell(
                      onTap: () async {},
                      borderRadius: BorderRadius.circular(8),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: MyText(
                          color: white,
                          multilanguage: Constant.userID != null ? false : true,
                          text: Constant.userID != null ? bottomView5 : "login",
                          fontsizeNormal: 14,
                          fontweight: FontWeight.w600,
                          fontsizeWeb: 15,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          textalign: TextAlign.center,
                          fontstyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      } else {
        return const SizedBox.shrink();
      }
    }
  }

  List<DropdownMenuItem<type.Result>>? _buildWebDropDownItems() {
    List<type.Result>? typeDropDownList = [];
    for (var i = 0;
        i < (homeProvider.sectionTypeModel.result?.length ?? 0) + 1;
        i++) {
      if (i == 0) {
        type.Result typeHomeResult = type.Result();
        typeHomeResult.id = 0;
        typeHomeResult.name = "Home";
        typeDropDownList.insert(i, typeHomeResult);
      } else {
        typeDropDownList.insert(i,
            (homeProvider.sectionTypeModel.result?[(i - 1)] ?? type.Result()));
      }
    }
    return typeDropDownList
        .map<DropdownMenuItem<type.Result>>((type.Result value) {
      return DropdownMenuItem<type.Result>(
        value: value,
        child: Container(
          constraints: const BoxConstraints(maxHeight: 30, minWidth: 0),
          decoration: Utils.setBackground(
            (typeDropDownList[homeProvider.selectedIndex].id ?? 0) ==
                    (value.id ?? 0)
                ? white
                : transparentColor,
            20,
          ),
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          child: MyText(
            color: (typeDropDownList[homeProvider.selectedIndex].id ?? 0) ==
                    (value.id ?? 0)
                ? black
                : white,
            multilanguage: false,
            text: (value.name.toString()),
            fontsizeNormal: 14,
            fontweight: FontWeight.w600,
            fontsizeWeb: 15,
            maxline: 1,
            overflow: TextOverflow.ellipsis,
            textalign: TextAlign.center,
            fontstyle: FontStyle.normal,
          ),
        ),
      );
    }).toList();
  }

  Widget tabTitle(List<type.Result>? sectionTypeList) {
    return ListView.separated(
      itemCount: (sectionTypeList?.length ?? 0) + 1,
      controller: tabScrollController,
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      separatorBuilder: (context, index) => const SizedBox(width: 5),
      itemBuilder: (BuildContext context, int index) {
        return Consumer<HomeProvider>(
          builder: (context, homeProvider, child) {
            return InkWell(
              borderRadius: BorderRadius.circular(25),
              onTap: () async {
                debugPrint("index ===========> $index");
                await getTabData(index, homeProvider.sectionTypeModel.result);
              },
              child: Container(
                constraints: const BoxConstraints(maxHeight: 30),
                decoration: Utils.setBackground(
                  homeProvider.selectedIndex == index
                      ? white
                      : transparentColor,
                  20,
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: MyText(
                  color: homeProvider.selectedIndex == index ? black : white,
                  multilanguage: false,
                  text: index == 0
                      ? "Home"
                      : index > 0
                          ? (sectionTypeList?[index - 1].name.toString() ?? "")
                          : "",
                  fontsizeNormal: 14,
                  fontweight: FontWeight.w600,
                  fontsizeWeb: 15,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  textalign: TextAlign.center,
                  fontstyle: FontStyle.normal,
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget tabItem(List<type.Result>? sectionTypeList) {
    return Container(
      width: MediaQuery.of(context).size.width,
      constraints: const BoxConstraints.expand(),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: Dimens.homeTabHeight,
            ),
            /* Banner */
            Consumer<SectionDataProvider>(
              builder: (context, sectionDataProvider, child) {
                if (sectionDataProvider.loadingBanner) {
                  return Container(
                    height: 230,
                    padding: const EdgeInsets.all(20),
                    child: Utils.pageLoader(),
                  );
                } else {
                  if (sectionDataProvider.sectionBannerModel.status == 200 &&
                      sectionDataProvider.sectionBannerModel.result != null) {
                    if (kIsWeb) {
                      if (MediaQuery.of(context).size.width < 720) {
                        return _mobileHomeBanner(
                            sectionDataProvider.sectionBannerModel.result);
                      } else {
                        return _webHomeBanner(
                            sectionDataProvider.sectionBannerModel.result);
                      }
                    } else {
                      return _mobileHomeBanner(
                          sectionDataProvider.sectionBannerModel.result);
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                }
              },
            ),

            /* Continue Watching & Remaining Sections */
            Consumer<SectionDataProvider>(
              builder: (context, sectionDataProvider, child) {
                if (sectionDataProvider.loadingSection) {
                  return Container(
                    height: 200,
                    padding: const EdgeInsets.all(20),
                    child: Utils.pageLoader(),
                  );
                } else {
                  if (sectionDataProvider.sectionListModel.status == 200) {
                    return Column(
                      children: [
                        /* Continue Watching */
                        (sectionDataProvider
                                    .sectionListModel.continueWatching !=
                                null)
                            ? continueWatchingLayout(sectionDataProvider
                                .sectionListModel.continueWatching)
                            : const SizedBox.shrink(),

                        /* Remaining Sections */
                        (sectionDataProvider.sectionListModel.result != null)
                            ? setSectionByType(
                                sectionDataProvider.sectionListModel.result)
                            : const SizedBox.shrink(),
                      ],
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                }
              },
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> getTabData(
      int position, List<type.Result>? sectionTypeList) async {
    final sectionDataProvider =
        Provider.of<SectionDataProvider>(context, listen: false);

    final homeProvider = Provider.of<HomeProvider>(context, listen: false);
    if (!mounted) return;
    await homeProvider.setSelectedTab(position);

    debugPrint("getTabData position ====> $position");
    debugPrint(
        "getTabData lastTabPosition ====> ${sectionDataProvider.lastTabPosition}");
    if (sectionDataProvider.lastTabPosition == position) {
      return;
    } else {
      sectionDataProvider.setTabPosition(position);
    }
    await sectionDataProvider.setLoading(true);
    await sectionDataProvider.getSectionBanner(
        position == 0 ? "0" : (sectionTypeList?[position - 1].id),
        position == 0 ? "1" : "2");
    await sectionDataProvider.getSectionList(
        position == 0 ? "0" : (sectionTypeList?[position - 1].id),
        position == 0 ? "1" : "2");
  }

  Widget _mobileHomeBanner(List<banner.Result>? sectionBannerList) {
    final sectionDataProvider =
        Provider.of<SectionDataProvider>(context, listen: false);
    if ((sectionBannerList?.length ?? 0) > 0) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: Dimens.homeBanner,
            child: CarouselSlider.builder(
              itemCount: (sectionBannerList?.length ?? 0),
              carouselController: pageController,
              options: CarouselOptions(
                initialPage: 0,
                height: Dimens.homeBanner,
                enlargeCenterPage: false,
                autoPlay: true,
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                viewportFraction: 1.0,
                onPageChanged: (val, _) async {
                  await sectionDataProvider.setCurrentBanner(val);
                },
              ),
              itemBuilder:
                  (BuildContext context, int index, int pageViewIndex) {
                return InkWell(
                  onTap: () {
                    log("Clicked on index ==> $index");
                    if ((sectionBannerList?[index].videoType ?? 0) == 1) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MovieDetails(
                              sectionBannerList?[index].id ?? 0,
                              sectionBannerList?[index].videoType ?? 0,
                              sectionBannerList?[index].typeId ?? 0,
                            );
                          },
                        ),
                      );
                    } else if ((sectionBannerList?[index].videoType ?? 0) ==
                        2) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return TvShowDetails(
                              sectionBannerList?[index].id ?? 0,
                              sectionBannerList?[index].videoType ?? 0,
                              sectionBannerList?[index].typeId ?? 0,
                            );
                          },
                        ),
                      );
                    }
                  },
                  child: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: Dimens.homeBanner,
                        child: MyNetworkImage(
                          imageUrl: sectionBannerList?[index].landscape ?? "",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: Dimens.homeBanner,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [
                              transparentColor,
                              transparentColor,
                              appBgColor,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            bottom: 0,
            child: Consumer<SectionDataProvider>(
              builder: (context, sectionDataProvider, child) {
                return CarouselIndicator(
                  count: (sectionBannerList?.length ?? 0),
                  index: sectionDataProvider.cBannerIndex,
                  space: 8,
                  height: 8,
                  width: 8,
                  cornerRadius: 4,
                  color: lightBlack,
                  activeColor: white,
                );
              },
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _webHomeBanner(List<banner.Result>? sectionBannerList) {
    final sectionDataProvider =
        Provider.of<SectionDataProvider>(context, listen: false);
    if ((sectionBannerList?.length ?? 0) > 0) {
      return SizedBox(
        width: MediaQuery.of(context).size.width,
        height: Dimens.homeWebBanner,
        child: CarouselSlider.builder(
          itemCount: (sectionBannerList?.length ?? 0),
          carouselController: pageController,
          options: CarouselOptions(
            initialPage: 0,
            height: Dimens.homeWebBanner,
            enlargeCenterPage: false,
            autoPlay: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            enableInfiniteScroll: true,
            autoPlayAnimationDuration: const Duration(milliseconds: 1000),
            viewportFraction: 0.95,
            onPageChanged: (val, _) async {
              await sectionDataProvider.setCurrentBanner(val);
            },
          ),
          itemBuilder: (BuildContext context, int index, int pageViewIndex) {
            return InkWell(
              onTap: () {
                log("Clicked on index ==> $index");
                if ((sectionBannerList?[index].videoType ?? 0) == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return MovieDetails(
                          sectionBannerList?[index].id ?? 0,
                          sectionBannerList?[index].videoType ?? 0,
                          sectionBannerList?[index].typeId ?? 0,
                        );
                      },
                    ),
                  );
                } else if ((sectionBannerList?[index].videoType ?? 0) == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return TvShowDetails(
                          sectionBannerList?[index].id ?? 0,
                          sectionBannerList?[index].videoType ?? 0,
                          sectionBannerList?[index].typeId ?? 0,
                        );
                      },
                    ),
                  );
                }
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(5, 2, 5, 2),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width *
                            (Dimens.webBannerImgPr),
                        height: Dimens.homeWebBanner,
                        child: MyNetworkImage(
                          imageUrl: sectionBannerList?[index].landscape ?? "",
                          fit: BoxFit.fill,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: Dimens.homeWebBanner,
                        alignment: Alignment.centerLeft,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                            colors: [
                              appBgColor,
                              appBgColor,
                              appBgColor,
                              appBgColor,
                              transparentColor,
                              transparentColor,
                              transparentColor,
                              transparentColor,
                              transparentColor,
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: Dimens.homeWebBanner,
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width *
                                  (1.0 - Dimens.webBannerImgPr),
                              constraints: const BoxConstraints(minHeight: 0),
                              padding:
                                  const EdgeInsets.fromLTRB(35, 50, 55, 35),
                              alignment: Alignment.centerLeft,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  MyText(
                                    color: white,
                                    text: sectionBannerList?[index].name ?? "",
                                    textalign: TextAlign.start,
                                    fontsizeNormal: 14,
                                    fontweight: FontWeight.w700,
                                    fontsizeWeb: 25,
                                    multilanguage: false,
                                    maxline: 2,
                                    overflow: TextOverflow.ellipsis,
                                    fontstyle: FontStyle.normal,
                                  ),
                                  const SizedBox(height: 12),
                                  MyText(
                                    color: whiteLight,
                                    text: sectionBannerList?[index]
                                            .categoryName ??
                                        "",
                                    textalign: TextAlign.start,
                                    fontsizeNormal: 14,
                                    fontweight: FontWeight.w600,
                                    fontsizeWeb: 15,
                                    multilanguage: false,
                                    maxline: 2,
                                    overflow: TextOverflow.ellipsis,
                                    fontstyle: FontStyle.normal,
                                  ),
                                  const SizedBox(height: 8),
                                  Expanded(
                                    child: MyText(
                                      color: whiteLight,
                                      text: sectionBannerList?[index]
                                              .description ??
                                          "",
                                      textalign: TextAlign.start,
                                      fontsizeNormal: 14,
                                      fontweight: FontWeight.w600,
                                      fontsizeWeb: 15,
                                      multilanguage: false,
                                      maxline:
                                          (MediaQuery.of(context).size.width <
                                                  1000)
                                              ? 2
                                              : 5,
                                      overflow: TextOverflow.ellipsis,
                                      fontstyle: FontStyle.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget continueWatchingLayout(List<ContinueWatching>? continueWatchingList) {
    if ((continueWatchingList?.length ?? 0) > 0) {
      final sectionDataProvider =
          Provider.of<SectionDataProvider>(context, listen: false);
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: MyText(
              color: white,
              text: "continuewatching",
              multilanguage: true,
              textalign: TextAlign.center,
              fontsizeNormal: 16,
              maxline: 1,
              fontweight: FontWeight.w600,
              fontsizeWeb: 16,
              overflow: TextOverflow.ellipsis,
              fontstyle: FontStyle.normal,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: Dimens.heightContiLand,
            child: ListView.separated(
              itemCount: (continueWatchingList?.length ?? 0),
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 20, right: 20),
              scrollDirection: Axis.horizontal,
              physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
              separatorBuilder: (context, index) => const SizedBox(
                width: 5,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    InkWell(
                      borderRadius: BorderRadius.circular(4),
                      onTap: () {
                        log("Clicked on index ==> $index");
                        if ((continueWatchingList?[index].videoType ?? 0) ==
                            1) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return MovieDetails(
                                  continueWatchingList?[index].id ?? 0,
                                  continueWatchingList?[index].videoType ?? 0,
                                  continueWatchingList?[index].typeId ?? 0,
                                );
                              },
                            ),
                          );
                        } else if ((continueWatchingList?[index].videoType ??
                                0) ==
                            2) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return TvShowDetails(
                                  continueWatchingList?[index].showId ?? 0,
                                  continueWatchingList?[index].videoType ?? 0,
                                  continueWatchingList?[index].typeId ?? 0,
                                );
                              },
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: Dimens.widthContiLand,
                        height: Dimens.heightContiLand,
                        alignment: Alignment.center,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: MyNetworkImage(
                            imageUrl:
                                continueWatchingList?[index].landscape ?? "",
                            fit: BoxFit.cover,
                            imgHeight: MediaQuery.of(context).size.height,
                            imgWidth: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 10, bottom: 8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () async {
                              Map<String, String> qualityUrlList =
                                  <String, String>{
                                '320p':
                                    continueWatchingList?[index].video320 ?? '',
                                '480p':
                                    continueWatchingList?[index].video480 ?? '',
                                '720p':
                                    continueWatchingList?[index].video720 ?? '',
                                '1080p':
                                    continueWatchingList?[index].video1080 ??
                                        '',
                              };
                              debugPrint(
                                  "qualityUrlList ==========> ${qualityUrlList.length}");
                              Constant.resolutionsUrls = qualityUrlList;
                              debugPrint(
                                  "resolutionsUrls ==========> ${Constant.resolutionsUrls.length}");
                              var isContinues = await Utils.openPlayer(
                                  context: context,
                                  playType: "Video",
                                  videoId: continueWatchingList?[index].id ?? 0,
                                  videoType:
                                      continueWatchingList?[index].videoType ??
                                          0,
                                  typeId:
                                      continueWatchingList?[index].typeId ?? 0,
                                  videoUrl:
                                      continueWatchingList?[index].video320 ??
                                          "",
                                  trailerUrl:
                                      continueWatchingList?[index].trailerUrl ??
                                          "",
                                  uploadType: continueWatchingList?[index]
                                          .videoUploadType ??
                                      "",
                                  vSubtitle:
                                      continueWatchingList?[index].subtitle ??
                                          "",
                                  vStopTime:
                                      continueWatchingList?[index].stopTime ??
                                          0);
                              if (isContinues != null && isContinues == true) {
                                await sectionDataProvider.getSectionBanner(
                                    "0", "1");
                                await sectionDataProvider.getSectionList(
                                    "0", "1");
                                Future.delayed(Duration.zero).then((value) {
                                  if (!mounted) return;
                                  setState(() {});
                                });
                              }
                            },
                            child: MyImage(
                              width: 30,
                              height: 30,
                              imagePath: "play.png",
                            ),
                          ),
                        ),
                        Container(
                          width: Dimens.widthContiLand,
                          constraints: const BoxConstraints(minWidth: 0),
                          padding: const EdgeInsets.all(3),
                          child: LinearPercentIndicator(
                            padding: const EdgeInsets.all(0),
                            barRadius: const Radius.circular(2),
                            lineHeight: 4,
                            percent: Utils.getPercentage(
                                continueWatchingList?[index].videoDuration ?? 0,
                                continueWatchingList?[index].stopTime ?? 0),
                            backgroundColor: secProgressColor,
                            progressColor: primaryColor,
                          ),
                        ),
                        (continueWatchingList?[index].releaseTag != null &&
                                (continueWatchingList?[index].releaseTag ?? "")
                                    .isNotEmpty)
                            ? Container(
                                decoration: const BoxDecoration(
                                  color: black,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(4),
                                    bottomRight: Radius.circular(4),
                                  ),
                                  shape: BoxShape.rectangle,
                                ),
                                alignment: Alignment.center,
                                width: Dimens.widthContiLand,
                                height: 15,
                                child: MyText(
                                  color: white,
                                  multilanguage: false,
                                  text:
                                      continueWatchingList?[index].releaseTag ??
                                          "",
                                  textalign: TextAlign.center,
                                  fontsizeNormal: 6,
                                  fontweight: FontWeight.w700,
                                  fontsizeWeb: 10,
                                  maxline: 1,
                                  overflow: TextOverflow.ellipsis,
                                  fontstyle: FontStyle.normal,
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget setSectionByType(List<list.Result>? sectionList) {
    return ListView.builder(
      itemCount: sectionList?.length ?? 0,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (sectionList?[index].data != null &&
            (sectionList?[index].data?.length ?? 0) > 0) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                child: MyText(
                  color: white,
                  text: sectionList?[index].title.toString() ?? "",
                  textalign: TextAlign.center,
                  fontsizeNormal: 16,
                  fontweight: FontWeight.w600,
                  fontsizeWeb: 16,
                  multilanguage: false,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal,
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: getRemainingDataHeight(
                  sectionList?[index].videoType ?? "",
                  sectionList?[index].screenLayout ?? "",
                ),
                child: ListView.separated(
                  itemCount: (sectionList?[index].data?.length ?? 0),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  separatorBuilder: (context, index) => const SizedBox(
                    width: 5,
                  ),
                  itemBuilder: (BuildContext context, int postion) {
                    /* video_type =>  1-video,  2-show,  3-language,  4-category */
                    /* screen_layout =>  landscape, potrait, square */
                    if ((sectionList?[index].videoType ?? "") == "1") {
                      if ((sectionList?[index].screenLayout ?? "") ==
                          "landscape") {
                        return landscape(sectionList?[index].data);
                      } else if ((sectionList?[index].screenLayout ?? "") ==
                          "potrait") {
                        return portrait(sectionList?[index].data);
                      } else if ((sectionList?[index].screenLayout ?? "") ==
                          "square") {
                        return square(sectionList?[index].data);
                      } else {
                        return landscape(sectionList?[index].data);
                      }
                    } else if ((sectionList?[index].videoType ?? "") == "2") {
                      if ((sectionList?[index].screenLayout ?? "") ==
                          "landscape") {
                        return landscape(sectionList?[index].data);
                      } else if ((sectionList?[index].screenLayout ?? "") ==
                          "potrait") {
                        return portrait(sectionList?[index].data);
                      } else if ((sectionList?[index].screenLayout ?? "") ==
                          "square") {
                        return square(sectionList?[index].data);
                      } else {
                        return landscape(sectionList?[index].data);
                      }
                    } else if ((sectionList?[index].videoType ?? "") == "3") {
                      return languageLayout(sectionList?[index].data);
                    } else if ((sectionList?[index].videoType ?? "") == "4") {
                      return genresLayout(sectionList?[index].data);
                    } else {
                      if ((sectionList?[index].screenLayout ?? "") ==
                          "landscape") {
                        return landscape(sectionList?[index].data);
                      } else if ((sectionList?[index].screenLayout ?? "") ==
                          "potrait") {
                        return portrait(sectionList?[index].data);
                      } else if ((sectionList?[index].screenLayout ?? "") ==
                          "square") {
                        return square(sectionList?[index].data);
                      } else {
                        return landscape(sectionList?[index].data);
                      }
                    }
                  },
                ),
              ),
            ],
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }

  double getRemainingDataHeight(String? videoType, String? layoutType) {
    if (videoType == "1" || videoType == "2") {
      if (layoutType == "landscape") {
        return Dimens.heightLand;
      } else if (layoutType == "potrait") {
        return Dimens.heightPort;
      } else if (layoutType == "square") {
        return Dimens.heightSquare;
      } else {
        return Dimens.heightLand;
      }
    } else if (videoType == "3" || videoType == "4") {
      return Dimens.heightLangGen;
    } else {
      if (layoutType == "landscape") {
        return Dimens.heightLand;
      } else if (layoutType == "potrait") {
        return Dimens.heightPort;
      } else if (layoutType == "square") {
        return Dimens.heightSquare;
      } else {
        return Dimens.heightLand;
      }
    }
  }

  Widget landscape(List<Datum>? sectionDataList) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Dimens.heightLand,
      child: ListView.separated(
        itemCount: sectionDataList?.length ?? 0,
        shrinkWrap: true,
        physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              log("Clicked on index ==> $index");
              if ((sectionDataList?[index].videoType ?? 0) == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MovieDetails(
                        sectionDataList?[index].id ?? 0,
                        sectionDataList?[index].videoType ?? 0,
                        sectionDataList?[index].typeId ?? 0,
                      );
                    },
                  ),
                );
              } else if ((sectionDataList?[index].videoType ?? 0) == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TvShowDetails(
                        sectionDataList?[index].id ?? 0,
                        sectionDataList?[index].videoType ?? 0,
                        sectionDataList?[index].typeId ?? 0,
                      );
                    },
                  ),
                );
              }
            },
            child: Container(
              width: Dimens.widthLand,
              height: Dimens.heightLand,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: MyNetworkImage(
                  imageUrl: sectionDataList?[index].landscape.toString() ?? "",
                  fit: BoxFit.cover,
                  imgHeight: MediaQuery.of(context).size.height,
                  imgWidth: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget portrait(List<Datum>? sectionDataList) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Dimens.heightPort,
      child: ListView.separated(
        itemCount: sectionDataList?.length ?? 0,
        shrinkWrap: true,
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              log("Clicked on index ==> $index");
              if ((sectionDataList?[index].videoType ?? 0) == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MovieDetails(
                        sectionDataList?[index].id ?? 0,
                        sectionDataList?[index].videoType ?? 0,
                        sectionDataList?[index].typeId ?? 0,
                      );
                    },
                  ),
                );
              } else if ((sectionDataList?[index].videoType ?? 0) == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TvShowDetails(
                        sectionDataList?[index].id ?? 0,
                        sectionDataList?[index].videoType ?? 0,
                        sectionDataList?[index].typeId ?? 0,
                      );
                    },
                  ),
                );
              }
            },
            child: Container(
              width: Dimens.widthPort,
              height: Dimens.heightPort,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: MyNetworkImage(
                  imageUrl: sectionDataList?[index].thumbnail.toString() ?? "",
                  fit: BoxFit.cover,
                  imgHeight: MediaQuery.of(context).size.height,
                  imgWidth: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget square(List<Datum>? sectionDataList) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Dimens.heightSquare,
      child: ListView.separated(
        itemCount: sectionDataList?.length ?? 0,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, right: 20),
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              log("Clicked on index ==> $index");
              if ((sectionDataList?[index].videoType ?? 0) == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return MovieDetails(
                        sectionDataList?[index].id ?? 0,
                        sectionDataList?[index].videoType ?? 0,
                        sectionDataList?[index].typeId ?? 0,
                      );
                    },
                  ),
                );
              } else if ((sectionDataList?[index].videoType ?? 0) == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return TvShowDetails(
                        sectionDataList?[index].id ?? 0,
                        sectionDataList?[index].videoType ?? 0,
                        sectionDataList?[index].typeId ?? 0,
                      );
                    },
                  ),
                );
              }
            },
            child: Container(
              width: Dimens.widthSquare,
              height: Dimens.heightSquare,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: MyNetworkImage(
                  imageUrl: sectionDataList?[index].thumbnail.toString() ?? "",
                  fit: BoxFit.cover,
                  imgHeight: MediaQuery.of(context).size.height,
                  imgWidth: MediaQuery.of(context).size.width,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget languageLayout(List<Datum>? sectionDataList) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Dimens.heightLangGen,
      child: ListView.separated(
        itemCount: sectionDataList?.length ?? 0,
        shrinkWrap: true,
        physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {
                  log("Clicked on index ==> $index");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return VideosByID(
                          sectionDataList?[index].id ?? 0,
                          sectionDataList?[index].name ?? "",
                          "ByLanguage",
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  width: Dimens.widthLangGen,
                  height: Dimens.heightLangGen,
                  alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: MyNetworkImage(
                          imageUrl:
                              sectionDataList?[index].image.toString() ?? "",
                          fit: BoxFit.fill,
                          imgHeight: MediaQuery.of(context).size.height,
                          imgWidth: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: Dimens.homeBanner,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [
                              transparentColor,
                              transparentColor,
                              appBgColor,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3),
                child: MyText(
                  color: white,
                  text: sectionDataList?[index].name.toString() ?? "",
                  textalign: TextAlign.center,
                  fontsizeNormal: 14,
                  fontweight: FontWeight.w500,
                  fontsizeWeb: 16,
                  multilanguage: false,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget genresLayout(List<Datum>? sectionDataList) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Dimens.heightLangGen,
      child: ListView.separated(
        itemCount: sectionDataList?.length ?? 0,
        shrinkWrap: true,
        physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(
          width: 5,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: [
              InkWell(
                borderRadius: BorderRadius.circular(4),
                onTap: () {
                  log("Clicked on index ==> $index");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return VideosByID(
                          sectionDataList?[index].id ?? 0,
                          sectionDataList?[index].name ?? "",
                          "ByCategory",
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  width: Dimens.widthLangGen,
                  height: Dimens.heightLangGen,
                  alignment: Alignment.center,
                  child: Stack(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: MyNetworkImage(
                          imageUrl:
                              sectionDataList?[index].image.toString() ?? "",
                          fit: BoxFit.fill,
                          imgHeight: MediaQuery.of(context).size.height,
                          imgWidth: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(0),
                        width: MediaQuery.of(context).size.width,
                        height: Dimens.homeBanner,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [
                              transparentColor,
                              transparentColor,
                              appBgColor,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(3),
                child: MyText(
                  color: white,
                  text: sectionDataList?[index].name.toString() ?? "",
                  textalign: TextAlign.center,
                  fontsizeNormal: 14,
                  fontweight: FontWeight.w500,
                  fontsizeWeb: 16,
                  multilanguage: false,
                  maxline: 1,
                  overflow: TextOverflow.ellipsis,
                  fontstyle: FontStyle.normal,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
