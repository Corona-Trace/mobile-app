import 'dart:convert' as JSON;
import 'dart:io';

import 'package:corona_trace/analytics/CTAnalyticsManager.dart';
import 'package:corona_trace/app_constants.dart';
import 'package:corona_trace/network/notification/response_notification.dart';
import 'package:dio/dio.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;

class DemoSettings {
  static final DemoSettings _instance = DemoSettings._internal();

  factory DemoSettings() => _instance;

  static DemoSettings get instance => _instance;

  DemoSettings._internal();

  static const String LOGO_PATH_STRING = "LOGO_PATH_STRING";

  static Future<Image> getLogoImage() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    try {
      var logoPath = sharedPrefs.getString(LOGO_PATH_STRING);
      var file = File(logoPath);
      if(await file.exists()) {
        var imageFile = Image.file(file);
        return imageFile;
      } else {
        return Image(image: AssetImage("assets/images/return_safe_logo.png"), color: Colors.white);
      }
    } catch(e) {
      debugPrint("stored logo could not be opened, returning default Image");
      return Image(image: AssetImage("assets/images/return_safe_logo.png"), color: Colors.white);
    }
  }

  static setLogoImage(File imageFile) async {
    final String imageName = path.basenameWithoutExtension(imageFile.path);
    final String docsDirPath = (await getApplicationDocumentsDirectory()).path;
    final File newImageFile = await imageFile.copy('$docsDirPath/$imageName');
    var sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setString(LOGO_PATH_STRING, newImageFile.path);
  }
}
