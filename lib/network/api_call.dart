import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:srdv_task/model/city_data_model.dart';
import 'package:srdv_task/model/country_data_model.dart';
import 'package:srdv_task/model/state_data_model.dart';

class ApiCall {
  final baseUrl = "https://beta.srdv.in/interview/dashboard/";
  var headers = {'API-Token': 'sr7It@y+2lcView'};

  //Fetch Country Data
  Future<CountryDataModel?> getCountryData() async {
    var client = http.Client();
    final url = baseUrl + "CountryList";

    try {
      var response = await client.get(Uri.parse(url), headers: headers);
      var jsonStr = jsonDecode(response.body);

      debugPrint(response.body);
      if (response.statusCode == 200) {
        var json = response.body;
        Map<String, dynamic> mapData = jsonDecode(json);
        return CountryDataModel.fromJson(mapData);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  //Fetch State Data
  Future<StateDataModel?> getStateData(countryId) async {
    var client = http.Client();
    final url = baseUrl + "StateList";

    Map<String, String> body = {"CountryID": "$countryId"};
    print(url);
    print(headers);
    print(body);
    try {
      var response = await client.post(Uri.parse(url),
          headers: headers, body: jsonEncode(body));
      var jsonStr = jsonDecode(response.body);
      print("Api Call in getCountryData");
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var json = response.body;
        Map<String, dynamic> mapData = jsonDecode(json);
        return StateDataModel.fromJson(mapData);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }

  ///Fetch City Data
  Future<CityDataModel?> getCityData(sId) async {
    var client = http.Client();
    final url = baseUrl + "CityList";

    var stateHeaders = {'API-Token': 'sr7It@y+2lcView'};
    Map<String, String> body = {"StateID": "$sId"};
    print(url);
    print(stateHeaders);
    print(body);
    try {
      var response = await client.post(Uri.parse(url),
          headers: stateHeaders, body: jsonEncode(body));
      var jsonStr = jsonDecode(response.body);
      print("Api Call in getCountryData");
      debugPrint(response.body);
      if (response.statusCode == 200) {
        var json = response.body;
        Map<String, dynamic> mapData = jsonDecode(json);
        return CityDataModel.fromJson(mapData);
      }
    } catch (e) {
      print(e);
      throw e;
    }
  }
}
