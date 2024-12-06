import 'dart:async';
import 'dart:developer';

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
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class TVChannels extends StatefulWidget {
  const TVChannels({Key? key}) : super(key: key);

  @override
  State<TVChannels> createState() => TVChannelsState();
}

class TVChannelsState extends State<TVChannels> {
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
      return SingleChildScrollView(
        child: channelShimmer(),
      );
    } else {
      if (channelSectionProvider.channelSectionModel.status == 200) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              /* Banner */
            ],
          ),
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




  /* ========= Open Player ========= *//* ========= Open Player ========= */
}
