import 'dart:async';
import 'dart:convert' as JSON;
import 'dart:io';
import 'package:corona_trace/AppConstants.dart';
import 'package:corona_trace/main.dart';
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
    firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
          showNotification(message["notification"]);
          print(message);
          navigateToMapDetail(message["data"]);
        },
        onResume: (Map<String, dynamic> message) async {
          print(message);
          navigateToMapDetail(message["data"]);
        },
        onLaunch: (Map<String, dynamic> message) async {
          print(message);
          navigateToMapDetail(message["data"]);
        });
    await sendAndRetrieveMessage();
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
  }

  sendAndRetrieveMessage() async {
    print("sending push");
    await firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(
          sound: true, badge: true, alert: true, provisional: false),
    );

    var response = await http.post(
      'https://fcm.googleapis.com/fcm/send',
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'key=${AppConstants.FIREBASE_SERVER_KEY}',
      },
      body: JSON.jsonEncode(
        <String, dynamic>{
          'notification': <String, dynamic>{
            'body': 'this is a body',
            'title': 'this is a title'
          },
          'priority': 'high',
          'data': <String, dynamic>{
            'click_action': 'FLUTTER_NOTIFICATION_CLICK',
            'id': '1',
            'body': 'this is a body',
            'title': 'this is a title',
            'status': 'done',
            "address":
                "Workafella Business Center 5th Floor, Western Aqua, Whitefields, HITEC City, Hyderabad, Telangana 500081, India",
            "userId": "d60aaa3bffdac1b9",
            "lat": 17.4521516,
            "lng": 78.3691191,
            "timestamp": "2020-03-25T10:22:28.715Z",
            "notificationId": "5e7ccc712b77251c8228f89d"
          },
          'to': await firebaseMessaging.getToken(),
        },
      ),
    );
  }

  Future<void> saveTokenForLoggedInUser() async {
    var token = await firebaseMessaging.getToken();
    await ApiRepository.updateTokenForUser(token);
  }
}
