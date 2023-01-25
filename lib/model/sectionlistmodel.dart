// To parse this JSON data, do
// final sectionListModel = sectionListModelFromJson(jsonString);

import 'dart:convert';

SectionListModel sectionListModelFromJson(String str) =>
    SectionListModel.fromJson(json.decode(str));

String sectionListModelToJson(SectionListModel data) =>
    json.encode(data.toJson());

class SectionListModel {
  SectionListModel({
    this.code,
    this.status,
    this.message,
    this.result,
    this.continueWatching,
  });

  int? code;
  int? status;
  String? message;
  List<Result>? result;
  List<ContinueWatching>? continueWatching;

  factory SectionListModel.fromJson(Map<String, dynamic> json) =>
      SectionListModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        result: List<Result>.from(
            json["result"].map((x) => Result.fromJson(x)) ?? []),
        continueWatching: json["continue_watching"] != null
            ? List<ContinueWatching>.from(json["continue_watching"]
                .map((x) => ContinueWatching.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "result": List<dynamic>.from(result?.map((x) => x.toJson()) ?? []),
        "continue_watching": continueWatching != null
            ? List<dynamic>.from(continueWatching?.map((x) => x.toJson()) ?? [])
            : [],
      };
}

class ContinueWatching {
  ContinueWatching({
    this.id,
    this.categoryId,
    this.languageId,
    this.castId,
    this.channelId,
    this.directorId,
    this.starringId,
    this.supportingCastId,
    this.networks,
    this.maturityRating,
    this.name,
    this.thumbnail,
    this.landscape,
    this.webImg,
    this.videoUploadType,
    this.video,
    this.trailerUrl,
    this.releaseYear,
    this.ageRestriction,
    this.maxVideoQuality,
    this.releaseTag,
    this.typeId,
    this.videoType,
    this.videoUrl,
    this.videoExtension,
    this.isPremium,
    this.description,
    this.videoDuration,
    this.videoSize,
    this.view,
    this.imdbRating,
    this.download,
    this.avgRating,
    this.noOfRating,
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
    this.sessionId,
  });

  int? id;
  String? categoryId;
  String? languageId;
  String? castId;
  int? channelId;
  String? directorId;
  String? starringId;
  String? supportingCastId;
  String? networks;
  String? maturityRating;
  String? name;
  String? thumbnail;
  String? landscape;
  String? webImg;
  String? videoUploadType;
  String? video;
  String? trailerUrl;
  String? releaseYear;
  String? ageRestriction;
  String? maxVideoQuality;
  String? releaseTag;
  int? typeId;
  int? videoType;
  String? videoUrl;
  String? videoExtension;
  int? isPremium;
  String? description;
  int? videoDuration;
  int? videoSize;
  int? view;
  int? imdbRating;
  int? download;
  int? avgRating;
  int? noOfRating;
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
  String? sessionId;

  factory ContinueWatching.fromJson(Map<String, dynamic> json) =>
      ContinueWatching(
        id: json["id"],
        categoryId: json["category_id"],
        languageId: json["language_id"],
        castId: json["cast_id"],
        channelId: json["channel_id"],
        directorId: json["director_id"],
        starringId: json["starring_id"],
        supportingCastId: json["supporting_cast_id"],
        networks: json["networks"],
        maturityRating: json["maturity_rating"],
        name: json["name"],
        thumbnail: json["thumbnail"],
        landscape: json["landscape"],
        webImg: json["web_img"],
        videoUploadType: json["video_upload_type"],
        video: json["video"],
        trailerUrl: json["trailer_url"],
        releaseYear: json["release_year"],
        ageRestriction: json["age_restriction"],
        maxVideoQuality: json["max_video_quality"],
        releaseTag: json["release_tag"],
        typeId: json["type_id"],
        videoType: json["video_type"],
        videoUrl: json["video_url"],
        videoExtension: json["video_extension"],
        isPremium: json["is_premium"],
        description: json["description"],
        videoDuration: json["video_duration"],
        videoSize: json["video_size"],
        view: json["view"],
        imdbRating: json["imdb_rating"],
        download: json["download"],
        avgRating: json["avg_rating"],
        noOfRating: json["no_of_rating"],
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
        sessionId: json["session_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "language_id": languageId,
        "cast_id": castId,
        "channel_id": channelId,
        "director_id": directorId,
        "starring_id": starringId,
        "supporting_cast_id": supportingCastId,
        "networks": networks,
        "maturity_rating": maturityRating,
        "name": name,
        "thumbnail": thumbnail,
        "landscape": landscape,
        "web_img": webImg,
        "video_upload_type": videoUploadType,
        "video": video,
        "trailer_url": trailerUrl,
        "release_year": releaseYear,
        "age_restriction": ageRestriction,
        "max_video_quality": maxVideoQuality,
        "release_tag": releaseTag,
        "type_id": typeId,
        "video_type": videoType,
        "video_url": videoUrl,
        "video_extension": videoExtension,
        "is_premium": isPremium,
        "description": description,
        "video_duration": videoDuration,
        "video_size": videoSize,
        "view": view,
        "imdb_rating": imdbRating,
        "download": download,
        "avg_rating": avgRating,
        "no_of_rating": noOfRating,
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
        "session_id": sessionId,
      };
}

class Result {
  Result({
    this.id,
    this.typeId,
    this.categoryId,
    this.videoId,
    this.tvShowId,
    this.languageId,
    this.categoryIds,
    this.title,
    this.videoType,
    this.screenLayout,
    this.filderBy,
    this.isViewAll,
    this.isHomeScreen,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.data,
  });

