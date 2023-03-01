import 'dart:convert';
import 'dart:developer';
import 'package:dtlive/utils/constant.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as path;

import 'package:dtlive/model/itemholder.dart';
import 'package:dtlive/model/taskinfomodel.dart';
import 'package:dtlive/model/sectiondetailmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path/path.dart';

class VideoDownloadProvider extends ChangeNotifier {
  List<TaskInfo>? currentTasks;
  late List<ItemHolder> items;
  TaskInfo? downloadTaskInfo;
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
    items = [];

    TaskInfo taskInfo = TaskInfo(
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
    items.add(ItemHolder(name: taskInfo.name, task: taskInfo));
    _requestDownload(taskInfo);
  }

  Future<void> _requestDownload(TaskInfo task) async {
    log('savedFile ============> ${task.savedFile}');
    log('savedDir ============> ${task.savedDir}');
    log('link ============> ${task.videoUrl!}');
    task.taskId = await FlutterDownloader.enqueue(
      url: task.videoUrl!,
      headers: {'auth': 'test_for_sql_encoding'},
      fileName: basename(task.savedFile ?? ''),
      savedDir: task.savedDir ?? '',
      saveInPublicStorage: true,
    );
  }

  saveInSecureStorage() async {
    var listString = await storage.read(
            key: "${Constant.hawkVIDEOList}${Constant.userID}") ??
        '';
    log("listString ===> ${listString.toString()}");
    List<TaskInfo>? myVideoList;
    if (listString.isNotEmpty) {
      myVideoList = List<TaskInfo>.from(
          jsonDecode(listString).map((x) => TaskInfo.fromJson(x)));
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

  checkVideoInSecure(List<TaskInfo>? myVideoList, String videoID) async {
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

        await storage.write(
            key: "${Constant.hawkVIDEOList} ${Constant.userID}",
            value: jsonEncode(myVideoList));
        return;
      }
    }
  }

  Future<List<TaskInfo>?> getDownloadsByType(String dType) async {
    List<TaskInfo>? myDownloadsList;
    if (dType == "video") {
      var listString = await storage.read(
              key: "${Constant.hawkVIDEOList}${Constant.userID}") ??
          '';
      log("listString ===> ${listString.toString()}");
      if (listString.isNotEmpty) {
        myDownloadsList = List<TaskInfo>.from(
            jsonDecode(listString).map((x) => TaskInfo.fromJson(x)));
      }
      return myDownloadsList;
    } else if (dType == "show") {
      var listString = await storage.read(
              key: "${Constant.hawkVIDEOList}${Constant.userID}") ??
          '';
      log("listString ===> ${listString.toString()}");
      if (listString.isNotEmpty) {
        myDownloadsList = List<TaskInfo>.from(
            jsonDecode(listString).map((x) => TaskInfo.fromJson(x)));
      }
      return myDownloadsList;
    } else {
      return myDownloadsList;
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
