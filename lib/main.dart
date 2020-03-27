import 'dart:io';

import 'package:corona_trace/LocationUpdates.dart';
import 'package:corona_trace/network/ResponseNotifications.dart';
import 'package:corona_trace/push_notifications/push_notifications.dart';
import 'package:corona_trace/ui/notifications/CTNotificationMapDetail.dart';
import 'package:corona_trace/ui/screens/UserInfoCollectorScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((value) => runApp(MyApp()));
  WidgetsFlutterBinding.ensureInitialized().addPostFrameCallback((timeStamp) {
    final PushNotifications _pushNotifications = PushNotifications();
    _pushNotifications
        .initStuff()
        .then((value) => LocationUpdates.initiateLocationUpdates());
  });
}

final GlobalKey<NavigatorState> _globalKey = GlobalKey<NavigatorState>();

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print(data);
    await navigateToMapDetail(data);
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
    print(notification);
    await navigateToMapDetail(notification["data"]);
  }

  // Or do other work.
  return Future<void>.value();
}

MaterialColor appColor = MaterialColor(
  Color.fromRGBO(44, 48, 84, 1.0).value,
  <int, Color>{
    50: Color.fromRGBO(44, 48, 84, .1),
    100: Color.fromRGBO(44, 48, 84, .2),
    200: Color.fromRGBO(44, 48, 84, .3),
    300: Color.fromRGBO(44, 48, 84, .4),
    400: Color.fromRGBO(44, 48, 84, .5),
    500: Color.fromRGBO(44, 48, 84, .6),
    600: Color.fromRGBO(44, 48, 84, .7),
    700: Color.fromRGBO(44, 48, 84, .8),
    800: Color.fromRGBO(44, 48, 84, .9),
    900: Color.fromRGBO(44, 48, 84, 1),
  },
);

navigateToMapDetail(obj) {
  print(obj);
  print("navigate now");
  var item = ResponseNotificationItem.map(obj);
  _globalKey.currentState.push(MaterialPageRoute(
      builder: (BuildContext context) =>
          CTNotificationMapDetail(crossedPaths: true, notification: item)));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CoronaTrace',
        navigatorKey: _globalKey,
        theme: ThemeData(primarySwatch: appColor, fontFamily: 'Montserrat'),
        home: UserInfoCollectorScreen(),
      ),
      data: MediaQueryData(),
    );
  }
}
