// To parse this JSON data, do
//
//     final cityDataModel = cityDataModelFromJson(jsonString);

import 'dart:convert';

CityDataModel cityDataModelFromJson(String str) =>
    CityDataModel.fromJson(json.decode(str));

String cityDataModelToJson(CityDataModel data) => json.encode(data.toJson());

class CityDataModel {
  CityDataModel({
    this.error,
    this.result,
  });

  Error? error;
  List<Result>? result;

  factory CityDataModel.fromJson(Map<String, dynamic> json) => CityDataModel(
        error: Error.fromJson(json["Error"]),
        result:
            List<Result>.from(json["Result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Error": error!.toJson(),
        "Result": List<dynamic>.from(result!.map((x) => x.toJson())),
      };
}

class Error {
  Error({
    this.errorCode,
    this.errorMessage,
  });

  String? errorCode;
  String? errorMessage;

  factory Error.fromJson(Map<String, dynamic> json) => Error(
        errorCode: json["ErrorCode"],
        errorMessage: json["ErrorMessage"],
      );

  Map<String, dynamic> toJson() => {
        "ErrorCode": errorCode,
        "ErrorMessage": errorMessage,
      };
}

class Result {
  Result({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["ID"],
        name: json["Name"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Name": name,
      };
}
