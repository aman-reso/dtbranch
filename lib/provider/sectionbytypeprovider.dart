import 'dart:developer';

import 'package:dtlive/model/sectionbannermodel.dart';
import 'package:dtlive/model/sectionlistmodel.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class SectionByTypeProvider extends ChangeNotifier {
  SectionBannerModel sectionBannerModel = SectionBannerModel();
  SectionListModel sectionListModel = SectionListModel();

  bool loading = false;

  SharedPre sharePref = SharedPre();

  Future<void> getSectionBanner(typeId, isHomePage) async {
    debugPrint("getSectionBanner typeId :==> $typeId");
    debugPrint("getSectionBanner isHomePage :==> $isHomePage");
    loading = true;
    sectionBannerModel = await ApiService().sectionBanner(typeId, isHomePage);
    debugPrint("get_banner status :==> ${sectionBannerModel.status}");
    debugPrint("get_banner message :==> ${sectionBannerModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> getSectionList(typeId, isHomePage) async {
    debugPrint("getSectionList typeId :==> $typeId");
    debugPrint("getSectionList isHomePage :==> $isHomePage");
    loading = true;
    sectionListModel = await ApiService().sectionList(typeId, isHomePage);
    debugPrint("section_list status :==> ${sectionListModel.status}");
    debugPrint("section_list message :==> ${sectionListModel.message}");
    loading = false;
    notifyListeners();
  }

  clearSectionProvider() {
    log("<================ clearSectionProvider ================>");
    sectionBannerModel = SectionBannerModel();
    sectionListModel = SectionListModel();
    notifyListeners();
  }
}
