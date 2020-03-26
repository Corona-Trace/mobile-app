import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConstants {
  static const DISTANCE_DISPLACEMENT_FACTOR = "DISTANCE_DISPLACEMENT_FACTOR";

  static const String TESTED_URL =
      "https://www.cdc.gov/coronavirus/2019-ncov/symptoms-testing/testing.html";
  static var FIREBASE_SERVER_KEY = "AAAAg8A-kLw:APA91bEAggSw3ljnjVAYkjjAT5K0bON9Uxv4d0NImb1GgAThiXLdRBU1jTkVHFlIqjvwVh7-jYyBsQSA_wDagd3HVZvzn58zUYWlY2ygWkBSTRBHoqIs7iEUsoV1GYjqpOxQW0quo42U";

  static const String DOCUMENTATION_URL = "";

  static Future<String> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }

  static void launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    }
  }
}
