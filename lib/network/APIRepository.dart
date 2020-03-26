import 'dart:convert' as JSON;

import 'package:corona_trace/AppConstants.dart';
import 'package:corona_trace/LocationUpdates.dart';
import 'package:corona_trace/network/ResponseNotifications.dart';
import 'package:corona_trace/ui/screens/UserInfoCollectorScreen.dart';
import 'package:dio/dio.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:http/http.dart' as http;

class ApiRepository {
  static Dio _dio = Dio();
  static const TOKEN = "TOKEN";
  static const API_URL =
      "http://coronatrace-env.eba-rzwsytyk.us-east-2.elasticbeanstalk.com";
  static const LAT_CONST = "LAT";
  static const LNG_CONST = "LNG";
  static const IS_SEVERE = "IS_SEVERE";
  static const ACCEPTED_ONCE = "ACCEPTED_ONCE";

  static Future<void> updateTokenForUser(String token) async {
    var instance = await SharedPreferences.getInstance();
    if (instance.getBool(ACCEPTED_ONCE) != null &&
        instance.getBool(ACCEPTED_ONCE)) {
      await LocationUpdates.requestPermissions();
    }
    if (instance.get(TOKEN) != null && instance.get(TOKEN) == token) {
      return;
    }
    var deviceID = await AppConstants.getDeviceId();
    var body = tokenRequestBody(token, deviceID);
    Response response =
        await _dio.post("$API_URL/users", data: JSON.jsonEncode(body));
    if (response.statusCode == 200) {
      await instance.setString(TOKEN, token);
    }
  }

  static Future<String> getRemoteConfigValue(String key) async {
    try {
      final RemoteConfig remoteConfig = await RemoteConfig.instance;
      await remoteConfig.fetch(expiration: Duration(minutes: 1));
      await remoteConfig.activateFetched();
      var url = remoteConfig.getString(key);
      return url;
    } catch (ex) {
      return "";
    }
  }

  static Map<String, String> tokenRequestBody(String token, String deviceID) =>
      {"token": token, "userId": deviceID};

  static Future<void> setUserSeverity(int severity) async {
    var instance = await SharedPreferences.getInstance();
    await instance.setBool(ACCEPTED_ONCE, true);
    try {
      var deviceID = await AppConstants.getDeviceId();
      var body = getSeverityBody(severity, deviceID);
      var response =
          await _dio.patch("$API_URL/users", data: JSON.jsonEncode(body));
      if (response.statusCode != 200) {
        // api failed set the value next time we get location updates.
        await instance.setBool(IS_SEVERE, severity == 1);
      } else if (response.statusCode == 200) {
        await instance.setBool(IS_SEVERE, null);
      }
    } catch (ex) {
      await instance.setBool(IS_SEVERE, severity == 1);
    }
  }

  static Future<ResponseNotifications> getNotificationsList(int pageNo) async {
    try {
      var deviceID = await AppConstants.getDeviceId();
      var response = await http
          .get("$API_URL/notification/$deviceID/?page=$pageNo&perPage=10");
      return ResponseNotifications.map(JSON.json.decode(response.body));
    } catch (ex) {
      throw ex;
    }
  }

  static Map<String, Object> getSeverityBody(int severity, String deviceID) =>
      {"severity": severity, "userId": deviceID};

  static Future<void> updateLocationForUserHistory(Location location) async {
    var lat = location.coords.latitude;
    var lng = location.coords.longitude;

    var instance = await SharedPreferences.getInstance();
    if (instance.getBool(IS_SEVERE) != null) {
      // the api failed to set severity retry last time
      setUserSeverity(instance.getBool(IS_SEVERE) ? 1 : 0);
    }
    var cacheLat = instance.getDouble(LAT_CONST);
    var cacheLng = instance.getDouble(LNG_CONST);
    if (cacheLat != null && cacheLng != null) {
      var distance =
          await Geolocator().distanceBetween(lat, lng, cacheLat, cacheLng);
      //less than 100 metres return !
      var displacement =
          await getRemoteConfigValue(AppConstants.DISTANCE_DISPLACEMENT_FACTOR);
      if (displacement != null &&
          displacement.isNotEmpty &&
          distance < double.parse(displacement)) {
        // dont do anythinh
      } else {
        await sendLocationUpdateInternal(lat, lng, instance);
      }
    } else {
      await sendLocationUpdateInternal(lat, lng, instance);
    }
  }

  static Future sendLocationUpdateInternal(
      double lat, double lng, SharedPreferences instance) async {
    var deviceID = await AppConstants.getDeviceId();
    var body = getLocationRequestBody(lat, lng, deviceID);
    Response response = await _dio.post(
      "$API_URL/usersLocationHistory",
      options: Options(contentType: "application/json"),
      data: JSON.jsonEncode(body),
    );
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
}
