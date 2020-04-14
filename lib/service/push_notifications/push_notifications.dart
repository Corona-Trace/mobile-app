import 'dart:async';
import 'dart:convert' as JSON;
import 'dart:io';

import 'package:corona_trace/main.dart';
import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/network/notification/response_notification_item.dart';
import 'package:corona_trace/ui/notifications/ct_notification_map_detail.dart';
import 'package:corona_trace/utils/app_localization.dart';
import 'package:corona_trace/utils/app_surveys.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class PushNotifications {
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static bool configuredPush = false;

  static Future<bool> arePermissionsDenied() async =>
      !await Permission.notification.isGranted ||
      await Permission.notification.isDenied;

  static Future<void> initStuff() async {
    configLocalNotification();
    registerNotification();
    await saveTokenForLoggedInUser();
    if (!configuredPush) {
      configuredPush = true;
      firebaseMessaging.configure(
          onBackgroundMessage:
              Platform.isAndroid ? myBackgroundMessageHandler : null,
          onMessage: (Map<String, dynamic> message) async {
            debugPrint("on message called $message");
            showNotification(message);
          },
          onResume: (Map<String, dynamic> message) async {
            debugPrint("on onResume called $message");
            myBackgroundMessageHandler(message);
          },
          onLaunch: (Map<String, dynamic> message) async {
            debugPrint("on onLaunch called");
            myBackgroundMessageHandler(message);
          });
    }
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (Platform.isIOS) {
      await navigateToMapDetail(message);
    } else {
      if (message.containsKey('data')) {
        // Handle data message
        final dynamic data = message['data'];
        await navigateToMapDetail(data);
      }

      if (message.containsKey('notification')) {
        showNotification(message);
      }
    }
    // Or do other work.
    return Future<void>.value();
  }

  static navigateToMapDetail(obj) {
    try {
      var item = ResponseNotificationItem.map(obj);
      globalKey.currentState.push(MaterialPageRoute(
          builder: (BuildContext context) {
            AppSurveys.triggerCrossedPathsNotificationSurvey();
            return CTNotificationMapDetail(crossedPaths: true, notification: item);
          }));
    } catch (ex) {
      debugPrint('navigateToMapDetail Failed: $ex');
    }
  }

  static void configLocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_stat_name');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  static Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    navigateToMapDetail(JSON.json.decode(payload));
  }

  static Future onSelectNotification(String payload) async {
    var jsonData = JSON.json.decode(payload);
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    debugPrint("json data $jsonData");
    if (Platform.isIOS) {
      navigateToMapDetail(jsonData);
    } else {
      navigateToMapDetail(jsonData["data"]);
    }
  }

  static void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid ? 'Zero-android' : 'Zero-ios',
      'Zero',
      'Zero channel',
      playSound: false,
      enableVibration: false,
      style: AndroidNotificationStyle.BigText,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    if (Platform.isAndroid) {
      if (message != null &&
          message.containsKey("notification") &&
          message["notification"]['title']?.toString()?.isNotEmpty == true) {
        await flutterLocalNotificationsPlugin.show(
            0,
            message["notification"]['title'].toString(),
            message["notification"]['body'].toString(),
            platformChannelSpecifics,
            payload: JSON.jsonEncode(message));
      }
    } else {
      await flutterLocalNotificationsPlugin.show(
          0,
          message['aps']["alert"]['title'].toString(),
          message['aps']["alert"]['body'].toString(),
          platformChannelSpecifics,
          payload: JSON.jsonEncode(message));
    }
    AppSurveys.triggerCrossedPathsNotificationSurvey();
  }

  static Future<void> registerNotification() async {
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
    firebaseMessaging.onTokenRefresh.listen((event) async {
      await saveTokenForLoggedInUser();
    });
  }

  static Future<void> saveTokenForLoggedInUser() async {
    var token = await firebaseMessaging.getToken();
    debugPrint(token);
    await ApiRepository.updateTokenForUser(token);
  }

  static Future<void> notifyUserDeniedPushPermissions(
      BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        if (Platform.isIOS) {
          return CupertinoAlertDialog(
            title:
              Text(AppLocalization.text("pushnotifications.off.title")),
            content:
                Text(AppLocalization.text("pushnotifications.off.description")),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text(AppLocalization.text("Settings")),
                onPressed: () {
                  openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
              CupertinoDialogAction(
                child: Text(AppLocalization.text("cancel_camel")),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        } else {
          return AlertDialog(
            title:
              Text(AppLocalization.text("pushnotifications.off.title")),
            content:
                Text(AppLocalization.text("pushnotifications.off.description")),
            actions: <Widget>[
              FlatButton(
                child: Text(AppLocalization.text("Settings")),
                onPressed: () {
                  openAppSettings();
                  Navigator.of(context).pop();
                },
              ),
              FlatButton(
                child: Text(AppLocalization.text("cancel_camel")),
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
