import 'package:corona_trace/analytics/CTAnalyticsManager.dart';
import 'package:corona_trace/location_updates.dart';
import 'package:corona_trace/network/api_repository.dart';
import 'package:corona_trace/service/demo_settings/demo_settings.dart';
import 'package:corona_trace/service/push_notifications/push_notifications.dart';
import 'package:corona_trace/ui_return_safe_demo/login/login.dart';
import 'package:corona_trace/ui_return_safe_demo/onboarding/onboarding_work_together.dart';
import 'package:corona_trace/ui_return_safe_demo/onboarding/onboarding_notification_permission.dart';
import 'package:corona_trace/ui_return_safe_demo/today_checkin/today_checkin_dashboard.dart';
import 'package:corona_trace/ui_v1_1/home_checkin/home_checkin_dashboard.dart';
import 'package:corona_trace/ui_v1_1/not_available_yet/home_not_available_dashboard.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:instabug_flutter/Instabug.dart';
// import 'package:instabug_flutter/Surveys.dart';

import 'utils/app_localization.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Crashlytics.instance.enableInDevMode = true;

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = Crashlytics.instance.recordFlutterError;

  // try {
  //   Instabug.start('d8d9d6c113ba17e5d515d3581726c9a0', [InvocationEvent.none]);
  //   Surveys.setAutoShowingEnabled(false);
  // } catch (ex) {
  //   print(ex);
  // }

  var onboardingDone = await ApiRepository.getIsOnboardingDone();
  var shouldNotifyWhenAvailable =
      await ApiRepository.getDidAllowNotifyWhenAvailable();
  var userSeverity = await ApiRepository.getUserSeverity();
  var pushNotificationsDenied = await PushNotifications.arePermissionsDenied();
  var locationInfoDenied = await LocationUpdates.arePermissionsDenied();
  var insideLocationGate = await LocationUpdates.isWithinAvailableGeoLocation();

  var isOnboardinDone = onboardingDone == null ? false : onboardingDone;
  var severity = userSeverity == null ? -1 : userSeverity;
  var logo = await DemoSettings.getLogoImage();
  runApp(MyApp(isOnboardinDone, severity, shouldNotifyWhenAvailable,
      locationInfoDenied, insideLocationGate, pushNotificationsDenied, logo));
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
  final bool insideLocationGate;
  final bool locationInfoDenied;
  final bool pushNotificationsDenied;
  final bool shouldNotifyWhenAvailable;
  final bool isOnboardinDone;
  final int severity;
  final Image logo;

  MyApp(
      this.isOnboardinDone,
      this.severity,
      this.shouldNotifyWhenAvailable,
      this.locationInfoDenied,
      this.insideLocationGate,
      this.pushNotificationsDenied,
      this.logo);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return getMaterialApp();
  }

  Widget startScreen() {
    return isOnboardinDone
        ? pushNotificationsDenied
            ? OnboardingNotificationPermission()
            : insideLocationGate
                ? TodayCheckinDashboard(severity: -1)
                : HomeNotAvailableDashboard(
                    notifyMeEnabled: shouldNotifyWhenAvailable,
                    locationInfoDenied: locationInfoDenied)
        : Login(logoImage: logo);
  }

  MediaQuery getMaterialApp() {
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
        title: 'Zero',
        navigatorKey: globalKey,
        theme: ThemeData(primarySwatch: appColor, fontFamily: 'Montserrat'),
        home: startScreen(),
      ),
      data: MediaQueryData(),
    );
  }
}
