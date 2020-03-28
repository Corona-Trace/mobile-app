import 'dart:async';
import 'dart:convert' as JSON;
import 'dart:io';
import 'package:corona_trace/AppConstants.dart';
import 'package:corona_trace/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:corona_trace/network/APIRepository.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotifications {
  final FirebaseMessaging firebaseMessaging = FirebaseMessaging();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initStuff() async {
    configLocalNotification();
    registerNotification();
    await saveTokenForLoggedInUser();
    //await sendAndRetrieveMessage();
  }

  void configLocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_stat_name');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onDidReceiveLocalNotification(
      int id, String title, String body, String payload) async {
    navigateToMapDetail(JSON.json.decode(payload));
  }

  Future onSelectNotification(String payload) async {
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

  void showNotification(message) async {
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

  void registerNotification() async {
    await firebaseMessaging.requestNotificationPermissions();
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );
    firebaseMessaging.onTokenRefresh.listen((event) async {
      await saveTokenForLoggedInUser();
    });
  }

  sendAndRetrieveMessage() async {
    print("sending push");

    print(await firebaseMessaging.getToken());
  }

  Future<void> saveTokenForLoggedInUser() async {
    var token = await firebaseMessaging.getToken();
    await ApiRepository.updateTokenForUser(token);
  }
}
