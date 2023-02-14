import 'dart:developer';

import 'package:dtlive/model/profilemodel.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class MyStuffProvider extends ChangeNotifier {
  ProfileModel profileModel = ProfileModel();

  bool loadingProfile = false, loadingDownload = false;

  Future<void> getProfile() async {
    debugPrint("getProfile userID :==> ${Constant.userID}");
    loadingProfile = true;
    profileModel = await ApiService().profile();
    debugPrint("get_profile status :==> ${profileModel.status}");
    debugPrint("get_profile message :==> ${profileModel.message}");
    loadingProfile = false;
    notifyListeners();
  }

  clearProvider() {
    log("<================ clearProvider ================>");
    profileModel = ProfileModel();
  }
}
