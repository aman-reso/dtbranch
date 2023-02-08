import 'dart:developer';

import 'package:dtlive/model/paymentoptionmodel.dart';
import 'package:dtlive/model/successmodel.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:flutter/material.dart';

class PaymentProvider extends ChangeNotifier {
  PaymentOptionModel paymentOptionModel = PaymentOptionModel();
  SuccessModel successModel = SuccessModel();

  bool loading = false, payLoading = false;
  String? currentPayment = "";

  Future<void> getPaymentOption() async {
    loading = true;
    paymentOptionModel = await ApiService().getPaymentOption();
    debugPrint("getPaymentOption status :==> ${paymentOptionModel.status}");
    debugPrint("getPaymentOption message :==> ${paymentOptionModel.message}");
    loading = false;
    notifyListeners();
  }

  Future<void> addTransaction(
      packageId, description, amount, paymentId, currencyCode) async {
    debugPrint("addTransaction userID :==> ${Constant.userID}");
    debugPrint("addTransaction packageId :==> $packageId");
    payLoading = true;
    successModel = await ApiService().addTransaction(
        packageId, description, amount, paymentId, currencyCode);
    debugPrint("addTransaction status :==> ${successModel.status}");
    debugPrint("addTransaction message :==> ${successModel.message}");
    payLoading = false;
    notifyListeners();
  }

  Future<void> addRentTransaction(videoId, amount, typeId, videoType) async {
    debugPrint("addRentTransaction userID :==> ${Constant.userID}");
    debugPrint("addRentTransaction videoId :==> $videoId");
    payLoading = true;
    successModel = await ApiService()
        .addRentTransaction(videoId, amount, typeId, videoType);
    debugPrint("addRentTransaction status :==> ${successModel.status}");
    debugPrint("addRentTransaction message :==> ${successModel.message}");
    payLoading = false;
    notifyListeners();
  }

  setCurrentPayment(String? payment) {
    currentPayment = payment;
    notifyListeners();
  }

  clearProvider() {
    log("<================ clearProvider ================>");
    currentPayment = "";
    paymentOptionModel = PaymentOptionModel();
    successModel = SuccessModel();
  }
}
