// To parse this JSON data, do
// final sectionDetailModel = sectionDetailModelFromJson(jsonString);

import 'dart:convert';

SectionDetailModel sectionDetailModelFromJson(String str) =>
    SectionDetailModel.fromJson(json.decode(str));

String sectionDetailModelToJson(SectionDetailModel data) =>
    json.encode(data.toJson());

class SectionDetailModel {
  SectionDetailModel({
    this.code,
    this.status,
    this.message,
    this.result,
    this.cast,
    this.session,
    this.getRelatedVideo,
    this.language,
    this.moreDetails,
  });

  int? code;
  int? status;
  String? message;
  Result? result;
  List<Cast>? cast;
  List<Session>? session;
  List<GetRelatedVideo>? getRelatedVideo;
  List<Language>? language;
  List<MoreDetail>? moreDetails;

  factory SectionDetailModel.fromJson(Map<String, dynamic> json) =>
      SectionDetailModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
        cast: List<Cast>.from(json["cast"].map((x) => Cast.fromJson(x))),
        session:
            List<Session>.from(json["session"].map((x) => Session.fromJson(x))),
        getRelatedVideo: List<GetRelatedVideo>.from(
            json["get_related_video"].map((x) => GetRelatedVideo.fromJson(x))),
        language: List<Language>.from(
            json["language"].map((x) => Language.fromJson(x))),
        moreDetails: List<MoreDetail>.from(
            json["more_details"].map((x) => MoreDetail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "result": result?.toJson(),
        "cast": List<dynamic>.from(cast?.map((x) => x.toJson()) ?? []),
        "session": List<dynamic>.from(session?.map((x) => x.toJson()) ?? []),
        "get_related_video":
            List<dynamic>.from(getRelatedVideo?.map((x) => x.toJson()) ?? []),
        "language": List<dynamic>.from(language?.map((x) => x.toJson()) ?? []),
        "more_details":
            List<dynamic>.from(moreDetails?.map((x) => x.toJson()) ?? []),
      };
}

class Cast {
  Cast({
    this.id,
    this.name,
    this.image,
    this.type,
    this.personalInfo,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? image;
  String? type;
  String? personalInfo;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory Cast.fromJson(Map<String, dynamic> json) => Cast(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        type: json["type"],
        personalInfo: json["personal_info"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "type": type,
        "personal_info": personalInfo,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Language {
  Language({
    this.id,
    this.name,
    this.image,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? image;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory Language.fromJson(Map<String, dynamic> json) => Language(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Result {
  Result({
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
  int? videoDuration;
  int? videoSize;
  int? download;
  int? view;
  int? imdbRating;
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

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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

class GetRelatedVideo {
  GetRelatedVideo({
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
    this.videoDuration,
    this.videoSize,
    this.view,
    this.imdbRating,
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
  int? videoDuration;
  int? videoSize;
  int? view;
  int? imdbRating;
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

  factory GetRelatedVideo.fromJson(Map<String, dynamic> json) =>
      GetRelatedVideo(
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
        videoDuration: json["video_duration"],
        videoSize: json["video_size"],
        view: json["view"],
        imdbRating: json["imdb_rating"],
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
        "video_duration": videoDuration,
        "video_size": videoSize,
        "view": view,
        "imdb_rating": imdbRating,
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

class MoreDetail {
  MoreDetail({
    this.title,
    this.description,
  });

  String? title;
  String? description;

  factory MoreDetail.fromJson(Map<String, dynamic> json) => MoreDetail(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}

class Session {
  Session({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.isDownloaded,
    this.rentBuy,
    this.isRent,
    this.rentPrice,
    this.isBuy,
  });

  int? id;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;
  int? isDownloaded;
  int? rentBuy;
  int? isRent;
  int? rentPrice;
  int? isBuy;

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        isDownloaded: json["is_downloaded"],
        rentBuy: json["rent_buy"],
        isRent: json["is_rent"],
        rentPrice: json["rent_price"],
        isBuy: json["is_buy"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "is_downloaded": isDownloaded,
        "rent_buy": rentBuy,
        "is_rent": isRent,
        "rent_price": rentPrice,
        "is_buy": isBuy,
      };
}
