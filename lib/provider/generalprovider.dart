import 'package:dtlive/model/generalsettingmodel.dart';
import 'package:dtlive/model/loginregistermodel.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class GeneralProvider extends ChangeNotifier {
  GeneralSettingModel generalSettingModel = GeneralSettingModel();
  LoginRegisterModel loginGmailModel = LoginRegisterModel();
  LoginRegisterModel loginOTPModel = LoginRegisterModel();

  bool loading = false;

  SharedPre sharePref = SharedPre();

  Future<void> getGeneralsetting(context) async {
    loading = true;
    generalSettingModel = await ApiService().genaralSetting();
    debugPrint("genaral_setting status :==> ${generalSettingModel.status}");
    loading = false;
    notifyListeners();
  }

  Future<void> loginWithSocial(email, name, type) async {
    debugPrint("loginWithSocial email :==> $email");
    debugPrint("loginWithSocial name :==> $name");
    debugPrint("loginWithSocial type :==> $type");

    loading = true;
    loginGmailModel = await ApiService().loginWithSocial(email, name, type);
    debugPrint("login status :==> ${loginGmailModel.status}");
    debugPrint("login message :==> ${loginGmailModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> loginWithOTP(mobile) async {
    debugPrint("getLoginOTP mobile :==> $mobile");

    loading = true;
    loginOTPModel = await ApiService().loginWithOTP(mobile);
    debugPrint("login status :==> ${loginOTPModel.status}");
    debugPrint("login message :==> ${loginOTPModel.message}");
    loading = false;
    notifyListeners();
  }
}