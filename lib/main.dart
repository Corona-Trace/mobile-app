import 'package:corona_trace/analytics/CTAnalyticsManager.dart';
import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/ui/notifications/notification_list_screen.dart';
import 'package:corona_trace/ui/screens/onboarding.dart';
import 'package:corona_trace/ui/screens/user_info_collector_screen.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'utils/app_localization.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  ApiRepository.getIsOnboardingDone().then((onboardingDone) {
    ApiRepository.getUserSeverity().then((userSeverity) {
      var isOnboardinDone = onboardingDone == null ? false : onboardingDone;
      var severity = userSeverity == null ? -1 : userSeverity;
      runApp(MyApp(isOnboardinDone, severity));
    });
  });
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
  final bool isOnboardinDone;
  final int severity;

  MyApp(this.isOnboardinDone, this.severity);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return getMaterialApp(this.isOnboardinDone, this.severity);
  }

  MediaQuery getMaterialApp(bool isOnboardinDone, int severity) {
    return MediaQuery(
      child: MaterialApp(
          navigatorObservers: [
            CTAnalyticsManager.instance.getFBAnalyticsObserver(),
          ],
        localizationsDelegates: [
          const AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en'),
          const Locale('es'),
          const Locale('it'),
          const Locale('fr'),
        ],
        localeResolutionCallback:
            (Locale locale, Iterable<Locale> supportedLocales) {
          if (locale == null) {
            debugPrint("*language locale is null!!!");
            return supportedLocales.first;
          }
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
        theme: ThemeData(primarySwatch: appColor, fontFamily: 'Montserrat'),
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
