import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dtlive/model/downloadvideomodel.dart';
import 'package:dtlive/provider/showdetailsprovider.dart';
import 'package:dtlive/utils/constant.dart';
import 'package:dtlive/utils/utils.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path/path.dart' as path;

import 'package:dtlive/model/sectiondetailmodel.dart';
import 'package:dtlive/model/episodebyseasonmodel.dart' as episode;
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

class ShowDownloadProvider extends ChangeNotifier {
  /* view Downloads init */
  int? seasonClickIndex;

  late BuildContext context;
  int dProgress = 0;
  int? cEpisodePos;
  int? seasonPos;
  int? mTotalEpi;
  Result? sectionDetails;
  List<Session>? seasonList;
  List<episode.Result>? episodeList;
  String? localPath;
  List<String>? savedEpiPathList = [];

  // Create storage
  final storage = const FlutterSecureStorage();

  bool loading = false;

  Future<void> prepareDownload(
      BuildContext context,
      Result? sectionDetails,
      List<Session>? seasonList,
      int? seasonPos,
      List<episode.Result>? episodeList) async {
    this.context = context;
    final tasks = await FlutterDownloader.loadTasks();

    if (tasks == null) {
      log('No tasks were retrieved from the database.');
      return;
    }

    if (this.sectionDetails != null) {
      this.sectionDetails = Result();
    }
    if (this.seasonList != null) {
      this.seasonPos = null;
      this.seasonList = [];
    }
    if (this.episodeList != null) {
      this.episodeList = [];
    }

    this.sectionDetails = sectionDetails;
    this.seasonList = seasonList;
    this.seasonPos = seasonPos;
    this.episodeList = episodeList;

    mTotalEpi = this.episodeList?.length;
    log("mTotalEpi ----------------------> $mTotalEpi");
    localPath = await Utils.prepareShowSaveDir(
        (sectionDetails?.name ?? "").replaceAll(RegExp('\\W+'), ''),
        (seasonList?[(seasonPos ?? 0)].name ?? "")
            .replaceAll(RegExp('\\W+'), ''));
    log("localPath ====> $localPath");
    _downloadEpisodeByPos(0);
  }

  _downloadEpisodeByPos(int epiPosition) async {
    if ((episodeList?[epiPosition].video320 ?? "").isNotEmpty) {
      cEpisodePos = epiPosition;
      log("cEpisodePos ========> $cEpisodePos");

      File? mTargetFile;
      String? mFileName =
          '${(seasonList?[(seasonPos ?? 0)].name ?? "").replaceAll(RegExp('\\W+'), '')}'
          '_Ep${(epiPosition + 1)}_${episodeList?[epiPosition].id}${(Constant.userID)}';

      try {
        mTargetFile = File(path.join(localPath ?? "",
            '$mFileName.${(episodeList?[epiPosition].videoExtension ?? "mp4")}'));
        // This is a sync operation on a real
        // app you'd probably prefer to use writeAsByte and handle its Future
      } catch (e) {
        debugPrint("saveShowStorage Exception ===> $e");
      }
      log("mFileName ========> $mFileName");
      log("mTargetFile ========> ${mTargetFile?.absolute.path ?? ""}");

      if (mTargetFile != null) {
        try {
          savedEpiPathList ??= [];
          savedEpiPathList?.add(mTargetFile.path);
          log("savedEpiPathList ========> ${savedEpiPathList?[epiPosition]}");
          await _requestDownload((episodeList?[epiPosition].video320 ?? ""),
              localPath, mTargetFile.path);
        } catch (e) {
          log("Downloading... Exception ======> $e");
        }
      }
    } else {
      if (!context.mounted) return;
      Utils.showSnackbar(context, "fail", "invalid_url", true);
    }
  }

  Future<void> _requestDownload(
      String? videoUrl, String? savedDir, String? savedFile) async {
    log('savedFile ===========> $savedFile');
    log('savedDir ============> $savedDir');
    log('videoUrl ============> $videoUrl');
    await FlutterDownloader.enqueue(
      url: videoUrl ?? "",
      headers: {'auth': 'test_for_sql_encoding'},
      fileName: basename(savedFile ?? ''),
      savedDir: savedDir ?? '',
      saveInPublicStorage: false,
    );
  }

