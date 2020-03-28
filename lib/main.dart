import 'dart:io';

import 'package:corona_trace/LocationUpdates.dart';
import 'package:corona_trace/network/APIRepository.dart';
import 'package:corona_trace/network/ResponseNotifications.dart';
import 'package:corona_trace/push_notifications/push_notifications.dart';
import 'package:corona_trace/ui/notifications/CTNotificationMapDetail.dart';
import 'package:corona_trace/ui/notifications/NotificationsListScreen.dart';
import 'package:corona_trace/ui/screens/Onboarding.dart';
import 'package:corona_trace/ui/screens/UserInfoCollectorScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'utils/AppLocalization.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
  initPush();
}

void initPush() {
  final PushNotifications _pushNotifications = PushNotifications();
  _pushNotifications.initStuff();
  _pushNotifications.firebaseMessaging.configure(
      onBackgroundMessage:
          Platform.isAndroid ? myBackgroundMessageHandler : null,
      onMessage: (Map<String, dynamic> message) async {
        print("on message called");
        _pushNotifications.showNotification(message);
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

Future _handleBGMessage(Map<String, dynamic> message) {
  print("_handleBGMessage");
  if (message.containsKey('data')) {
// Handle data message
    final dynamic data = message['data'];
    navigateToMapDetail(data);
    print("bg message data");
  }

  if (message.containsKey('notification')) {
// Handle notification message
    final dynamic notification = message['notification'];
    navigateToMapDetail(message);
    print("bg message notification");
  }
  print(message);
  return Future<void>.value();
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
    await navigateToMapDetail(notification);
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
  try {
    var item = ResponseNotificationItem.map(obj);
    _globalKey.currentState.push(MaterialPageRoute(
        builder: (BuildContext context) =>
            CTNotificationMapDetail(crossedPaths: true, notification: item)));
  } catch (ex) {
    print(ex);
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiRepository.getIsOnboardingDone(),
      builder: (context, data) {
        if (!data.hasData) {
          return Container(
            color: appColor,
          );
        } else {
          var isOnboardinDone = data.data == null ? false : data.data as bool;
          return getMaterialApp(isOnboardinDone);
        }
      },
    );
  }

  Widget getMaterialApp(bool isOnboardinDone) {
    return FutureBuilder(
      future: ApiRepository.getUserSeverity(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            color: appColor,
          );
        }
        var severity = snapshot.data == null ? -1 : snapshot.data as int;
        return MediaQuery(
          child: MaterialApp(
            localizationsDelegates: [
              const AppLocalizationsDelegate(),
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en'),
              const Locale('es'),
            ],
            localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
              print(locale);
              for (Locale supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode ||
                    supportedLocale.countryCode == locale.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
            debugShowCheckedModeBanner: false,
            title: 'CoronaTrace',
            navigatorKey: _globalKey,
            theme: ThemeData(primarySwatch: appColor, fontFamily: 'Montserrat'),
            home: isOnboardinDone
                ? severity == -1
                    ? UserInfoCollectorScreen()
                    : NotificationsListScreen()
                : OnboardingScreen(),
          ),
          data: MediaQueryData(),
        );
      },
    );
  }
}
