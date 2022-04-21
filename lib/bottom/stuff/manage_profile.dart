import 'package:flutter/material.dart';
import 'package:primevideo/bottom/stuff/editprofile.dart';
import 'package:primevideo/utils/colors.dart';

class ManageProfile extends StatefulWidget {
  const ManageProfile({Key? key}) : super(key: key);

  @override
  State<ManageProfile> createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      appBar: AppBar(
        backgroundColor: const Color(0xff0e171e),
        leading: const Icon(
          Icons.arrow_back,
          color: transParentColor,
        ),
        title: const Text(
          "Edit profiles",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return ListTile(
              leading: CircleAvatar(
                radius: 22,
                child: Image.asset('assets/images/profile.png'),
              ),
              title: const Text(
                "Anand",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: textColor),
              ),
              trailing: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EditProfile()));
                },
                child: const Icon(
                  Icons.edit_outlined,
                  color: greyColor,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