  saveEpisodeInSecureStorage(int epiPosition) async {
    var listString = await storage.read(
            key:
                '${Constant.hawkEPISODEList}${Constant.userID}${seasonList?[(seasonPos ?? 0)].id}${sectionDetails?.id}') ??
        '';
    log("listString ===> ${listString.toString()}");
    List<EpisodeItem>? myEpiList;
    if (listString.isNotEmpty) {
      myEpiList = List<EpisodeItem>.from(
          jsonDecode(listString).map((x) => EpisodeItem.fromJson(x)));
    }
    log("myEpiList ===> ${myEpiList?.length}");
    log("savedEpiPathList ===> ${savedEpiPathList?[epiPosition]}");

    /* Save Episodes */
    EpisodeItem episodeItem = EpisodeItem(
      id: episodeList?[epiPosition].id,
      showId: sectionDetails?.id,
      sessionId: seasonList?[(seasonPos ?? 0)].id,
      thumbnail: episodeList?[epiPosition].thumbnail,
      landscape: episodeList?[epiPosition].landscape,
      videoUploadType: episodeList?[epiPosition].videoUploadType,
      videoType: episodeList?[epiPosition].videoType,
      videoExtension: episodeList?[epiPosition].videoExtension,
      videoDuration: episodeList?[epiPosition].videoDuration,
      isPremium: episodeList?[epiPosition].isPremium,
      description: episodeList?[epiPosition].description,
      status: episodeList?[epiPosition].status,
      video320: episodeList?[epiPosition].video320,
      video480: episodeList?[epiPosition].video480,
      video720: episodeList?[epiPosition].video720,
      video1080: episodeList?[epiPosition].video1080,
      savedDir: localPath,
      savedFile: savedEpiPathList?[epiPosition],
      subtitle: episodeList?[epiPosition].subtitle,
      subtitleType: episodeList?[epiPosition].subtitleType,
      isDownloaded: 1,
      isBookmark: episodeList?[epiPosition].isBookmark,
      rentBuy: episodeList?[epiPosition].rentBuy,
      isRent: episodeList?[epiPosition].isRent,
      rentPrice: episodeList?[epiPosition].rentPrice,
      isBuy: episodeList?[epiPosition].isBuy,
      categoryName: episodeList?[epiPosition].categoryName,
    );

    myEpiList ??= [];
    if (myEpiList.isNotEmpty) {
      await checkEpisodeInSecure(
          myEpiList,
          episodeList?[epiPosition].id.toString() ?? "",
          sectionDetails?.id.toString() ?? "",
          seasonList?[(seasonPos ?? 0)].id.toString() ?? "");
    }
    myEpiList.add(episodeItem);
    log("myEpiList ===> ${myEpiList.length}");

    if (myEpiList.isNotEmpty) {
      await storage.write(
          key:
              '${Constant.hawkEPISODEList}${Constant.userID}${seasonList?[(seasonPos ?? 0)].id}${sectionDetails?.id}',
          value: jsonEncode(myEpiList));
    }
    /* **************/

    log("cEpisodePos -------------------===> $cEpisodePos");
    log("lastEpiPos --------------------===> ${((mTotalEpi ?? 0) - 1)}");
    if (cEpisodePos == (mTotalEpi ?? 0) - 1) {
      saveShowInSecureStorage();
    } else {
      cEpisodePos = (cEpisodePos ?? 0) + 1;
      _downloadEpisodeByPos(cEpisodePos ?? 0);
    }
    log("cEpisodePos -------------------===> $cEpisodePos");
  }

