import 'package:dtlive/model/sectiontypemodel.dart';
import 'package:dtlive/model/successmodel.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class HomeProvider extends ChangeNotifier {
  SuccessModel successModel = SuccessModel();
  SectionTypeModel sectionTypeModel = SectionTypeModel();

  bool loading = false;

  SharedPre sharePref = SharedPre();

  Future<void> getSectionType() async {
    loading = true;
    sectionTypeModel = await ApiService().sectionType();
    debugPrint("get_type status :==> ${sectionTypeModel.status}");
    debugPrint("get_type message :==> ${sectionTypeModel.message}");
    loading = false;
    notifyListeners();
  }
}
