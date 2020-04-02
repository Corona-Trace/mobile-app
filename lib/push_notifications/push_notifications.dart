import 'dart:async';
import 'dart:convert' as JSON;
import 'dart:io';

import 'package:corona_trace/main.dart';
import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/network/repository_notifications.dart';
import 'package:corona_trace/ui/notifications/ct_notification_map_detail.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotifications {
  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static bool configuredPush = false;

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
            print("on message called");
            showNotification(message);
          },
          onResume: (Map<String, dynamic> message) async {
            print("on onResume called");
            navigateToMapDetail(message["data"]);
          },
          onLaunch: (Map<String, dynamic> message) async {
            print("on onLaunch called");
            navigateToMapDetail(message["data"]);
          });
    }
  }

  static Future<dynamic> myBackgroundMessageHandler(
      Map<String, dynamic> message) async {
    if (message.containsKey('data')) {
      // Handle data message
      final dynamic data = message['data'];
      await navigateToMapDetail(data);
    }

    if (message.containsKey('notification')) {
      // Handle notification message
      final dynamic notification = message['notification'];
      await navigateToMapDetail(notification);
    }

    // Or do other work.
    return Future<void>.value();
  }

  static navigateToMapDetail(obj) {
    try {
      var item = ResponseNotificationItem.map(obj);
      globalKey.currentState.push(MaterialPageRoute(
          builder: (BuildContext context) =>
              CTNotificationMapDetail(crossedPaths: true, notification: item)));
    } catch (ex) {
      print(ex);
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
    print("json data $jsonData");
    if (Platform.isIOS) {
      navigateToMapDetail(jsonData);
    } else {
      navigateToMapDetail(jsonData["data"]);
    }
  }

  static void showNotification(message) async {
    var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      Platform.isAndroid ? 'coronatrace-android' : 'coronatrace-ios',
      'coronatrace',
      'coronatrace channel',
      playSound: false,
      enableVibration: false,
      style: AndroidNotificationStyle.BigText,
      importance: Importance.Max,
      priority: Priority.High,
    );
    var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
    var platformChannelSpecifics = new NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
        0,
        message["notification"]['title'].toString(),
        message["notification"]['body'].toString(),
        platformChannelSpecifics,
        payload: JSON.jsonEncode(message));
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
    await ApiRepository.updateTokenForUser(token);
  }
}
