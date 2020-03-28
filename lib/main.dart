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
final GlobalKey<NavigatorState> globalKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiRepository.getIsOnboardingDone(),
      builder: (context, data) {
        print(data);
        if (data.connectionState == ConnectionState.done) {
          var isOnboardinDone = data.data == null ? false : data.data as bool;
          return handleOnboardingDone(isOnboardinDone);
        }
        return Container(
          color: Color(0xFF2c3054),
        );
      },
    );
  }

  Widget handleOnboardingDone(bool isOnboardinDone) {
    return FutureBuilder(
      future: ApiRepository.getUserSeverity(),
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.connectionState == ConnectionState.done) {
          var severity = snapshot.data == null ? -1 : snapshot.data as int;
          return getMaterialApp(isOnboardinDone, severity);
        }
        return Container(
          color: Color(0xFF2c3054),
        );
      },
    );
  }

  MediaQuery getMaterialApp(bool isOnboardinDone, int severity) {
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
        localeResolutionCallback:
            (Locale locale, Iterable<Locale> supportedLocales) {
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
        navigatorKey: globalKey,
        theme:
            ThemeData(primarySwatch: appColor, fontFamily: 'Montserrat'),
        home: isOnboardinDone
            ? severity == -1
                ? UserInfoCollectorScreen()
                : NotificationsListScreen()
            : OnboardingScreen(),
      ),
      data: MediaQueryData(),
    );
  }
}
