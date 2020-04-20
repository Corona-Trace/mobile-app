import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:url_launcher/url_launcher.dart';

class AppConstants {
  static const TESTED_POSITIVE = 1;
  static const TESTED_NEGATIVE = 2;
  static const WAITING = 3;
  static const NOT_TESTED_FEEL_SICK = 4;
  static const NOT_TESTTED_NOT_SICK = 5;

  static const DISTANCE_DISPLACEMENT_FACTOR = "DISTANCE_DISPLACEMENT_FACTOR";

  static const String TESTED_URL =
      "https://www.cdc.gov/coronavirus/2019-ncov/symptoms-testing/testing.html";
  static const String DOCUMENTATION_URL =
      "https://www.cdc.gov/coronavirus/2019-ncov/prepare/prevention.html";
  static const String CARE_FOR_SOMEONE = "https://www.cdc.gov/coronavirus/2019-ncov/if-you-are-sick/care-for-someone.html";
  static const String STEPS_WHEN_SICK = "https://www.cdc.gov/coronavirus/2019-ncov/if-you-are-sick/steps-when-sick.html";

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
