// To parse this JSON data, do
// final sectionTypeModel = sectionTypeModelFromJson(jsonString);

import 'dart:convert';

SectionTypeModel sectionTypeModelFromJson(String str) =>
    SectionTypeModel.fromJson(json.decode(str));

String sectionTypeModelToJson(SectionTypeModel data) =>
    json.encode(data.toJson());

class SectionTypeModel {
  SectionTypeModel({
    this.code,
    this.status,
    this.message,
    this.result,
  });

  int? code;
  int? status;
  String? message;
  List<Result>? result;

  factory SectionTypeModel.fromJson(Map<String, dynamic> json) =>
      SectionTypeModel(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        result: json["result"] != null
            ? List<Result>.from(json["result"].map((x) => Result.fromJson(x)))
            : <Result>[],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "result": result != null
            ? List<dynamic>.from(result!.map((x) => x.toJson()))
            : <Result>[],
      };
}

class Result {
  Result({
    this.id,
    this.name,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  int? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "created_at": createdAt.toString(),
        "updated_at": updatedAt.toString(),
      };
}