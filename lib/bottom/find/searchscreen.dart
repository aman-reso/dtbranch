import 'package:flutter/material.dart';
import 'package:primevideo/component/divider.dart';
import 'package:primevideo/component/smalltext.dart';
import 'package:primevideo/utils/colors.dart';

class SearchItems extends StatefulWidget {
  const SearchItems({Key? key}) : super(key: key);

  @override
  State<SearchItems> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItems> {
  bool show = true;
  TextEditingController search = TextEditingController();
  List<String> searchItems = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBgColor,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios_rounded,
                    color: greyColor,
                    size: 30,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.065,
                  child: TextField(
                      style: const TextStyle(color: blackColor),
                      controller: search,
                      onChanged: _runfilter,
                      decoration: InputDecoration(
                        suffixIcon: searchItems.isEmpty
                            ? const Icon(Icons.mic_outlined, color: blackColor)
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    searchItems.clear();
                                    search.clear();
                                  });
                                },
                                child: const Icon(
                                  Icons.close_outlined,
                                  color: blackColor,
                                ),
                              ),
                        filled: true,
                        fillColor: textColor,
                        disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(07),
                            ),
                            borderSide:
                                BorderSide(color: yellowColor, width: 2)),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(07.0)),
                          borderSide: BorderSide(color: greyColor, width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(07)),
                          borderSide: BorderSide(color: greyColor, width: 1),
                        ),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.86,
            child: searchItems.isEmpty
                ? const SizedBox()
                : ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5,
                            ),
                            SmallText("prime video"),
                            const SizedBox(
                              height: 5,
                            ),
                            const DividerUI()
                          ],
                        ),
                      );
                    },
                  ),
          )
        ],
      )),
    );
  }

  _runfilter(String keywords) async {
    if (keywords.isEmpty) {
      setState(() {
        searchItems.clear();
      });
    } else {
      setState(() {
        searchItems.add(keywords);
      });
    }
  }
}
