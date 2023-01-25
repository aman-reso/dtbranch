import 'dart:async';

import 'package:dtlive/model/subscriptionmodel.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:dtlive/provider/subscriptionprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/utils.dart';
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
  PageController pageController = PageController();

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

  @override
  Widget build(BuildContext context) {
    final subscriptionProvider =
        Provider.of<SubscriptionProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: subscriptionBG,
      appBar: Utils.myAppBarWithBack(context, "subsciption"),
      body: subscriptionProvider.loading
          ? Utils.pageLoader()
          : (subscriptionProvider.subscriptionModel.status == 200)
              ? Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      alignment: Alignment.center,
                      child: MyText(
                        color: otherColor,
                        text: "subscriptiondesc",
                        multilanguage: true,
                        textalign: TextAlign.center,
                        fontsize: 16,
                        maxline: 2,
                        fontwaight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                        fontstyle: FontStyle.normal,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    /* Remaining Data */
                    (subscriptionProvider.subscriptionModel.result != null)
                        ? Flexible(
                            child: buildPackageItem(
                                subscriptionProvider.subscriptionModel.result),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )
              : const NoData(),
    );
  }

  Widget buildPackageItem(List<Result>? packageList) {
    return PageView.builder(
      itemCount: packageList?.length ?? 0,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Wrap(
            children: [
              Card(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 5,
                color: (packageList?.elementAt(index).isBuy == 1
                    ? primaryColor
                    : black),
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
                            color: (packageList?.elementAt(index).isBuy == 1
                                ? black
                                : primaryColor),
                            text: packageList?.elementAt(index).name ?? "",
                            textalign: TextAlign.center,
                            fontsize: 22,
                            maxline: 1,
                            multilanguage: false,
                            overflow: TextOverflow.ellipsis,
                            fontwaight: FontWeight.w700,
                            fontstyle: FontStyle.normal,
                          ),
                          MyText(
                            color: (packageList?.elementAt(index).isBuy == 1
                                ? black
                                : primaryColor),
                            text:
                                "${packageList?.elementAt(index).price.toString() ?? ""} / ${packageList?.elementAt(index).time.toString() ?? ""} ${packageList?.elementAt(index).type.toString() ?? ""}",
                            textalign: TextAlign.center,
                            fontsize: 20,
                            maxline: 1,
                            multilanguage: false,
                            overflow: TextOverflow.ellipsis,
                            fontwaight: FontWeight.bold,
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
                    (packageList?.elementAt(index).data != null &&
                            (packageList?.elementAt(index).data?.length ?? 0) >
                                0)
                        ? Scrollbar(
                            thickness: 3,
                            thumbVisibility: true,
                            scrollbarOrientation: ScrollbarOrientation.right,
                            radius: const Radius.circular(5),
                            child: AlignedGridView.count(
                              shrinkWrap: true,
                              crossAxisCount: 1,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              itemCount:
                                  (packageList?.elementAt(index).data?.length ??
                                      0),
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              physics: const AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.vertical,
                              itemBuilder:
                                  (BuildContext context, int position) {
                                return Container(
                                  constraints:
                                      const BoxConstraints(minHeight: 30),
                                  width: MediaQuery.of(context).size.width,
                                  margin: const EdgeInsets.only(bottom: 15),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: MyText(
                                          color: (packageList
                                                      ?.elementAt(index)
                                                      .isBuy ==
                                                  1
                                              ? black
                                              : otherColor),
                                          text: packageList
                                                  ?.elementAt(index)
                                                  .data
                                                  ?.elementAt(position)
                                                  .packageKey ??
                                              "",
                                          textalign: TextAlign.start,
                                          multilanguage: false,
                                          fontsize: 16,
                                          maxline: 3,
                                          overflow: TextOverflow.ellipsis,
                                          fontwaight: FontWeight.w600,
                                          fontstyle: FontStyle.normal,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      ((packageList
                                                          ?.elementAt(index)
                                                          .data
                                                          ?.elementAt(position)
                                                          .packageValue ??
                                                      "") ==
                                                  "1" ||
                                              (packageList
                                                          ?.elementAt(index)
                                                          .data
                                                          ?.elementAt(position)
                                                          .packageValue ??
                                                      "") ==
                                                  "0")
                                          ? MyImage(
                                              width: 30,
                                              height: 30,
                                              color: (packageList
                                                              ?.elementAt(index)
                                                              .data
                                                              ?.elementAt(
                                                                  position)
                                                              .packageValue ??
                                                          "") ==
                                                      "1"
                                                  ? (packageList
                                                              ?.elementAt(index)
                                                              .isBuy ==
                                                          1
                                                      ? black
                                                      : primaryColor)
                                                  : redColor,
                                              imagePath: (packageList
                                                              ?.elementAt(index)
                                                              .data
                                                              ?.elementAt(
                                                                  position)
                                                              .packageValue ??
                                                          "") ==
                                                      "1"
                                                  ? "tick_mark.png"
                                                  : "cross_mark.png",
                                            )
                                          : MyText(
                                              color: (packageList
                                                          ?.elementAt(index)
                                                          .isBuy ==
                                                      1
                                                  ? black
                                                  : otherColor),
                                              text: packageList
                                                      ?.elementAt(index)
                                                      .data
                                                      ?.elementAt(position)
                                                      .packageValue ??
                                                  "",
                                              textalign: TextAlign.center,
                                              fontsize: 22,
                                              multilanguage: false,
                                              maxline: 1,
                                              overflow: TextOverflow.ellipsis,
                                              fontwaight: FontWeight.bold,
                                              fontstyle: FontStyle.normal,
                                            ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        : const SizedBox.shrink(),
                    const SizedBox(
                      height: 20,
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(5),
                        onTap: () {},
                        child: Container(
                          height: 52,
                          width: MediaQuery.of(context).size.width * 0.5,
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          decoration: BoxDecoration(
                            color: (packageList?.elementAt(index).isBuy == 1
                                ? white
                                : primaryColor),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: MyText(
                            color: black,
                            text: "chooseplan",
                            textalign: TextAlign.center,
                            fontsize: 18,
                            fontwaight: FontWeight.w800,
                            multilanguage: true,
                            maxline: 1,
                            overflow: TextOverflow.ellipsis,
                            fontstyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
