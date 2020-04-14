import 'dart:convert' as JSON;

import 'package:corona_trace/analytics/CTAnalyticsManager.dart';
import 'package:corona_trace/app_constants.dart';
import 'package:corona_trace/network/notification/response_notification.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';

class ApiRepository {
  static final ApiRepository _instance = ApiRepository._internal();

  factory ApiRepository() => _instance;

  static ApiRepository get instance => _instance;

  ApiRepository._internal() {}

  static BaseOptions dioOptions = new BaseOptions(connectTimeout: 15000, receiveTimeout: 30000);
  static Dio _dio = Dio(dioOptions);
  static const TOKEN = "TOKEN";
  static const API_URL = "https://api-yp2tme3siq-uc.a.run.app";
  static const TERMS_AND_CONDITIONS = "https://www.tracetozero.org/legal/terms-of-service";
  static const PRIVACY_POLICY = "https://www.tracetozero.org/legal/privacy-policy";
  static const LAT_CONST = "LAT";
  static const LNG_CONST = "LNG";
  static const SEVERITY = "SEVERITY";
  static const USER_LOCATION_URL = "$API_URL/usersLocationHistory";
  static const String IS_ONBOARDING_DONE = "IS_ONBOARDING_DONE";

  static Future<void> updateTokenForUser(String token) async {
    var instance = await SharedPreferences.getInstance();
    if (instance.get(TOKEN) != null && instance.get(TOKEN) == token) {
      return;
    }
    var deviceID = await AppConstants.getDeviceId();
    var url = "$API_URL/users";
    var body = tokenRequestBody(token, deviceID);
    Response response =
        await _dio.post(url, data: JSON.jsonEncode(body));
    var statusCode = response.statusCode;
    debugPrint("$statusCode - $url");
    if (response.statusCode == 200) {
      await instance.setString(TOKEN, token);
    }
  }

  static Map<String, String> tokenRequestBody(String token, String deviceID) =>
      {"token": token, "userId": deviceID};

  static Future<void> setUserSeverity(int severity) async {
    var instance = await SharedPreferences.getInstance();

    var severity = await getUserSeverity();

    if (severity == null || (severity != null && severity == -1)) {
      CTAnalyticsManager.instance.setFirstSeverityCheck(severity);
    } else {
      CTAnalyticsManager.instance.setSeverityCheck(severity);
    }

    await instance.setInt(SEVERITY, severity);
    try {
      var deviceID = await AppConstants.getDeviceId();
      var url = "$API_URL/users";
      var body = getSeverityBody(severity, deviceID);
      Response response = await _dio.patch(url, data: JSON.jsonEncode(body));
      var statusCode = response.statusCode;
      debugPrint("$statusCode - $url");
    } catch (ex) {
      debugPrint('setUserSeverity Failed: $ex');
      throw ex;
    }
  }

  Future<ResponseNotifications> getNotificationsList(int pageNo) async {
    try {
      var deviceID = await AppConstants.getDeviceId();
      var url = "$API_URL/notification/$deviceID?page=$pageNo&perPage=10";
      var response = await http.get(url);
      var statusCode = response.statusCode;
      debugPrint("$statusCode - $url");
      return ResponseNotifications.map(JSON.json.decode(response.body));
    } catch (ex) {
      debugPrint('getNotificationsList Failed: $ex');
      throw ex;
    }
  }

  static Map<String, Object> getSeverityBody(int severity, String deviceID) =>
      {"severity": severity, "userId": deviceID};

  static Future<int> getUserSeverity() async {
    var instance = await SharedPreferences.getInstance();
    return instance.getInt(SEVERITY);
  }

  static Future sendLocationUpdateInternal(
      double lat, double lng, SharedPreferences instance) async {
    var deviceID = await AppConstants.getDeviceId();
    var body = getLocationRequestBody(lat, lng, deviceID);
    Response response = await _dio.post(
      USER_LOCATION_URL,
      options: Options(contentType: "application/json"),
      data: JSON.jsonEncode(body),
    );
    debugPrint('$response.statusCode');
    if (response.statusCode == 200) {
      await instance.setDouble(LAT_CONST, lat);
      await instance.setDouble(LNG_CONST, lng);
    }
  }

  static Map<String, Object> getLocationRequestBody(
      double lat, double lng, String deviceID) {
    return {
      "lat": lat,
      "lng": lng,
      "location": {
        "type": "Point",
        "coordinates": [lng, lat]
      },
      "timestamp": DateTime.now().toIso8601String(),
      "userId": deviceID
    };
  }

  static Future<bool> getIsOnboardingDone() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    return sharedPrefs.getBool(IS_ONBOARDING_DONE) ?? false;
  }

  static setOnboardingDone(bool isDone) async {
    var sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setBool(IS_ONBOARDING_DONE, isDone);
  }
}
