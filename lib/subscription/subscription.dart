import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dtlive/model/subscriptionmodel.dart';
import 'package:dtlive/pages/loginsocial.dart';
import 'package:dtlive/shimmer/shimmerutils.dart';
import 'package:dtlive/subscription/allpayment.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:dtlive/provider/subscriptionprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class Subscription extends StatefulWidget {
  const Subscription({
    Key? key,
  }) : super(key: key);

  @override
  State<Subscription> createState() => SubscriptionState();
}

class SubscriptionState extends State<Subscription> {
  // PageController pageController = PageController();
  CarouselController pageController = CarouselController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    await subscriptionProvider.getPackages();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
  }

  _checkAndPay(List<Result>? packageList, int index) async {
    if (Constant.userID != null) {
      for (var i = 0; i < (packageList?.length ?? 0); i++) {
        if (packageList?[i].isBuy == 1) {
          debugPrint("<============= Purchaged =============>");
          Utils.showSnackbar(context, "info", "already_purchased", true);
          return;
        }
      }
      if (packageList?[index].isBuy == 0) {
        await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return AllPayment(
                payType: 'Package',
                itemId: packageList?[index].id.toString() ?? '',
                price: packageList?[index].price.toString() ?? '',
                itemTitle: packageList?[index].name.toString() ?? '',
                typeId: '',
                videoType: '',
                productPackage: '',
                currency: '',
              );
            },
          ),
        );
      }
    } else {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginSocial();
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return Scaffold(
        backgroundColor: subscriptionBG,
        body: _buildSubscription(),
      );
    } else {
      return Scaffold(
        backgroundColor: subscriptionBG,
        appBar: Utils.myAppBarWithBack(context, "subsciption", true),
        body: _buildSubscription(),
      );
    }
  }

  Widget _buildSubscription() {
    final subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    if (subscriptionProvider.loading) {
      return ShimmerUtils.buildSubscribeShimmer(context);
    } else {
      if (subscriptionProvider.subscriptionModel.status == 200) {
        return Column(
          children: [
            if (kIsWeb) SizedBox(height: Dimens.homeTabHeight),
            const SizedBox(height: 12),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: const EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.center,
              child: MyText(
                color: otherColor,
                text: "subscriptiondesc",
                multilanguage: true,
                textalign: TextAlign.center,
                fontsizeNormal: 16,
                fontsizeWeb: 18,
                maxline: 2,
                fontweight: FontWeight.w600,
                overflow: TextOverflow.ellipsis,
                fontstyle: FontStyle.normal,
              ),
            ),
            const SizedBox(height: 12),
            /* Remaining Data */
            (subscriptionProvider.subscriptionModel.result != null)
                ? Flexible(
                    child: buildPackageItem(
                        subscriptionProvider.subscriptionModel.result),
                  )
                : const SizedBox.shrink(),
            const SizedBox(height: 20),
          ],
        );
      } else {
        return const NoData(title: '', subTitle: '');
      }
    }
  }

  Widget buildPackageItem(List<Result>? packageList) {
    return CarouselSlider.builder(
      itemCount: (packageList?.length ?? 0),
      carouselController: pageController,
      options: CarouselOptions(
        initialPage: 0,
        height: MediaQuery.of(context).size.height,
        enlargeCenterPage: true,
        enlargeFactor: 0.18,
        autoPlay: false,
        autoPlayCurve: Curves.easeInOutQuart,
        enableInfiniteScroll: true,
        viewportFraction: 0.8,
      ),
      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
        return Wrap(
          children: [
            Card(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              elevation: 3,
              color: (packageList?[index].isBuy == 1 ? primaryColor : black),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.only(left: 18, right: 18),
                    constraints: const BoxConstraints(minHeight: 55),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        MyText(
                          color: (packageList?[index].isBuy == 1
                              ? black
                              : primaryColor),
                          text: packageList?[index].name ?? "",
                          textalign: TextAlign.center,
                          fontsizeNormal: 18,
                          fontsizeWeb: 24,
                          maxline: 1,
                          multilanguage: false,
                          overflow: TextOverflow.ellipsis,
                          fontweight: FontWeight.w700,
                          fontstyle: FontStyle.normal,
                        ),
                        MyText(
                          color: (packageList?[index].isBuy == 1
                              ? black
                              : primaryColor),
                          text:
                              "${packageList?[index].price.toString() ?? ""} / ${packageList?[index].time.toString() ?? ""} ${packageList?[index].type.toString() ?? ""}",
                          textalign: TextAlign.center,
                          fontsizeNormal: 16,
                          fontsizeWeb: 22,
                          maxline: 1,
                          multilanguage: false,
                          overflow: TextOverflow.ellipsis,
                          fontweight: FontWeight.w600,
                          fontstyle: FontStyle.normal,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 0.5,
                    margin: const EdgeInsets.only(bottom: 12),
                    color: otherColor,
                  ),
                  (packageList?[index].data != null &&
                          (packageList?[index].data?.length ?? 0) > 0)
                      ? Scrollbar(
                          thickness: 3,
                          thumbVisibility: true,
                          scrollbarOrientation: ScrollbarOrientation.right,
                          controller: scrollController,
                          radius: const Radius.circular(5),
                          child: AlignedGridView.count(
                            shrinkWrap: true,
                            crossAxisCount: 1,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            itemCount: (packageList?[index].data?.length ?? 0),
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            physics: const AlwaysScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (BuildContext context, int position) {
                              return Container(
                                constraints:
                                    const BoxConstraints(minHeight: 30),
                                width: MediaQuery.of(context).size.width,
                                margin: const EdgeInsets.only(bottom: 15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: MyText(
                                        color: (packageList?[index].isBuy == 1
                                            ? black
                                            : otherColor),
                                        text: packageList?[index]
                                                .data?[position]
                                                .packageKey ??
                                            "",
                                        textalign: TextAlign.start,
                                        multilanguage: false,
                                        fontsizeNormal: 15,
                                        fontsizeWeb: 18,
                                        maxline: 3,
                                        overflow: TextOverflow.ellipsis,
                                        fontweight: FontWeight.w600,
                                        fontstyle: FontStyle.normal,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    ((packageList?[index]
                                                        .data?[position]
                                                        .packageValue ??
                                                    "") ==
                                                "1" ||
                                            (packageList?[index]
                                                        .data?[position]
                                                        .packageValue ??
                                                    "") ==
                                                "0")
                                        ? MyImage(
                                            width: 23,
                                            height: 23,
                                            color: (packageList?[index]
                                                            .data?[position]
                                                            .packageValue ??
                                                        "") ==
                                                    "1"
                                                ? (packageList?[index].isBuy ==
                                                        1
                                                    ? black
                                                    : primaryColor)
                                                : redColor,
                                            imagePath: (packageList?[index]
                                                            .data?[position]
                                                            .packageValue ??
                                                        "") ==
                                                    "1"
                                                ? "tick_mark.png"
                                                : "cross_mark.png",
                                          )
                                        : MyText(
                                            color:
                                                (packageList?[index].isBuy == 1
                                                    ? black
                                                    : otherColor),
                                            text: packageList?[index]
                                                    .data?[position]
                                                    .packageValue ??
                                                "",
                                            textalign: TextAlign.center,
                                            fontsizeNormal: 16,
                                            fontsizeWeb: 24,
                                            multilanguage: false,
                                            maxline: 1,
                                            overflow: TextOverflow.ellipsis,
                                            fontweight: FontWeight.bold,
                                            fontstyle: FontStyle.normal,
                                          ),
                                  ],
                                ),
                              );
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(height: 20),

                  /* Choose Plan */
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () async {
                        _checkAndPay(packageList, index);
                      },
                      child: Container(
                        height: 45,
                        width: MediaQuery.of(context).size.width * 0.5,
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        decoration: BoxDecoration(
                          color: (packageList?[index].isBuy == 1
                              ? white
                              : primaryColor),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: Consumer<SubscriptionProvider>(
                          builder: (context, subscriptionProvider, child) {
                            return MyText(
                              color: black,
                              text: (packageList?[index].isBuy == 1)
                                  ? "current"
                                  : "chooseplan",
                              textalign: TextAlign.center,
                              fontsizeNormal: 16,
                              fontsizeWeb: 20,
                              fontweight: FontWeight.w700,
                              multilanguage: true,
                              maxline: 1,
                              overflow: TextOverflow.ellipsis,
                              fontstyle: FontStyle.normal,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}