  int? id;
  int? typeId;
  int? categoryId;
  String? videoId;
  String? tvShowId;
  String? languageId;
  String? categoryIds;
  String? title;
  String? videoType;
  String? screenLayout;
  String? filderBy;
  int? isViewAll;
  String? isHomeScreen;
  int? status;
  String? createdAt;
  String? updatedAt;
  List<Datum>? data;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        typeId: json["type_id"],
        categoryId: json["category_id"],
        videoId: json["video_id"],
        tvShowId: json["tv_show_id"],
        languageId: json["language_id"],
        categoryIds: json["category_ids"],
        title: json["title"],
        videoType: json["video_type"],
        screenLayout: json["screen_layout"],
        filderBy: json["filder_by"],
        isViewAll: json["is_view_all"],
        isHomeScreen: json["is_home_screen"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type_id": typeId,
        "category_id": categoryId,
        "video_id": videoId,
        "tv_show_id": tvShowId,
        "language_id": languageId,
        "category_ids": categoryIds,
        "title": title,
        "video_type": videoType,
        "screen_layout": screenLayout,
        "filder_by": filderBy,
        "is_view_all": isViewAll,
        "is_home_screen": isHomeScreen,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.categoryId,
    this.languageId,
    this.castId,
    this.channelId,
    this.directorId,
    this.starringId,
    this.supportingCastId,
    this.networks,
    this.maturityRating,
    this.studios,
    this.contentAdvisory,
    this.viewingRights,
    this.typeId,
    this.videoType,
    this.name,
    this.description,
    this.thumbnail,
    this.landscape,
    this.webImg,
    this.videoUploadType,
    this.video,
    this.trailerUrl,
    this.releaseYear,
    this.ageRestriction,
    this.maxVideoQuality,
    this.releaseTag,
    this.videoUrl,
    this.videoExtension,
    this.isPremium,
    this.videoDuration,
    this.videoSize,
    this.view,
    this.imdbRating,
    this.download,
    this.avgRating,
    this.noOfRating,
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
    this.sessionId,
    this.image,
  });

  int? id;
  String? categoryId;
  String? languageId;
  String? castId;
  int? channelId;
  String? directorId;
  String? starringId;
  String? supportingCastId;
  String? networks;
  String? maturityRating;
  String? studios;
  String? contentAdvisory;
  String? viewingRights;
  int? typeId;
  int? videoType;
  String? name;
  String? description;
  String? thumbnail;
  String? landscape;
  String? webImg;
  String? videoUploadType;
  String? video;
  String? trailerUrl;
  String? releaseYear;
  String? ageRestriction;
  String? maxVideoQuality;
  String? releaseTag;
  String? videoUrl;
  String? videoExtension;
  int? isPremium;
  int? videoDuration;
  int? videoSize;
  int? view;
  int? imdbRating;
  int? download;
  int? avgRating;
  int? noOfRating;
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
  String? sessionId;
  String? image;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        categoryId: json["category_id"],
        languageId: json["language_id"],
        castId: json["cast_id"],
        channelId: json["channel_id"],
        directorId: json["director_id"],
        starringId: json["starring_id"],
        supportingCastId: json["supporting_cast_id"],
        networks: json["networks"],
        maturityRating: json["maturity_rating"],
        studios: json["studios"],
        contentAdvisory: json["content_advisory"],
        viewingRights: json["viewing_rights"],
        typeId: json["type_id"],
        videoType: json["video_type"],
        name: json["name"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        landscape: json["landscape"],
        webImg: json["web_img"],
        videoUploadType: json["video_upload_type"],
        video: json["video"],
        trailerUrl: json["trailer_url"],
        releaseYear: json["release_year"],
        ageRestriction: json["age_restriction"],
        maxVideoQuality: json["max_video_quality"],
        releaseTag: json["release_tag"],
        videoUrl: json["video_url"],
        videoExtension: json["video_extension"],
        isPremium: json["is_premium"],
        videoDuration: json["video_duration"],
        videoSize: json["video_size"],
        view: json["view"],
        imdbRating: json["imdb_rating"],
        download: json["download"],
        avgRating: json["avg_rating"],
        noOfRating: json["no_of_rating"],
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
        sessionId: json["session_id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_id": categoryId,
        "language_id": languageId,
        "cast_id": castId,
        "channel_id": channelId,
        "director_id": directorId,
        "starring_id": starringId,
        "supporting_cast_id": supportingCastId,
        "networks": networks,
        "maturity_rating": maturityRating,
        "studios": studios,
        "content_advisory": contentAdvisory,
        "viewing_rights": viewingRights,
        "type_id": typeId,
        "video_type": videoType,
        "name": name,
        "description": description,
        "thumbnail": thumbnail,
        "landscape": landscape,
        "web_img": webImg,
        "video_upload_type": videoUploadType,
        "video": video,
        "trailer_url": trailerUrl,
        "release_year": releaseYear,
        "age_restriction": ageRestriction,
        "max_video_quality": maxVideoQuality,
        "release_tag": releaseTag,
        "video_url": videoUrl,
        "video_extension": videoExtension,
        "is_premium": isPremium,
        "video_duration": videoDuration,
        "video_size": videoSize,
        "view": view,
        "imdb_rating": imdbRating,
        "download": download,
        "avg_rating": avgRating,
        "no_of_rating": noOfRating,
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
        "session_id": sessionId,
        "image": image,
      };
}
