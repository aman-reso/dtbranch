import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:primevideo/bottom/articlescreen.dart';
import 'package:primevideo/component/smalltext.dart';

class DownloadPage extends StatefulWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  State<DownloadPage> createState() => _DownloadPageState();
}

class _DownloadPageState extends State<DownloadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              const Text("Downloads",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SmallText("5 videos"),
                        const SizedBox(width: 10),
                        SmallText("150 min"),
                        const SizedBox(width: 10),
                        SmallText("150 MB")
                      ],
                    ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.15,
                    //   height: MediaQuery.of(context).size.height * 0.05,
                    //   decoration: BoxDecoration(
                    //       color: Colors.blueGrey[500],
                    //       borderRadius: BorderRadius.circular(03)),
                    //   child: const Center(
                    //     child: Text(
                    //       "Edit",
                    //       style: TextStyle(color: Colors.white),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 05),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ArticleScreen()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.14,
                          color: Colors.blueGrey[900],
                          child: Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.14,
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image:
                                            AssetImage('assets/images/kgf.jpg'),
                                        fit: BoxFit.fill)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "The Family Man",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      height: 05,
                                    ),
                                    Row(
                                      children: [
                                        SmallText("5 episode"),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        SmallText("150 MB")
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 05,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.45,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.05,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              Text(
                                                "prime",
                                                style: TextStyle(
                                                    color: Colors.blue,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        listIcon(
                                          Icons.chevron_right_sharp,
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  listIcon(icon) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.1,
      height: MediaQuery.of(context).size.height * 0.05,
      child: Icon(
        icon,
        color: Colors.grey,
        size: 40,
      ),
    );
  }
}
