import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dtlive/webservice/notificationservice.dart';
import 'package:flutter/material.dart';

class DownloadProvider extends ChangeNotifier {
  late Dio dio;
  bool loading = false;
  final _progressList = <double>[];

  // double count = 0.0;

  double currentProgress(int index) {
    //fetch the current progress,
    //its in a list because we might want to download
    // multiple files at the same time,
    // so this makes sure the correct download progress
    // is updated.
    try {
      return _progressList[index];
    } catch (e) {
      _progressList.add(0.0);
      return 0;
    }
  }

  void downloadVideo(
      String filePathWithName, String downloadUrl, int index) async {
    NotificationService notificationService = NotificationService();

    final dio = Dio();

    try {
      dio.download(
        downloadUrl,
        filePathWithName,
        onReceiveProgress: ((count, total) async {
          await Future.delayed(const Duration(seconds: 1), () {
            _progressList[index] = (count / total);
            notificationService.createNotification(
                100, ((count / total) * 100).toInt(), index);
            notifyListeners();
          });
        }),
      );
    } on DioError catch (e) {
      log("error downloading file :======> $e");
    }
  }

  clearProvider() {
    log("<================ clearProvider ================>");
  }
}
