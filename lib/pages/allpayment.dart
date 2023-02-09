import 'dart:developer';

import 'package:dtlive/provider/paymentprovider.dart';
import 'package:dtlive/provider/showdetailsprovider.dart';
import 'package:dtlive/provider/videodetailsprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/myimage.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class AllPayment extends StatefulWidget {
  final String? payType,
      itemId,
      price,
      itemTitle,
      typeId,
      videoType,
      productPackage,
      currency;
  const AllPayment({
    Key? key,
    required this.payType,
    required this.itemId,
    required this.price,
    required this.itemTitle,
    required this.typeId,
    required this.videoType,
    required this.productPackage,
    required this.currency,
  }) : super(key: key);

  @override
  State<AllPayment> createState() => AllPaymentState();
}

class AllPaymentState extends State<AllPayment> {
  late ProgressDialog prDialog;
  late PaymentProvider paymentProvider;
  SharedPre sharedPref = SharedPre();
  String? userId, userName, userEmail, userMobileNo, paymentId;

  @override
  void initState() {
    prDialog = ProgressDialog(context);
    _getData();
    super.initState();
  }

  _getData() async {
    paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
    await paymentProvider.getPaymentOption();

    /* PaymentID */
    paymentId = Utils.generateRandomOrderID();
    log('paymentId =====================> $paymentId');

    userId = await sharedPref.read("userid");
    userName = await sharedPref.read("username");
    userEmail = await sharedPref.read("useremail");
    userMobileNo = await sharedPref.read("usermobile");
    log('getUserData userId ==> $userId');
    log('getUserData userName ==> $userName');
    log('getUserData userEmail ==> $userEmail');
    log('getUserData userMobileNo ==> $userMobileNo');

    Future.delayed(Duration.zero).then((value) {
      if (!mounted) return;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: Utils.myAppBarWithBack(context, "payment_details"),
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /* Amount */
              Container(
                width: MediaQuery.of(context).size.width,
                constraints: const BoxConstraints(minHeight: 50),
                decoration: Utils.setBackground(primaryColor, 0),
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                alignment: Alignment.centerLeft,
                child: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                    text: payableAmountIs,
                    style: GoogleFonts.inter(
                      textStyle: const TextStyle(
                        color: lightBlack,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0.5,
                      ),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: "${Constant.currencySymbol}${widget.price ?? ""}",
                        style: GoogleFonts.inter(
                          textStyle: const TextStyle(
                            color: black,
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            fontStyle: FontStyle.normal,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: paymentProvider.loading
                      ? Container(
                          height: 230,
                          padding: const EdgeInsets.all(20),
                          child: Utils.pageLoader(),
                        )
                      : paymentProvider.paymentOptionModel.status == 200
                          ? paymentProvider.paymentOptionModel.result != null
                              ? Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(15, 20, 15, 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      MyText(
                                        color: whiteLight,
                                        text: "payment_methods",
                                        fontsize: 17,
                                        maxline: 1,
                                        multilanguage: true,
                                        overflow: TextOverflow.ellipsis,
                                        fontwaight: FontWeight.w500,
                                        textalign: TextAlign.center,
                                        fontstyle: FontStyle.normal,
                                      ),
                                      const SizedBox(height: 5),
                                      MyText(
                                        color: lightGray,
                                        text: "choose_a_payment_methods_to_pay",
                                        multilanguage: true,
                                        fontsize: 14,
                                        maxline: 2,
                                        overflow: TextOverflow.ellipsis,
                                        fontwaight: FontWeight.normal,
                                        textalign: TextAlign.center,
                                        fontstyle: FontStyle.normal,
                                      ),
                                      const SizedBox(height: 20),
                                      MyText(
                                        color: complimentryColor,
                                        text: "pay_with",
                                        multilanguage: true,
                                        fontsize: 16,
                                        maxline: 1,
                                        overflow: TextOverflow.ellipsis,
                                        fontwaight: FontWeight.w800,
                                        textalign: TextAlign.center,
                                        fontstyle: FontStyle.normal,
                                      ),
                                      const SizedBox(height: 20),

                                      /* /* Payments */ */
                                      /* In-App purchase */
                                      paymentProvider.paymentOptionModel.result
                                                  ?.inAppPurchage !=
                                              null
                                          ? paymentProvider
                                                      .paymentOptionModel
                                                      .result
                                                      ?.inAppPurchage
                                                      ?.visibility ==
                                                  "1"
                                              ? Card(
                                                  semanticContainer: true,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  elevation: 5,
                                                  color: lightBlack,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    onTap: () async {
                                                      await paymentProvider
                                                          .setCurrentPayment(
                                                              "inapp");
                                                    },
                                                    child: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minHeight: 85),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          MyImage(
                                                            imagePath:
                                                                "inapp.png",
                                                            fit: BoxFit.fill,
                                                            height: 35,
                                                            width: 110,
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          Expanded(
                                                            child: MyText(
                                                              color:
                                                                  primaryColor,
                                                              text:
                                                                  "InApp Purchase",
                                                              multilanguage:
                                                                  false,
                                                              fontsize: 14,
                                                              maxline: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontwaight:
                                                                  FontWeight
                                                                      .w600,
                                                              textalign:
                                                                  TextAlign.end,
                                                              fontstyle:
                                                                  FontStyle
                                                                      .normal,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          MyImage(
                                                            imagePath:
                                                                "ic_arrow_right.png",
                                                            fit: BoxFit.fill,
                                                            height: 22,
                                                            width: 20,
                                                            color: white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink()
                                          : const SizedBox.shrink(),
                                      const SizedBox(height: 5),

                                      /* Paypal */
                                      paymentProvider.paymentOptionModel.result
                                                  ?.paypal !=
                                              null
                                          ? paymentProvider
                                                      .paymentOptionModel
                                                      .result
                                                      ?.paypal
                                                      ?.visibility ==
                                                  "1"
                                              ? Card(
                                                  semanticContainer: true,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  elevation: 5,
                                                  color: lightBlack,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    onTap: () async {
                                                      await paymentProvider
                                                          .setCurrentPayment(
                                                              "paypal");
                                                    },
                                                    child: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minHeight: 85),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          MyImage(
                                                            imagePath:
                                                                "paypal.png",
                                                            fit: BoxFit.fill,
                                                            height: 35,
                                                            width: 130,
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          Expanded(
                                                            child: MyText(
                                                              color:
                                                                  primaryColor,
                                                              text: "Paypal",
                                                              multilanguage:
                                                                  false,
                                                              fontsize: 14,
                                                              maxline: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontwaight:
                                                                  FontWeight
                                                                      .w600,
                                                              textalign:
                                                                  TextAlign.end,
                                                              fontstyle:
                                                                  FontStyle
                                                                      .normal,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          MyImage(
                                                            imagePath:
                                                                "ic_arrow_right.png",
                                                            fit: BoxFit.fill,
                                                            height: 22,
                                                            width: 20,
                                                            color: white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink()
                                          : const SizedBox.shrink(),
                                      const SizedBox(height: 5),

                                      /* Razorpay */
                                      paymentProvider.paymentOptionModel.result
                                                  ?.razorpay !=
                                              null
                                          ? paymentProvider
                                                      .paymentOptionModel
                                                      .result
                                                      ?.razorpay
                                                      ?.visibility ==
                                                  "1"
                                              ? Card(
                                                  semanticContainer: true,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  elevation: 5,
                                                  color: lightBlack,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    onTap: () async {
                                                      await paymentProvider
                                                          .setCurrentPayment(
                                                              "razorpay");
                                                      _initializeRazorpay();
                                                    },
                                                    child: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minHeight: 85),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          MyImage(
                                                            imagePath:
                                                                "razorpay.png",
                                                            fit: BoxFit.fill,
                                                            height: 35,
                                                            width: 130,
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          Expanded(
                                                            child: MyText(
                                                              color:
                                                                  primaryColor,
                                                              text: "Razorpay",
                                                              multilanguage:
                                                                  false,
                                                              fontsize: 14,
                                                              maxline: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontwaight:
                                                                  FontWeight
                                                                      .w600,
                                                              textalign:
                                                                  TextAlign.end,
                                                              fontstyle:
                                                                  FontStyle
                                                                      .normal,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          MyImage(
                                                            imagePath:
                                                                "ic_arrow_right.png",
                                                            fit: BoxFit.fill,
                                                            height: 22,
                                                            width: 20,
                                                            color: white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink()
                                          : const SizedBox.shrink(),
                                      const SizedBox(height: 5),

                                      /* Paytm */
                                      paymentProvider.paymentOptionModel.result
                                                  ?.payTm !=
                                              null
                                          ? paymentProvider
                                                      .paymentOptionModel
                                                      .result
                                                      ?.payTm
                                                      ?.visibility ==
                                                  "1"
                                              ? Card(
                                                  semanticContainer: true,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  elevation: 5,
                                                  color: lightBlack,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    onTap: () async {
                                                      await paymentProvider
                                                          .setCurrentPayment(
                                                              "paytm");
                                                    },
                                                    child: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minHeight: 85),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          MyImage(
                                                            imagePath:
                                                                "paytm.png",
                                                            fit: BoxFit.fill,
                                                            height: 30,
                                                            width: 90,
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          Expanded(
                                                            child: MyText(
                                                              color:
                                                                  primaryColor,
                                                              text: "Paytm",
                                                              multilanguage:
                                                                  false,
                                                              fontsize: 14,
                                                              maxline: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontwaight:
                                                                  FontWeight
                                                                      .w600,
                                                              textalign:
                                                                  TextAlign.end,
                                                              fontstyle:
                                                                  FontStyle
                                                                      .normal,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          MyImage(
                                                            imagePath:
                                                                "ic_arrow_right.png",
                                                            fit: BoxFit.fill,
                                                            height: 22,
                                                            width: 20,
                                                            color: white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink()
                                          : const SizedBox.shrink(),
                                      const SizedBox(height: 5),

                                      /* Flutterwave */
                                      paymentProvider.paymentOptionModel.result
                                                  ?.flutterWave !=
                                              null
                                          ? paymentProvider
                                                      .paymentOptionModel
                                                      .result
                                                      ?.flutterWave
                                                      ?.visibility ==
                                                  "1"
                                              ? Card(
                                                  semanticContainer: true,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  elevation: 5,
                                                  color: lightBlack,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    onTap: () async {
                                                      await paymentProvider
                                                          .setCurrentPayment(
                                                              "flutterwave");
                                                    },
                                                    child: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minHeight: 85),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          MyImage(
                                                            imagePath:
                                                                "flutterwave.png",
                                                            fit: BoxFit.fill,
                                                            height: 35,
                                                            width: 130,
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          Expanded(
                                                            child: MyText(
                                                              color:
                                                                  primaryColor,
                                                              text:
                                                                  "Flutterwave",
                                                              multilanguage:
                                                                  false,
                                                              fontsize: 14,
                                                              maxline: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontwaight:
                                                                  FontWeight
                                                                      .w600,
                                                              textalign:
                                                                  TextAlign.end,
                                                              fontstyle:
                                                                  FontStyle
                                                                      .normal,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          MyImage(
                                                            imagePath:
                                                                "ic_arrow_right.png",
                                                            fit: BoxFit.fill,
                                                            height: 22,
                                                            width: 20,
                                                            color: white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink()
                                          : const SizedBox.shrink(),
                                      const SizedBox(height: 5),

                                      /* PayUMoney */
                                      paymentProvider.paymentOptionModel.result
                                                  ?.payUMoney !=
                                              null
                                          ? paymentProvider
                                                      .paymentOptionModel
                                                      .result
                                                      ?.payUMoney
                                                      ?.visibility ==
                                                  "1"
                                              ? Card(
                                                  semanticContainer: true,
                                                  clipBehavior: Clip
                                                      .antiAliasWithSaveLayer,
                                                  elevation: 5,
                                                  color: lightBlack,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: InkWell(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                    onTap: () async {
                                                      await paymentProvider
                                                          .setCurrentPayment(
                                                              "payumoney");
                                                    },
                                                    child: Container(
                                                      constraints:
                                                          const BoxConstraints(
                                                              minHeight: 85),
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          MyImage(
                                                            imagePath:
                                                                "payumoney.png",
                                                            fit: BoxFit.fill,
                                                            height: 35,
                                                            width: 130,
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          Expanded(
                                                            child: MyText(
                                                              color:
                                                                  primaryColor,
                                                              text:
                                                                  "PayU Money",
                                                              multilanguage:
                                                                  false,
                                                              fontsize: 14,
                                                              maxline: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontwaight:
                                                                  FontWeight
                                                                      .w600,
                                                              textalign:
                                                                  TextAlign.end,
                                                              fontstyle:
                                                                  FontStyle
                                                                      .normal,
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 15),
                                                          MyImage(
                                                            imagePath:
                                                                "ic_arrow_right.png",
                                                            fit: BoxFit.fill,
                                                            height: 22,
                                                            width: 20,
                                                            color: white,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              : const SizedBox.shrink()
                                          : const SizedBox.shrink(),
                                    ],
                                  ),
                                )
                              : const NoData(title: '', subTitle: '')
                          : const NoData(title: '', subTitle: ''),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /* ********* Rezorpay START ********* */
  void _initializeRazorpay() {
    if (paymentProvider.paymentOptionModel.result?.razorpay != null) {
      Razorpay razorpay = Razorpay();
      var options = {
        'key':
            paymentProvider.paymentOptionModel.result?.razorpay?.isLive == "1"
                ? paymentProvider
                        .paymentOptionModel.result?.razorpay?.liveKey1 ??
                    ""
                : paymentProvider
                        .paymentOptionModel.result?.razorpay?.testKey1 ??
                    "",
        'amount': (double.parse(widget.price ?? "") * 100),
        'name': widget.itemTitle ?? "",
        'description': widget.itemTitle ?? "",
        'retry': {'enabled': true, 'max_count': 1},
        'send_sms_hash': true,
        'prefill': {'contact': userMobileNo, 'email': userEmail},
        'external': {'wallets': []}
      };
      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
      razorpay.open(options);
    } else {
      Utils.showSnackbar(context, "", "payment_not_processed");
    }
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) async {
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    Utils.showSnackbar(context, "fail", "payment_fail");
    await paymentProvider.setCurrentPayment("");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    // paymentId = response.paymentId;
    debugPrint("paymentId ========> $paymentId");
    Utils.showSnackbar(context, "success", "payment_success");
    if (widget.payType == "Package") {
      addTransaction(widget.itemId, widget.itemTitle, widget.price, paymentId,
          widget.currency);
    } else if (widget.payType == "Rent") {
      addRentTransaction(
          widget.itemId, widget.price, widget.typeId, widget.videoType);
    }
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    debugPrint("============ External Wallet Selected ============");
  }
  /* ********* Rezorpay END ********* */

  Future addTransaction(
      packageId, description, amount, paymentId, currencyCode) async {
    final VideoDetailsProvider videoDetailsProvider =
        Provider.of<VideoDetailsProvider>(context, listen: false);
    final ShowDetailsProvider showDetailsProvider =
        Provider.of<ShowDetailsProvider>(context, listen: false);

    Utils.showProgress(context, prDialog);
    await paymentProvider.addTransaction(
        packageId, description, amount, paymentId, currencyCode);

    if (!paymentProvider.payLoading) {
      await prDialog.hide();

      if (paymentProvider.successModel.status == 200) {
        await videoDetailsProvider.updatePrimiumPurchase();
        await showDetailsProvider.updatePrimiumPurchase();
        await videoDetailsProvider.updateRentPurchase();
        await showDetailsProvider.updateRentPurchase();

        if (!mounted) return;
        Navigator.pop(context);
      } else {
        if (!mounted) return;
        Utils.showSnackbar(
            context, "response", paymentProvider.successModel.message ?? "");
      }
    }
  }

  Future addRentTransaction(videoId, amount, typeId, videoType) async {
    final VideoDetailsProvider videoDetailsProvider =
        Provider.of<VideoDetailsProvider>(context, listen: false);
    final ShowDetailsProvider showDetailsProvider =
        Provider.of<ShowDetailsProvider>(context, listen: false);

    Utils.showProgress(context, prDialog);
    await paymentProvider.addRentTransaction(
        videoId, amount, typeId, videoType);

    if (!paymentProvider.payLoading) {
      await prDialog.hide();

      if (paymentProvider.successModel.status == 200) {
        if (videoType == "1") {
          await videoDetailsProvider.updateRentPurchase();
        } else if (videoType == "2") {
          await showDetailsProvider.updateRentPurchase();
        }

        if (!mounted) return;
        Navigator.pop(context);
      } else {
        if (!mounted) return;
        Utils.showSnackbar(
            context, "response", paymentProvider.successModel.message ?? "");
      }
    }
  }
}
