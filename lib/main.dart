import 'package:corona_trace/LocationUpdates.dart';
import 'package:corona_trace/push_notifications/push_notifications.dart';
import 'package:corona_trace/ui/screens/Onboarding.dart';
import 'package:corona_trace/ui/screens/UserInfoCollectorScreen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting().then((value) => runApp(MyApp()));
  PushNotifications()
      .initStuff()
      .then((value) => LocationUpdates.initiateLocationUpdates())
      .then((value) => LocationUpdates.scheduleBGTask());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CoronaTrace',
        theme:
            ThemeData(primarySwatch: Colors.indigo, fontFamily: 'Montserrat'),
        home: OnboardingScreen(),
      ),
      data: MediaQueryData(),
    );
  }
}
