import 'package:corona_trace/analytics/CTAnalyticsEvents.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class CTAnalyticsManager {
  FirebaseAnalytics _analytics;
  FirebaseAnalyticsObserver _firebaseAnalyticsObserver;

  static final CTAnalyticsManager _instance = CTAnalyticsManager._internal();

  factory CTAnalyticsManager() => _instance;

  static CTAnalyticsManager get instance => _instance;

  CTAnalyticsManager._internal() {
    _analytics = FirebaseAnalytics();
    _firebaseAnalyticsObserver =
        FirebaseAnalyticsObserver(analytics: _analytics);
  }

  FirebaseAnalytics getFBAnalytics() => _analytics;

  FirebaseAnalyticsObserver getFBAnalyticsObserver() =>
      _firebaseAnalyticsObserver;

  logPermissionsGranted() {
    getFBAnalytics()
        .logEvent(name: CTAnalyticsEvents.PERMISSIONS_GRANTED_INITIAL)
        .catchError((error) {
      print(error);
    });
  }
}