  saveShowInSecureStorage() async {
    final showDetailsProvider =
        Provider.of<ShowDetailsProvider>(context, listen: false);
    var listString = await storage.read(
            key:
                "${Constant.hawkEPISODEList}${Constant.userID}${seasonList?[(seasonPos ?? 0)].id}${sectionDetails?.id}") ??
        '';
    log("listString ===> ${listString.toString()}");
    List<EpisodeItem>? myEpiList;
    if (listString.isNotEmpty) {
      myEpiList = List<EpisodeItem>.from(
          jsonDecode(listString).map((x) => EpisodeItem.fromJson(x)));
    }

    /* Save Seasons */
    var listSeasonString = await storage.read(
            key:
                "${Constant.hawkSEASONList}${Constant.userID}${sectionDetails?.id}") ??
        '';
    log("listSeasonString ===> ${listSeasonString.toString()}");
    List<SessionItem>? mySeasonList;
    if (listSeasonString.isNotEmpty) {
      mySeasonList = List<SessionItem>.from(
          jsonDecode(listSeasonString).map((x) => SessionItem.fromJson(x)));
    }
    SessionItem sessionItem = SessionItem(
      id: seasonList?[(seasonPos ?? 0)].id,
      showId: sectionDetails?.id,
      sessionPosition: seasonPos,
      name: seasonList?[(seasonPos ?? 0)].name,
      status: seasonList?[(seasonPos ?? 0)].status,
      isDownloaded: 1,
      rentBuy: seasonList?[(seasonPos ?? 0)].rentBuy,
      isRent: seasonList?[(seasonPos ?? 0)].isRent,
      rentPrice: seasonList?[(seasonPos ?? 0)].rentPrice,
      isBuy: seasonList?[(seasonPos ?? 0)].isBuy,
      episode: myEpiList,
    );
    mySeasonList ??= [];
    if (mySeasonList.isNotEmpty) {
      await checkSeasonInSecure(
          mySeasonList,
          sectionDetails?.id.toString() ?? "",
          seasonList?[(seasonPos ?? 0)].id.toString() ?? "");
    }
    mySeasonList.add(sessionItem);
    log("mySeasonList ===> ${mySeasonList.length}");

    if (mySeasonList.isNotEmpty) {
      await storage.write(
          key:
              "${Constant.hawkSEASONList}${Constant.userID}${sectionDetails?.id}",
          value: jsonEncode(mySeasonList));
    }
    /* ************/

    /* Save Show */
    var listShowString =
        await storage.read(key: "${Constant.hawkSHOWList}${Constant.userID}") ??
            '';
    log("listShowString ===> ${listShowString.toString()}");
    List<DownloadVideoModel>? myShowList;
    if (listShowString.isNotEmpty) {
      myShowList = List<DownloadVideoModel>.from(jsonDecode(listShowString)
          .map((x) => DownloadVideoModel.fromJson(x)));
    }
    DownloadVideoModel downloadShowModel = DownloadVideoModel(
      id: sectionDetails?.id,
      taskId: sectionDetails?.id.toString(),
      name: sectionDetails?.name,
      description: sectionDetails?.description,
      videoType: sectionDetails?.videoType,
      typeId: sectionDetails?.typeId,
      isPremium: sectionDetails?.isPremium,
      isBuy: sectionDetails?.isBuy,
      isRent: sectionDetails?.isRent,
      rentBuy: sectionDetails?.rentBuy,
      rentPrice: sectionDetails?.rentPrice,
      isDownload: 1,
      releaseYear: sectionDetails?.releaseYear,
      landscapeImg: sectionDetails?.landscape,
      thumbnailImg: sectionDetails?.thumbnail,
      savedDir: localPath,
      session: mySeasonList,
    );
    myShowList ??= [];
    if (myShowList.isNotEmpty) {
      await checkShowInSecure(myShowList, sectionDetails?.id.toString() ?? "");
    }
    myShowList.add(downloadShowModel);
    log("myShowList ===> ${myShowList.length}");

    if (myShowList.isNotEmpty) {
      await storage.write(
          key: "${Constant.hawkSHOWList}${Constant.userID}",
          value: jsonEncode(myShowList));
    }
    /* ************/

    if (cEpisodePos == (mTotalEpi ?? 0) - 1) {
      // ignore: use_build_context_synchronously
      showDetailsProvider.setDownloadComplete(
          context,
          showDetailsProvider
              .sectionDetailModel.session?[showDetailsProvider.seasonPos].id,
          showDetailsProvider.sectionDetailModel.result?.videoType,
          showDetailsProvider.sectionDetailModel.result?.typeId,
          showDetailsProvider.sectionDetailModel.result?.id);
    }
    notifyListeners();
  }

