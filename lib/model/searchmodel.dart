// To parse this JSON data, do
// final searchModel = searchModelFromJson(jsonString);

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    this.code,
    this.status,
    this.message,
    this.result,
    this.video,
    this.tvshow,
  });

  int? code;
  int? status;
  String? message;
  List<dynamic>? result;
  List<Video>? video;
  List<Tvshow>? tvshow;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        result: json["result"],
        video: List<Video>.from(json["video"].map((x) => Video.fromJson(x))),
        tvshow:
            List<Tvshow>.from(json["tvshow"].map((x) => Tvshow.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "result": result,
        "video": List<dynamic>.from(video?.map((x) => x.toJson()) ?? []),
        "tvshow": List<dynamic>.from(tvshow?.map((x) => x.toJson()) ?? []),
      };
}

class Tvshow {
  Tvshow({
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
    this.view,
    this.imdbRating,
    this.avgRating,
    this.noOfRating,
    this.status,
    this.isTitle,
    this.isPremium,
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
  String? studios;
  String? contentAdvisory;
  String? viewingRights;
  int? typeId;
  int? videoType;
  String? name;
  String? description;
  String? thumbnail;
  String? landscape;
  int? view;
  int? imdbRating;
  int? avgRating;
  int? noOfRating;
  String? status;
  String? isTitle;
  int? isPremium;
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

  factory Tvshow.fromJson(Map<String, dynamic> json) => Tvshow(
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
        view: json["view"],
        imdbRating: json["imdb_rating"],
        avgRating: json["avg_rating"],
        noOfRating: json["no_of_rating"],
        status: json["status"],
        isTitle: json["is_title"],
        isPremium: json["is_premium"],
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
        "studios": studios,
        "content_advisory": contentAdvisory,
        "viewing_rights": viewingRights,
        "type_id": typeId,
        "video_type": videoType,
        "name": name,
        "description": description,
        "thumbnail": thumbnail,
        "landscape": landscape,
        "view": view,
        "imdb_rating": imdbRating,
        "avg_rating": avgRating,
        "no_of_rating": noOfRating,
        "status": status,
        "is_title": isTitle,
        "is_premium": isPremium,
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

class Video {
  Video({
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
    this.video320,
    this.video480,
    this.video720,
    this.video1080,
    this.subtitleType,
    this.subtitle,
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
  String? video320;
  String? video480;
  String? video720;
  String? video1080;
  String? subtitleType;
  String? subtitle;
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

  factory Video.fromJson(Map<String, dynamic> json) => Video(
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
        video320: json["video_320"],
        video480: json["video_480"],
        video720: json["video_720"],
        video1080: json["video_1080"],
        subtitleType: json["subtitle_type"],
        subtitle: json["subtitle"],
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
        "video_320": video320,
        "video_480": video480,
        "video_720": video720,
        "video_1080": video1080,
        "subtitle_type": subtitleType,
        "subtitle": subtitle,
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
