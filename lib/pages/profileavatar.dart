import 'package:dtlive/provider/avatarprovider.dart';
import 'package:dtlive/utils/color.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:dtlive/widget/mynetworkimg.dart';
import 'package:dtlive/widget/nodata.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class ProfileAvatar extends StatefulWidget {
  const ProfileAvatar({Key? key}) : super(key: key);

  @override
  State<ProfileAvatar> createState() => _ProfileAvatarState();
}

class _ProfileAvatarState extends State<ProfileAvatar> {
  late AvatarProvider avatarProvider;
  String? pickedImageUrl;

  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    avatarProvider = Provider.of<AvatarProvider>(context, listen: false);
    await avatarProvider.getAvatar();
    Future.delayed(Duration.zero).then((value) => setState(() {}));
  }

  @override
  void dispose() {
    avatarProvider.clearProvider();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: appBgColor,
        appBar: Utils.myAppBar(context, "changeprofileimage"),
        body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: avatarProvider.loading
                ? Utils.pageLoader()
                : (avatarProvider.avatarModel.status == 200)
                    ? (avatarProvider.avatarModel.result != null)
                        ? (avatarProvider.avatarModel.result?.length ?? 0) > 0
                            ? AlignedGridView.count(
                                shrinkWrap: true,
                                crossAxisCount: 4,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                itemCount: (avatarProvider
                                        .avatarModel.result?.length ??
                                    0),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 10, 20, 20),
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder:
                                    (BuildContext context, int position) {
                                  return InkWell(
                                    borderRadius: BorderRadius.circular(4),
                                    onTap: () {
                                      debugPrint(
                                          "Clicked position =====> $position");
                                      pickedImageUrl = avatarProvider
                                              .avatarModel
                                              .result?[position]
                                              .image
                                              .toString() ??
                                          "";
                                      debugPrint(
                                          "pickedImageUrl =====> $pickedImageUrl");
                                      onBackPressed();
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 77,
                                      alignment: Alignment.center,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(40),
                                        child: MyNetworkImage(
                                          imageUrl: avatarProvider.avatarModel
                                                  .result?[position].image
                                                  .toString() ??
                                              "",
                                          fit: BoxFit.cover,
                                          imgHeight: MediaQuery.of(context)
                                              .size
                                              .height,
                                          imgWidth:
                                              MediaQuery.of(context).size.width,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              )
                            : const NoData(
                                title: '',
                                subTitle: '',
                              )
                        : const NoData(
                            title: '',
                            subTitle: '',
                          )
                    : const NoData(
                        title: '',
                        subTitle: '',
                      ),
          ),
        ),
      ),
    );
  }

  Future<bool> onBackPressed() async {
    debugPrint("pickedImageUrl ====> $pickedImageUrl");
    Navigator.pop(context, pickedImageUrl);
    return Future.value(true);
  }
}