  checkShowInSecure(List<DownloadVideoModel>? myShowList, String showID) async {
    log("checkShowInSecure UserID ===> ${Constant.userID}");
    log("checkShowInSecure showID ===> $showID");

    if ((myShowList?.length ?? 0) == 0) {
      await storage.delete(key: "${Constant.hawkSHOWList}${Constant.userID}");
      return;
    }
    for (int i = 0; i < (myShowList?.length ?? 0); i++) {
      log("Secure itemID ==> ${myShowList?[i].id}");

      if ((myShowList?[i].id.toString()) == (showID)) {
        log("myShowList =======================> i = $i");
        myShowList?.remove(myShowList[i]);

        await storage.write(
            key: "${Constant.hawkSHOWList}${Constant.userID}",
            value: jsonEncode(myShowList));
      }
    }
  }

  checkSeasonInSecure(
      List<SessionItem>? mySeasonList, String showID, String seasonID) async {
    log("checkSeasonInSecure UserID ===> ${Constant.userID}");
    log("checkSeasonInSecure showID ===> $showID");
    log("checkSeasonInSecure seasonID ===> $seasonID");

    if ((mySeasonList?.length ?? 0) == 0) {
      await storage.delete(
          key: "${Constant.hawkSEASONList}${Constant.userID}$showID");
      return;
    }
    for (int i = 0; i < (mySeasonList?.length ?? 0); i++) {
      log("Secure itemID ==> ${mySeasonList?[i].id}");

      if ((mySeasonList?[i].id.toString()) == (seasonID) &&
          (mySeasonList?[i].showId.toString()) == (showID)) {
        log("mySeasonList =======================> i = $i");
        mySeasonList?.remove(mySeasonList[i]);

        await storage.write(
            key: "${Constant.hawkSEASONList}${Constant.userID}$showID",
            value: jsonEncode(mySeasonList));
      }
    }
  }

  checkEpisodeInSecure(List<EpisodeItem>? myEpisodeList, String epiID,
      String showID, String seasonID) async {
    log("checkEpisodeInSecure UserID ===> ${Constant.userID}");
    log("checkEpisodeInSecure epiID ===> $epiID");
    log("checkEpisodeInSecure showID ===> $showID");
    log("checkEpisodeInSecure seasonID ===> $seasonID");

    if ((myEpisodeList?.length ?? 0) == 0) {
      await storage.delete(
          key: "${Constant.hawkEPISODEList}${Constant.userID}$seasonID$showID");
      return;
    }
    for (int i = 0; i < (myEpisodeList?.length ?? 0); i++) {
      log("Secure itemID ==> ${myEpisodeList?[i].id}");

      if ((myEpisodeList?[i].id.toString()) == (epiID) &&
          (myEpisodeList?[i].showId.toString()) == (showID) &&
          (myEpisodeList?[i].sessionId.toString()) == (seasonID)) {
        log("myEpisodeList =======================> i = $i");
        myEpisodeList?.remove(myEpisodeList[i]);

        await storage.write(
            key:
                "${Constant.hawkEPISODEList}${Constant.userID}$seasonID$showID",
            value: jsonEncode(myEpisodeList));
      }
    }
  }

  Future<List<SessionItem>?> getDownloadedSeasons(String showID) async {
    loading = true;
    List<SessionItem>? mySeasonList;
    var listString = await storage.read(
            key: "${Constant.hawkSEASONList}${Constant.userID}$showID") ??
        '';
    log("listString ===> ${listString.toString()}");
    if (listString.isNotEmpty) {
      mySeasonList = List<SessionItem>.from(
          jsonDecode(listString).map((x) => SessionItem.fromJson(x)));
    }
    loading = false;
    notifyListeners();
    return mySeasonList;
  }

