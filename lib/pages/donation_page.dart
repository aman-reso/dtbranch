import 'dart:convert';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../widget/mynetworkimg.dart';

class DonationPage extends StatefulWidget {
  final String url;

  DonationPage(this.url);

  @override
  _DonationPageState createState() => _DonationPageState();
}

class _DonationPageState extends State<DonationPage> {
  TextEditingController amountController = TextEditingController();

  void createDonation() {
    if (Constant.userID == null) {
      showAlertDialog(context, "", 'Please login to continue');
    } else {
      ApiService()
          .createDonation(amountController.text)
          .then((value) => {handleSuccess(value.success)})
          .catchError((error) => {showAlertDialog(context, "Failure", error)});
    }
  }

  void handleSuccess(bool isSuccess) {
    if (isSuccess) {
      showAlertDialog(context, "Success", "Donation successfully");
    } else {
      showAlertDialog(context, "Failure", "Something went wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: MyText(
            color: black,
            text: "Donation",
            textalign: TextAlign.start,
            fontsizeNormal: 16,
            fontsizeWeb: 16,
            fontweight: FontWeight.bold,
            maxline: 1,
            overflow: TextOverflow.ellipsis,
            fontstyle: FontStyle.normal,
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 180,
              child: MyNetworkImage(
                imageUrl: widget.url ?? "",
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: createDonation,
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor), // Change to the desired background color
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0), // Adjust the value to change the button's roundness
                  ),
                ),
              ),
              child: MyText(
                color: accentColor,
                text: 'Make Donation',
                fontsizeNormal: 15,
                fontsizeWeb: 17,
                maxline: 1,
                multilanguage: false,
                overflow: TextOverflow.ellipsis,
                fontweight: FontWeight.w600,
                textalign: TextAlign.center,
                fontstyle: FontStyle.normal,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}

void showAlertDialog(BuildContext context, String title, String message) {
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      ElevatedButton(
        child: const Text("Okay"),
        onPressed: () {
          Navigator.of(context).pop(); // Close the dialog
        },
      ),
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

class DonationResponse {
  final bool success;
  final DonationResult result;
  final String message;

  DonationResponse({
    required this.success,
    required this.result,
    required this.message,
  });

  factory DonationResponse.fromJson(Map<String, dynamic> json) {
    return DonationResponse(
      success: json['success'] ?? false,
      result: DonationResult.fromJson(json['result'] ?? {}),
      message: json['message'] ?? '',
    );
  }
}

class DonationResult {
  final bool isPaid;
  final String id;
  final String userId;
  final int amount;
  final int v;

  DonationResult({
    required this.isPaid,
    required this.id,
    required this.userId,
    required this.amount,
    required this.v,
  });

  factory DonationResult.fromJson(Map<String, dynamic> json) {
    return DonationResult(
      isPaid: json['isPaid'] ?? false,
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      amount: json['amount'] ?? 0,
      v: json['__v'] ?? 0,
    );
  }
}
