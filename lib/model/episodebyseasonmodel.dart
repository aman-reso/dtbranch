// To parse this JSON data, do
// final episodeBySeasonModel = episodeBySeasonModelFromJson(jsonString);

import 'dart:convert';

EpisodeBySeasonModel epiBySeasonModelFromJson(String str) =>
    EpisodeBySeasonModel.fromJson(json.decode(str));

String epiBySeasonModelToJson(EpisodeBySeasonModel data) =>
    json.encode(data.toJson());

class EpisodeBySeasonModel {
  EpisodeBySeasonModel({
    this.code,
    this.status,
    this.message,
    this.result,
  });

  int? code;
  int? status;
  String? message;
  List<Result>? result;

  factory EpisodeBySeasonModel.fromJson(Map<String, dynamic> json) =>
      EpisodeBySeasonModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result?.map((x) => x.toJson()) ?? []),
      };
}

class Result {
  Result({
    this.id,
    this.showId,
    this.sessionId,
    this.thumbnail,
    this.landscape,
    this.video,
    this.videoUploadType,
    this.videoType,
    this.videoUrl,
    this.videoExtension,
    this.videoDuration,
    this.isPremium,
    this.description,
    this.view,
    this.download,
    this.status,
    this.isTitle,
    this.createdAt,
    this.updatedAt,
    this.stopTime,
    this.isDownloaded,
    this.isBookmark,
    this.rentBuy,
    this.isRent,
    this.rentPrice,
    this.isBuy,
    this.categoryName,
  });

  int? id;
  int? showId;
  int? sessionId;
  String? thumbnail;
  String? landscape;
  String? video;
  String? videoUploadType;
  String? videoType;
  String? videoUrl;
  String? videoExtension;
  int? videoDuration;
  int? isPremium;
  String? description;
  int? view;
  int? download;
  String? status;
  String? isTitle;
  String? createdAt;
  String? updatedAt;
  int? stopTime;
  int? isDownloaded;
  int? isBookmark;
  int? rentBuy;
  int? isRent;
  int? rentPrice;
  int? isBuy;
  String? categoryName;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        showId: json["show_id"],
        sessionId: json["session_id"],
        thumbnail: json["thumbnail"],
        landscape: json["landscape"],
        video: json["video"],
        videoUploadType: json["video_upload_type"],
        videoType: json["video_type"],
        videoUrl: json["video_url"],
        videoExtension: json["video_extension"],
        videoDuration: json["video_duration"],
        isPremium: json["is_premium"],
        description: json["description"],
        view: json["view"],
        download: json["download"],
        status: json["status"],
        isTitle: json["is_title"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        stopTime: json["stop_time"],
        isDownloaded: json["is_downloaded"],
        isBookmark: json["is_bookmark"],
        rentBuy: json["rent_buy"],
        isRent: json["is_rent"],
        rentPrice: json["rent_price"],
        isBuy: json["is_buy"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "show_id": showId,
        "session_id": sessionId,
        "thumbnail": thumbnail,
        "landscape": landscape,
        "video": video,
        "video_upload_type": videoUploadType,
        "video_type": videoType,
        "video_url": videoUrl,
        "video_extension": videoExtension,
        "video_duration": videoDuration,
        "is_premium": isPremium,
        "description": description,
        "view": view,
        "download": download,
        "status": status,
        "is_title": isTitle,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "stop_time": stopTime,
        "is_downloaded": isDownloaded,
        "is_bookmark": isBookmark,
        "rent_buy": rentBuy,
        "is_rent": isRent,
        "rent_price": rentPrice,
        "is_buy": isBuy,
        "category_name": categoryName,
      };
}
