import 'package:flutter_downloader/flutter_downloader.dart';

class TaskInfo {
  String? taskId;
  int? progress = 0;
  DownloadTaskStatus? status = DownloadTaskStatus.undefined;

  TaskInfo({
    this.id,
    this.taskId,
    this.name,
    this.description,
    this.videoUrl,
    this.savedDir,
    this.savedFile,
    this.videoType,
    this.typeId,
    this.isPremium,
    this.isBuy,
    this.isRent,
    this.rentBuy,
    this.rentPrice,
    this.isDownload,
    this.videoDuration,
    this.videoUploadType,
    this.trailerUrl,
    this.releaseYear,
    this.landscapeImg,
    this.thumbnailImg,
  });

  final int? id;
  final String? name;
  final String? description;
  final String? videoUrl;
  final String? savedDir;
  final String? savedFile;
  final int? videoType;
  final int? typeId;
  final int? isPremium;
  final int? isBuy;
  final int? isRent;
  final int? rentBuy;
  final int? rentPrice;
  final int? isDownload;
  final int? videoDuration;
  final String? videoUploadType;
  final String? trailerUrl;
  final String? releaseYear;
  final String? landscapeImg;
  final String? thumbnailImg;

  factory TaskInfo.fromJson(Map<String, dynamic> json) => TaskInfo(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        videoUrl: json["videoUrl"],
        savedDir: json["savedDir"],
        savedFile: json["savedFile"],
        videoType: json["videoType"],
        typeId: json["typeId"],
        isPremium: json["isPremium"],
        isBuy: json["isBuy"],
        isRent: json["isRent"],
        rentBuy: json["rentBuy"],
        rentPrice: json["rentPrice"],
        isDownload: json["isDownload"],
        videoDuration: json["videoDuration"],
        videoUploadType: json["videoUploadType"],
        trailerUrl: json["trailerUrl"],
        releaseYear: json["releaseYear"],
        landscapeImg: json["landscapeImg"],
        thumbnailImg: json["thumbnailImg"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "videoUrl": videoUrl,
        "savedDir": savedDir,
        "savedFile": savedFile,
        "videoType": videoType,
        "typeId": typeId,
        "isPremium": isPremium,
        "isBuy": isBuy,
        "isRent": isRent,
        "rentBuy": rentBuy,
        "rentPrice": rentPrice,
        "isDownload": isDownload,
        "videoDuration": videoDuration,
        "videoUploadType": videoUploadType,
        "trailerUrl": trailerUrl,
        "releaseYear": releaseYear,
        "landscapeImg": landscapeImg,
        "thumbnailImg": thumbnailImg,
      };
}
