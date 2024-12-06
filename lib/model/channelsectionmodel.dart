// To parse this JSON data, do
// final channelSectionModel = channelSectionModelFromJson(jsonString);

import 'dart:convert';

class ChannelSectionModel {
  ChannelSectionModel({
    this.code,
    this.status,
    this.message,
    this.result,
  });

  int? code;
  int? status;
  String? message;
  List<Video>? result;

  factory ChannelSectionModel.fromJson(Map<String, dynamic> json) =>
      ChannelSectionModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        result: List<Video>.from(json["video"].map((x) => Video.fromJson(x))),
      );
}

class Video {
  final int id;
  final int channelId;
  final String categoryId;
  final String languageId;
  final String castId;
  final int typeId;
  final int videoType;
  final String name;
  final String thumbnail;
  final String landscape;
  final String description;
  final int isPremium;
  final String isTitle;
  final int download;
  final String videoUploadType;
  final String video320;
  final String video480;
  final String video720;
  final String video1080;
  final String videoExtension;
  final int videoDuration;
  final String trailerType;
  final String trailerUrl;
  final String subtitleType;
  final String subtitleLang1;
  final String subtitle1;
  final String subtitleLang2;
  final String subtitle2;
  final String subtitleLang3;
  final String subtitle3;
  final String releaseDate;
  final String releaseYear;
  final double imdbRating;
  final int view;
  final int status;
  final String createdAt;
  final String updatedAt;
  final String directorId;
  final String starringId;
  final String supportingCastId;
  final String networks;
  final String maturityRating;
  final String ageRestriction;
  final String maxVideoQuality;
  final String releaseTag;
  final int videoSize;

  Video({
    required this.id,
    required this.channelId,
    required this.categoryId,
    required this.languageId,
    required this.castId,
    required this.typeId,
    required this.videoType,
    required this.name,
    required this.thumbnail,
    required this.landscape,
    required this.description,
    required this.isPremium,
    required this.isTitle,
    required this.download,
    required this.videoUploadType,
    required this.video320,
    required this.video480,
    required this.video720,
    required this.video1080,
    required this.videoExtension,
    required this.videoDuration,
    required this.trailerType,
    required this.trailerUrl,
    required this.subtitleType,
    required this.subtitleLang1,
    required this.subtitle1,
    required this.subtitleLang2,
    required this.subtitle2,
    required this.subtitleLang3,
    required this.subtitle3,
    required this.releaseDate,
    required this.releaseYear,
    required this.imdbRating,
    required this.view,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.directorId,
    required this.starringId,
    required this.supportingCastId,
    required this.networks,
    required this.maturityRating,
    required this.ageRestriction,
    required this.maxVideoQuality,
    required this.releaseTag,
    required this.videoSize,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      channelId: json['channel_id'],
      categoryId: json['category_id'],
      languageId: json['language_id'],
      castId: json['cast_id'],
      typeId: json['type_id'],
      videoType: json['video_type'],
      name: json['name'],
      thumbnail: json['thumbnail'],
      landscape: json['landscape'],
      description: json['description'],
      isPremium: json['is_premium'],
      isTitle: json['is_title'],
      download: json['download'],
      videoUploadType: json['video_upload_type'],
      video320: json['video_320'],
      video480: json['video_480'],
      video720: json['video_720'],
      video1080: json['video_1080'],
      videoExtension: json['video_extension'],
      videoDuration: json['video_duration'],
      trailerType: json['trailer_type'],
      trailerUrl: json['trailer_url'],
      subtitleType: json['subtitle_type'],
      subtitleLang1: json['subtitle_lang_1'],
      subtitle1: json['subtitle_1'],
      subtitleLang2: json['subtitle_lang_2'],
      subtitle2: json['subtitle_2'],
      subtitleLang3: json['subtitle_lang_3'],
      subtitle3: json['subtitle_3'],
      releaseDate: json['release_date'],
      releaseYear: json['release_year'],
      imdbRating: json['imdb_rating'].toDouble(),
      view: json['view'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      directorId: json['director_id'],
      starringId: json['starring_id'],
      supportingCastId: json['supporting_cast_id'],
      networks: json['networks'],
      maturityRating: json['maturity_rating'],
      ageRestriction: json['age_restriction'],
      maxVideoQuality: json['max_video_quality'],
      releaseTag: json['release_tag'],
      videoSize: json['video_size'],
    );
  }
}
