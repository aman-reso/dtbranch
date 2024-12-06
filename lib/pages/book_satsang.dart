
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/webservice/apiservices.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'donation_page.dart';

class BookSatsangPage extends StatefulWidget {
  @override
  _BookSatsangPageState createState() => _BookSatsangPageState();
}

class _BookSatsangPageState extends State<BookSatsangPage> {
  TextEditingController userIdController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController altMobileNumberController = TextEditingController();
  TextEditingController selectedBabaController = TextEditingController();
  TextEditingController dateOfOrganizingController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController detailsController = TextEditingController();

  Future<void> bookSatsang() async {
    var body = BookedSatsang(
      userId: Constant.userID,
      fullName: fullNameController.text,
      mobileNumber: mobileNumberController.text,
      alternativeMobileNumber: altMobileNumberController.text,
      selectedBabaOrGuruMaharaj: selectedBabaController.text,
      dateOfOrganizing: dateOfOrganizingController.text,
      locationOfSatsang: locationController.text,
      additionalDetails: detailsController.text,
    ).toJson();

    ApiService()
        .bookSatsang(body)
        .then((value) => {
              showAlertDialog(
                  context, "Success", 'Donation created successfully')
            })
        .catchError(
            (error) => {showAlertDialog(context, "Success", error.toString())});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyText(
          color: black,
          text: 'Organize Satsang',
          fontsizeNormal: 15,
          fontsizeWeb: 17,
          maxline: 1,
          multilanguage: false,
          overflow: TextOverflow.ellipsis,
          fontweight: FontWeight.w600,
          textalign: TextAlign.center,
          fontstyle: FontStyle.normal,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Column(
              children: [
                TextField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
                    labelText: 'Full Name',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 12), // Adjust vertical padding
                  ),
                ),
                const SizedBox(height: 8), // Reduce SizedBox height to maintain spacing

                TextField(
                  controller: mobileNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Mobile Number',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 12), // Adjust vertical padding
                  ),
                ),
                const SizedBox(height: 8), // Reduce SizedBox height to maintain spacing

                TextField(
                  controller: altMobileNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Alternative Mobile Number',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 12), // Adjust vertical padding
                  ),
                ),
                const SizedBox(height: 8), // Reduce SizedBox height to maintain spacing

                TextField(
                  controller: selectedBabaController,
                  decoration: const InputDecoration(
                    labelText: 'Selected Baba/Guru Maharaj',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 12), // Adjust vertical padding
                  ),
                ),
                const SizedBox(height: 8), // Reduce SizedBox height to maintain spacing

                TextField(
                  controller: dateOfOrganizingController,
                  decoration: const InputDecoration(
                    labelText: 'Date of Organizing',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 12), // Adjust vertical padding
                  ),
                ),
                const SizedBox(height: 8), // Reduce SizedBox height to maintain spacing

                TextField(
                  controller: locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location of Satsang',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 12), // Adjust vertical padding
                  ),
                ),
                const SizedBox(height: 8), // Reduce SizedBox height to maintain spacing

                TextField(
                  controller: detailsController,
                  decoration: const InputDecoration(
                    labelText: 'Additional Details',
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 12), // Adjust vertical padding
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: bookSatsang,
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
                text: 'Send Booking Request',
                fontsizeNormal: 15,
                fontsizeWeb: 17,
                maxline: 1,
                multilanguage: false,
                overflow: TextOverflow.ellipsis,
                fontweight: FontWeight.w600,
                textalign: TextAlign.center,
                fontstyle: FontStyle.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    userIdController.dispose();
    fullNameController.dispose();
    mobileNumberController.dispose();
    altMobileNumberController.dispose();
    selectedBabaController.dispose();
    dateOfOrganizingController.dispose();
    locationController.dispose();
    detailsController.dispose();
    super.dispose();
  }
}

class BookedSatsang {
  final String? userId;
  final String fullName;
  final String mobileNumber;
  final String alternativeMobileNumber;
  final String selectedBabaOrGuruMaharaj;
  final String dateOfOrganizing;
  final String locationOfSatsang;
  final String additionalDetails;

  BookedSatsang({
    this.userId,
    required this.fullName,
    required this.mobileNumber,
    required this.alternativeMobileNumber,
    required this.selectedBabaOrGuruMaharaj,
    required this.dateOfOrganizing,
    required this.locationOfSatsang,
    required this.additionalDetails,
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'fullName': fullName,
      'mobileNumber': mobileNumber,
      'alternativeMobileNumber': alternativeMobileNumber,
      'selectedBabaOrGuruMaharaj': selectedBabaOrGuruMaharaj,
      'dateOforganizing': dateOfOrganizing,
      'locationOfSatsang': locationOfSatsang,
      'additionalDetails': additionalDetails,
    };
  }
}
