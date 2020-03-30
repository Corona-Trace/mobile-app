import 'dart:io';

import 'package:corona_trace/network/APIRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;

import 'AppConstants.dart';

class LocationUpdates {
  static requestPermissions() async {
    await bg.BackgroundGeolocation.requestPermission();
  }

  static Future<void> stopLocationUpdates(BuildContext context) async {
    notifyUserStoppedLocationUpdates(context);
    await bg.BackgroundGeolocation.stop();
  }

  static initiateLocationUpdates() async {
    try {
      await LocationUpdates.requestPermissions();
      var userId = await AppConstants.getDeviceId();
      bg.BackgroundGeolocation.onHttp((bg.HttpEvent event) {
        print(event);
      });
      await bg.BackgroundGeolocation.ready(bg.Config(
              url: ApiRepository.USER_LOCATION_URL,
              maxBatchSize: 50,
              params: {"userId": userId},
              extras: {"userId": userId},
              locationsOrderDirection: "DESC",
              maxDaysToPersist: 3,
              debug: true,
              autoSync: true,
              desiredAccuracy: bg.Config.DESIRED_ACCURACY_HIGH,
              stopOnTerminate: false,
              allowIdenticalLocations: false,
              startOnBoot: true,
              enableHeadless: true,
              locationAuthorizationAlert: {
                'titleWhenNotEnabled': 'Your location-services are disabled',
                'titleWhenOff': 'Your location-services are disabled',
                'instructions':
                    'Permitting ‘Always-on’ access to your device location is essential to provide critical location-based COVID-19 notifications.',
                'cancelButton': 'Cancel',
                'settingsButton': 'Settings'
              },
              notification: bg.Notification(
                  title: "Corona Trace",
                  text:
                      "Your location is being tracked, but all data will be anonymous."),
              logLevel: bg.Config.LOG_LEVEL_VERBOSE))
          .then((bg.State state) {
        if (!state.enabled) {
          bg.BackgroundGeolocation.start();
        }
      });
    } catch (ex) {}
  }

  static Future<void> notifyUserStoppedLocationUpdates(
      BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            content: Text(
                "We won't track your location and no anonymous location-based information will be sent to you"),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else {
          return AlertDialog(
            content: Text(
                "We won't track your location and no anonymous location-based information will be sent to you"),
            actions: <Widget>[
              FlatButton(
                child: Text('Ok'),
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
}
