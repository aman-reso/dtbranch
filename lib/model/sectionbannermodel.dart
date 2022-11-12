// To parse this JSON data, do
// final sectionBannerModel = sectionBannerModelFromJson(jsonString);

import 'dart:convert';

SectionBannerModel sectionBannerModelFromJson(String str) =>
    SectionBannerModel.fromJson(json.decode(str));

String sectionBannerModelToJson(SectionBannerModel data) =>
    json.encode(data.toJson());

class SectionBannerModel {
  SectionBannerModel({
    this.code,
    this.status,
    this.message,
    this.result,
  });

  int? code;
  int? status;
  String? message;
  List<Result>? result;

  factory SectionBannerModel.fromJson(Map<String, dynamic> json) =>
      SectionBannerModel(
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
        "result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.name,
    this.id,
    this.categoryId,
    this.description,
    this.videoType,
    this.typeId,
    this.thumbnail,
    this.landscape,
    this.video,
    this.stopTime,
    this.isDownloaded,
    this.isBookmark,
    this.rentBuy,
    this.isRent,
    this.rentPrice,
    this.isBuy,
    this.categoryName,
    this.sessionId,
  });

  String? name;
  int? id;
  String? categoryId;
  String? description;
  int? videoType;
  int? typeId;
  String? thumbnail;
  String? landscape;
  String? video;
  int? stopTime;
  int? isDownloaded;
  int? isBookmark;
  int? rentBuy;
  int? isRent;
  int? rentPrice;
  int? isBuy;
  String? categoryName;
  String? sessionId;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        id: json["id"],
        categoryId: json["category_id"],
        description: json["description"],
        videoType: json["video_type"],
        typeId: json["type_id"],
        thumbnail: json["thumbnail"],
        landscape: json["landscape"],
        video: json["video"],
        stopTime: json["stop_time"],
        isDownloaded: json["is_downloaded"],
        isBookmark: json["is_bookmark"],
        rentBuy: json["rent_buy"],
        isRent: json["is_rent"],
        rentPrice: json["rent_price"],
        isBuy: json["is_buy"],
        categoryName: json["category_name"],
        sessionId: json["session_id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "category_id": categoryId,
        "description": description,
        "video_type": videoType,
        "type_id": typeId,
        "thumbnail": thumbnail,
        "landscape": landscape,
        "video": video,
        "stop_time": stopTime,
        "is_downloaded": isDownloaded,
        "is_bookmark": isBookmark,
        "rent_buy": rentBuy,
        "is_rent": isRent,
        "rent_price": rentPrice,
        "is_buy": isBuy,
        "category_name": categoryName,
        "session_id": sessionId,
      };
}
