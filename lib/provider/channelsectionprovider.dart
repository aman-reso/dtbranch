import 'dart:developer';

import 'package:dtlive/model/channelsectionmodel.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class ChannelSectionProvider extends ChangeNotifier {
  ChannelSectionModel channelSectionModel = ChannelSectionModel();

  bool loading = false;

  SharedPre sharePref = SharedPre();

  Future<void> getChannelSection() async {
    debugPrint("getChannelSection userID :==> ${Constant.userID}");
    loading = true;
    channelSectionModel = await ApiService().channelSectionList();
    debugPrint(
        "channel_section_list status :==> ${channelSectionModel.status}");
    debugPrint(
        "channel_section_list message :==> ${channelSectionModel.message}");
    loading = false;
    notifyListeners();
  }

  clearSectionProvider() {
    log("<================ clearChannelSectionProvider ================>");
    channelSectionModel = ChannelSectionModel();
    notifyListeners();
  }
}
