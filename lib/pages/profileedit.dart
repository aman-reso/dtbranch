import 'dart:developer';
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:dtlive/provider/profileprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/sharedpre.dart';
import 'package:dtlive/utils/strings.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/mytext.dart';
import 'package:dtlive/widget/mytextformfield.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:provider/provider.dart';

class ProfileEdit extends StatefulWidget {
  const ProfileEdit({Key? key}) : super(key: key);

  @override
  State<ProfileEdit> createState() => ProfileEditState();
}

class ProfileEditState extends State<ProfileEdit> {
  late ProgressDialog prDialog;
  SharedPre sharePref = SharedPre();
  final ImagePicker imagePicker = ImagePicker();
  File? pickedImageFile;
  bool? isSwitched;
  String? userId, userName, aboutUsUrl, privacyUrl, termsConditionUrl;
  SharedPre sharedPref = SharedPre();
  final nameController = TextEditingController();

  @override
  void initState() {
    prDialog = ProgressDialog(context);
    getUserData();
    super.initState();
  }

  void getUserData() async {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    await profileProvider.getProfile();
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    if (!profileProvider.loading) {
      if (profileProvider.profileModel.status == 200) {
        if (profileProvider.profileModel.result != null) {
          log("User Name ==> ${(profileProvider.profileModel.result?.name ?? "")}");
          log("User ID ==> ${(profileProvider.profileModel.result?.id ?? 0)}");
          if (nameController.text.toString() == "") {
            if ((profileProvider.profileModel.result?.name ?? "") != "") {
              nameController.text =
                  profileProvider.profileModel.result?.name ?? "";
            }
          }
        }
      }
    }
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: Utils.myAppBar(context, "setting"),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(22),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              /* Profile Image */
              Consumer<ProfileProvider>(
                builder: (context, value, child) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(45),
                    clipBehavior: Clip.antiAlias,
                    child: pickedImageFile != null
                        ? Image.file(
                            pickedImageFile!,
                            fit: BoxFit.cover,
                            height: 90,
                            width: 90,
                          )
                        : MyNetworkImage(
                            imageUrl: profileProvider.profileModel.status == 200
                                ? profileProvider.profileModel.result != null
                                    ? (profileProvider
                                            .profileModel.result?.image ??
                                        Constant.userPlaceholder)
                                    : Constant.userPlaceholder
                                : Constant.userPlaceholder,
                            fit: BoxFit.cover,
                            imgHeight: 90,
                            imgWidth: 90,
                          ),
                  );
                },
              ),
              const SizedBox(
                height: 8,
              ),
              /* Change Button */
              InkWell(
                borderRadius: BorderRadius.circular(5),
                onTap: () {
                  pickImageDialog();
                },
                child: Container(
                  constraints: const BoxConstraints(
                    minHeight: 35,
                    maxWidth: 100,
                  ),
                  alignment: Alignment.center,
                  child: MyText(
                    text: "chnage",
                    fontsize: 16,
                    multilanguage: true,
                    maxline: 1,
                    overflow: TextOverflow.ellipsis,
                    fontwaight: FontWeight.w500,
                    fontstyle: FontStyle.normal,
                    textalign: TextAlign.center,
                    color: otherColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              /* Name */
              Container(
                height: Constant.textFieldHeight,
                padding: const EdgeInsets.only(left: 10, right: 10),
                decoration: Utils.textFieldBGWithBorder(),
                alignment: Alignment.center,
                child: MyTextFormField(
                  mHint: enterName,
                  mController: nameController,
                  mObscureText: false,
                  mMaxLine: 1,
                  mHintTextColor: otherColor,
                  mTextColor: black,
                  mkeyboardType: TextInputType.name,
                  mTextInputAction: TextInputAction.done,
                  mInputBorder: InputBorder.none,
                  mTextAlign: TextAlign.center,
                ),
              ),
              /* Save */
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () async {
                      log("nameController Name ==> ${nameController.text.toString()}");
                      log("pickedImageFile ==> ${pickedImageFile?.path ?? "not picked"}");
                      if (nameController.text.toString().isEmpty) {
                        return Utils.showSnackbar(
                            context, "TextField", enterName);
                      }
                      final profileProvider =
                          Provider.of<ProfileProvider>(context, listen: false);
                      Utils.showProgress(context, prDialog);
                      await sharePref.save(
                          "username", nameController.text.toString());
                      if (pickedImageFile != null) {
                        await profileProvider.getImageUpload(pickedImageFile);
                      }
                      await profileProvider
                          .getUpdateProfile(nameController.text.toString());
                      await profileProvider.getProfile();
                      prDialog.hide();
                    },
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      decoration: BoxDecoration(
                        color: primaryDark,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      alignment: Alignment.center,
                      child: MyText(
                        color: white,
                        text: "save",
                        multilanguage: true,
                        textalign: TextAlign.center,
                        fontsize: 15,
                        fontwaight: FontWeight.w600,
                        maxline: 1,
                        overflow: TextOverflow.ellipsis,
                        fontstyle: FontStyle.normal,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void pickImageDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: lightBlack,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(0),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (BuildContext context) {
        return Wrap(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(23),
              color: lightBlack,
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyText(
                          color: white,
                          text: "addphoto",
                          textalign: TextAlign.center,
                          fontsize: 16,
                          fontwaight: FontWeight.bold,
                          multilanguage: true,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontstyle: FontStyle.normal,
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        MyText(
                          color: white,
                          multilanguage: true,
                          text: "pickimagenote",
                          textalign: TextAlign.center,
                          fontsize: 13,
                          fontwaight: FontWeight.normal,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontstyle: FontStyle.normal,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  /* Camera Pick */
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      Navigator.of(context).pop();
                      getFromCamera();
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                      ),
                      height: 48,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primaryLight,
                          width: .5,
                        ),
                        color: primaryDarkColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: MyText(
                        color: white,
                        text: "takephoto",
                        textalign: TextAlign.center,
                        fontsize: 16,
                        multilanguage: true,
                        maxline: 1,
                        overflow: TextOverflow.ellipsis,
                        fontwaight: FontWeight.w500,
                        fontstyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  /* Gallery Pick */
                  InkWell(
                    borderRadius: BorderRadius.circular(5),
                    onTap: () {
                      Navigator.of(context).pop();
                      getFromGallery();
                    },
                    child: Container(
                      constraints: BoxConstraints(
                        minWidth: MediaQuery.of(context).size.width,
                      ),
                      height: 48,
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: primaryLight,
                          width: .5,
                        ),
                        color: primaryDarkColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: MyText(
                        color: white,
                        text: "choosegallry",
                        textalign: TextAlign.center,
                        fontsize: 16,
                        multilanguage: true,
                        maxline: 1,
                        overflow: TextOverflow.ellipsis,
                        fontwaight: FontWeight.w500,
                        fontstyle: FontStyle.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(5),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        constraints: const BoxConstraints(
                          minWidth: 75,
                          maxWidth: 80,
                        ),
                        height: 50,
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: otherColor,
                            width: .5,
                          ),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: MyText(
                          color: white,
                          text: cancel,
                          textalign: TextAlign.center,
                          fontsize: 16,
                          maxline: 1,
                          overflow: TextOverflow.ellipsis,
                          fontwaight: FontWeight.w500,
                          fontstyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  /// Get from gallery
  void getFromGallery() async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      setState(() {
        pickedImageFile = File(pickedFile.path);
        log("Gallery pickedImageFile ==> ${pickedImageFile!.path}");
      });
    }
  }

  /// Get from Camera
  void getFromCamera() async {
    final XFile? pickedFile = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 1000,
      maxHeight: 1000,
      imageQuality: 100,
    );
    if (pickedFile != null) {
      setState(() {
        pickedImageFile = File(pickedFile.path);
        log("Camera pickedImageFile ==> ${pickedImageFile!.path}");
      });
    }
  }
}