  Future<List<EpisodeItem>?> getDownloadedEpisodes(
      String showID, String seasonID) async {
    loading = true;
    List<EpisodeItem>? myEpisodeList;
    var listString = await storage.read(
            key:
                "${Constant.hawkEPISODEList}${Constant.userID}$seasonID$showID") ??
        '';
    log("listString ===> ${listString.toString()}");
    if (listString.isNotEmpty) {
      myEpisodeList = List<EpisodeItem>.from(
          jsonDecode(listString).map((x) => EpisodeItem.fromJson(x)));
    }
    loading = false;
    notifyListeners();
    return myEpisodeList;
  }

  Future<void> deleteShowFromDownload(String showID) async {
    log("deleteShowFromDownload UserID ===> ${Constant.userID}");
    log("deleteShowFromDownload showID ===> $showID");
    List<DownloadVideoModel>? myShowList = [];
    var listString =
        await storage.read(key: '${Constant.hawkSHOWList}${Constant.userID}') ??
            '';
    log("listString ===> ${listString.toString()}");
    if (listString.isNotEmpty) {
      myShowList = List<DownloadVideoModel>.from(
          jsonDecode(listString).map((x) => DownloadVideoModel.fromJson(x)));
    }
    log("myShowList ===> ${myShowList.length}");

    if (myShowList.isEmpty) {
      await storage.delete(key: "${Constant.hawkSHOWList}${Constant.userID}");
      return;
    }
    for (int i = 0; i < myShowList.length; i++) {
      log("Secure itemID ==> ${myShowList[i].id}");

      if ((myShowList[i].id.toString()) == (showID)) {
        log("myShowList =======================> i = $i");
        String dirPath = myShowList[i].savedDir ?? "";
        myShowList.remove(myShowList[i]);
        File dirFolder = File(dirPath);
        log("File existsSync ==> ${dirFolder.existsSync()}");
        dirFolder.deleteSync(recursive: true);
        await storage.delete(key: "${Constant.hawkSHOWList}${Constant.userID}");
      }
    }
  }

