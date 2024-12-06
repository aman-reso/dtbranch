import 'dart:async';
import 'dart:io';
import 'package:dtlive/utils/color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';

import '../model/sectiondetailmodel.dart';
import '../webservice/apiservices.dart';

class PDFScreen extends StatefulWidget {
  Ebook? ebook;

  PDFScreen(this.ebook, {Key? key}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';

  String pathPDF = "";
  String landscapePathPdf = "";
  String remotePDFpath = "";
  late Ebook? ebook;

  SectionDetailModel? sectionDetailModel;

  @override
  void initState() {
    super.initState();
    ebook = widget.ebook;
    if (ebook != null && ebook?.url == null) {
      getSectionDetails(
          ebook?.typeId, ebook?.videoType, ebook?.id, ebook?.upcomingType);
    } else if (ebook?.url != null) {
      createFileOfPdfUrl(ebook?.url ?? "");
    }
  }

  Future<File> createFileOfPdfUrl(String pdfUrl) async {
    Completer<File> completer = Completer();
    if (kDebugMode) {
      print("Start download file from internet!");
    }
    try {
      var url = pdfUrl;
      final filename = url.substring(url.lastIndexOf("/") + 1);
      var request = await HttpClient().getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      var dir = await getApplicationDocumentsDirectory();
      if (kDebugMode) {
        print("Download files");
      }
      if (kDebugMode) {
        print("${dir.path}/$filename");
      }
      File file = File("${dir.path}/$filename");

      await file.writeAsBytes(bytes, flush: true);
      completer.complete(file);
    } catch (e) {
      throw Exception('Error parsing asset file!');
    }

    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: whiteLight1,
          foregroundColor: whiteLight1,
          centerTitle: false,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: const Text(
            "Read",
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back,color: black,), // Icon for the back button
            onPressed: () {
              Navigator.of(context).pop(); // Navigate back to previous screen
            },
          )),
      body: Stack(
        children: <Widget>[
          if (remotePDFpath.isNotEmpty)
            PDFView(
              filePath: remotePDFpath,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: true,
              pageSnap: true,
              defaultPage: currentPage!,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation: false,
              // if set to true the link is handled in flutter
              onRender: (_pages) {
                setState(() {
                  pages = _pages;
                  isReady = true;
                });
              },
              onError: (error) {
                setState(() {
                  errorMessage = error.toString();
                });
                if (kDebugMode) {
                  print(error.toString());
                }
              },
              onPageError: (page, error) {
                setState(() {
                  errorMessage = '$page: ${error.toString()}';
                });
                if (kDebugMode) {
                  print('$page: ${error.toString()}');
                }
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onLinkHandler: (String? uri) {
                if (kDebugMode) {
                  print('goto uri: $uri');
                }
              },
              onPageChanged: (int? page, int? total) {
                print('page change: $page/$total');
                setState(() {
                  currentPage = page;
                });
              },
            ),
          errorMessage.isEmpty
              ? !isReady
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container()
              : Center(
                  child: Text(errorMessage),
                )
        ],
      ),
      floatingActionButton: FutureBuilder<PDFViewController>(
        future: _controller.future,
        builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
          if (snapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                FloatingActionButton.extended(
                  label: const Text("Prev"),
                  onPressed: () async {
                    final controller = snapshot.data!;
                    final currentPage = await controller.getCurrentPage();
                    if (currentPage! > 0) {
                      await controller.setPage(currentPage - 1);
                    }
                  },
                ),
                FloatingActionButton.extended(
                  label: Text("Current: ${currentPage! + 1}"),
                  onPressed: () {}, // Action for displaying the current page
                ),
                FloatingActionButton.extended(
                  label: const Text("Next"),
                  onPressed: () async {
                    final controller = snapshot.data!;
                    final currentPage = await controller.getCurrentPage();
                    if (currentPage! < pages! - 1) {
                      await controller.setPage(currentPage + 1);
                    }
                  },
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }

  void getSectionDetails(typeId, videoType, videoId, upcomingType) {
    debugPrint("getSectionDetails typeId :========> $typeId");
    debugPrint("getSectionDetails videoType :=====> $videoType");
    debugPrint("getSectionDetails videoId :=======> $videoId");
    debugPrint("getSectionDetails upcomingType :==> $upcomingType");

    ApiService()
        .sectionDetails(typeId, videoType, videoId, upcomingType)
        .then((value) {
      setState(() {
        sectionDetailModel = value;
      });
      createFileOfPdfUrl(value.result?.video320 ?? "").then((f) {
        setState(() {
          remotePDFpath = f.path;
        });
      }).catchError((error) {
        debugPrint('Error creating PDF file: $error');
      });
    }).catchError((error) {
      debugPrint('Error fetching section details: $error');
    });
  }
}

class Ebook {
  final int id;
  final int typeId;
  final int upcomingType;
  final int videoType;
  final String? url; // Changed Strng to String and made it nullable

  Ebook({
    required this.id,
    required this.typeId,
    required this.upcomingType,
    required this.videoType,
    this.url, // Added this.url to the constructor
  });
}
