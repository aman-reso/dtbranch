import 'dart:developer';

import 'package:dtlive/model/sectiondetailmodel.dart';
import 'package:dtlive/model/successmodel.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class VideoDetailsProvider extends ChangeNotifier {
  SuccessModel successModel = SuccessModel();
  SectionDetailModel sectionDetailModel = SectionDetailModel();

  bool loading = false;
  String tabClickedOn = "related";

  Future<void> getSectionDetails(typeId, videoType, videoId) async {
    debugPrint("getSectionDetails typeId :==> $typeId");
    debugPrint("getSectionDetails videoType :==> $videoType");
    debugPrint("getSectionDetails videoId :==> $videoId");
    loading = true;
    sectionDetailModel =
        await ApiService().sectionDetails(typeId, videoType, videoId);
    debugPrint("section_detail status :==> ${sectionDetailModel.status}");
    debugPrint("section_detail message :==> ${sectionDetailModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> setBookMark(
      BuildContext context, typeId, videoType, videoId) async {
    if ((sectionDetailModel.result?.isBookmark ?? 0) == 0) {
      sectionDetailModel.result?.isBookmark = 1;
      Utils.showSnackbar(context, "WatchlistAdd", "addwatchlistmessage");
    } else {
      sectionDetailModel.result?.isBookmark = 0;
      Utils.showSnackbar(context, "WatchlistRemove", "removewatchlistmessage");
    }
    notifyListeners();
    getAddBookMark(typeId, videoType, videoId);
  }

  Future<void> getAddBookMark(typeId, videoType, videoId) async {
    debugPrint("getAddBookMark typeId :==> $typeId");
    debugPrint("getAddBookMark videoType :==> $videoType");
    debugPrint("getAddBookMark videoId :==> $videoId");
    successModel =
        await ApiService().addRemoveBookmark(typeId, videoType, videoId);
    debugPrint("add_remove_bookmark status :==> ${successModel.status}");
    debugPrint("add_remove_bookmark message :==> ${successModel.message}");
  }

  Future<void> removeFromContinue(videoId, videoType) async {
    sectionDetailModel.result?.stopTime = 0;
    notifyListeners();

    debugPrint("removeFromContinue videoType :==> $videoType");
    debugPrint("removeFromContinue videoId :==> $videoId");
    successModel =
        await ApiService().removeContinueWatching(videoId, videoType);
    debugPrint("removeFromContinue message :==> ${successModel.message}");
  }

  updateRentPurchase() {
    if (sectionDetailModel.result != null) {
      sectionDetailModel.result?.rentBuy == 1;
    }
  }

  updatePrimiumPurchase() {
    if (sectionDetailModel.result != null) {
      sectionDetailModel.result?.isBuy == 1;
    }
  }

  setTabClick(clickedOn) {
    log("clickedOn ===> $clickedOn");
    tabClickedOn = clickedOn;
    notifyListeners();
  }

  clearProvider() {
    log("<================ clearProvider ================>");
    sectionDetailModel = SectionDetailModel();
    successModel = SuccessModel();
    tabClickedOn = "related";
  }
}
