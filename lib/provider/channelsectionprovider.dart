import 'dart:developer';

import 'package:dtlive/model/channelsectionmodel.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class ChannelSectionProvider extends ChangeNotifier {
  ChannelSectionModel channelSectionModel = ChannelSectionModel();

  bool loading = false;
  int? cBannerIndex = 0;

  Future<void> getChannelSection() async {
    loading = true;
    channelSectionModel = await ApiService().channelSectionList();
    debugPrint("getChannelSection status :==> ${channelSectionModel.status}");
    debugPrint("getChannelSection message :==> ${channelSectionModel.message}");
    loading = false;
    notifyListeners();
  }

  setCurrentBanner(index) {
    cBannerIndex = index;
    notifyListeners();
  }

  clearProvider() {
    log("<================ clearProvider ================>");
    channelSectionModel = ChannelSectionModel();
  }
}
