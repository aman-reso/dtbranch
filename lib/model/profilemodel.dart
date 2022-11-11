// To parse this JSON data, do
// final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) =>
    ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.code,
    this.status,
    this.message,
    this.result,
  });

  int? code;
  int? status;
  String? message;
  Result? result;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        result: Result.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "result": result?.toJson() ?? {},
      };
}

class Result {
  Result({
    this.id,
    this.languageId,
    this.name,
    this.userName,
    this.mobile,
    this.email,
    this.gender,
    this.image,
    this.status,
    this.type,
    this.apiToken,
    this.emailVerifyToken,
    this.isEmailVerify,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? languageId;
  String? name;
  String? userName;
  String? mobile;
  String? email;
  String? gender;
  String? image;
  int? status;
  int? type;
  String? apiToken;
  String? emailVerifyToken;
  String? isEmailVerify;
  String? createdAt;
  String? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        languageId: json["language_id"],
        name: json["name"],
        userName: json["user_name"],
        mobile: json["mobile"],
        email: json["email"],
        gender: json["gender"],
        image: json["image"],
        status: json["status"],
        type: json["type"],
        apiToken: json["api_token"],
        emailVerifyToken: json["email_verify_token"],
        isEmailVerify: json["is_email_verify"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "language_id": languageId,
        "name": name,
        "user_name": userName,
        "mobile": mobile,
        "email": email,
        "gender": gender,
        "image": image,
        "status": status,
        "type": type,
        "api_token": apiToken,
        "email_verify_token": emailVerifyToken,
        "is_email_verify": isEmailVerify,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
