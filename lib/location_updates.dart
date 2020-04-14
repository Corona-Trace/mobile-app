import 'dart:io';

import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart';
import 'package:permission_handler/permission_handler.dart';

import 'app_constants.dart';

class LocationUpdates {
  static requestPermissions() async {
    await bg.BackgroundGeolocation.requestPermission();
  }

  static Future<void> stopLocationUpdates(BuildContext context) async {
    notifyUserStoppedLocationUpdates(context);
    await bg.BackgroundGeolocation.stop();
  }

  static Future<bool> initiateLocationUpdates(context) async {
    var permissionDenied = await arePermissionsDenied();
    if (permissionDenied) {
      showLocationPermissionsNotAvailableDialog(context);
      return Future.value(false);
    } else {
      try {
        await initiateLocationUpdatesInternal();
        return Future.value(true);
      } catch (ex) {
        showLocationPermissionsNotAvailableDialog(context);
        return Future.value(false);
      }
    }
  }

  static Future initiateLocationUpdatesInternal() async {
    var userId = await AppConstants.getDeviceId();
    await bg.BackgroundGeolocation.ready(bg.Config(
            url: ApiRepository.USER_LOCATION_URL,
            maxBatchSize: 50,
            params: {
              "userId": userId,
              "offset": DateTime.now().timeZoneOffset.inMilliseconds
            },
            extras: {
              "userId": userId,
              "offset": DateTime.now().timeZoneOffset.inMilliseconds
            },
            locationsOrderDirection: "DESC",
            maxDaysToPersist: 3,
            debug: false,
            autoSync: true,
            triggerActivities: 'on_foot, walking, running',
            desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
            stopOnTerminate: false,
            allowIdenticalLocations: false,
            startOnBoot: true,
            enableHeadless: true,
            locationAuthorizationAlert: {
              "titleWhenNotEnabled":
                  AppLocalization.text("Location.Authorization.Alert.Disabled"),
              "titleWhenOff":
                  AppLocalization.text("Location.Authorization.Alert.Disabled"),
              "instructions": AppLocalization.text(
                  "Location.Authorization.Alert.Permission.Always"),
              "cancelButton": AppLocalization.text("cancel_camel"),
              "settingsButton": AppLocalization.text("Settings")
            },
            notification: bg.Notification(
                title: "Zero",
                text: AppLocalization.text("Location.Tray.Notification")),
            logLevel: bg.Config.LOG_LEVEL_OFF))
        .then((bg.State state) {
      if (!state.enabled) {
        bg.BackgroundGeolocation.start();
      }
    });
  }

  static Future<bool> isWithinAvailableGeoLocation() async {
    Location current = await bg.BackgroundGeolocation.getCurrentPosition();
    // TODO: Implement when API is available, send current location
    return false;
  } 

  static Future<bool> arePermissionsDenied() async =>
      !await Permission.locationAlways.isGranted ||
      await Permission.locationAlways.isPermanentlyDenied ||
      !await Permission.location.isGranted;

  static Future<void> notifyUserStoppedLocationUpdates(
      BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            content:
                Text(AppLocalization.text("Location.Authorization.Stopped")),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(AppLocalization.text("Ok")),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else {
          return AlertDialog(
            content:
                Text(AppLocalization.text("Location.Authorization.Stopped")),
            actions: <Widget>[
              FlatButton(
                child: Text(AppLocalization.text("Ok")),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        }
      },
    );
  }

  static showLocationPermissionsNotAvailableDialog(BuildContext context) {
    if (Platform.isAndroid) {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              AppLocalization.text("Location.Authorization.Alert.Disabled"),
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            content: Text(AppLocalization.text(
                "Location.Authorization.Alert.Permission.Always")),
            actions: <Widget>[
              FlatButton(
                child: Text(AppLocalization.text("cancel_camel")),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(AppLocalization.text("Settings")),
                onPressed: () async {
                  Navigator.of(context).pop();
                  openAppSettings();
                },
              ),
            ],
          );
        },
      );
    } else {
      LocationUpdates.requestPermissions();
    }
  }
}
