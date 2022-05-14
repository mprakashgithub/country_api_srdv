// To parse this JSON data, do
//
//     final countryDataModel = countryDataModelFromJson(jsonString);

import 'dart:convert';

CountryDataModel countryDataModelFromJson(String str) =>
    CountryDataModel.fromJson(json.decode(str));

String countryDataModelToJson(CountryDataModel data) =>
    json.encode(data.toJson());

class CountryDataModel {
  CountryDataModel({
    this.error,
    this.result,
  });

  Error? error;
  List<Result>? result;

  factory CountryDataModel.fromJson(Map<String, dynamic> json) =>
      CountryDataModel(
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
    this.countryId,
    this.countryCode,
    this.countryName,
  });

  int? countryId;
  String? countryCode;
  String? countryName;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        countryId: json["CountryID"],
        countryCode: json["CountryCode"],
        countryName: json["CountryName"],
      );

  Map<String, dynamic> toJson() => {
        "CountryID": countryId,
        "CountryCode": countryCode,
        "CountryName": countryName,
      };
}
