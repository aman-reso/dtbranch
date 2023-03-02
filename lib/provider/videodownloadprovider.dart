import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dtlive/utils/constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as path;

import 'package:dtlive/model/downloadvideomodel.dart';
import 'package:dtlive/model/sectiondetailmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path/path.dart';

class VideoDownloadProvider extends ChangeNotifier {
  List<DownloadVideoModel>? currentTasks;
  DownloadVideoModel? downloadTaskInfo;
  int dProgress = 0;

  // Create storage
  final storage = const FlutterSecureStorage();

  bool loading = false;

  Future<void> prepareDownload(
      Result? sectionDetails, String? localPath, String? mFileName) async {
    final tasks = await FlutterDownloader.loadTasks();

    if (tasks == null) {
      log('No tasks were retrieved from the database.');
      return;
    }

    currentTasks = [];

    DownloadVideoModel taskInfo = DownloadVideoModel(
      id: sectionDetails?.id,
      taskId: sectionDetails?.id.toString(),
      name: sectionDetails?.name,
      description: sectionDetails?.description,
      videoUrl: sectionDetails?.video320,
      savedDir: localPath,
      savedFile: path.join(localPath ?? '',
          '$mFileName.${(sectionDetails?.videoExtension ?? '.mp4')}'),
      videoType: sectionDetails?.videoType,
      typeId: sectionDetails?.typeId,
      isPremium: sectionDetails?.isPremium,
      isBuy: sectionDetails?.isBuy,
      isRent: sectionDetails?.isRent,
      rentBuy: sectionDetails?.rentBuy,
      rentPrice: sectionDetails?.rentPrice,
      isDownload: 1,
      videoDuration: sectionDetails?.videoDuration,
      releaseYear: sectionDetails?.releaseYear,
      landscapeImg: sectionDetails?.landscape,
      thumbnailImg: sectionDetails?.thumbnail,
    );
    currentTasks?.add(taskInfo);
    log('currentTasks ============> ${currentTasks?.length}');
    _requestDownload(taskInfo);
  }

  Future<void> _requestDownload(DownloadVideoModel task) async {
    log('savedFile ============> ${task.savedFile}');
    log('savedDir ============> ${task.savedDir}');
    log('link ============> ${task.videoUrl!}');
    task.taskId = await FlutterDownloader.enqueue(
      url: task.videoUrl!,
      headers: {'auth': 'test_for_sql_encoding'},
      fileName: basename(task.savedFile ?? ''),
      savedDir: task.savedDir ?? '',
      saveInPublicStorage: false,
    );
  }

  saveInSecureStorage() async {
    var listString = await storage.read(
            key: "${Constant.hawkVIDEOList}${Constant.userID}") ??
        '';
    log("listString ===> ${listString.toString()}");
    List<DownloadVideoModel>? myVideoList;
    if (listString.isNotEmpty) {
      myVideoList = List<DownloadVideoModel>.from(
          jsonDecode(listString).map((x) => DownloadVideoModel.fromJson(x)));
    }

    if ((myVideoList?.length ?? 0) > 0) {
      await checkVideoInSecure(
          myVideoList, currentTasks?[0].id.toString() ?? "");
    }
    myVideoList = currentTasks;
    log("myVideoList ===> ${myVideoList?.length}");

    if ((myVideoList?.length ?? 0) > 0) {
      await storage.write(
          key: "${Constant.hawkVIDEOList}${Constant.userID}",
          value: jsonEncode(myVideoList));
    }
  }

  checkVideoInSecure(
      List<DownloadVideoModel>? myVideoList, String videoID) async {
    log("checkVideoInSecure UserID ===> ${Constant.userID}");
    log("checkVideoInSecure videoID ===> $videoID");

    if ((myVideoList?.length ?? 0) == 0) {
      await storage.delete(key: "${Constant.hawkVIDEOList} ${Constant.userID}");
      return;
    }
    for (int i = 0; i < (myVideoList?.length ?? 0); i++) {
      log("Secure itemID ==> ${myVideoList?[i].id}");

      if ((myVideoList?[i].id.toString()) == (videoID)) {
        log("myVideoList =======================> i = $i");
        myVideoList?.remove(myVideoList[i]);
        if ((myVideoList?.length ?? 0) == 0) {
          await storage.delete(
              key: "${Constant.hawkVIDEOList} ${Constant.userID}");
          return;
        }
        await storage.write(
            key: "${Constant.hawkVIDEOList} ${Constant.userID}",
            value: jsonEncode(myVideoList));
        return;
      }
    }
  }

  Future<List<DownloadVideoModel>?> getDownloadsByType(String dType) async {
    loading = true;
    List<DownloadVideoModel>? myDownloadsList;
    if (dType == "video") {
      var listString = await storage.read(
              key: "${Constant.hawkVIDEOList}${Constant.userID}") ??
          '';
      log("listString ===> ${listString.toString()}");
      if (listString.isNotEmpty) {
        myDownloadsList = List<DownloadVideoModel>.from(
            jsonDecode(listString).map((x) => DownloadVideoModel.fromJson(x)));
      }
      loading = false;
      notifyListeners();
      return myDownloadsList;
    } else if (dType == "show") {
      loading = true;
      List<DownloadVideoModel>? myDownloadsList;
      var listString = await storage.read(
              key: "${Constant.hawkSHOWList}${Constant.userID}") ??
          '';
      log("listString ===> ${listString.toString()}");
      if (listString.isNotEmpty) {
        myDownloadsList = List<DownloadVideoModel>.from(
            jsonDecode(listString).map((x) => DownloadVideoModel.fromJson(x)));
      }
      loading = false;
      notifyListeners();
      return myDownloadsList;
    } else {
      loading = false;
      notifyListeners();
      return myDownloadsList;
    }
  }

  Future<void> deleteVideoFromDownload(String videoID) async {
    log("deleteVideoFromDownload UserID ===> ${Constant.userID}");
    log("deleteVideoFromDownload videoID ===> $videoID");
    List<DownloadVideoModel>? myVideoList = [];
    var listString = await storage.read(
            key: '${Constant.hawkVIDEOList}${Constant.userID}') ??
        '';
    log("listString ===> ${listString.toString()}");
    if (listString.isNotEmpty) {
      myVideoList = List<DownloadVideoModel>.from(
          jsonDecode(listString).map((x) => DownloadVideoModel.fromJson(x)));
    }
    log("myVideoList ===> ${myVideoList.length}");

    if (myVideoList.isEmpty) {
      await storage.delete(key: "${Constant.hawkVIDEOList}${Constant.userID}");
      return;
    }
    for (int i = 0; i < myVideoList.length; i++) {
      log("Secure itemID ==> ${myVideoList[i].id}");

      if ((myVideoList[i].id.toString()) == (videoID)) {
        log("myVideoList =======================> i = $i");
        String filePath = myVideoList[i].savedFile ?? "";
        myVideoList.remove(myVideoList[i]);
        File file = File(filePath);
        if (await file.exists()) {
          file.delete();
        }
        await storage.delete(
            key: "${Constant.hawkVIDEOList}${Constant.userID}");
      }
    }
  }

  setDownloadProgress(int progress) {
    dProgress = progress;
    if (dProgress == 100) {
      saveInSecureStorage();
    }
    notifyListeners();
    log('setDownloadProgress dProgress ==============> $dProgress');
  }

  clearProvider() {
    log("<================ clearProvider ================>");
  }
}