  Future<void> deleteEpisodeFromDownload(List<EpisodeItem>? myEpisodeList,
      String epiID, String showID, String seasonID) async {
    List<DownloadVideoModel>? myShowList = [];
    List<SessionItem>? mySessionList = [];
    List<EpisodeItem>? myEpisodeList = [];
    var listString =
        await storage.read(key: '${Constant.hawkSHOWList}${Constant.userID}') ??
            '';
    log("listString ===> ${listString.toString()}");
    if (listString.isNotEmpty) {
      myShowList = List<DownloadVideoModel>.from(
          jsonDecode(listString).map((x) => DownloadVideoModel.fromJson(x)));
    }
    log("myShowList ===> ${myShowList.length}");

    var listSeasonString = await storage.read(
            key:
                '${Constant.hawkSEASONList}${Constant.userID}${sectionDetails?.id}') ??
        '';
    log("listSeasonString ===> ${listSeasonString.toString()}");
    if (listSeasonString.isNotEmpty) {
      mySessionList = List<SessionItem>.from(
          jsonDecode(listSeasonString).map((x) => SessionItem.fromJson(x)));
    }
    log("mySeasonList ===> ${mySessionList.length}");

    var listEpisodeString = await storage.read(
            key:
                '${Constant.hawkEPISODEList}${Constant.userID}${seasonList?[(seasonPos ?? 0)].id}${sectionDetails?.id}') ??
        '';
    log("listEpisodeString ===> ${listEpisodeString.toString()}");
    if (listEpisodeString.isNotEmpty) {
      myEpisodeList = List<EpisodeItem>.from(
          jsonDecode(listEpisodeString).map((x) => EpisodeItem.fromJson(x)));
    }
    log("myEpisodeList ===> ${myEpisodeList.length}");

    /* Main Download Loop */
    for (int i = 0; i < myShowList.length; i++) {
      if ((myShowList[i].id.toString()) == showID) {
        log("Stored ShowID ========> ${myShowList[i].id}");
        /* Season(Session) Loop */
        for (int j = 0; j < mySessionList.length; j++) {
          if (mySessionList[j].id.toString() == seasonID.toString() &&
              mySessionList[j].showId.toString() == showID.toString()) {
            log("Stored SessionID ========> ${mySessionList[j].id}");
            /* Episode Loop */
            for (int k = 0; k < myEpisodeList.length; k++) {
              log("Hawk epiID ==> ${myEpisodeList[k].id}");
              if (myEpisodeList[k].id.toString() == epiID.toString() &&
                  myEpisodeList[k].showId.toString() == showID.toString() &&
                  myEpisodeList[k].sessionId.toString() ==
                      seasonID.toString()) {
                log("Stored EpisodeID ========> ${myEpisodeList[k].id}");
                log("Stored SessionID ========> ${myEpisodeList[k].sessionId}");
                log("Stored ShowID ========> ${myEpisodeList[k].showId}");
                log("myEpisodeList =======================> k = $k");
                String dirPath = myShowList[i].savedDir ?? "";
                String epiPath = myEpisodeList[k].savedFile ?? "";
                log("epiPath =====> $epiPath");
                log("dirPath =====> $dirPath");

                log("myEpisodeList ====BEFORE=====> ${myEpisodeList.length}");
                myEpisodeList.remove(myEpisodeList[k]);
                log("myEpisodeList ====AFTER=====> ${myEpisodeList.length}");
                await storage.write(
                    key:
                        "${Constant.hawkEPISODEList}${Constant.userID}$seasonID$showID",
                    value: jsonEncode(myEpisodeList));
                if (myEpisodeList.isEmpty) {
                  log("mySessionList ====BEFORE=====> ${mySessionList.length}");
                  mySessionList.remove(mySessionList[j]);
                  log("mySessionList ====AFTER=====> ${mySessionList.length}");
                }
                if (myEpisodeList.isNotEmpty) {
                  mySessionList[j].episode = myEpisodeList;
                }
                await storage.write(
                    key: "${Constant.hawkSEASONList}${Constant.userID}$showID",
                    value: jsonEncode(mySessionList));
                if (mySessionList.isEmpty) {
                  log("myShowList ====BEFORE=====> ${myShowList.length}");
                  myShowList.remove(myShowList[i]);
                  log("myShowList ====AFTER=====> ${myShowList.length}");
                }
                if (mySessionList.isNotEmpty) {
                  myShowList[i].session = mySessionList;
                }

                await storage.write(
                    key: "${Constant.hawkSHOWList}${Constant.userID}",
                    value: jsonEncode(myShowList));
                log("myShowList ====SIZE=====> ${myShowList.length}");

                if (myEpisodeList.isNotEmpty) {
                  File file = File(epiPath);
                  if (await file.exists()) {
                    file.delete();
                  }
                } else {
                  if (mySessionList.isEmpty) {
                    File dirFolder = File(dirPath);
                    log("File existsSync ==> ${dirFolder.existsSync()}");
                    dirFolder.deleteSync(recursive: true);
                    await storage.delete(
                        key: "${Constant.hawkSHOWList}${Constant.userID}");
                  }
                }
                return;
              }
            }
          }
        }
      }
    }
  }

  setSelectedSeason(index) {
    seasonClickIndex = index;
    notifyListeners();
  }

  setDownloadProgress(int progress) {
    dProgress = progress;
    if (progress == 100) {
      saveEpisodeInSecureStorage(cEpisodePos ?? 0);
      dProgress = 0;
    }
    notifyListeners();
    log('setDownloadProgress dProgress ==============> $dProgress');
  }

  clearProvider() {
    seasonClickIndex;
    dProgress = 0;
    cEpisodePos;
    seasonPos;
    mTotalEpi;
    sectionDetails;
    seasonList = [];
    episodeList = [];
    localPath = "";
    savedEpiPathList = [];
    log("<================ clearProvider ================>");
  }
}
