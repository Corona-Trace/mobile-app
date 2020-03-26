import 'dart:async';
import 'dart:convert' as JSON;
import 'dart:io';

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
  }

  void configLocalNotification() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('ic_stat_name');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
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
    await flutterLocalNotificationsPlugin.show(0, message['title'].toString(),
        message['body'].toString(), platformChannelSpecifics,
        payload: JSON.jsonEncode(message));
  }

  void registerNotification() async {
    await firebaseMessaging.requestNotificationPermissions();
    firebaseMessaging.onTokenRefresh.listen((event) async {
      await saveTokenForLoggedInUser();
    });
    firebaseMessaging.configure(onMessage: (Map<String, dynamic> message) {
      showNotification(message["notification"]);
      return;
    }, onResume: (Map<String, dynamic> message) {
      return;
    }, onLaunch: (Map<String, dynamic> message) {
      return;
    });
  }

  Future<void> saveTokenForLoggedInUser() async {
    var token = await firebaseMessaging.getToken();
    await ApiRepository.updateTokenForUser(token);
  }
}
