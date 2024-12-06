import 'dart:async';
import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:dtlive/model/channelsectionmodel.dart';
import 'package:dtlive/model/channelsectionmodel.dart' as banner;
import 'package:dtlive/pages/loginsocial.dart';
import 'package:dtlive/pages/player_pod.dart';
import 'package:dtlive/shimmer/shimmerutils.dart';
import 'package:dtlive/subscription/subscription.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/dimens.dart';
import 'package:dtlive/webwidget/footerweb.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:dtlive/pages/player_vimeo.dart';
import 'package:dtlive/pages/player_youtube.dart';
import 'package:dtlive/provider/channelsectionprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Channels extends StatefulWidget {
  const Channels({Key? key}) : super(key: key);

  @override
  State<Channels> createState() => ChannelsState();
}

class ChannelsState extends State<Channels> {
  late ChannelSectionProvider channelSectionProvider;
  CarouselController carouselController = CarouselController();

  @override
  void initState() {
    channelSectionProvider =
        Provider.of<ChannelSectionProvider>(context, listen: false);
    super.initState();
    _getData();
  }

  _getData() async {
    await channelSectionProvider.getChannelSection();
    Future.delayed(Duration.zero).then((value) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  void dispose() {
    channelSectionProvider.clearProvider();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      body: SafeArea(
        child: _buildChannelPage(),
      ),
    );
  }

  Widget _buildChannelPage() {
    if (channelSectionProvider.loading) {
      return SingleChildScrollView(child: channelShimmer());
    } else {
      if (channelSectionProvider.channelSectionModel.status == 200) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: _buildVideoItem(),
        );
      } else {
        return const NoData(title: '', subTitle: '');
      }
    }
  }

  /* Section Shimmer */
  Widget channelShimmer() {
    return Column(
      children: [
        /* Banner */
        if ((kIsWeb || Constant.isTV) &&
            MediaQuery.of(context).size.width > 720)
          ShimmerUtils.channelBannerWeb(context)
        else
          ShimmerUtils.channelBannerMobile(context),

        /* Remaining Sections */
        ListView.builder(
          itemCount: 10, // itemCount must be greater than 5
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (BuildContext context, int index) {
            if (index == 1) {
              return ShimmerUtils.setChannelSections(context, "potrait");
            } else if (index == 2) {
              return ShimmerUtils.setChannelSections(context, "square");
            } else if (index == 3) {
              return ShimmerUtils.setChannelSections(context, "potrait");
            } else {
              return ShimmerUtils.setChannelSections(context, "landscape");
            }
          },
        ),
      ],
    );
  }


  /* ========= Open Player ========= */
  openPlayer(List<dynamic>? sectionBannerList, int index) async {
    if (Constant.userID != null) {
      if ((sectionBannerList?[index].link ?? "").isNotEmpty) {
        if ((sectionBannerList?[index].isBuy ?? 0) == 1) {
          if (kIsWeb) {
            if ((sectionBannerList?[index].link ?? "").contains("youtube")) {
              return PlayerYoutube(
                "Channel",
                0,
                0,
                0,
                0,
                sectionBannerList?[index].link ?? "",
                0,
                "",
                sectionBannerList?[index].image ?? "",
              );
            } else {
              return PlayerPod(
                "Channel",
                0,
                0,
                0,
                0,
                sectionBannerList?[index].link ?? "",
                0,
                "",
                sectionBannerList?[index].image ?? "",
              );
            }
          } else {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  if ((sectionBannerList?[index].link ?? "")
                      .contains("youtube")) {
                    return PlayerYoutube(
                      "Channel",
                      0,
                      0,
                      0,
                      0,
                      sectionBannerList?[index].link ?? "",
                      0,
                      "",
                      sectionBannerList?[index].image ?? "",
                    );
                  } else if ((sectionBannerList?[index].link ?? "")
                      .contains("vimeo")) {
                    return PlayerVimeo(
                      "Channel",
                      0,
                      0,
                      0,
                      0,
                      sectionBannerList?[index].link ?? "",
                      0,
                      "",
                      sectionBannerList?[index].image ?? "",
                    );
                  } else {
                    return PlayerPod(
                      "Channel",
                      0,
                      0,
                      0,
                      0,
                      sectionBannerList?[index].link ?? "",
                      0,
                      "",
                      sectionBannerList?[index].image ?? "",
                    );
                  }
                },
              ),
            );
          }
        } else {
          dynamic isSubscribed = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const Subscription();
              },
            ),
          );
          debugPrint("isSubscribed ==========> $isSubscribed");
          if (isSubscribed != null && isSubscribed == true) {
            _getData();
          }
        }
      } else {
        if (!mounted) return;
        Utils.showSnackbar(context, "fail", "invalid_url", true);
      }
    } else {
      if ((kIsWeb || Constant.isTV)) {
        Utils.buildWebAlertDialog(context, "login", "")
            .then((value) => _getData());
        return;
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const LoginSocial();
          },
        ),
      );
    }
  }
  /* ========= Open Player ========= */

  Widget _buildVideoItem() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
      child: ResponsiveGridList(
        minItemWidth: Dimens.widthLand,
        verticalGridSpacing: 8,
        horizontalGridSpacing: 8,
        minItemsPerRow: 2,
        maxItemsPerRow: 8,
        listViewBuilderOptions: ListViewBuilderOptions(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
        children: List.generate(
          (channelSectionProvider.channelSectionModel.result?.length ?? 0),
              (position) {
            return InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () {
                log("Clicked on position ==> $position");
                Utils.openDetails(
                  context: context,
                  videoId:
                  channelSectionProvider.channelSectionModel.result?[position].id ??
                      0,
                  upcomingType: 0,
                  videoType: channelSectionProvider
                      .channelSectionModel.result?[position].videoType ??
                      0,
                  typeId: channelSectionProvider
                      .channelSectionModel.result?[position].typeId ??
                      0,
                );
              },
              child: Container(
                width: Dimens.widthLand,
                height: Dimens.heightLand,
                alignment: Alignment.center,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: MyNetworkImage(
                    imageUrl: channelSectionProvider
                        .channelSectionModel.result?[position].landscape
                        .toString() ??
                        "",
                    fit: BoxFit.cover,
                    imgHeight: MediaQuery.of(context).size.height,
                    imgWidth: MediaQuery.of(context).size.width,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

}
