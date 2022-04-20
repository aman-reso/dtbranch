import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevideo/component/divider.dart';
import 'package:primevideo/component/smalltext.dart';

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
      backgroundColor: const Color(0xff0e171e),
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
                    color: Colors.grey,
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
                      style: const TextStyle(color: Colors.black),
                      controller: search,
                      onChanged: _runfilter,
                      decoration: InputDecoration(
                        suffixIcon: searchItems.isEmpty
                            ? const Icon(
                                Icons.mic_outlined,
                                color: Colors.black,
                              )
                            : InkWell(
                                onTap: () {
                                  setState(() {
                                    searchItems.clear();
                                    search.clear();
                                  });
                                },
                                child: const Icon(
                                  Icons.close_outlined,
                                  color: Colors.black,
                                ),
                              ),
                        filled: true,
                        fillColor: Colors.white,
                        disabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(07),
                            ),
                            borderSide:
                                BorderSide(color: Colors.yellow, width: 2)),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(07.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(07)),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
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
                ? SizedBox()
                : ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            SmallText("prime video"),
                            SizedBox(
                              height: 5,
                            ),
                            DividerUI()
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
