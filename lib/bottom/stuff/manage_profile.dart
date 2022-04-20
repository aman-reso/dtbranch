import 'package:flutter/material.dart';
import 'package:primevideo/bottom/stuff/editprofile.dart';

class ManageProfile extends StatefulWidget {
  const ManageProfile({Key? key}) : super(key: key);

  @override
  State<ManageProfile> createState() => _ManageProfileState();
}

class _ManageProfileState extends State<ManageProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0e171e),
      appBar: AppBar(
        backgroundColor: const Color(0xff0e171e),
        leading: Icon(
          Icons.arrow_back,
          color: Colors.transparent,
        ),
        title: Text(
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
              title: Text(
                "Anand",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              trailing: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfile()));
                },
                child: Icon(
                  Icons.edit_outlined,
                  color: Colors.grey,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
