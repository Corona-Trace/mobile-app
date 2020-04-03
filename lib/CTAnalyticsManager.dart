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
    _firebaseAnalyticsObserver = FirebaseAnalyticsObserver(analytics: _analytics);
  }

  getFBAnalytics() => _analytics;
  getFBAnalyticsObserver() => _firebaseAnalyticsObserver;
}
