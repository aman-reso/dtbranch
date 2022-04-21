import 'package:flutter/material.dart';
import 'package:primevideo/bottom/find/searchscreen.dart';
import 'package:primevideo/utils/colors.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  bool isSeeMore = false;
  bool isSeeMore2 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0e171e),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SearchItems()));
                },
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.08,
                    decoration: BoxDecoration(
                        color: btnPrimaryblue,
                        border: Border.all(
                          color: borderColor,
                        ),
                        borderRadius: BorderRadius.circular(05)),
                    child: const ListTile(
                      leading: Icon(Icons.search, color: textColor),
                      trailing: Icon(Icons.mic_outlined, color: textColor),
                      title: Text(
                        "Search by actor, title...",
                        style: TextStyle(
                          color: Color(0xff718694),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15),
                child: Text(
                  "Browsed by",
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                            color: btnPrimaryblue,
                            borderRadius: BorderRadius.circular(05)),
                        child: text(),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                            color: btnPrimaryblue,
                            borderRadius: BorderRadius.circular(05)),
                        child: text(),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, bottom: 8, right: 8),
                      child: Container(
                          width: MediaQuery.of(context).size.width * 0.45,
                          height: MediaQuery.of(context).size.height * 0.08,
                          decoration: BoxDecoration(
                              color: const Color(0xff0e1c29),
                              borderRadius: BorderRadius.circular(05)),
                          child: text()),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8, right: 8),
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        height: MediaQuery.of(context).size.height * 0.08,
                        decoration: BoxDecoration(
                            color: btnPrimaryblue,
                            borderRadius: BorderRadius.circular(05)),
                        child: text(),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 10),
                child: Text(
                  "Genres",
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
              buildGenre(context),
              buildSeemoreButton(),
              const SizedBox(
                height: 20,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, top: 15),
                child: Text(
                  "Language",
                  style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
              buildLanguage(context),
              buildSeemore2(),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSeemore2() {
    return InkWell(
      onTap: () {
        setState(() => isSeeMore2 = !isSeeMore2);
      },
      child: isSeeMore2
          ? const SizedBox()
          : const Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: Text(
                "see more",
                style: TextStyle(color: bluetext),
              ),
            ),
    );
  }

  SizedBox buildLanguage(BuildContext context) {
    final height = isSeeMore2
        ? MediaQuery.of(context).size.height * 0.42
        : MediaQuery.of(context).size.height * 0.33;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          divider(),
          buildrow("English", () {}),
          divider(),
          buildrow("English", () {}),
          divider(),
          buildrow("English", () {}),
          divider(),
          buildrow("English", () {}),
          divider(),
          buildrow("English", () {}),
          // isSeeMore2 ? SizedBox() : divider(),
          // isSeeMore2 ? SizedBox() : buildrow("English", () {}),
        ],
      ),
    );
  }

  InkWell buildSeemoreButton() {
    return InkWell(
      onTap: () {
        setState(() => isSeeMore = !isSeeMore);
      },
      child: isSeeMore
          ? const SizedBox()
          : const Padding(
              padding: EdgeInsets.only(left: 15, top: 10),
              child: Text(
                "see more",
                style: TextStyle(color: bluetext),
              ),
            ),
    );
  }

  SizedBox buildGenre(BuildContext context) {
    final height = isSeeMore
        ? MediaQuery.of(context).size.height * 0.42
        : MediaQuery.of(context).size.height * 0.33;
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          divider(),
          buildrow("Action and adventure", () {}),
          divider(),
          buildrow("Action and adventure", () {}),
          divider(),
          buildrow("Action and adventure", () {}),
          divider(),
          buildrow("Action and adventure", () {}),
          divider(),
          buildrow("Action and adventure", () {}),
          // isSeeMore ? SizedBox() : divider(),
          // isSeeMore ? SizedBox() : buildrow("Action and adventure", () {}),
        ],
      ),
    );
  }

  text() {
    return const Center(
      child: Text(
        "Divine Originals",
        style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
      ),
    );
  }

  divider() {
    return const Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Divider(color: textColor),
    );
  }

  buildrow(String text, VoidCallback ontap) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: const TextStyle(
              color: Color(0xff7b919e),
            ),
          ),
          InkWell(
            onTap: ontap,
            child: const Icon(
              Icons.chevron_right_outlined,
              color: textColor,
              size: 30,
            ),
          )
        ],
      ),
    );
  }
}
