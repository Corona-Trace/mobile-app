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
  static const AIRTABLE_QUERY = "?fields%5B%5D=Name&filterByFormula=%7BAvailability%7D";
  static const STATES_URL = "$AIRTABLE_API_BASE_URL/States$AIRTABLE_QUERY";
  static const COUNTRIES_URL = "$AIRTABLE_API_BASE_URL/Countries$AIRTABLE_QUERY";
  static const CITIES_URL = "$AIRTABLE_API_BASE_URL/Cities$AIRTABLE_QUERY";

  static Future<Iterable<String>> getAvailableStatesList() async {
    try {
      Response response = await _dio.get(STATES_URL);
      var statusCode = response.statusCode;
      debugPrint("$statusCode - $STATES_URL");
      return AirtableResponse.map(response.data).records
        .map((record) => record.fields.name);
    } catch (ex) {
      debugPrint('getAvailableStatesList Failed: $ex');
      throw ex;
    }
  }

  static Future<Iterable<String>> getAvailableCountriesList() async {
    try {
      Response response = await _dio.get(COUNTRIES_URL);
      var statusCode = response.statusCode;
      debugPrint("$statusCode - $STATES_URL");
      return AirtableResponse.map(response.data).records
        .map((record) => record.fields.name);
    } catch (ex) {
      debugPrint('getAvailableStatesList Failed: $ex');
      throw ex;
    }
  }

  static Future<Iterable<String>> getAvailableCitiesList() async {
    try {
      Response response = await _dio.get(CITIES_URL);
      var statusCode = response.statusCode;
      debugPrint("$statusCode - $STATES_URL");
      return AirtableResponse.map(response.data).records
        .map((record) => record.fields.name);
    } catch (ex) {
      debugPrint('getAvailableStatesList Failed: $ex');
      throw ex;
    }
  }
}
