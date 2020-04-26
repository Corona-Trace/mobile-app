import 'dart:convert' as JSON;

import 'package:corona_trace/analytics/CTAnalyticsManager.dart';
import 'package:corona_trace/app_constants.dart';
import 'package:corona_trace/network/airtable/airtable_response.dart';
import 'package:corona_trace/network/notification/response_notification.dart';
import 'package:dio/dio.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AirtableRepository {
  static final AirtableRepository _instance = AirtableRepository._internal();

  factory AirtableRepository() => _instance;

  static AirtableRepository get instance => _instance;

  AirtableRepository._internal();

  static BaseOptions dioOptions =
      new BaseOptions(
        connectTimeout: 15000, 
        receiveTimeout: 30000,
        headers: {
          "Authorization":"Bearer ${DotEnv().env['AIRTABLE_API_KEY']}"
        });
  static Dio _dio = Dio(dioOptions);

  static const AIRTABLE_API_BASE_URL = "https://api.airtable.com/v0/appeeTR6FdXwMaHYo";
  static const STATES_URL = "$AIRTABLE_API_BASE_URL/States";
  static const COUNTRIES_URL = "$AIRTABLE_API_BASE_URL/Countries";
  static const CITIES_URL = "$AIRTABLE_API_BASE_URL/Cities";

  static String getAirtableQueryURL(String url, String name) {
    return "$url?fields%5B%5D=Name&filterByFormula=AND(%7BAvailability%7D%2C%7BName%3D%22$name%22%7D)";
  }

  static Future<bool> checkIfAvailableInStatesList(String state) async {
    try {
      var url = getAirtableQueryURL(STATES_URL, state);
      Response response = await _dio.get(url);
      var statusCode = response.statusCode;
      debugPrint("$statusCode - $url");
      var records = AirtableResponse.map(response.data).records;
      return records.isNotEmpty;
    } catch (ex) {
      debugPrint('checkIfAvailableInStatesList Failed: $ex');
      throw ex;
    }
  }

  static Future<bool> checkIfAvailableInCountriesList(String country) async {
    try {
      var url = getAirtableQueryURL(COUNTRIES_URL, country);
      Response response = await _dio.get(url);
      var statusCode = response.statusCode;
      debugPrint("$statusCode - $url");
      var records = AirtableResponse.map(response.data).records;
      return records.isNotEmpty;
    } catch (ex) {
      debugPrint('checkIfAvailableInCountriesList Failed: $ex');
      throw ex;
    }
  }

  static Future<bool> checkIfAvailableInCitiesList(String city) async {
    try {
      var url = getAirtableQueryURL(CITIES_URL, city);
      Response response = await _dio.get(url);
      var statusCode = response.statusCode;
      debugPrint("$statusCode - $url");
      var records = AirtableResponse.map(response.data).records;
      return records.isNotEmpty;
    } catch (ex) {
      debugPrint('checkIfAvailableInCitiesList Failed: $ex');
      throw ex;
    }
  }
}
