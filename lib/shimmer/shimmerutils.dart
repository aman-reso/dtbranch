import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/shimmer/shimmerwidget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ShimmerUtils {
  static Widget bannerMobile(context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: Dimens.homeBanner,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: Dimens.homeBanner,
                child: ShimmerWidget.roundcorner(
                  height: Dimens.homeBanner,
                  shapeBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0))),
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
        Positioned(
          bottom: 0,
          child: CarouselIndicator(
            count: 6,
            index: 1,
            space: 8,
            height: 8,
            width: 8,
            cornerRadius: 4,
            color: dotsDefaultColor,
            activeColor: dotsDefaultColor,
          ),
        ),
      ],
    );
  }

  static Widget bannerWeb(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Dimens.homeWebBanner,
      margin: const EdgeInsets.fromLTRB(27, 2, 27, 7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          color: lightBlack,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: Dimens.homeWebBanner,
            child: ShimmerWidget.roundcorner(
              height: Dimens.homeWebBanner,
              shimmerColor: lightBlack,
              shapeBorder: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
          ),
        ),
      ),
    );
  }

  static Widget channelBannerMobile(context) {
    return Stack(
      alignment: AlignmentDirectional.bottomCenter,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: Dimens.channelBanner,
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: Dimens.channelBanner,
                child: ShimmerWidget.roundcorner(
                  height: Dimens.channelBanner,
                  shapeBorder: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(0))),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width,
                height: Dimens.channelBanner,
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
        Positioned(
          bottom: 0,
          child: CarouselIndicator(
            count: 6,
            index: 1,
            space: 8,
            height: 8,
            width: 8,
            cornerRadius: 4,
            color: dotsDefaultColor,
            activeColor: dotsDefaultColor,
          ),
        ),
      ],
    );
  }

  static Widget channelBannerWeb(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: Dimens.channelWebBanner,
      margin: const EdgeInsets.fromLTRB(27, 2, 27, 7),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          color: lightBlack,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: Dimens.channelWebBanner,
            child: ShimmerWidget.roundcorner(
              height: Dimens.channelWebBanner,
              shimmerColor: lightBlack,
              shapeBorder: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
          ),
        ),
      ),
    );
  }

  static Widget continueWatching(context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 25),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ShimmerWidget.roundrectborder(
            height: 15,
            width: 100,
            shimmerColor: lightBlack,
            shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: Dimens.heightContiLand,
          child: ListView.separated(
            itemCount: kIsWeb ? 6 : 3,
            shrinkWrap: true,
            padding: const EdgeInsets.only(left: 20, right: 20),
            scrollDirection: Axis.horizontal,
            physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
            separatorBuilder: (context, index) => const SizedBox(width: 5),
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  Container(
                    width: Dimens.widthContiLand,
                    height: Dimens.heightContiLand,
                    alignment: Alignment.center,
                    child: ShimmerWidget.roundcorner(
                      width: Dimens.widthContiLand,
                      height: Dimens.heightContiLand,
                      shimmerColor: lightBlack,
                      shapeBorder: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4))),
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const Padding(
                        padding: EdgeInsets.only(left: 10, bottom: 8),
                        child: ShimmerWidget.circular(
                          width: 30,
                          height: 30,
                          shimmerColor: black,
                        ),
                      ),
                      Container(
                        width: Dimens.widthContiLand,
                        constraints: const BoxConstraints(minWidth: 0),
                        padding: const EdgeInsets.all(3),
                        child: ShimmerWidget.roundcorner(
                          width: Dimens.widthContiLand,
                          height: 4,
                          shimmerColor: black,
                          shapeBorder: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(2))),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  static Widget setSectionByType(context, String layoutType) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 25),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: ShimmerWidget.roundrectborder(
            height: 15,
            width: 100,
            shimmerColor: lightBlack,
            shapeBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
          ),
        ),
        const SizedBox(height: 12),
        if (layoutType == "landscape") landscapeList(context),
        if (layoutType == "potrait") portraitList(context),
        if (layoutType == "square") squareList(context),
        if (layoutType == "langGen") languageGenresList(context),
      ],
    );
  }

  static Widget landscapeList(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Dimens.heightLand,
      child: ListView.separated(
        itemCount: kIsWeb ? 7 : 3,
        shrinkWrap: true,
        physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: Dimens.widthLand,
            height: Dimens.heightLand,
            alignment: Alignment.center,
            child: ShimmerWidget.roundcorner(
              height: Dimens.heightLand,
              shapeBorder: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
          );
        },
      ),
    );
  }

  static Widget portraitList(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Dimens.heightPort,
      child: ListView.separated(
        itemCount: kIsWeb ? 7 : 3,
        shrinkWrap: true,
        physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: Dimens.widthPort,
            height: Dimens.heightPort,
            alignment: Alignment.center,
            child: ShimmerWidget.roundcorner(
              height: Dimens.heightPort,
              shapeBorder: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
          );
        },
      ),
    );
  }

  static Widget squareList(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Dimens.heightSquare,
      child: ListView.separated(
        itemCount: kIsWeb ? 7 : 3,
        shrinkWrap: true,
        physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: Dimens.widthSquare,
            height: Dimens.heightSquare,
            alignment: Alignment.center,
            child: ShimmerWidget.roundcorner(
              height: Dimens.heightSquare,
              shapeBorder: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4))),
            ),
          );
        },
      ),
    );
  }

  static Widget languageGenresList(context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: Dimens.heightLangGen,
      child: ListView.separated(
        itemCount: kIsWeb ? 7 : 3,
        shrinkWrap: true,
        physics: const PageScrollPhysics(parent: BouncingScrollPhysics()),
        padding: const EdgeInsets.only(left: 20, right: 20),
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
            width: Dimens.widthLangGen,
            height: Dimens.heightLangGen,
            child: Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  width: Dimens.widthLangGen,
                  height: Dimens.heightLangGen,
                  alignment: Alignment.center,
                  child: ShimmerWidget.roundcorner(
                    height: Dimens.heightLangGen,
                    shapeBorder: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(3),
                  child: ShimmerWidget.roundrectborder(
                    height: 10,
                    shimmerColor: black,
                    shapeBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(2))),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
